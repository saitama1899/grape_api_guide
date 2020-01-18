module Ebye
    module Entities
        class Customer < Grape::Entity
            expose :name
            expose :adress
        end
    end
end