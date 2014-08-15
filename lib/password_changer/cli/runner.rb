# encoding: utf-8
module PasswordChanger
  module Cli
    class Runner < Thor
      class_option :verbose, default: PasswordChanger.config.verbose_mode, type: :boolean, desc: 'Set verbose log level'
      class_option :debug_mode, default: PasswordChanger.config.debug_mode, type: :boolean, desc: 'Run application in debug mode'

      option :csv_file, default: PasswordChanger.config.csv_file, desc: 'Load users and passwords from csv file'
      option :user, default: PasswordChanger.config.user, desc: 'Change password for user' 
      option :ask_new_password, type: :boolean, default: PasswordChanger.config.ask_new_password, desc: 'Ask for new password' 
      option :format, default: PasswordChanger.config.format, desc: 'Output format for changed users' 
      desc 'start', 'Start password change'
      def start
        PasswordChanger.load_plugins

        PasswordChanger.enable_debug_mode   if options[:debug_mode]
        PasswordChanger.enable_verbose_mode if options[:verbose]

        PluginChecker.check

        data = if options[:csv_file]
                 PasswordChanger::Readers::Csv.new.parse(File.expand_path(options[:csv_file]))
               elsif options[:user]
                 PasswordChanger::Readers::SingleUser.new.parse(options[:user], options[:ask_new_password])
               else
                 fail ArgumentError, 'Please use either `--csv-file`- or `--user`-option.'
               end

        printer = if options[:format].to_sym == :csv
                    Printer::Csv.new
                  elsif options[:format].to_sym == :pretty
                    Printer::Pretty.new
                  else
                    fail ArgumentError, 'Please use either "csv" or "pretty" as output format.'
                  end

        Actions::ChangePassword.new(printer).run(data)
      end

      default_command :start
    end
  end
end
