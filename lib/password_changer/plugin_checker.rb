# encoding: utf-8
module PasswordChanger
  class PluginChecker
    def self.check
      fail ChangerClassError, "Password changer class \"Changer\" is not defined. Did you install a plugin which implements that changer-class?" unless defined? Changer
    end
  end
end
