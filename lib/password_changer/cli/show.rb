# encoding: utf-8
module PasswordChanger
  module Cli
    class Show < Thor

      desc 'config', 'Show configuration'
      option :defaults, type: :boolean, desc: 'Show default configuration'
      def config
        if options[:defaults]
          capture :stderr do
            puts PasswordChanger::ApplicationConfig.new(file: nil).to_s
          end
        else
          puts PasswordChanger.config.to_s
        end
      end
    end
  end
end
