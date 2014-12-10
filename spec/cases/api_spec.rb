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
    VCR.use_cassette 'api/token/1' do
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
  it "returns the next entries" do
    VCR.use_cassette 'api/token/1' do
      api = Webhose::API.new(ENV["TOKEN"])
      response1 = api.search("test")
      VCR.use_cassette 'api/token/2' do
        response2 = response1.next
        expect(response2.posts.length).to eq(100)
        expect(response1.posts.first.url != response2.posts.first.url)
      end
    end
  end
end
