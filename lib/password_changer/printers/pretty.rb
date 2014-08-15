# encoding: utf-8
module PasswordChanger
  module Printers
    class Pretty
      def output(users)
        users.each do |user|
          PasswordChanger.logger.debug "User \"#{user.name}\" has the following password \"#{user.new_password}\" now."
        end
      end
    end
  end
end
