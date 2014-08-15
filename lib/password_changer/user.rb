# encoding: utf-8
module PasswordChanger
  class User
    attr_reader :name, :old_password
    attr_accessor :new_password

    def initialize(name:, old_password:, new_password:)
      @name         = name
      @old_password = old_password
      @new_password = new_password
    end
  end
end

