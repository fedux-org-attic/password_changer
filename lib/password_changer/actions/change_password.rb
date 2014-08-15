module PasswordChanger
  module Actions
    class ChangePassword
      private

      attr_reader :changer, :printers

      public

      def initialize(printers, changer)
        @changer  = changer
        @printers = printers
      end

      def run(*data)
        users = data.flatten.map do |d|
          raise ArgumentError, 'Attribute "user_name" or "old_password" is missing!' if d[:name].blank? || d[:old_password].blank?

          new_password = PasswordChanger::PasswordGenerator.new.generate(old_password: d[:old_password])
          d[:new_password] = new_password if d[:new_password].blank?

          User.new(**d)
        end

        users.each { |u| changer.change(u) }

        printers.each { |p| p.output users }
      end
    end
  end
end
