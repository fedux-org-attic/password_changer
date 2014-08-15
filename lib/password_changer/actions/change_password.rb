module PasswordChanger
  module Actions
    class ChangePassword
      private

      attr_reader :changer, :formatter

      public

      def initialize(printer)
        @changer = Changer.new
        @printer = printer
      end

      def run(*data)
        users = data.flatten.map do |d|
          raise ArgumentError, 'Attribute "user_name" or "old_password" is missing!' if d[:name].blank? || d[:old_password].blank?

          new_password = PasswordChanger::PasswordGenerator.new.generate(old_password: d[:old_password])
          d[:new_password] = new_password if d[:new_password].blank?

          User.new(**d)
        end

        users.each { |u| changer.change(u) }

        printer.output users
      end
    end
  end
end
