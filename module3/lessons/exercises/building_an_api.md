# Building an API Exercise

## Overview

- Versioned APIs
- Tutorial
    - RSpec & FactoryBot Setup
    - Creating our First Test and Factory
    - Api::V1::BooksController#index
    - Api::V1::BooksController#show
    - Api::V1::BooksController#create
    - Api::V1::BooksController#update
    - Api::V1::BooksController#destroy
    - Going above and beyond - Add Api::V2::BooksController#index

## Background: Versioned APIs

In software (and probably other areas in life) you’re never going to know less about a problem than you do right now. Procrastination and being resolved to solve only immediate problems can be an effective strategy while writing software. Our assumptions are often wrong and we need to change what we build.

When building APIs, we don’t always know exactly how they will be used. Because of this, we should aim to build with the assumption that things will need to change.

Imagine we are serving up an API that several other companies and developers are using. Let’s think through a simple example. Let’s say we have an API endpoint of `GET /api/books/1` that returns a JSON response that includes an `id`, `title`, `author`, `genre`, `summary` and `number_sold`. Now imagine that at a later date we no longer want to provide `number_sold` and instead want to replace it with a new attribute called `popularity`. What happens to all of our consumers that were dependent on `number_sold`?

We can provide a better experience for our clients (other developers) by versioning our API. Instead of our endpoint being `GET /api/books/1` we can add an extra segment to our URL with a version number. Something like `GET /api/v1/books/1`. If we ever want to change our API in the future we can simply change the segment to represent the new API `GET /api/v2/books/1`. The big advantage here is we can have both endpoints served simultaneously to allow our clients to transition their code bases to use the newest version. Usually the intent is to shutdown the initial API since maintaining multiple versions can be a drain on resources. Most companies will provide a date that the deprecated API will be shutdown.

We’ll be building a versioned API in this tutorial.

## Tutorial

### RSpec, Factory Bot Setup, Faker

