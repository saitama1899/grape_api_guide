module Ebye
    module Entities
        class Index < Grape::Entity
            expose :name
            expose :adress
        end
    end
end