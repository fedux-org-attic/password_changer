# encoding: utf-8
module PasswordChanger
  module Cli
    class Runner < Thor
      class_option :verbose, default: PasswordChanger.config.verbose_mode, type: :boolean, desc: 'Set verbose log level'
      class_option :debug_mode, default: PasswordChanger.config.debug_mode, type: :boolean, desc: 'Run application in debug mode'

      option :csv_file, default: PasswordChanger.config.csv_file, desc: 'Load users and passwords from csv file'
      option :user, default: PasswordChanger.config.user, desc: 'Change password for user' 
      option :ask_new_password, type: :boolean, default: PasswordChanger.config.ask_new_password, desc: 'Ask for new password' 
      option :output_format, type: :array, default: PasswordChanger.config.output_format, desc: 'Output format for changed users' 
      option :show_screenshot_on_error, type: :boolean, default: PasswordChanger.config.show_screenshot_on_error, desc: 'Show a screenshot on error'
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

        Actions::ChangePassword.new(
          find_printers(options[:output_format]), 
          Changer.new(show_screenshot_on_error: options[:show_screenshot_on_error])
        ).run(data)
      end

      default_command :start

      no_commands do
        def find_printers(formats)
          formats.inject([]) do |a, e|
            a << case e.to_sym
                 when :csv
                   Printers::Csv.new
                 when :pretty
                   Printers::Pretty.new
                 when :plain
                   Printers::Plain.new
                 else
                   fail ArgumentError, 'Please use either "csv", "plain" or "pretty" as output format.'
                 end
          end
        end

      end
    end
  end
end
