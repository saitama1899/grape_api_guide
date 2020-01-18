FactoryBot.define do
    factory :order do
        name: Faker::Commerce.product_name, 
        shipped: true,
        delivered: true
        customer_id nil 
    end
end