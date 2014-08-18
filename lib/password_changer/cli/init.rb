# encoding: utf-8
module PasswordChanger
  module Cli
    # This class provides an 'presentation init' command for the middleman CLI.
    class Init < Thor
      include Thor::Actions

      desc 'application ', 'Initialize system for use of middleman-presentation'
      option :configuration_file, default: PasswordChanger.config.preferred_configuration_file, desc: 'Path to configuration file'
      option :force, type: :boolean, desc: 'Force creation of config file'
      def application
        source_paths << File.expand_path('../../../../templates', __FILE__)

        @version = PasswordChanger::VERSION
        @config = PasswordChanger.config

        opts = options.dup.deep_symbolize_keys
        template 'config.yaml.tt', opts.delete(:configuration_file), **opts
      end
    end
  end
end
