# encoding: utf-8
module PasswordChanger
  module Printers
    class Csv
      def output(users)
        users.each do |user|
          sprintf "\"%s\",\"%s\"\n", user.name, user.new_password
        end
      end
    end
  end
end
