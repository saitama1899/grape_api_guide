# Basic usage and example of making an API with Grape

The point of this project is to learn how to use grape, define its tools, and as documentation for anyone who wants to understand how the core of the [main project](https://github.com/assimovt/badigeeks-api) will work.

Good practices that I'll recommend following this project and any project:
- Always try to write first the tests.
- Working and implementing little and functional steps everytime.
- After that, commit and push with a clear description with that what you done.

> This readme.md could also be as example to how to document with Markdown a readme file

## What is Grape?
[Grape](https://github.com/ruby-grape/) is a API framework for ruby language, it is used to write RESTful API for the existing web application that is already written in Rails or Sinatra framework. It has inbuilt option like common convention, multiple data/response format, versioning etc.

### Adventages of Grape in order to make an **API with Rails**

- You can easily document the API with description without writing separate API document.
- Easy and standard syntax of API endpoints.
- Easy way to format data for typical response.
- Adding new parameter and basic validation can be done easily.
- Definition of routes and API body is very decent and developer friendly.
- Grape API is much faster than any other API for rails application.
- Versioning support.

## Usage guide

Making the project
```bash
$ rails new grape_api_guide --api -T
```
> You can indicate a database adding --database=postgresql , for more options: ```$ rails new --help ```

### Gems that we will use
> The best practice in terms of adding gems to your gemfile is to specify the version. You can find it on [rubygems.org](https://rubygems.org/)

[Grape](https://github.com/ruby-grape/)

[Grape-Entity](https://github.com/ruby-grape/grape-entity): With Grape-Entity we could handle which attribute we would like to display in our API according to our models.

[Grape On Rails Routes](https://github.com/syedmusamah/grape_on_rails_routes): Very useful gem to visualize API routes.

[Faker](https://github.com/faker-ruby/faker): Easy and quickly way to populate fake data in DB

```bash
gem 'grape'
gem 'grape-entity'
gem 'grape_on_rails_routes'
```
```bash
bundle install
```