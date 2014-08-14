# encoding: utf-8
module PasswordChanger
  module Cli
    class Runner < Thor
      class_option :verbose, default: PasswordChanger.config.verbose_mode, type: :boolean, desc: 'Set verbose log level'
      class_option :debug_mode, default: PasswordChanger.config.debug_mode, type: :boolean, desc: 'Run application in debug mode'

      option :csv_file, default: PasswordChanger.config.csv_file, desc: 'Load users and passwords from csv file'
      option :user, default: PasswordChanger.config.user, desc: 'Change password for user' 
      option :ask_new_password, default: PasswordChanger.config.ask_new_password, desc: 'Ask for new password' 
      desc 'start', 'Start password change'
      def start
        PasswordChanger.enable_debug_mode   if options[:debug_mode]
        PasswordChanger.enable_verbose_mode if options[:verbose]

        data = if options[:csv_file]
                 PasswordChanger::Readers::Csv.new.parse(File.expand_path(options[:csv_file]))
               elsif options[:user]
                 PasswordChanger::Readers::SingleUser.new.parse(options[:user], options[:ask_new_password])
               else
                 raise ArgumentError, 'Please use either `--csv-file`- or `--user`-option'
               end

        Actions::ChangePassword.new.run(data)
      end

      default_command :start
    end
  end
end
