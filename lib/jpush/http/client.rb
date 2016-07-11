require_relative 'response'

module JPush
  module Http
    module Client
      extend self

      def get(settings, url, params: nil, headers: {})
        send_request(settings, :get, url, params: params, headers: headers)
      end

      def post(settings, url, body: , headers: {})
        send_request(settings, :post, url, body: body, headers: headers)
      end

      def put(settings, url, body: , headers: {})
        send_request(settings, :put, url, body: body, headers: headers)
      end

      def delete(settings, url, params: nil, headers: {})
        send_request(settings, :delete, url, params: params, headers: headers)
      end

      def send_request(settings, method, url, params: nil, body: nil, headers: {}, opts: {})
        raw_response = Utils::Http.new(
          settings,
          method.to_sym,
          url,
          params: params,
          body: body,
          headers: headers,
          opts: opts
        ).basic_auth.send_request

        Response.new(raw_response)
      end

    end
  end
end
