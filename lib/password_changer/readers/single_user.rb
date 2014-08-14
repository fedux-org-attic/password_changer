# encoding: utf-8
module PasswordChanger
  module Readers
    # Build data for single User
    class SingleUser
      def parse(user, ask_new_password)
        old_password = ask('Old Password: ') { |q| q.echo = '*' }
        new_password = ask('New Password: ') { |q| q.echo = '*' } if ask_new_password

        {
          name: user,
          old_password: old_password,
          new_password: new_password
        }
      end
    end
  end
end

