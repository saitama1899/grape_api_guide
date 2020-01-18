module Ebye
    module V1
        class Customers < Grape::API
            # With v1 we specify the version of our API
            version 'v1', using: :path
            # Tell our API that we allow only JSON
            format :json
            # We prefix the path of our API. Remind you, in route.rb we set route like that mount Ebye::Base => '/'
            # With this prefix we could access to our API instead '/api'

            prefix :api
            # Indicates customers routes
            resource :customers do
                # Description of our method and what we are expecting
                desc 'Return list of customers'
                get do
                    # Method to return all customers
                    customers = Customer.all
                    present customers, with: Ebye::Entities::Customer
                end

                desc 'Return a specific customer'
                # route_param :id Allows us to define namespace to pick up a customer thanks to its id
                route_param :id do
                    get do
                        customer = Customer.find(params[:id])
                        present customer, with: Ebye::Entities::Customer
                    end
                end
            end
        end
    end
end