require "webhose/http/client"
require "webhose/api/response"
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
    end
    class SearchRequest < Request
      def perform
        @client.call(method,path,params)
      end
      def path
        "/search"
      end
      def method
        API_GET
      end
    end
  end
end
