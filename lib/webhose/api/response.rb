module Webhose
  module Api
    class Response
      attr_accessor :posts
      def initialize(posts,opts = {})
        self.posts = posts
        @next_request = opts[:next]
      end
      def next
        @next_request.perform  #if @next_request
      end
    end
  end
end
