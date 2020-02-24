module Ebye
    module Entities
        class Order < Grape::Entity
            expose :name
            expose :shipped
            expose :delivered
        end
    end
end