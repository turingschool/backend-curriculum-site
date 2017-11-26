---
layout: page
title: Building an Internal API
subheading:
length: 90
tags: apis, testing, requests, rails
---

## Learning Goals

* Understand how an internal API works at a conceptual level
* Use request specs to cover an internal API
* Feel comfortable writing request specs that deal with different HTTP verbs (GET, POST, PUT, DELETE)

## Warmup

* What is an API in the context of web development?
* Why might we decide to expose information in a database we control through an API?
* Why might we create an API *not* to be consumed by others?
* What do we need to test in an API?
* How will our tests be different from feature tests we have implemented in the past?

## Overview

* Review of New Tools
* RSpec & Factory Girl Setup
* Creating Our First Test and Factory
* Api::V1::ItemsController#index
* Api::V1::ItemsController#show
* Api::V1::ItemsController#create
* Api::V1::ItemsController#update
* Api::V1::ItemsController#destroy

[Slides](../slides/building_an_internal_api)

## New Tools

### Testing

* `get 'api/v1/items'`: submits a get request to your application
* `response`: captures the response to a given request
* `JSON.parse(response)`: parses a JSON response

### Controller

* `render`: tells your controller what to render as a response
* `json: Item.all`: hash argument for render - converts Item.all to valid JSON

## Procedure

### 0. RSpec & Factory Girl Setup

Let's start by creating a new Rails project. If you are creating an api only Rails project, you can append `--api` to your rails new line in the command line.
Read [section 3 of the docs](http://edgeguides.rubyonrails.org/api_app.html) to see how an api-only rails project is configured.

```sh
$ rails new building_internal_apis -T -d postgresql --api
$ cd building_internal_apis
$ bundle
$ bundle exec rake db:create
```

Add `gem 'rspec-rails'` to your Gemfile.

```sh
$ bundle
$ rails g rspec:install
```

Now let's get our factories set up!

add `gem 'factory_bot_rails'` to your :development, :test block in your Gemfile.

```sh
$ bundle
$ mkdir spec/support/
$ touch spec/support/factory_bot.rb
```

Inside of the factory_bot.rb file:

```ruby
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

Inside of the rails_helper.rb file:

```ruby
require 'support/factory_bot'
```

### Versioned APIs

In software (and probably other areas in life) you're never going to know less about a problem than you do right now. Procrastination and being resolved to solve only immediate problems can be an effective strategy while writing software. Our assumptions are often wrong and we need to change what we build. When building APIs, we don't always know exactly how they will be used. Because of this, we should aim to build with the assumption that things will need to change.

Imagine we are serving up an API that several other companies and developers are using. Let's think through a simple example. Let's say we have an API endpoint of `GET /api/items/1` that returns a JSON response that includes an `id`, `title`, `description`, and `number_sold`. Now imagine that at a later date we no longer want to provide `number_sold` and instead want to replace it with a new attribute called `popularity`. What happens to all of our consumers that were dependent on `number_sold`?

We can provide a better experience for our clients by versioning our API. Instead of our endpoint being `GET /api/items/1` we can add an extra segment to our URL with a version number. Something like `GET /api/v1/items/1`. If we ever want to change our API in the future we can simply change the segment to represent the new API `GET /api/v2/items/1`. The big advantage here is we can have both endpoints served simultaneously to allow our clients to transition their code bases to use the newest version. Usually the intent is to shutdown the initial API since maintaining multiple versions can be a drain on resources. Most companies will provide a date that the deprecated API will be shutdown.

We'll be building a versioned API for this lesson.

### 1. Creating Our First Test

Now that our configuration is set up, we can start test driving our code. First, let's set up the test file.
In true TDD form, we need to create the structure of the test folders ourselves. Even though we are going to be creating controller files for
our api, users are going to be sending HTTP requests to our app. For this reason, we are going to call these specs `requests` instead of
`controller specs`. Let's create our folder structure.

```sh
$ mkdir -p spec/requests/api/v1
$ touch spec/requests/api/v1/items_request_spec.rb
```

Note that we are namespacing under `/api/v1`. This is how we are going to namespace our controllers, so we want to do the same in our tests.

On the first line of our test, we want to set up our data. We configured Factory Bot so let's have it generate some items for us.
We then want to make the request that a user would be making. We want a `get` request to `api/v1/items` and we would like to get
json back. At the end of the test we want to assert that the response was a success.

**spec/requests/api/v1/items_request_spec.rb**

```rb
require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success
  end
end
```

### 2. Creating Our First Model, Migration, and Factory

Let's make the test pass!

The first error that we should receive is

```sh
Failure/Error: create_list(:item, 3) ArgumentError: Factory not registered: item
```

This is because we have not created a factory yet. The easiest way to create a factory is to generate the model.

Let's generate a model.

```sh
$ rails g model Item name description:text
```

Notice that not only was the Item model created, but a factory was created for the item in
`spec/factories/items.rb`

Now let's migrate!

```sh
$ bundle exec rake db:migrate
== 20160229180616 CreateItems: migrating ======================================
-- create_table(:items)
   -> 0.0412s
== 20160229180616 CreateItems: migrated (0.0413s) =============================
```

Before we run our test again, let's take a look at the Item Factory that was generated for us.

**spec/factories/items.rb**

```rb
FactoryBot.define do
  factory :item do
    name "MyString"
    description "MyText"
  end
end
```

We can see that the attributes are created with auto-populated data using `My` and the attribute data type.
This is boring. Let's change it to reflect a real item.

**spec/factories/items.rb**

```rb
FactoryBot.define do
  factory :item do
    name "Banana Stand"
    description "There's always money in the banana stand."
  end
end
```

### 3. Api::V1::ItemsController#index

We're TDD'ing so let's run our tests again.

We should get the error `ActionController::RoutingError: No route matches [GET] "/api/v1/items"`
This is because we haven't created our controller yet so let's create it! Keep in mind the namespacing we used to setup the test directory.
`api/v1`

```sh
$ mkdir -p app/controllers/api/v1
$ touch app/controllers/api/v1/items_controller.rb
```

We can add the following to the controller we just made:

```rb
# app/controllers/api/v1/items_controller.rb
class Api::V1::ItemsController < ApplicationController
end
```

If we were to run our tests again, we should get the same error because we haven't setup the routing.

```rb
# config/routes.rb
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index]
    end
  end
