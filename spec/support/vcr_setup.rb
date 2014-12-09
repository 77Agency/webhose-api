require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :faraday
  c.filter_sensitive_data('<TOKEN>') {ENV["TOKEN"]}
end
