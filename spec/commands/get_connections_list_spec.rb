require 'rails_helper'

describe GetConnectionsList do
  
  context 'successfully executed' do
    let(:route_locations_url) { 'https://my-json-server.typicode.com/marcuzh/router_location_test_api/db' }
    let(:expected_response) { ["Williamson Park <-> Birmingham Hippodrome", "Loughborough University <-> Lancaster Brewery", "Loughborough University <-> Lancaster Castle", "Lancaster University <-> Lancaster Brewery"] }
    
    subject { described_class.new(route_locations_url: route_locations_url).call }
    
    it 'response success' do
      expect(subject.outflow.output.success?).to be true
    end

    it 'response body' do
      expect(subject.outflow.output.data[:connections]).to be_an_instance_of(Array)
      expect(subject.outflow.output.data[:connections]).to eq(expected_response)
    end
  end
end
