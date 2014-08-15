# encoding: utf-8
require 'spec_helper'

RSpec.describe PasswordGenerator do
  context '#generate' do
    it 'succeeds if it finds a number' do
      generator = PasswordGenerator.new
      expect(generator.send(:includes_number?, '1asdf')).to be_truthy
    end

    it 'fails if it doesn\'t find a number' do
      generator = PasswordGenerator.new
      expect(generator.send(:includes_number?, 'asdf')).to be_falsy
    end
  end
end
