---
layout: page
title: Consuming an API
length: 90
tags: apis, testing, controller tests, rails
---

## Consuming an API

### Learning Goals

* Can explain why API consumption is important/useful
* Understands the value and process of using BDD to solve a problem

### Warmup

* What are the advantages to OAuth?
* Why bother consuming an API? What does it offer us?
* Did you write any code you weren't happy with yesterday after we kicked off the project? Where?

### Workshop

We are going to use the Sunlight API to retrieve all legislators and committees that match a criteria - and we are going to test it using VCR.

#### 0. Setup

First, let's create a new Rails project.

```sh
$ rails new testing_3rd_party_apis --skip-spring --skip-turbolinks -T --database=postgresql
$ cd testing_3rd_party_apis
```

Add to your Gemfile:

```ruby
group :development, :test do
  gem 'rspec-rails'
end
```

```sh
$ bundle
$ rails g rspec:install
$ bundle exec rake db:create
```

We also need to add a few gems. We are going to add: [Faraday](https://github.com/lostisland/faraday), [Figaro](https://github.com/laserlemon/figaro).

* Faraday is an HTTP client library that provides an easy-to-use interface to make requests
* Figaro is simple, Heroku friendly and makes it easy to hide your secret configs in a Rails app

```
# Gemfile
....

gem 'faraday'
gem 'figaro'

```

Bundle your gems to install the new dependencies. To configure Figaro, we run `bundle exec figaro install`. Now we can add our secrets to `config/application.yml` which is already added to the `.gitignore`.

```sh
$ bundle exec figaro install
      create  config/application.yml
      append  .gitignore
```

#### 1. Preparing a service

We are going to create a Sunlight service in our application that can communicate with the Sunlight API. Let's create the services folder and a service file:

```sh
$ mkdir app/services
$ touch app/services/sunlight_service.rb
$ mkdir spec/services
$ touch spec/services/sunlight_service_test.rb
```

In `test/services/sunlight_service_test.rb`, add the following:

```rb
# test/services/sunlight_service_spec.rb
require 'rails_helper'

describe SunlightService do
  attr_reader :service

  before(:each) do
    @service = SunlightService.new
  end
end
```

At the top, we require the `rails_helper`. We also add a method that will create a new instance of the SunlightService (yet to be built) and add an attr_reader so we can easily reference it throughout the program.

Let's add a first test; `#legislators`. The purpose of the `legislators` method is to return all legislators that match a certain criteria. In this case, we are querying for all the female legislators. In `services/sunlight_service.rb` we need to make a call to the Sunlight API and ask for all female legislators.

```rb
# spec/services/sunlight_service_spec.rb
describe '#legislators' do
  it 'finds all female legislators' do
    legislators = @service.legislators(gender: "F")
    legislator  = legislators.first

    expect(legislators.count).to eq(20)
    expect(legislator[:first_name]).to eq('Liz')
    expect(legislator[:last_name]).to eq('Cheney')
  end
end
```

If we run `rspec` the errors ask us to create the SunglightService class.

```rb
# app/services/sunlight_service.rb
class SunlightService
end
```

#### 2. Exploring the API

The API call we need to make in order to make the test pass is the following:

```
http://congress.api.sunlightfoundation.com/legislators?gender=F
```

You can run that URL in the browser, replacing the last bit with your own API key.

* `http://congress.api.sunlightfoundation.com/` is the base url
* `legislators` is the endpoint
* `?gender=F` are the params we are sending

#### 3. Fetching legislators

If we run our test, it tells us that we don't have the method `legislators`. Before we go any further, let's create a connection to the Sunlight API using Faraday. In the `initialize` method we are creating a new connection with the base url. We also set the our API key as a param. In the legislators method we are just putting a `pry` for now.

```rb
# app/services/sunlight_service.rb
attr_reader :connection

def initialize
  @connection = Faraday.new('http://congress.api.sunlightfoundation.com')
end

def legislators(criteria)
  require 'pry'; binding.pry
end
```

If we run our tests and are caught by the pry, we can see what `connection` looks like. It's a Faraday instance and you should be able to find the params we just set. In the [Faraday docs](https://github.com/lostisland/faraday#usage) we see that it's pretty easy to make `get` requests.

```rb
# GET http://sushi.com/nigiri/sake.json
response = conn.get '/nigiri/sake.json'

# GET http://sushi.com/nigiri?name=Maguro
# and if we want to send additonal params
conn.get '/nigiri', { :name => 'Maguro' }
```

Now try to make a `get` request in the pry session.

```
[5] pry(#<SunlightService>)> connection.get('legislators', criteria)
```

In the body, we get a bunch of JSON back, and if you compare the values in the body with the JSON you get with the JSON you get from making the call in the browser you'll see it's the same.

```
http://congress.api.sunlightfoundation.com/legislators?gender=F
```

Ok. We know how to make the API call. We get data (JSON) back. To make better sense of it, we need to parse it.

First, let's add a private method `parse` that can parse our responses.

```rb
# app/services/sunlight_service.rb
private

def parse(response)
  JSON.parse(response.body, symbolize_names: true)
end
```

Then, let's build out the `legislators` method. Here, we are passing the response to our `parse` method, and from that return value we are accessing the values under the `results` key. I highly recommend putting a pry in this method and look at the response and see why we are accessing the `results` key.

```rb
# app/services/sunlight_service.rb
def legislators(criteria)
  parse(connection.get('legislators', criteria))[:results]
end
```

Run your tests... and we should have one passing test.

#### 4. Fetching committees

The process of fetching committees is fairly similar to how we fetched legislators. Let's start with a test:

```rb

# spec/services/sunlight_service_spec.rb
describe '#committees' do
  it 'can find a list of committees by chamber' do
    committees = service.committees(chamber: 'senate')
    committee  = committees.first

    expect(committees.count).to eq(20)
    expect(committee[:name]).to eq('Federal Spending Oversight and Emergency Management')
  end
end
```

Get the test passing by adding the `committees` method.

#### 5. Creating a Legislator model

We want to implement the following behavior:

```
$ Legislator.find_by({gender: 'F'}) #=> [<Legislator>, <Legislator>, <Legislator>, <Legislator>...]
```

Right now, we don't even have a Legislator model! Before we add the model, let's add a test file.

```sh
$ mkdir spec/models
$ touch spec/models/legislator_spec.rb
```

Cool, now let's add the test. Instead of accessing the SunlightService directly, we want to call a method on the Legislator to get Legislator objects back instead of just an array of hashes.

```rb
# spec/models/legislator_spec.rb
require 'rails_helper'

describe Legislator do
  describe '#find_by' do
    it 'finds legislators by gender' do
      legislators = Legislator.find_by(gender: 'F')
      legislator  = legislators.first

      expect(legislators.count).to eq(20)
      expect(legislator.class).to eq(Legislator)
      expect(legislator.first_name).to eq("Liz")
      expect(legislator.last_name).to eq("Cheney")
    end
  end
end
```

The test tells us to add the model.

```sh
$ touch app/models/legislator.rb
```

```rb
# app/models/legislator.rb
class Legislator
end
```

And add the method...

```rb
# app/models/legislator.rb
class Legislator

  def self.find_by(criteria)
  end

end
```

This is dynamic data we are getting from a 3rd party API and there's no need to store it in our database - we don't want to be in charge of data that we can easliy query for. But we still want to return Legislator objects from the `Legislator#find_by` method. To achieve this, we can use [OpenStruct](http://ruby-doc.org/stdlib-2.0.0/libdoc/ostruct/rdoc/OpenStruct.html).

OpenStruct is a data structure very similar to a hash but we can define methods on the instance. For example:

```sh
[1] pry(main)> require 'ostruct'
=> true
[2] pry(main)> person = OpenStruct.new
=> #<OpenStruct>
[3] pry(main)> person.name = "Lovisa"
=> "Lovisa"
[4] pry(main)> person.age = 24
=> 24
[5] pry(main)> person
=> #<OpenStruct name="Lovisa", age=24>
[6] pry(main)> person.class
=> OpenStruct
```

First, let's make the class inherit from OpenStruct. This enables us to call `Legislator.new({name: "Lovisa"})`, which will return a `Legislator` object with one property set; `name: "Lovisa"`.

Then, we need to create an instance of the SunlightService so we can trigger API requests from this model.

```rb
# app/models/legislator.rb
class Legislator < OpenStruct
  attr_reader :service

  def self.service
    @service ||= SunlightService.new
  end

  def self.find_by(criteria)
  end
end
```

Great! If we run our tests, nothing has changed. Now we need to use `service` to fetch all the legislators matching the given criteria, then map over the array of hashes we get back and create a `Legislator` object for each hash.

```rb
# app/models/legislator.rb
def self.find_by(criteria)
  service.legislators(criteria).map do |legislator|
    Legislator.new(legislator)
  end
end
```

Run the tests... and it should all be passing.

#### 6. Creating a Committee model

Similar to legislators, we want to be able to query for committees matching a given criteria and get `Committee` objects back.

```
$ Committee.find_by(chamber: 'senate') #=> [<Committee>, <Committee>, <Committee>, <Committee>...]
```

As you can see, the `committee_spec.rb` is very similar to `legislator_test.rb`.

```rb
# spec/models/committee_spec.rb
require 'rails_helper'

describe Committee do
  describe '#find_by' do
    it "returns committees by chamber" do
      committees = Committee.find_by(chamber: 'senate')
      committee  = committees.first

      expect(committees.count).to eq(20)
      expect(committee.class).to eq(Committee)
      expect(committee.name).to eq('Federal Spending Oversight and Emergency Management')
    end
  end
end
```

Make the test pass - if you get stuck, reference the `Legislator` model.

### Materials

* [Alternative Lesson Plan](https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/mocking_apis_v2.markdown)
* [Code-a-Long Notes](https://www.dropbox.com/s/3afogbj3qwuptj8/Turing%20-%20Testing%20an%20External%20API%20%28Notes%29.pages?dl=0)
* [Alternative Code-a-Long](https://www.dropbox.com/s/3x1vfhu9wdx2juj/Turing%20-%20Revisiting%20Testing%20an%20External%20API.pages?dl=0)