Let’s start by creating a new Rails project. If you are creating an api only Rails project, you can append `--api` to your rails new line in the command line. Read [section 3 of the docs](http://edgeguides.rubyonrails.org/api_app.html) to see how an api-only rails project is configured.

```bash
$ rails new building_internal_apis -T -d postgresql --api
$ cd building_internal_apis
$ bundle
$ bundle exec rails db:create
```

Add `gem “rspec-rails”` to your :development, :test block in your Gemfile, along with `gem "pry"`.

```bash
$ bundle
$ rails g rspec:install
```

Now let's get our factories set up!

add `gem "factory_bot_rails"`, `gem "faker"` to your :development, :test block in your Gemfile. Remember to bundle afterwards.

Inside of the `rails_helper.rb` file add this to the `RSpec.configure` block:

```ruby
config.include FactoryBot::Syntax::Methods
```

### Creating Our First Test

Now that our configuration is set up, we can start test driving our code. First, let's set up the test file. In true TDD form, we need to create the structure of the test folders ourselves. Even though we are going to be creating controller files for our api, users are going to be sending HTTP requests to our app. For this reason, we are going to call these specs `requests` instead of `controller specs`. Let's create our folder structure.

```bash
$ mkdir -p spec/requests/api/v1
$ touch spec/requests/api/v1/books_request_spec.rb
```

Note that we are namespacing under `/api/v1`. This is how we are going to namespace our controllers, so we want to do the same in our tests.

On the first line of our test, we want to set up our data. We configured Factory Bot so let's have it generate some books for us. We then want to make the request that a user would be making. We want a `get` request to `api/v1/books` and we would like to get json back. At the end of the test we want to assert that the response was a success.

*spec/requests/api/v1/books_request_spec.rb*

```ruby
require 'rails_helper'

describe "Books API" do
  it "sends a list of books" do
    create_list(:book, 3)

    get '/api/v1/books'

    expect(response).to be_successful
  end
end
```

### Creating our First Model, Migration, and Factory

Let's make the test pass!

The first error that we should receive is:

```bash
1) Books API sends a list of books
     Failure/Error: create_list(:book, 3)

     KeyError:
       Factory not registered: "book"
     # ./spec/requests/api/v1/books_request_spec.rb:5:in `block (2 levels) in <top (required)>'
     # ------------------
     # --- Caused by: ---
     # KeyError:
     #   key not found: "book"
     #   ./spec/requests/api/v1/books_request_spec.rb:5:in `block (2 levels) in <top (required)>'
```

This is because we have not created a factory yet. The easiest way to create a factory is to generate the model.

Let's generate a model.

```bash
$ rails g model Book title author genre summary:text number_sold:integer
```

Notice that not only was the Book model created, but a factory was created for the book in `spec/factories/books.rb`

Now let's migrate!

```bash
$ bundle exec rails db:migrate
== 20230131213200 CreateBooks: migrating ======================================
-- create_table(:books)
   -> 0.0041s
== 20230131213200 CreateBooks: migrated (0.0042s) =============================
```

Before we run our test again, let's take a look at the Book Factory that was generated for us.

*spec/factories/books.rb*

```ruby
FactoryBot.define do
  factory :book do
    title { "MyString" }
    author { "MyString" }
    genre { "MyString" }
    summary { "MyText" }
    number_sold { 1 }
  end
end
```

We can see that the attributes are created with auto-populated data using `My` and the attribute data type. BORRRRINNNNNNG. Let’s use Faker to generate data for us.

*spec/factories/books.rb*

```ruby
FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    genre { Faker::Book.genre }
    summary { Faker::Lorem.paragraph }
    number_sold { Faker::Number.within(range: 1..1000) }
  end
end
```

### Api::V1::BooksController#index

We're TDD'ing so let's run our tests again.

We should get the error:

```bash

  1) Books API sends a list of books
     Failure/Error: get '/api/v1/books'

     ActionController::RoutingError:
       No route matches [GET] "/api/v1/books"
     # ./spec/requests/api/v1/books_request_spec.rb:7:in `block (2 levels) in <main>'
```

This is because we haven't yet set up our routing.

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index]
    end
  end
end
```

Let’s run our test again and sure enough, that changes our error.

```bash
1) Books API sends a list of books
     Failure/Error: get '/api/v1/books'

     ActionController::RoutingError:
       uninitialized constant Api

             Object.const_get(camel_cased_word)
                   ^^^^^^^^^^

                   raise MissingController.new(error.message, error.name)
                   ^^^^^
     # ./spec/requests/api/v1/books_request_spec.rb:7:in `block (2 levels) in <main>'
     # ------------------
     # --- Caused by: ---
     # NameError:
     #   uninitialized constant Api
     #
     #         Object.const_get(camel_cased_word)
     #               ^^^^^^^^^^
     #   ./spec/requests/api/v1/books_request_spec.rb:7:in `block (2 levels) in <main>'
```

Our routes file is telling our app to look for a directory `api` in our `controllers` directory, but that doesn't yet exist. Ultimately, we're going to need a controller. Let's go ahead and create that controller in this next step.

If you'd like, feel free to run your tests after creating the directory structure to see the new error confirming that we're looking for a controller.

```bash
$ mkdir -p app/controllers/api/v1
$ touch app/controllers/api/v1/books_controller.rb
```

We can add the following to the controller we just made:

*app/controllers/api/v1/books_controller.rb*

```ruby
class Api::V1::BooksController < ApplicationController
end
```

And then we also want to add the action to the controller.

*app/controllers/api/v1/books_controller.rb*

```ruby
class Api::V1::BooksController < ApplicationController
  def index
  end
end
```

So let’s run our test again, and good news we are successfully getting a response! But we aren't actually getting any data. Without any data or templates, Rails 5 API will respond with `Status 204 No Content`. Since it's a `2xx` status code, it is interpreted as a success.

Now lets see if we can actually get some data.

Let us add more to our test.

*spec/requests/api/v1/books_request_spec.rb*

```ruby
require 'rails_helper'

