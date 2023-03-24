---
title: Customizing JSON in your API
length: 90
tags: json, javascript, rails, ruby, api
---
# Customizing JSON in Your API

## Learning Goals

- Articulate what a serializer is and how to create one in a Rails application.
- Understand the purpose of serializers and how they support OOP Principles
- Understand what constitutes presentation logic in the context of serving a JSON API and why formatting in the model is not the right place

## Warmup

On your own, research serializers. In your notebook, write down the answers to these questions:

- What do serializers allow us to do?
- What resources were you able to find? Which seem most promising?
- What search terms did you use that gave the best results?

## Serializers

Serializers allow us to break from the concept of views fully with our API, and instead, mold that data in an object-oriented fashion. We don’t have views to do our dirty work for us anymore, so we rely on serializers in order to present to whomever is consuming our API what we want them to see.

When we call `render json:`, Rails makes a call to `as_json` under the hood unless we have a serializer set up. Eventually, `as_json` calls `to_json` and our response is generated.

With how we've used `render json:` up til now, all data related with the resources in our database is sent back to the client as-is.

Let's imagine that you don't just want the raw guts of your model converted to JSON and sent out to the user -- maybe you want to customize what you send back.

## Specifications for JSON Response

Let's use the [json:api](https://jsonapi.org/) specification for our JSON responses. Take a minute to familiarize yourself with the documentation.

- What is the root `key`?
- How are the attributes formatted for a resource in a response?
- How are a resource's relationships formatted?

## Exercise

### Adding to our Existing Project

