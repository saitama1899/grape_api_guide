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

    let(:customer_id) { customers.first.id }

    # GET /customers/:id ####################################
    describe 'GET /customers/:id' do
        before { get "/api/v1/customers/#{customer_id}" }

        context 'when the record exists' do

            it 'returns the customer' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(customer_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:customer_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match("{\"message\":\"Couldn't find customer with 'id'=100\"}")
            end
        end
    end
end