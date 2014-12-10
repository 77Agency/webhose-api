require "webhose/http/client"
require "webhose/api/response"
require "webhose/models"
module Webhose
  module Api
    class Request 
      API_GET = 'get'
      API_POST = 'post'
      attr_reader :params

      def initialize(params)
        @params = params
        @client = Webhose::Http::Client.new
      end

      def perform
        parse_response(@client.call(method,path,params))
      end

      def method
        raise NotImplementedError
      end

      def path
        raise NotImplementedError
      end

      def parse_response(response)
        posts = response.body["posts"].map {|p| post_from_json(p)}
        opts = {}
        opts[:next] = request_from_next(response.body["next"]) if response.body["next"]
        Webhose::Api::Response.new(posts,opts)
      end

      def post_from_json(json)
        Webhose::Models::Post.new(json["url"],json["ord_in_thread"],json["author"],Time.parse(json["published"]),json["title"],json["text"],json["language"],json["crawled"],json["thread"])
      end

      def request_from_next(next_link)
        self.class.new(Addressable::URI.parse(next_link).query_values)
      end

    end
    class SearchRequest < Request
      def path
        "/search"
      end
      def method
        API_GET
      end
    end
  end
end
