require 'faraday'
require 'addressable/uri'
require "addressable/template"
require 'webhose/errors'
require 'webhose/http/response'
require 'faraday_middleware'
module Webhose
  module Http
    class Client

      ENDPOINT = "https://webhose.io"

      attr_accessor :faraday_middleware

      def call(method,path,params)

        conn = build_connection

        case method.to_s
          when "get"
            uri = Addressable::URI.parse(path)
            template = Addressable::Template.new("#{path}{?query*}")
            path = template.expand({query: (uri.query_values || {}).merge(params)})
            params = {}
        end

        response = conn.send(method,path,params).instance_eval {|r| Webhose::Http::Response.new(r.status.to_i,r.body,r.headers)}

        case response.status
          when 401
            raise Webhose::Errors::AccessDenied.new(response.status,response.body)
        end
        response
      end
      private 

      def build_connection
        conn = Faraday.new(default_endpoint) do |conn|
          conn.response :json, :content_type => /\bjson$/
          conn.adapter default_adapter
        end
      end

      def default_format
        :json
      end

      def default_adapter
        Faraday.default_adapter
      end

      def default_endpoint
        ENDPOINT
      end
    end
  end
end