describe "Books API" do
  it "sends a list of books" do
    create_list(:book, 3)

    get '/api/v1/books'

    expect(response).to be_successful

    books = JSON.parse(response.body)
  end
end
```

When we run our tests again, we get a semi-obnoxious `JSON::ParserError`.

Well that makes sense. We aren't actually rendering anything yet. Let's render some JSON from our controller.

*app/controllers/api/v1/books_controller.rb*

```ruby
class Api::V1::BooksController < ApplicationController
  def index
    render json: Book.all
  end
end
```

And... our test is passing again.

Let's take a closer look at the response. Put a pry on line eight in the test, right below where we make the request.

If you just type `response` you can take a look at the entire response object. We care about the response body. If you enter `response.body` you can see the data that is returned from the endpoint.

The data we got back is json, and we need to parse it to get a Ruby object. Try entering  `JSON.parse(response.body)`. As you see, the data looks a lot more like Ruby after we parse it. Now that we have a Ruby object, we can make assertions about it.

*spec/requests/api/v1/books_request_spec.rb*

```ruby
require 'rails_helper'

describe "Books API" do
  it "sends a list of books" do
    create_list(:book, 3)

    get '/api/v1/books'

    expect(response).to be_successful

    books = JSON.parse(response.body, symbolize_names: true)

    expect(books.count).to eq(3)

    books.each do |book|
      expect(book).to have_key(:id)
      expect(book[:id]).to be_an(Integer)

      expect(book).to have_key(:title)
      expect(book[:title]).to be_a(String)

      expect(book).to have_key(:author)
      expect(book[:author]).to be_a(String)

      expect(book).to have_key(:genre)
      expect(book[:genre]).to be_a(String)

      expect(book).to have_key(:summary)
      expect(book[:summary]).to be_a(String)

      expect(book).to have_key(:number_sold)
      expect(book[:number_sold]).to be_an(Integer)
    end
  end
end
```

Run your tests again and they should still be passing.****

### BooksController#show

Now we are going to test drive the `/api/v1/books/:id` endpoint. From the `show` action, we want to return a single book.

First, let's add a test to our existing test file. As you can see, we have added a key `id` in the request:

*spec/requests/api/v1/books_request_spec.rb*

```ruby
it "can get one book by its id" do
  id = create(:book).id

  get "/api/v1/books/#{id}"

  book = JSON.parse(response.body, symbolize_names: true)

  expect(response).to be_successful

  expect(book).to have_key(:id)
  expect(book[:id]).to eq(id)

  expect(book).to have_key(:title)
  expect(book[:title]).to be_a(String)

  expect(book).to have_key(:author)
  expect(book[:author]).to be_a(String)

  expect(book).to have_key(:genre)
  expect(book[:genre]).to be_a(String)

  expect(book).to have_key(:summary)
  expect(book[:summary]).to be_a(String)

  expect(book).to have_key(:number_sold)
  expect(book[:number_sold]).to be_an(Integer)
end
```

## Try to test drive the implementation before looking at the code below!

Run the tests and the first error we get is:

```bash
1) Books API can get one book by its id
     Failure/Error: get "/api/v1/books/#{id}"

     ActionController::RoutingError:
       No route matches [GET] "/api/v1/books/31"
     # ./spec/requests/api/v1/books_request_spec.rb:39:in `block (2 levels) in <main>'
```

Let’s update our routes:

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :show]
    end
  end
end
```

Let’s run our tests and:

```bash
1) Books API can get one book by its id
     Failure/Error: get "/api/v1/books/#{id}"

     AbstractController::ActionNotFound:
       The action 'show' could not be found for Api::V1::BooksController
     # ./spec/requests/api/v1/books_request_spec.rb:39:in `block (2 levels) in <main>'
