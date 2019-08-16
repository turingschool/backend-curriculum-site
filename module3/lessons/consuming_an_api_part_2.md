---
layout: page
title: Consuming an API Part Two - Testing and Refactoring
length: 90
tags: apis, rails, faraday, refactoring, VCR
---

### Resources

* [Video](https://www.youtube.com/watch?v=FUYoJTtfJ20) showing how to setup Webmock and VCR

### Learning Goals

After this class, a student should be able to:
* Refactor code that reaches an API from the controller into its own service.
* Understand the four main advantages of using a network mocking gem to test
external APIs.
* Understand that stubbing can also help testing APIs.
* Configure and set up tests using VCR.

Right now, our app does what it's supposed to do but there's a good chance that
it doesn't "feel" right. Specifically, our `members` method in
`HouseMemberSearchResults` is long, violates SRP, and the logic that lives in it
isn't reusable. Time to refactor.

```ruby
class HouseMemberSearchResults
  # code omitted

  def members
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    member_search_data = JSON.parse(response.body, symbolize_names: true)[:results]

    member_search_data.map do |member_data|
      Member.new(member_data)
    end
  end

  private
  attr_reader :state
end
```

A great way to approach refactoring in Ruby is to keep the working code at the
bottom of the method and write the refactored code above the working
implementation in that same method. Let's add several newlines so it's clear
where the refactor attempt ends and the older implementation begins. This creates
a nice safety net if the refactor goes poorly and prevents us from trying to
remember what used to work.

```ruby
class HouseMemberSearchResults
  # code omitted

  def members
    # Declaring what we wish existed
    service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end



    # Current working implementation
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    member_search_data = JSON.parse(response.body, symbolize_names: true)[:results]

    member_search_data.map do |member_data|
      Member.new(member_data)
    end
  end

  private
  attr_reader :state
end
```

Why did we settle on using a local variable of `service`? Service objects are a
way of encapsulating logic that doesn't quite fit into our current MVC structure.
We use service objects extensively in Rails applications, especially when we are
dealing with logic that interacts with several objects or the complexity of a task
doesn't fit neatly into any of the MVC layers we currently have.

Of course `service` isn't defined so let's do that.

```ruby
class HouseMemberSearchResults
  # code omitted

  def members
    # Declaring what we wish existed
    service = PropublicaService.new
    service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end

    # Current working implementation
    # code omitted
```

And now we need to define `PropublicaService`. Let's write a test for that.

```ruby
# /spec/services/propublica_service_spec.rb

require 'rails_helper'

describe PropublicaService do
  context "instance methods" do
    context "#members_by_state" do
      it "returns member data" do
        search = subject.members_by_state("CO")
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array
        expect(search[:results].count).to eq 7
        member_data = search[:results].first

        expect(member_data).to have_key :name
        expect(member_data).to have_key :role
        expect(member_data).to have_key :district
        expect(member_data).to have_key :party
      end
    end
  end
end
```

This test makes sure we are getting back all of the name/value pairs we are
dependent on within our app. Let's run it and make it pass.

We already have the code written to make this pass. We just need to get it into
the right place.

```ruby
# app/services/propublica_service.rb

class PropublicaService
  def members_by_state(state)
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
```

You'll notice we didn't move over the instantiating of the `Member` objects.
This is because we want the only job of this service to be to talk to Propublica (SRP).
If this class needs to know about the `Member` class it now has an unnecessary
dependency. The facade needs the `Member` class and while it's a dependency it
isn't unnecessary.

Run our service test and we should be good. Now run the feature test. When
it passes we can update out facade. Before deleting code, let's comment it out.

```ruby
class HouseMemberSearchResults
  # code omitted

  def members
    service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end




    # conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
    #   faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
    #   faraday.adapter Faraday.default_adapter
    # end
    #
    # response = conn.get("/congress/v1/members/house/#{state}/current.json")
    #
    # member_search_data = JSON.parse(response.body, symbolize_names: true)[:results]
    #
    # member_search_data.map do |member_data|
    #   Member.new(member_data)
    # end
  end

  private
  attr_reader :state
end
```

Run the tests and they should pass. Now it's safe to delete.

```ruby
class HouseMemberSearchResults
  def member_count
    members.count
  end

  def members
    service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end
  end

  private
  attr_reader :state
end
```

We're getting close but notice that each time we call the `members` method we
will make an API call despite the fact that the info will be the same. Let's use
memoization to make fewer API calls.

```ruby
class HouseMemberSearchResults
  def member_count
    members.count
  end

  def members
    @members ||= service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end
  end

  private
  attr_reader :state
end
```

There, that's better. Next up: We need to finish refactoring our service.
There's a bit too much logic in one method. One easy refactor is to take local
variables that are reusable and split them into their own methods. The `conn`
variable is great for this.



```ruby
# app/services/propublica_service.rb

class PropublicaService
  def members_by_state(state)
    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  private

  def conn
    Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
```

We could also break out `response` but there's a good chance that we might want
to make other API calls from this same class and then calling it response wouldn't
make much sense.

Making a `GET` request and parsing JSON seems like a thing we might do over and
over. Let's see if we can share that logic using declarative programming.

```ruby
# app/services/propublica_service.rb

class PropublicaService
  def members_by_state(state)
    # What we wish existed
    get_json("/congress/v1/members/house/#{state}/current.json")




    # Working implementation
    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  private

  def conn
    Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
```

Run the tests and watch them fail. Let's follow the errors...

```ruby
class PropublicaService
  def members_by_state(state)
    # What we wish existed
    get_json("/congress/v1/members/house/#{state}/current.json")




    # Working implementation
    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def conn
    Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
```

Tests are passing so let's comment out the previous implementation and confirm
this works. Once it does delete the commented out code.

```ruby
class PropublicaService
  def members_by_state(state)
    get_json("/congress/v1/members/house/#{state}/current.json")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def conn
    Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
```

Much better. There's an opportunity to split the `get_json` method into
a module so it's reusable in other services but we'll stop here. It's also worth
noting that memoizing at the service layer can lead to unintended consequences
since the data we get back might become stale. This is particularly problematic
when we are run code that might last longer than the typical HTTP request/response
cycle. An example of this might be a report that needs to run in the background
and might take several minutes or longer to complete. For this reason we should
not memoize in this service.

Finally, all of our tests are making real API calls which is not good. There are
multiple ways to get around this. Use this video on [Stubbing External API calls with Webmock and VCR](https://www.youtube.com/watch?v=FUYoJTtfJ20).
