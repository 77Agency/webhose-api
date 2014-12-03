require 'webhose/api/request'
module Webhose
  class API
    def initialize(token)
      @token = token
    end
    attr_reader :token

    def search(q, params = {})
      Webhose::Api::SearchRequest.new(params.merge(q: q,token: @token)).perform
    end
  end
end
