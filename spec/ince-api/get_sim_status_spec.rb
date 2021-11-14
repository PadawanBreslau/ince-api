require 'spec_helper'

RSpec.describe InceApi::GetSimStatus do
  it 'get one sim card status' do
    VCR.use_cassette('get_sim_status') do
      response = described_class.new(access_token: @token, iccid: '8988228066602306770').sim_status
      expect(response['status']).to eq 'ATTACHED'
      expect(response['location']['country']['name']).to eq 'Poland'
      expect(response['location']['operator']['name']).to eq 'Plus'
    end
  end
end
