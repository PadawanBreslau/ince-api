require 'spec_helper'

RSpec.describe InceApi::GetSim do
  it 'get one sim card' do
    VCR.use_cassette('valid_credentials') do
      response = InceApi::CreateAccessToken.new(username: 'Good Username', password: 'Good Password').create_token
      @token = response['access_token']
    end

    VCR.use_cassette('get_sim') do
      response = described_class.new(access_token: @token, iccid: '8988228066602306770').sim
      expect(response['status']).to eq 'Activated'
      expect(response['label']).to eq 'Test API'
    end
  end

  it 'wrond iccid' do
    VCR.use_cassette('valid_credentials') do
      response = InceApi::CreateAccessToken.new(username: 'Good Username', password: 'Good Password').create_token
      @token = response['access_token']
    end

    VCR.use_cassette('get_sim_wrong_iccid') do
      response = described_class.new(access_token: @token, iccid: '11111222233444').sim
      expect(response['error_message']).to eq "SIM with ICCID not found"
      expect(response['status_code']).to eq 404
    end
  end
end
