require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:success_response_body) { '{"connections":["Williamson Park \u003c-\u003e Birmingham Hippodrome","Loughborough University \u003c-\u003e Lancaster Brewery","Loughborough University \u003c-\u003e Lancaster Castle","Lancaster University \u003c-\u003e Lancaster Brewery"]}' }

  subject { get :connections }

  describe 'GET #connections' do
    context 'successful response' do
      before { subject }
      
      it 'returns 200 status' do
        expect(response.status).to eq(200)
      end
      
      it 'returns expected body' do
        expect(response.body).to eq(success_response_body)
      end
    end

    context 'unsuccessful response' do
      before do 
        ENV['ROUTE_LOCATIONS_URL'] = 'foo.com/get-locations'
        subject
      end

      it 'return internal server error (500) status' do
        expect(subject.status).to eq(500)
      end

      it 'returns error body' do
        expect(response.body).to include("Not Found")
      end
      
      after do
        Dotenv.load '.env.test'
      end
    end
  end
end
