require "spec_helper"

describe "Webhose::API" do 
  it "should return" do
    VCR.use_cassette 'api/no_token' do
      token = "a"
      api = Webhose::API.new(token)
      expect {api.search("test")}.to raise_error(Webhose::Errors::AccessDenied)
    end
  end
end
