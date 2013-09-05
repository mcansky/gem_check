require 'minitest/autorun'
require 'minitest/pride'
require 'faker'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :faraday
end

require File.expand_path('../../lib/gem_check.rb', __FILE__)
