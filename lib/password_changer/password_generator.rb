# encoding: utf-8
module PasswordChanger
  class PasswordGenerator
    def generate(old_password: '', length: 8)
      loop do
        new_password = generate_string(length)

        return new_password if is_totally_different?(old_password, new_password) && includes_number?(new_password) && has_no_doubled_letters?(new_password)
      end
    end

    private

    def is_totally_different?(string1, string2)
      max_length = [string1, string2].max_by { |x| x.length }.length

      Levenshtein.distance(string1, string2) >= max_length
    end

    def has_no_doubled_letters?(string)
      result = (/(.)\1/ === string)

      !result
    end

    def includes_number?(string)
      !(string.split(//) & (0..9).map(&:to_s)).blank?
    end

    def generate_string(length)
      o = [('a'..'z'), (0..9)].map { |i| i.to_a }.flatten
      (0...length).map { o[rand(o.length)] }.join
    end
  end
end

