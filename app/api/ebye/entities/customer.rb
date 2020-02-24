module Ebye
    module Entities
        class Customer < Grape::Entity
            expose :name
            expose :adress
            expose :orders, using: Ebye::Entities::Order
        end
    end
end