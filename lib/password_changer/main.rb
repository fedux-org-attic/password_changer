# encoding: utf-8
# Main
module PasswordChanger
  @logger         = Logger.new
  @config         = ApplicationConfig.new
  @debug_mode     = false
  @plugin_manager = PluginManager.new
  @plugin_prefix  = Regexp.new("^#{self.name.downcase.underscore}-")

  class << self
    attr_reader :logger, :config, :plugin_manager, :plugin_prefix
    attr_accessor :debug_mode

    def root_path
      File.expand_path '../../../', __FILE__
    end

    def debug_mode?
      @debug_mode == true
    end

    def load_plugins
      self.plugin_manager.locate_plugins
      self.plugin_manager.load_plugins
    end

    def configure_i18n
      I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
      I18n.load_path = Dir[::File.join(PasswordChanger.root_path, 'locales', '*.yml')]
      I18n.backend.load_translations
      I18n.available_locales = [:en, :de]
      I18n.enforce_available_locales = false
    end

    def enable_verbose_mode
      self.logger.info "Activating verbose mode."

      PasswordChanger.logger.mode = :debug
    end

    def enable_debug_mode
      self.logger.info "Activating debug mode."

      self.logger.mode = :debug
      self.debug_mode  = true

      require 'pry'
      if RUBY_VERSION < '2.0.0'
        require 'debugger'
      else
        require 'byebug'
      end

    rescue LoadError
      PasswordChanger.logger.error "You tried to enable debug-mode, but either 'pry'- or 'byebug (ruby > 2)/debugger (ruby < 2)'-gem are not installed. Please fix that before using the debug-switch again."
    end
  end
end

PasswordChanger.configure_i18n
