module Webhose
  module Models
    class Post < Webhose::Models::Model
      attr_accessor :url,:ord_in_thread,:author,:published,:title,:text,:language,:crawled,:thread
      def initialize(url,ord_in_thread,author,published,title,text,language,crawled, thread = nil)
        self.url = url
        self.ord_in_thread = ord_in_thread
        self.author = author
        self.published = published
        self.title = title
        self.text = text
        self.language = language
        self.crawled = crawled
        self.thread = thread
      end
    end
  end
end
