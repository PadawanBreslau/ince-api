module InceApi
  class CreateSms
    def initialize(access_token:, iccid:, params:{})
      @access_token = access_token
      @iccid = iccid
      @params = params
    end

    def send
      response = connection.request(request)
      response.code.to_i == 201 ? allowed_params.merge(status: 'OK') : { status: 'FAILED', error_code: response.code.to_i}
    end

    private

    ALLOWED_KEYS = %i(source_address payload udh dcs source_address_type expiry_date)
    def allowed_params
      @params.slice(*ALLOWED_KEYS)
    end

    def url
      @url ||= URI("https://api.1nce.com/management-api/v1/sims/#{@iccid}/sms")
    end

    def connection
      @connection ||= Net::HTTP.new(url.host, url.port).tap do |http|
        http.use_ssl = true
      end
    end

    def request
      Net::HTTP::Post.new(url).tap do |request|
        request.body = allowed_params.to_json
        request["Accept"] = 'application/json'
        request["Content-Type"] = 'application/json;charset=UTF-8'
        request['Authorization'] = "Bearer #{@access_token}"
      end
    end
  end
end