```

So right now we should add our action and then declare what data should be returned from the endpoint:

*app/controllers/api/v1/books_controller.rb*

```ruby
class Api::V1::BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def show
    render json: Book.find(params[:id])
  end
end
```

Run the tests and we should have two passing tests.

### BooksController#create

Let's start with adding the test to our test file. Since we are creating a new book, we need to pass data for the new book via the HTTP request. We can do this easily by adding the params as a key-value pair. Also note that we swapped out the `get` in the request for a `post` since we are creating data.

Also note that we aren't parsing the response to access the last book we created, we can simply query for the last Book record created.

*spec/requests/api/v1/books_request_spec.rb*

```ruby
it "can create a new book" do
  book_params = ({
                  title: 'Murder on the Orient Express',
                  author: 'Agatha Christie',
                  genre: 'mystery',
                  summary: 'Filled with suspense.',
                  number_sold: 432
                })
  headers = {"CONTENT_TYPE" => "application/json"}

  # We include this header to make sure that these params are passed as JSON rather than as plain text
  post "/api/v1/books", headers: headers, params: JSON.generate(book: book_params)
  created_book = Book.last

  expect(response).to be_successful
  expect(created_book.title).to eq(book_params[:title])
  expect(created_book.author).to eq(book_params[:author])
  expect(created_book.summary).to eq(book_params[:summary])
  expect(created_book.genre).to eq(book_params[:genre])
  expect(created_book.number_sold).to eq(book_params[:number_sold])
end
```

Run the test and you should get:

```ruby
1) Books API can create a new book
     Failure/Error: post "/api/v1/books", headers: headers, params: JSON.generate(book: book_params)

     ActionController::RoutingError:
       No route matches [POST] "/api/v1/books"
     # ./spec/requests/api/v1/books_request_spec.rb:75:in `block (2 levels) in <main>'
```

We have been to this rodeo before. Let’s add a route and an action:

*config/routes.rb*

```
namespace :api do
  namespace :v1 do
    resources :books, only: [:index, :show, :create]
  end
end
```

*app/controllers/api/v1/books_controller.rb*

```ruby
def create
end
```

We run the tests and we’re going to get an error.

```ruby
1) Books API can create a new book
     Failure/Error: expect(created_book.title).to eq(book_params[:title])

     NoMethodError:
       undefined method `title' for nil:NilClass

           expect(created_book.title).to eq(book_params[:title])

# ./spec/requests/api/v1/books_request_spec.rb:79:in `block (2 levels) in <main>'
```

This occurs because we aren’t actually creating anything yet.

We are going to create an book with the incoming params. Let's take advantage of all the niceties Rails gives us and use strong params.

*app/controllers/api/v1/books_controller.rb*

```ruby
def create
  render json: Book.create(book_params)
end

private

  def book_params
    params.require(:book).permit(:title, :author, :summary, :genre, :number_sold )
  end
```

We should now have three passing tests.

### BooksController#Update

Like before, let's add a test.

This test looks very similar to the previous one we wrote. Note that we aren't making assertions about the response, instead we are accessing the book we updated from the database to make sure it actually updated the record.

*spec/requests/api/v1/books_request_spec.rb*

```ruby
it "can update an existing book" do
  id = create(:book).id
  previous_name = Book.last.title
  book_params = { title: "Charlotte's Web" }
  headers = {"CONTENT_TYPE" => "application/json"}

  # We include this header to make sure that these params are passed as JSON rather than as plain text
  patch "/api/v1/books/#{id}", headers: headers, params: JSON.generate({book: book_params})
  book = Book.find_by(id: id)

  expect(response).to be_successful
  expect(book.title).to_not eq(previous_name)
  expect(book.title).to eq("Charlotte's Web")
end
```

### Try to test drive the implementation before you look at the code below.

*config/routes.rb*

```ruby
namespace :api do
  namespace :v1 do
    resources :books, only: [:index, :show, :create, :update]
  end
end
```

*app/controllers/api/v1/books_controller.rb*

```ruby
def update
  render json: Book.update(params[:id], book_params)
