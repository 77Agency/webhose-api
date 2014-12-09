require "spec_helper"

describe "Webhose::API" do 
  it "throws an exception if access is denied" do
    VCR.use_cassette 'api/no_token' do
      token = "a"
      api = Webhose::API.new(token)
      expect {api.search("test")}.to raise_error(Webhose::Errors::AccessDenied)
    end
  end
  it "parse correctly all the entries" do
    VCR.use_cassette 'api/token' do
      api = Webhose::API.new(ENV["TOKEN"])
      response = api.search("test")
      expect(response.posts.length).to eq(100)
      post = response.posts.first
      post.url = "http://www.cotidianul.ro/profesorul-badescu-dezvaluie-adevarul-despre-lista-conspirativa-a-lui-dughin-252678/"
      post.ord_in_thread = 0
      post.author = "cotidianul.ro"
      post.published = Time.parse("2014-12-07T01:11:00.000+02:00")
      post.title = "Profesorul Bădescu dezvăluie adevărul despre lista conspirativă a lui Dughin"
      post.language = "romanian"
      post.crawled = Time.parse("2014-12-06T01:11:30.000+02:00")
    end
  end

end
