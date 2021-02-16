---
title: Customizing JSON in your API
length: 90
tags: json, javascript, rails, ruby, api
---

## Learning Goals

* Generate and customize Rails Serializers
* Understand what constitutes presentation logic in the context of serving a JSON API and why formatting in the model is not the right place

## Warmup

On your own, research serializers. In your notebook, write down the answers to these questions:

* What do serializers allow us to do?
* What resources were you able to find? Which seem most promising?
* What search terms did you use that gave the best results?

## Serializers

Serializers allow us to break from the concept of views fully with our API, and instead, mold that data in an object-oriented fashion. We don’t have views to do our dirty work for us anymore, so we rely on serializers in order to present to whomever is consuming our API what we want them to see.

When we call `render json:`, Rails makes a call to `as_json` under the hood unless we have a serializer set up. Eventually, `as_json` calls `to_json` and our response is generated.

With how we've used `render json:` up til now, all data related with the resources in our database is sent back to the client as-is.

Let's imagine that you don't just want the raw guts of your model converted to JSON and sent out to the user -- maybe you want to customize what you send back.


## Specifications for JSON response

Let's use the [json:api](https://jsonapi.org/) specification for our JSON responses. Take a minute to familiarize yourself with the documentation.

- What is the root `key`?
- How are the attributes formatted for a resource in a response?
- How are a resource's relationships formatted?

## Exercise

### Adding to Our Existing Project

You may have created a repo to code-along with the building and API video last Thursday during evals. Feel free to use the repository that you created. Otherwise, you can clone [this](https://github.com/turingschool-examples/building-apis) repo. Below are instructions for getting started from scratch.

```bash
git clone https://github.com/turingschool-examples/building-apis.git
```
```bash
bundle
```
```bash
git checkout complete-building-api-exercise
```
```bash
bundle exec rake db:create
```

We want to work with objects that have related models, so let's add a `Store` model:

```bash
rails g model store name
```
```bash
rails g model store_book store:references book:references book_price:integer quantity:integer
```
```bash
bundle exec rake db:migrate
```

Add relationships to your models:

```ruby
# in book.rb
has_many :store_books
has_many :stores, through: :store_books

# in stores.rb
has_many :store_books
has_many :books, through: :store_books
```

And whip together a quick seed file:

```ruby
#in seeds.rb
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

And seed

```ruby
bundle exec rake db:seed
```

Create the store controller and routes:

  - touch `controllers/api/v1/stores_controller.rb`
  - add controller setup for index and show

```ruby
# stores_controller
class Api::V1::StoresController < ApplicationController
  def index
  end

  def show
  end
end
```
  - Add the routes to our routes file
```ruby
namespace :api do
  namespace :v1 do
    resources :books
    resources :stores, only: [:index, :show]
  end
end
```
  - Set `index` and `show` methods to render appropriate json.

```ruby
# stores_controller
class Api::V1::StoresController < ApplicationController
  def index
    Store.all
  end

  def show
    Store.find(params[:id])
  end
end
```

### Responses

Use Postman to view the current responses that your API is providing to the routes listed below:

* api/v1/stores
* api/v1/stores/:id

So we have our responses from our server, but it isn’t JSON API 1.0 And it has this created at and updated at stuff which we don’t want. So what do we do? We need to use a serializer.


### Customizing JSON

1. Create a Store Serializer and try to build out a hash that will look like this __without__ using a gem:
```ruby
{
  "data": [
    {
      "id": "1",
      "type": "store",
      "attributes": {
        "id": 1,
        "name": "Toy, Steuber and Schinner",
        "num_books": 8,
        "active": true
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

### Using FastJSONAPI to modify `as_json`

Add this line to your Gemfile.

```
gem 'fast_jsonapi'
```

And then `bundle install`


We can now use the built in generator in order to make ourselves a serializer.

```rails g serializer Store id name```

This will add the appropriate attributes from the  Store model.  And give us only the id and store name.

Let’s check out what is in the Serializer.

```ruby
class StoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
```

So now we have this serializer, and we need to modify our controller.

```ruby
class Api::V1::OrdersController < ApplicationController
  def index
    render json: StoreSerializer.new(Store.all)
  end

  def show
    render json: StoreSerializer.new(Store.find(params[:id]))
  end
end
```

So what we are doing is instead of rendering the ActiveRecord stuff in json, we are sending it to the serializer, where the stuff gets serialized, and then that gets rendered as json.

But what if we wanted to show some awesome relationship action?

Easy.

```ruby
class StoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  has_many :books
end
```

Add that to your serializer and refresh.

What if we wanted a custom attribute? We can do so using this format.

Let’s say we wanted an attribute with the number of books.

```ruby
class StoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  has_many :books

  attribute :num_books do |object|
    object.books.count
  end
end
```

This syntax is a bit different from what we are used to. We use `attribute` singular, and then as a symbol we pick the name of what we want our attribute to be. We use a do end block similar to an enumerable with a block parameter. Now the block parameter, `object` is a lot like self. We get to use it for each single thing of a collection we pass to the serializer. We are essentially saying for each thing you serialize, grab the books and count them too. In this manner we can add a custom generated value for each book.

We can also have a custom static attribute like so:

```ruby
class StoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  has_many :books

  attribute :num_books do |object|
    object.books.count
  end

  attribute :active do
    true
  end
end
```

## Extra Practice

Do what we did to `Stores`, but for `Books` now.

- Some existing fields
  - `id`, `title`, `author`, `genre`, `summary`, `num_sold`
- Some custom fields
  - `num_stores`
- A relationship
  - `stores`

## Additional Resources

* [Jbuilder](https://github.com/rails/jbuilder)
* [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)
* [Nested Includes with fast_jsonapi](https://github.com/Netflix/fast_jsonapi/pull/152)
