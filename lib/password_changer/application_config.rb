# encoding: utf-8
module PasswordChanger
  class ApplicationConfig < FeduxOrgStdlib::AppConfig
    option :csv_file, nil
    option :verbose_mode, false
    option :debug_mode, false
    option :user, nil
    option :ask_new_password, false
    option :output_format, %w(csv)
    option :show_screenshot_on_error, true
    option :viewer_command, 'xdg-open'
    option :plugin_whitelist, []
    option :plugin_blacklist, []

    private

    def _config_name
      'application'
    end
  end
end
