# encoding: utf-8
require 'aruba/api'
require 'aruba/reporting'

RSpec.configure do |c|
  c.include Aruba::Api

  c.before(:each) do
    clean_current_dir
    restore_env
  end
end