end
```

### BooksController#Destroy

Last one. Finally.

In this test, the last line in this test is refuting the existence of the book we created at the top of this test.

*spec/requests/api/v1/books_request_spec.rb*

```ruby
it "can destroy an book" do
  book = create(:book)

  expect(Book.count).to eq(1)

  delete "/api/v1/books/#{book.id}"

  expect(response).to be_successful
  expect(Book.count).to eq(0)
  expect{Book.find(book.id)}.to raise_error(ActiveRecord::RecordNotFound)
end
```

Alternatively, we can also use RSpec's [expect change](https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs/matchers/expect-change) method as an extra check. In our case, `change` will check that the numeric difference of `Book.count` before and after the block is run is `-1`.

*spec/requests/api/v1/books_request_spec.rb*

```ruby
it "can destroy an book" do
  book = create(:book)

  expect{ delete "/api/v1/books/#{book.id}" }.to change(Book, :count).by(-1)

  expect{Book.find(book.id)}.to raise_error(ActiveRecord::RecordNotFound)
end
```

Let’s make the test pass.

*config/routes.rb*

```ruby
namespace :api do
  namespace :v1 do
    resources :books
  end
end
```

*app/controllers/api/v1/books_controller.rb*

```ruby
def destroy
  render json: Book.delete(params[:id])
end
```

Congratulations you have done the thing. 

### One Step Further

At the beginning of this exercise we discussed the importance of versioning. So let's implement a v2 route for our books index that will return book `popularity` and not `number_sold`.

Let's begin by making a test. We will need to create a new `v2` directory to hold our `books_request_spec`.

```bash
$ mkdir -p spec/requests/api/v2
$ touch spec/requests/api/v2/books_request_spec.rb
```

And let’s add a test.

*spec/requests/api/v2/books_request_spec.rb*

```ruby
require 'rails_helper'

describe "Books API" do
  it "sends a list of books" do
    create_list(:book, 3)

    get '/api/v2/books'

    expect(response).to be_successful

    books = JSON.parse(response.body, symbolize_names: true)

    expect(books.count).to eq(3)

    books.each do |book|
      expect(book).to have_key(:id)
      expect(book[:id]).to be_an(Integer)

      expect(book).to have_key(:title)
      expect(book[:title]).to be_a(String)

      expect(book).to have_key(:author)
      expect(book[:author]).to be_a(String)

      expect(book).to have_key(:genre)
      expect(book[:genre]).to be_a(String)

      expect(book).to have_key(:summary)
      expect(book[:summary]).to be_a(String)

      expect(book).to have_key(:popularity)
      expect(book[:popularity]).to be_an(String)

      expect(book).to_not have_key(:number_sold)
    end
  end
end
```

And when we run our tests, we should see an error involving a missing route.

```bash
1) Books API sends a list of books
     Failure/Error: get '/api/v2/books'

     ActionController::RoutingError:
       No route matches [GET] "/api/v2/books"
     # ./spec/requests/api/v2/books_request_spec.rb:7:in `block (2 levels) in <main>'
```

So lets make ourselves an appropriate route:

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
    end

    namespace :v2 do
      resources :books, only: [:index]
    end
  end
end
```

Running our tests, we should get a new error:

```bash
1) Books API sends a list of books
     Failure/Error: get '/api/v2/books'

     ActionController::RoutingError:
       uninitialized constant Api::V2

             Object.const_get(camel_cased_word)
                   ^^^^^^^^^^

                   raise MissingController.new(error.message, error.name)
                   ^^^^^
     # ./spec/requests/api/v2/books_request_spec.rb:7:in `block (2 levels) in <main>'
     # ------------------
     # --- Caused by: ---
     # NameError:
     #   uninitialized constant Api::V2
     #
     #         Object.const_get(camel_cased_word)
     #               ^^^^^^^^^^
     #   ./spec/requests/api/v2/books_request_spec.rb:7:in `block (2 levels) in <main>'
