FactoryBot.define do
    factory :order do
        name { Faker::Commerce.product_name }
        shipped { Faker::Boolean.boolean }
        delivered { false }
        customer_id nil 
    end
end