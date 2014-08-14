# encoding: utf-8
module PasswordChanger
  module Readers
    # Build data array from csv file
    class Csv
      def parse(file)
        csv = CSV.new(
          File.read(file), 
          headers: true, 
          header_converters: :symbol, 
          converters: [:all ]
        )

        csv.to_a.map {|row| row.to_hash }
      end
    end
  end
end
