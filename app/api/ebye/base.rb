module Ebye
    class Base < Grape::API
        mount Ebye::V1::Customers
    end
end