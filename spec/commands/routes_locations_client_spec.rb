require 'rails_helper'

describe RoutesLocationsClient do
  let(:method) { :get }
  
  context 'successfully executed' do
    let(:url) { 'https://my-json-server.typicode.com/marcuzh/router_location_test_api/db' }
    let(:expected_response) { {"routers"=>[{"id"=>1, "name"=>"citadel-01", "location_id"=>1, "router_links"=>[1]}, {"id"=>2, "name"=>"citadel-02", "location_id"=>1, "router_links"=>[]}, {"id"=>3, "name"=>"core-07", "location_id"=>7, "router_links"=>[15]}, {"id"=>4, "name"=>"hybrid-x022", "location_id"=>4, "router_links"=>[14]}, {"id"=>5, "name"=>"meta-04", "location_id"=>3, "router_links"=>[6, 7]}, {"id"=>6, "name"=>"universal-16", "location_id"=>3, "router_links"=>[5]}, {"id"=>7, "name"=>"prod", "location_id"=>3, "router_links"=>[5]}, {"id"=>8, "name"=>"custprod-01", "location_id"=>6, "router_links"=>[11]}, {"id"=>9, "name"=>"edgesrv-01", "location_id"=>8, "router_links"=>[14, 15]}, {"id"=>10, "name"=>"proxyA", "location_id"=>5, "router_links"=>[14]}, {"id"=>11, "name"=>"proxyB", "location_id"=>2, "router_links"=>[8]}, {"id"=>14, "name"=>"cdn10", "location_id"=>4, "router_links"=>[4, 9, 10]}, {"id"=>15, "name"=>"cdn20", "location_id"=>7, "router_links"=>[3, 9]}], "locations"=>[{"id"=>1, "postcode"=>"BE12 2ND", "name"=>"Birmingham Motorcycle Museum"}, {"id"=>2, "postcode"=>"BE12 2ND", "name"=>"Birmingham Hippodrome"}, {"id"=>3, "postcode"=>"BE13 1EQ", "name"=>"Winterbourne House"}, {"id"=>4, "postcode"=>"LA10 1DX", "name"=>"Lancaster Brewery"}, {"id"=>5, "postcode"=>"LA10 7QP", "name"=>"Lancaster University"}, {"id"=>6, "postcode"=>"LA10 9FL", "name"=>"Williamson Park"}, {"id"=>7, "postcode"=>"LA11 1DX", "name"=>"Lancaster Castle"}, {"id"=>8, "postcode"=>"LE13 2SW", "name"=>"Loughborough University"}]} }
    
    subject { described_class.new(url: url, method: method).call }
    
    it 'response success' do
      expect(subject.outflow.output).to be_an_instance_of(Hash)
      expect(subject.outflow.output).to eq(expected_response)
    end
  end
end
