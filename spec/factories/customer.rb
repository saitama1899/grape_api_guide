FactoryBot.define do
    factory :customer do
      title { Faker::TvShows::GameOfThrones.character }
      adress { Faker::TvShows::GameOfThrones.city }
    end
 end