You may have created a repo to code-along with from the [Building an API in Rails](https://backend.turing.edu/module3/lessons/building_a_rails_api)
 lesson. Feel free to use the repository that you created. Otherwise, you can clone [this]([https://github.com/turingschool-examples/building_an_api_2210](https://github.com/turingschool-examples/building_internal_apis_7))
 repo, and use the `main` branch. Below are instructions for getting started with this repo.

```bash
$ bundle
```

```bash
$ bundle exec rails db:{drop,create,migrate,seed}
```

We want to work with objects that have related models so we will add a `Store` model and connect that to our `Book`

```bash
$ rails g model store name
```

```bash
$ rails g model store_book store:references book:references book_price:integer quantity:integer
```

```bash
$ bundle exec rails db:migrate
```

And now with our migrations run, let us add the relationships to our models.

*app/models/book.rb*

```ruby
has_many :store_books
has many :stores, through: :store_books
```

*app/models/store.rb*

```ruby
has_many :store_books
has_many :books, through: :store_books
```

And now, we can whip together a seeds file.

*db/seeds.rb*

```ruby
20.times do
  Book.create!(
    title: Faker::Book.title,
    author: Faker::Book.author,
    genre: Faker::Book.genre,
    summary: Faker::Lorem.paragraph,
    number_sold: Faker::Number.within(range: 1..10)
  )
end

5.times do
  Store.create!(
    name: Faker::Company.name
  )
end

books = Book.all

books.each do |book|
  store_id_1 = rand(1..5)
  store_id_2 = rand(1..5)

  StoreBook.create!([
      {
        book_id: book.id,
        store_id: store_id_1,
        book_price: rand(100..10000),
        quantity: rand(1..10)
      },
      {
        book_id: book.id,
        store_id: store_id_2,
        book_price: rand(100..10000),
        quantity: rand(1..10)
      }
    ])
end
```

Now that we have a seed file, lets actually seed our development database.

```bash
$ bundle exec rails db:seed
```

You can confirm this worked by opening your rails console and taking a look at the contents of your development database.

Now we are going to create a controller for the store and some routes.

```bash
$ touch app/controllers/api/v1/stores_controller.rb
```

*app/controllers/api/v1/stores_controller.rb*

```ruby
class Api::V1::StoresController < ApplicationController
  def index
  end

  def show
  end
end
```

And we have to add our routes:

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
      resources :stores, only: [:index, :show]
    end

    namespace :v2 do
      resources :books, only: [:index]
    end
  end
end
```

And now we have to write the appropriate code in our controller.

*api/controllers/api/v1/stores_controller.rb*

```ruby
class Api::V1::StoresController < ApplicationController
  def index
    render json: Store.all
  end

  def show
    render json: Store.find(params[:id])
  end
end
```

## Responses

Use Postman to view the current responses that your API is providing to the routes listed below:

- api/v1/stores
- api/v1/stores/:id

So we have our responses from our server, but it isn’t JSON API 1.0 And it has this created at and updated at stuff which we don’t want. So what do we do? We need to use a serializer.

## Customizing JSON

This is some practice time for you. 

1. Create a serializer for `Store` and build out a hash that will look like the following *WITHOUT THE USE OF A GEM.* (You only need to do this for the show)

```ruby
{
  "data": [
    {
      "id": "1",
      "type": "store",
      "attributes": {
        "name": "Toy, Steuber and Schinner",
        "num_books": 8
      },
      "relationships": {
        "books": {
          "data": [
            {
              "id": "1",
              "type": "book"
            },
            {
              "id": "4",
              "type": "book"
            }
          ]
        }
      }
    }
  ]
}
```

That was a pain in the butt, wasn’t it? Creating serializers by hand that are JSON API 1.0 for everything we want to make an API for can certainly be time consuming. There are better ways.

## Using the jsonapi-serializer gem

You can view the docs on the jsonapi-serializer gem [here](https://github.com/jsonapi-serializer/jsonapi-serializer#installation).

Add it to your Gemfile

```ruby
gem "jsonapi-serializer"
```

And go ahead and

```bash
$ bundle install
```

This gem gives us a built in generator to make ourselves all of the serializers we could possibly want.

```bash
$ rails g serializer Store name
```

We can take a look and see what’s inside it.

*app/serializers/store_serializer.rb*

```ruby
class StoreSerializer
  include JSONAPI::Serializer
  attributes :name
end
```

Now that we have our serializer, we need to edit our controller to use said serializer.

*app/controllers/api/v1/stores_controller.rb*

```ruby
class Api::V1::StoresController < ApplicationController
  def index
    render json: StoreSerializer.new(Store.all)
  end

  def show
    render json: StoreSerializer.new(Store.find(params[:id]))
  end
end
```

We can see that instead of just letting our ActiveRecord be rendered in JSON, we are going to take our collections, and send them to the serializer, and have the result of THAT be converted to JSON.

What we have here is all fine, but it still lacks our relationship information. We don’t know anything about books that belong to the particular stores.

First, we add a line to our serializer.

*app/serializers/store_serializer.rb*

```ruby
class StoreSerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :books
end
```

If we try to run Postman again, it fails and tells us that it’s trying to look for a serializer for our book, but it can’t find one, so it is up to us to create one. 

```ruby
$ rails g serializer Book title author genre summary number_sold
```

Restart our server and we should start to see some books. 

We also have the ability to add our own custom attributes. What if we wanted an attribute that told us how many books each store had?

*app/serializers/store_serializer.rb*

```ruby
class StoreSerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :books

  attribute :num_books do |object|
    object.books.count
  end
end
```

This syntax is a bit different from what we are used to. We use `attribute` singular, and then as a symbol we pick the name of what we want our attribute to be. We use a do end block similar to an enumerable with a block parameter. Now the block parameter, `object` is a lot like self. We get to use it for each single thing of a collection we pass to the serializer. We are essentially saying for each thing you serialize, grab the books and count them too. In this manner we can add a custom generated value for each book.

We can also have a custom static attribute like so:

*app/serializers/store_serializer.rb*

```ruby
class StoreSerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :books

  attribute :num_books do |object|
    object.books.count
  end

  attribute :active do
    true
  end
end
```

Alternatively we could create a num_books method in our `Store` model and then set it as an attribute in our serializer:

*app/models/store.rb*

```ruby
class Store < ApplicationRecord
  has_many :store_books 
  has_many :books, through: :store_books
  
  def num_books
    self.books.count
  end 
end
```

*app/serializers/store_serializer.rb*

```ruby
class StoreSerializer
  include JSONAPI::Serializer
  attributes :name, :num_books

  has_many :books
  
  attribute :active do
    true
  end
end
```

Completed version of this lesson to this point is available [here](https://github.com/turingschool-examples/building_internal_apis_7/tree/customizing-json).

## Extra Practice

Do what we did to `Stores`, but for `Books` now.

- Some existing fields
    - `id`, `title`, `author`, `genre`, `summary`, `num_sold`
- Some custom fields
    - `num_stores`
- A relationship
    - `stores`

## Additional Resources

- [Jbuilder](https://github.com/rails/jbuilder)
- [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)
- [Nested Includes with fast_jsonapi](https://github.com/Netflix/fast_jsonapi/pull/152)
