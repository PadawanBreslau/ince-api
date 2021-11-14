module InceApi
  class GetSim
    def initialize(access_token:, iccid:)
      @access_token = access_token
      @iccid = iccid
    end

    def sim
      response = connection.request(request)
      if response.body != ''
        JSON.parse(response.body)
      else
        {'status_code' => 404, 'error_message' => 'SIM with ICCID not found'}
      end
    end

    private

    def url
      @url ||= URI("https://api.1nce.com/management-api/v1/sims/#{@iccid}")
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
