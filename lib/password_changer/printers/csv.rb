# encoding: utf-8
module PasswordChanger
  module Printers
    class Csv
      def output(users)
        PasswordChanger.logger.info "You find the changed user accounts below. If an error occured during password change, the old password is given.\n"

        users.each do |user|
          printf "\"%s\",\"%s\"\n", user.name, user.new_password
        end
      end
    end
  end
end
