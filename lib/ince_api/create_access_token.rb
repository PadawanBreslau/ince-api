require 'uri'
require 'net/http'
require 'openssl'
require 'base64'
require 'json'

module InceApi
  class CreateAccessToken
    def initialize(username:, password:)
      @username = username
      @password = password
    end

    URL = URI("https://api.1nce.com/management-api/oauth/token")

    def create_token
      response = connection.request(request)
      JSON.parse(response.body)
    end

    def request
      Net::HTTP::Post.new(URL).tap do |request|
        request["Accept"] = 'application/json'
        request["Content-Type"] = 'application/x-www-form-urlencoded'
        request["Authorization"] = "Basic #{encoded_credentials}"
        request.body = "grant_type=client_credentials"
      end
    end

    def connection
      @connection ||= Net::HTTP.new(URL.host, URL.port).tap do |http|
        http.use_ssl = true
      end
    end

    def encoded_credentials
      Base64.encode64("#{@username}:#{@password}").strip
    end
  end
end
