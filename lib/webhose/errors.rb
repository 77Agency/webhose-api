module Webhose
  module Errors
    class WebhoseError < StandardError ; end
    class APIError  < WebhoseError
      attr_accessor :http_code, :message
      def initialize(http_code,message)
        self.http_code = http_code
        self.message = message
        super(message)
      end
    end
    class AccessDenied < APIError; end
  end
end
