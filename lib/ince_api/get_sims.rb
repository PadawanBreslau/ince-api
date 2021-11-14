module InceApi
  class GetSims
    def initialize(access_token:, params: {})
      @access_token = access_token
      @params = params
    end

    def sims
      response = connection.request(request)
      JSON.parse(response.body)
    end

    private

    ALLOWED_KEYS = %i(page pageSize q sort)
    def params_query
      URI.encode_www_form @params.slice(*ALLOWED_KEYS)
    end

    def url
      @url ||= URI("https://api.1nce.com/management-api/v1/sims?#{params_query}")
    end

    def connection
      @connection ||= Net::HTTP.new(url.host, url.port).tap do |http|
        http.use_ssl = true
      end
    end

    def request
      Net::HTTP::Get.new(url).tap do |request|
        request["Accept"] = 'application/json'
        request['Authorization'] = "Bearer #{@access_token}"
      end
    end
  end
end
