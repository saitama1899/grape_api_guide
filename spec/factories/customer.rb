FactoryBot.define do
    factory :customer do
      name { Faker::TvShows::GameOfThrones.character }
      adress { Faker::TvShows::GameOfThrones.city }
    end
 end