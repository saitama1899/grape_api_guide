# Basic usage and example of making an API with Grape

The point of this project is to learn how to use [Grape](https://github.com/ruby-grape/), work and define its related tools, and as documentation for anyone who wants to understand how the core of the [main project](https://github.com/assimovt/badigeeks-api) will work. This guide is also mentioning how to work with models and RSpec, and will serve as a reminder of good practices and steps to follow. 

Good practices that I'll recommend following this project and any project (and as a reminder for myself):
- Always write first the (failure) tests.
- Try to write a code that explains itself, with a modular and single responsibility principle (SRP) based structure.
- Working and implementing little and functional steps everytime.
- After that, commit and push with a clear description with that what you done.

> This readme.md could also be as example to how to document the main project readme with Markdown

## What is Grape?
[Grape](https://github.com/ruby-grape/) is an API framework for ruby language, it is used to write RESTful API for the existing web application that is already written in Rails or Sinatra framework. It has inbuilt option like common convention, multiple data/response format, versioning etc.

### Adventages of Grape in order to make an **API with Rails**

- You can easily document the API with description without writing separate API document.
- Easy and standard syntax of API endpoints.
- Easy way to format data for typical response.
- Adding new parameter and basic validation can be done easily.
- Definition of routes and API body is very decent and developer friendly.
- Grape API is much faster than any other API for rails application.
- Versioning support.

## Usage guide

### Making the project

```bash
$ rails new grape_api_guide --api -T
```
> You can indicate a database adding --database=postgresql , for more options: ```$ rails new --help ```

### Gems that I will use
> A good practice in terms of adding gems to your gemfile is to specify the version. You can find that here [rubygems.org](https://rubygems.org/)

#### Grape gems

[Grape](https://github.com/ruby-grape/): Explained above.

[Grape Entity](https://github.com/ruby-grape/grape-entity): With Grape-Entity we could handle which attribute we would like to display in our API according to our models.

[Grape On Rails Routes](https://github.com/syedmusamah/grape_on_rails_routes): Very useful gem to visualize API routes.

#### TDD gems

[RSpec](https://github.com/rspec/rspec-rails): For testing purposes we will use RSpec. The basic idea behind this concept is that of Test Driven Development where the tests are written first and the development is based on writing just enough code that will fulfill those tests followed by refactoring. 

[Faker](https://github.com/faker-ruby/faker): Easy and quickly way to populate fake data in DB.

[Facotry Bot](https://github.com/thoughtbot/factory_bot): Is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies. 

[Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers): Provides RSpec with additional matchers that if written by hand would be harder to write.

[Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner): Cleans our test database to ensure a clean state in each test suite.

```bash

gem 'grape'
gem 'grape-entity'
gem 'grape_on_rails_routes'

[...]

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end

```

```bash
$ bundle install
```

### Configuring the project

Initialize the spec directory (where our tests will reside)

```bash
$ rails generate rspec:install
```

Configure the TDD environment on ```rails_helper.rb```

```ruby
# [...]
# Add additional requires below this line. Rails is not loaded until this point!
require 'database_cleaner'

# configure shoulda matchers to use rspec as the test framework and full matcher libraries for rails
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# [...]
RSpec.configure do |config|
  # [...]
  # add `FactoryBot` methods
  config.include FactoryBot::Syntax::Methods

  # start by truncating all the tables but then use the faster transaction strategy the rest of the time.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  # start the transaction strategy as examples are run
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
```
### Making the models

For this guide I'll work with 2 models, on a 1:M relationship. One *Customer* has many *Orders* and one *Order* belongs to a single *Customer*.

```bash
$ rails g model Customer name:string adress:string
$ rails g model Order name:string shipped:boolean delivered:boolean customer:references
$ rails db:migrate RAILS_ENV=test
```

### Model specs

Following the TDD methodology, we should write the model specs first
> This should work as a kick example on how to work with TDD

```ruby
# on spec/models/customer_spec.rb
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:orders).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:adress) }
end

# on spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do

  it { should belong_to(:customer) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:shipped) }
  it { should validate_presence_of(:delivered) }
end
```
Running rspec should fail

```bash
$ rspec
```

We need to validate the presence of that fields on models

```ruby
# on models/customer.rb
class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates_presence_of :name, :adress
end

# on models/order.rb
class Order < ApplicationRecord
  belongs_to :customer
  validates_presence_of :name
  validates_presence_of :shipped
  validates_presence_of :delivered
end
```
Running rspec should pass the validations test

### Test data through Factory Bot

We can make test and volatile data with Factory Bot

```bash
$ mkdir spec/factories && touch spec/factories/{customer.rb,order.rb} 
```
```ruby
# on factories/customer.rb
FactoryBot.define do
  factory :customer do
    title { Faker::TvShows::GameOfThrones.character }
    adress { Faker::TvShows::GameOfThrones.city }
  end
end

# on factories/order.rb
FactoryBot.define do
    factory :order do
        name { Faker::Commerce.product_name }
        shipped { Faker::Boolean.boolean }
        delivered { false }
        customer_id nil 
    end
end
```
Then if we want, we can create instances of our models.

### Test data through seeds.rb and DB

We can also populate database filling ```seeds.rb```

```ruby
require 'database_cleaner'
# This cleans after each rails db:seeds
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
        shipped: true,
        delivered: true
    )
end
```

And running then 
```bash
$ rails db:seeds
```

You can play with the DB instances through the rails console ```$ rails c```

## Build the API with Grape

First step is to create our API folder within app and also a folder with the name of our API (I named it ebye)

```bash
$ mkdir -p app/api/ebye
```
We need to tell to our application where our API will be written, so we will add on ```application.rb```

```ruby
config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
config.autoload_paths += Dir[Rails.root.join('app', 'api/ebye/v1', '*')]
```
Our API needs a main file where we will declare the paths, so we need a base.rb file which will find inside ebye folder.

```ruby
# on api/ebye/base.rb
module Ebye
    class Base < Grape::API
        mount Ebye::V1::Customers
        # This line above is the path to find our API, we will write all our API methods inside a Customers.rb
    end
end
```

Adding in our ```routes.rb``` a route to access to API from our app.

```ruby 
  mount Ebye::Base => '/'
```
This means that the API starting point is our base.rb

### Making our first endpoint

Our first endpoint will be a simple GET /customers

#### Tests first

We need to create the folder request in order to write there our custom tests.

```bash
$ mkdir -p spec/request && touch spec/request/customer_spec.rb
```

We are also creating a support folder wich will contain helper files and methods to make our code modular and easier to read.

```bash
$ mkdir -p spec/support && touch spec/support/request_spec_helper.rb
```

```ruby
module RequestSpecHelper
    def json
      JSON.parse(response.body)
    end
end
```

In order to be able to use this methods, we must add the following line to our ```rails_helper.rb```
```ruby
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
```

Then we are ready to make the first API test for customers. We'll initialize test data thanks to our factory bot previous configuration.

```ruby
# on customer_spec.rb
require 'rails_helper'

RSpec.describe 'customer API', type: :request do

    let!(:customers) { create_list(:customer, 15) }

    # GET /customers #######################
    describe 'GET /customers' do
        # make HTTP get request before each example
        before { get '/api/v1/customers' }

        it 'returns all customers' do
            expect(json).not_to be_empty
            expect(json.size).to eq(15)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
end
```
The tests should fail! Thats because we didn't created the endpoint yet. Lets do it.

We will create the folder V1 which will contain our customers.rb file mentioned above. In this file we'll define some configurations for the api customers. 

```bash
$ mkdir -p app/api/ebye/v1 && touch app/api/ebye/v1/customers.rb
```

```ruby
# on app/api/ebye/v1/customers.rb
module Ebye
  module V1
    class Customers < Grape::API
      # With v1 we specify the version of our API
      version 'v1', using: :path
      # Tell our API that we allow only JSON
      format :json
      # We prefix the path of our API. Remind you, in route.rb we set route like that mount Ebye::Base => '/'
      # With this prefix we could access to our API instead '/api'
      prefix :api
      # Indicates customers routes
      resource :customers do
        # Description of our method and what we are expecting
        desc 'Return list of customers'
        get do
          # Method to return all customers
          customers = Customer.all
          present customers
        end
      end
    end
  end
end
```

Our first endpoint is finished. Using postman, you can test your API and should return all customers created before on seeds.rb . 

You can also see the endpoint in the terminal by doing
```bash
$ rails grape:routes
```