```

This error is telling us that we are missing a v2 directory in the api folder within app/controllers. Add a new `v2`
 directory and `books_controller.rb`
 file.

```bash
$ mkdir -p app/controllers/api/v2
$ touch app/controllers/api/v2/books_controller.rb
```

And we also have to add something to the controller, I suppose.

*app/controllers/api/v2/books_controller.rb*

```ruby
class Api::V2::BooksController < ApplicationController
  def index
  end
end
```

If we run our tests now, we will get a JSON error because we aren’t actually returning anything.

```bash
1) Books API sends a list of books
     Failure/Error: books = JSON.parse(response.body, symbolize_names: true)

     JSON::ParserError:
       859: unexpected token at ''
     # ./spec/requests/api/v2/books_request_spec.rb:11:in `block (2 levels) in <main>'
```

Let’s fix it.

*app/controllers/api/v2/books_controller.rb*

```ruby
class Api::V2::BooksController < ApplicationController
  def index
    render json: Book.all
  end
end
```

We get past the error we were getting before, but it’s erroring out on the fact that we don’t yet have a popularity attribute.

```ruby
1) Books API sends a list of books
     Failure/Error: expect(book).to have_key(:popularity)
       expected `{:author=>"Keely Emard", :created_at=>"2023-01-31T23:31:16.307Z", :genre=>"Mystery", :id=>150, :numbe...atur sit. Sed eveniet placeat.", :title=>"Ah, Wilderness!", :updated_at=>"2023-01-31T23:31:16.307Z"}.has_key?(:popularity)` to be truthy, got false
     # ./spec/requests/api/v2/books_request_spec.rb:31:in `block (3 levels) in <main>'
     # ./spec/requests/api/v2/books_request_spec.rb:15:in `each'
     # ./spec/requests/api/v2/books_request_spec.rb:15:in `block (2 levels) in <main>'
```

We are going to create a migration to add it to our books table.

```bash
rails g migration AddPopularityToBooks popularity:string
```

Run the migration.

We need a way to calculate popularity so we are going to use a callback on our model. Check out the [rails docs](https://guides.rubyonrails.org/active_record_callbacks.html) to learn more about callbacks.

*app/models/book.rb*

```ruby
class Book < ApplicationRecord
before_save { |book| book.popularity = calculate_popularity }

private
  def calculate_popularity
    if number_sold > 5
      'high'
    else
      'low'
    end
  end
end
```

Awesome! Now we have our popularity attribute. Before we celebrate too early though, we still have a failing test because we are returning the `number_sold`. We need to customize our response a little bit more. For us to accomplish this, we are going to use something called a Serializer.

```bash
$ mkdir -p app/serializers
$ touch app/serializers/book_serializer.rb
```

*app/serializers/book_serializer.rb*

```ruby
class BookSerializer
  def self.format_books(books)
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        author: book.author,
        genre: book.genre,
        summary: book.summary,
        popularity: book.popularity
      }
    end
  end
end
```

Now that we have a serializer that formats our books for our json response we can use it in our controller.

*app/controllers/api/v2/books_controller.rb*

```ruby
class Api::V2::BooksController < ApplicationController
  def index
    books = Book.all
    render json: BookSerializer.format_books(books)
  end
end
```

Run our tests again and we should have a passing test! If you are still curious about serializers look ahead to the serializers lesson and do a little research.

## Supporting Materials

- [Getting started with Factory Bot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)
- [Use Factory Bot's Build Stubbed for a Faster Test](https://robots.thoughtbot.com/use-factory-girls-build-stubbed-for-a-faster-test) (Note that this post uses `FactoryGirl` instead of `FactoryBot`. `FactoryGirl` is the old name.)
- [Building an Internal API Short Tutorial](https://vimeo.com/185342639)

You can find a repo of this exercise completed in its entirety [here](https://github.com/turingschool-examples/building_internal_apis_7).