```

Also, add the action in the controller:

```rb
# app/controllers/api/v1/items_controller.rb
class Api::V1::ItemsController < ApplicationController

  def index
  end

end
```

Great! We are successfully getting a response. But we aren't actually getting any data. Without any data or templates, Rails 5 API
will respond with `Status 204 No Content`. Since it's a `2xx` status code, it is interpreted as a success.

Now lets see if we can actually get some data.

```rb
# spec/requests/api/v1/items_request_spec.rb
require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
     create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_success

      items = JSON.parse(response.body)
   end
end
```

When we run our tests again, we get a semi-obnoxious error of `JSON::ParserError: A JSON text must at least contain two octets!`.
This just means that we need open and closing braces for it to actually be JSON. Either `[]` or `{}`

Well that makes sense. We aren't actually rendering anything yet. Let's render some JSON from our controller.

```rb
# app/controllers/api/v1/items_controller.rb
class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

end
```

And... our test is passing again.

Let's take a closer look at the response. Put a pry on line eight in the test, right below where we make the request.

If you just type `response` you can take a look at the entire response object. We care about the response body. If you enter `response.body` you can see the data that is returned from the endpoint. We are getting back two items that we never created - this is data served from fixtures. Please feel free to edit the data in the fixtures file as you see fit.

The data we got back is json, and we need to parse it to get a Ruby object. Try entering `JSON.parse(response.body)`. As you see, the data looks a lot more like Ruby after we parse it. Now that we have a Ruby object, we can make assertions about it.

```rb
# spec/requests/api/v1/items_request_spec.rb
require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end
end
```

Run your tests again and they should still be passing.

### 4. ItemsController#show

Now we are going to test drive the `/api/v1/items/:id` endpoint. From the `show` action, we want to return a single item.

First, let's write the test. As you can see, we have added a key `id` in the request:

```rb
# spec/requests/api/v1/items_request_spec.rb
  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end
```

Try to test drive the implementation before looking at the code below.
---

Run the tests and the first error we get is: `ActionController::RoutingError: No route matches [GET] "/api/v1/items/980190962"`, or some other similar route. Factory Bot has created an id for us.

Let's update our routes.

```rb
# config/routes.rb
namespace :api do
  namespace :v1 do
    resources :items, only: [:index, :show]
  end
