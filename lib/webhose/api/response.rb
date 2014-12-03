module Webhose
  module Api
    class Response
      attr_accessor :posts
      def initialize(posts,opts = {})
        self.posts = posts
      end
      def next
      end
    end
  end
end
