require 'rails_helper'

RSpec.describe 'customer API', type: :request do

    let!(:customers) { create_list(:customer, 15) }

    # GET /customers #######################
    describe 'GET /customers' do
        # make HTTP get request before each example
        before { get '/api/v1/customers' }

        it 'returns all customers' do
            expect(json).not_to be_empty
            expect(json.size).to eq(15)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
end