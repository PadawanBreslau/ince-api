module InceApi
  class GetSimUsage
    def initialize(access_token:, iccid:, params: {})
      @access_token = access_token
      @iccid = iccid
      @params = params
    end

    def sim_usage
      response = connection.request(request)
      if response.body != ''
        JSON.parse(response.body)
      else
        {'status_code' => 404, 'error_message' => 'SIM with ICCID not found'}
      end
    end

    private

    ALLOWED_KEYS = %i(start_dt end_dt)
    def params_query
      URI.encode_www_form @params.slice(*ALLOWED_KEYS)
    end

    def url
      @url ||= URI("https://api.1nce.com/management-api/v1/sims/#{@iccid}/usage?#{params_query}")
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
