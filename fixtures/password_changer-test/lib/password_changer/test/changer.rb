# encoding: utf-8
module PasswordChanger
  class Changer
    private

    attr_reader :website, :show_screenshot_on_error, :viewer

    public

    def initialize(website: 'https://password-portal.example.com', show_screenshot_on_error: true, viewer: 'xdg-open')
      @website                  = website
      @show_screenshot_on_error = show_screenshot_on_error

      Capybara.register_driver :poltergeist do |app|
        options = {
          timeout: 240,
        }

        Capybara::Poltergeist::Driver.new(app, options)
      end

      Capybara.default_driver = :poltergeist

      %w(http_proxy https_proxy).each do |p|
        ENV.delete p
        ENV.delete p.upcase
      end

    end

    def change(user)
      PasswordChanger.logger.debug "The user \"#{user.name}\" has old password \"#{user.old_password}\" and new password \"#{user.new_password}\"."

      user
    end

    private

    def show_page_in_image_viewer
      screenshot_file = Tempfile.new(%w(screenshot .png))
      page.save_screenshot screenshot_file.path
      system("#{Shellwords.escape(viewer)} #{screenshot_file.path}")
    end
  end
end
