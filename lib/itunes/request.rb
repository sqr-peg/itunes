module ITunes
  module Request

    # @private
    private

    # Perform an HTTP GET request
    def request(request_type, params)
      url = '/WebObjects/MZStoreServices.woa/wa/ws' + request_type + '&country=GB'
      logger.debug url
      response = connection.get do |req|
        req.url url, params
        req.options = request_options
      end
      response.body
    end

    def connection
      options = {
        :headers => {'Accept' => 'application/json', 'User-Agent' => user_agent},
        :url => api_endpoint,
      }

      Faraday.new(options) do |builder|
        builder.use Faraday::Response::Rashify
        builder.use Faraday::Response::ParseJson
        builder.adapter(adapter)
      end
    end
  end
end