end
```

Run the tests and... `The action 'show' could not be found for Api::V1::ItemsController`.

Add the action and declare what data should be returned from the endpoint:

```rb
def show
  render json: Item.find(params[:id])
end
```

Run the tests and... we should have two passing tests.

### 5. ItemsController#create

Let's start with the test. Since we are creating a new item, we need to pass data for the new item via the HTTP request.
We can do this easily by adding the params as a key-value pair. Also note that we swapped out the `get` in the request for a `post` since we are creating data.

Also note that we aren't parsing the response to access the last item we created, we can simply query for the last Item record created.

```rb
# spec/requests/api/v1/items_request_spec.rb
it "can create a new item" do
  item_params = { name: "Saw", description: "I want to play a game" }

  post "/api/v1/items", params: {item: item_params}
  item = Item.last

  assert_response :success
  expect(response).to be_success
  expect(item.name).to eq(item_params[:name])
end
```

Run the test and you should get `ActionController::RoutingError:No route matches [POST] "/api/v1/items"`

First, we need to add the route and the action.

```rb
# config/routes.rb
namespace :api do
  namespace :v1 do
    resources :items, only: [:index, :show, :create]
  end
end
```

```rb
# app/controllers/api/v1/items_controller.rb
def create
end
```

Run the tests... and the test fails. You should get `NoMethodError: undefined method 'name' for nil:NilClass`. That's because we aren't actually creating anything yet.

We are going to create an item with the incoming params. Let's take advantage of all the niceties Rails gives us and use strong params.

```rb
# app/controllers/api/v1/items_controller.rb
def create
  render json: Item.create(item_params)
end

private

  def item_params
    params.require(:item).permit(:name, :description)
  end
```

Run the tests and we should have 3 passing tests.

### 6. Api::V1::ItemsController#update

Like before, let's add a test.

This test looks very similar to the previous one we wrote. Note that we aren't making assertions about the response, instead we are accessing the item we updated from the database to make sure it actually updated the record.

```rb
# spec/requests/api/v1/items_request_spec.rb
it "can update an existing item" do
  id = create(:item).id
  previous_name = Item.last.name
  item_params = { name: "Sledge" }

  put "/api/v1/items/#{id}", params: {item: item_params}
  item = Item.find_by(id: id)

  expect(response).to be_success
  expect(item.name).to_not eq(previous_name)
  expect(item.name).to eq("Sledge")
end
```

Try to test drive the implementation before looking at the code below.
---

```rb
# config/routes.rb
namespace :api do
  namespace :v1 do
    resources :items, only: [:index, :show, :create, :update]
  end
end
```

```rb
# app/controllers/api/v1/items_controller.rb
def update
  render json: Item.update(params[:id], item_params)
end
```

### 7. Api::V1::ItemsController#destroy

Ok, last endpoint to test and implement: destroy!

In this test, the last line in this test is refuting the existence of the item we created at the top of this test.

```rb
# spec/requests/api/v1/items_request_spec.rb
it "can destroy an item" do
  item = create(:item)

  expect(Item.count).to eq(1)

  delete "/api/v1/items/#{item.id}"

  expect(response).to be_success
  expect(Item.count).to eq(0)
  expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
end
```

We can also use RSpec's [expect change](https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs/matchers/expect-change) method as an extra check. In our case, `change` will check that the numeric difference of `Item.count` before and after the block is run is `-1`.

```rb
it "can destroy an item" do
  item = create(:item)

  expect{delete "/api/v1/items/#{item.id}"}.to change(Item, :count).by(-1)

  expect(response).to be_success
  expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
end
```

Make the test pass.
---

```rb
# config/routes.rb
namespace :api do
  namespace :v1 do
    resources :items, except: [:new, :edit]
  end
end
```

```rb
# app/controllers/api/v1/items_controller.rb
def destroy
  Item.delete(params[:id])
end
```

Pat yourself on the back. You just built an API. And with TDD. Huzzah! Now go call a friend and tell them how cool you are.

## Supporting Materials

* [Getting started with Factory Bot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)
* [Use Factory Bot's Build Stubbed for a Faster Test](https://robots.thoughtbot.com/use-factory-girls-build-stubbed-for-a-faster-test) (Note that this post uses `FactoryGirl` instead of `FactoryBot`. `FactoryGirl` is the old name.)
* [Building an Internal API Short Tutorial](https://vimeo.com/185342639)
