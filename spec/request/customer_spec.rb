require 'rails_helper'

RSpec.describe 'products API', type: :request do

    let!(:customers) { create_list(:customer, 10) }

    # GET /customers #######################
    describe 'GET /customers' do
        # make HTTP get request before each example
        before { get '/api/v1/customers' }

        it 'returns all customers' do
            expect(JSON.parse(response.body)).not_to be_empty
            expect(JSON.parse(response.body).size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
end