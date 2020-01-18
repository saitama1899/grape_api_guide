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
            present customers
            end
        end
      end
    end
end