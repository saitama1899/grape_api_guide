require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

10.times do
    Customer.create!(
        name: Faker::TvShows::GameOfThrones.character, 
        adress: Faker::TvShows::GameOfThrones.city
    )
end

customer_ids = Customer.ids

30.times do
    Order.create!(
        customer_id: customer_ids.sample, 
        name: Faker::Commerce.product_name, 
        shipped: Faker::Boolean.boolean,
        delivered: false
    )
end