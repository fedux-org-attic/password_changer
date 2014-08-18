# PasswordChanger

The `password_changer` helps you to change passwords for multiple users in an
easy fashion.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'password_changer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install password_changer

## Getting started

### Introduction

Before it change the passwords of your user accounts, it needs your help. You
need to implement the algorithm to change the passwords. How much work it is,
depends a lot on the portal you need to use to change password.

### Implement your own password change algorithm

*Install bundler*

The bundler provides a helper to generate the basic structure of a gem.

```
gem install bundler
```

*Create gem*

```
# general usage
bundle gem password_changer-<plugin_name>

# example
bundle gem password_changer-product_xyz
```

*Create class*

`password_changer-product_xyz/lib/password_changer-product_xyz/changer.rb`:

```ruby
# encoding: utf-8
module PasswordChanger
  class Changer
    include Capybara::DSL

    private

    attr_reader :website, :show_screenshot_on_error

    public

    def initialize(website: 'https://password-portal.example.com/', show_screenshot_on_error: true)
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

      visit_website
      fill_in_data(user)
      check_success(user)

      user
    end

    def check_success(user)
      if page.has_content? 'Password succesfully changed.'
        PasswordChanger.logger.debug "Change password for \"#{user.name}\" to \"#{user.new_password}\" was a success."
      else
        PasswordChanger.logger.error "Change password for \"#{user.name}\" to \"#{user.new_password}\" failed. Old password was \"#{user.old_password}\"."
        user.new_password = user.old_password

        show_page_in_image_viewer if show_screenshot_on_error
      end
    end

    def visit_website
      PasswordChanger.logger.debug "Visiting \"#{website}\" to change password"
      visit website
    end

    def fill_in_data(user)
      page.fill_in 'user_name', with: user.name
      page.fill_in 'old_password', with: user.old_password
      page.fill_in 'new_password1', with: user.new_password
      page.fill_in 'new_password2', with: user.new_password

      page.click 'submit'
    end

    def show_page_in_image_viewer
      screenshot_file = Tempfile.new(%w(screenshot .png))
      page.save_screenshot screenshot_file.path
      system("xdg-open #{screenshot_file.path}")
    end
  end
end
```

*Require class*

`password_changer-product_xyz/lib/password_changer-product_xyz.rb`:

```ruby
require 'password_changer-product_xyz/changer
```

*Install gem* or *Publish gem*

```
rake install
```

or

```
rake release
```

## Run command

###  Executables

You can run `password_changer` via:

```
# long
password_changer

# short
pc
```

### Use csv-file

You can use csv-files with `password_changer`. You can provide new passwords to
`password_changer` or let `password_changer` generate new ones.

*Generate new password*

```
"name","old_password"
```

*Use predefined new password*
```
"name","old_password","new_password"
```

*Change passwords based on csv-file*

```
pc --csv-file users.csv
```

### Enable debug mode

You can enable debugging-gems and enable verbose logging, by using `--debug-mode`-option.

```
pc --csv-file users.csv --debug-mode
```

### Enable verbose logging only

You can enable verbose logging, by using `--verbose`-option.

```
pc --csv-file users.csv --verbose
```

### Choose output format

There are some output formats available:

* Plain

  ```
  user new_password
  ```

* Csv

  ```
  "user","new_password"
  ```

* Pretty

  ```
  2014-08-18 11:38:27 +0200 DEBUG : Change password for "user1" to "password1" was a success.
  ```

```
pc --csv-file users.csv --debug-mode
```

### Show screenshot on error

The `password_changer` passes a variable named `show_screenshot_on_error` to
`Changer`-class.

```
pc --csv-file users.csv --show-screenshot-on-error
```

### Ask password in single user input mode

If you want to change the password for a single user, you can advise
`password_changer` to ask for the password.

```
pc --user --ask-new-password
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/password_changer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
