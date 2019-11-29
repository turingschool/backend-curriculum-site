---
layout: page
title: Refactoring API Consumption
length: 180
tags: apis, rails, faraday
---

When we write tests we should write code at the same layer of the application that the test is running. At this point it's common for students to jump to the controller and try to get everything to work. This approach tends to lead to code that is difficult to pull together, maintain, and reuse.

Let's let our tests drive us and write the code we wish existed at the view layer.

### Declarative Programming

```
# app/views/search/index.html.erb

<%= facade.member_count %> Results
<% facade.members.each do |member| %>
<ul class="member">
  <li class="name"><%= member.name %></li>
  <li class="role"><%= member.role %></li>
  <li class="party"><%= member.party %></li>
  <li class="district"><%= member.district %></li>
</ul>
<% end %>
```

Here's the code we wish existed. Of course this doesn't work yet and we'll need to figure out how to make it work. This is often referred to as dream driven development at Turing and is more commonly referred to as [Declarative Programming](https://vimeo.com/131588133) outside of Turing. Simply put, we write code we wish existed and worry about implementation details later.

We use this strategy in life all the time. A statement such as "I'm need to travel to New York City." is an example. There is no mention of _how_ we plan to get there. We could take a train, car, plane, bicycle, or some combination but those are details we will worry about later. Depending on your origin different strategies make more sense than others.

It's less likely, although perhaps more exciting, to select a means of travel without knowing the final destination. "I'd like to ride a train for 12 hours, a bus for 3 hours, and a boat for 2 hours. Where can I go?" There's a good chance you won't end up in NYC.

Writing code this way makes it more likely that we'll end up with abstractions that aren't vulnerable to breaking if implementation changes.

For example, currently we are using Propublica to retrieve this data but this data used to be provided by an API called The Sunlight Foundation. Google also makes some of this data available through their Civic API. By deciding how we want to interface with these objects and classes (picking our destination) prior to implementing API calls (how we are going to get there) we make this view more robust and less brittle. Imagine if we were parsing hashes here instead of objects. If the API changes, the keys of that hash likely change and this view suddenly stops working. We want to minimize the number of layers that need to change if we switch out our API.

### `locals` Instead of Instance Variables

The other thing that might stand out to you in the code above is the use of the local variable `facade`. We'll talk about what a facade is in just a bit. So why aren't we using an instance variable?

As the applications you build grow in complexity you'll find yourself using more and more partials. Partials are generally shared between multiple views. And one view can load several partials. There's a good chance you will reuse variable names at some point in some of these partials. Why is this potentially bad?

When you assign an instance variable in your controller it sets that value for _all_ of the views and partials associated with this page load. This makes it likely that someone will at some point override an instance variable accidentally. By using a local variable instead we will need to explicitly pass in our variables making for more robust code.

Another bonus is the errors will also be more helpful and easier to troubleshoot. So why did we decide we wanted a local variable called `facade`?

### The Facade Pattern

The facade pattern is a design pattern common to object oriented programming. A facades is an object that serve as a front-facing interface that hides more complex behavior.

It's common for pages to require data from multiple locations. For example, a dashboard might need to reach out to multiple tables and perhaps make some API calls in order to display all of the required data. One strategy is to send in several instance variables which is likely what you have done up until this point.

Sandy Metz has a [list of rules for developers](https://thoughtbot.com/blog/sandi-metz-rules-for-developers) These rules are based on patterns observed through decades of object oriented programming with the intent of building applications that are less painful to maintain and change. One of those rules is "Controllers can instantiate only one object. Therefore, views can only know about one instance variable and views should only send messages to that object".

The facade allows us to send one object into the view. We're going a step further here by not using an instance variable but the core principle of limiting the view to one object is the core concept of the facade. The blog post linked above discusses this more in depth and has further reading if you are interested.

### The Law of Demeter

You'll notice in the code we decided to go with `facade.member_count` instead of `facade.members.count`. As a general rule, it's good for the facade to adhere to the [Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter). While there are times to break this rule, it's best to get some experience following it prior to deciding to violate it. You'll have better intuitions around the benefits and when to break it.

Here are the core concepts of the LoD.

* Each unit should have only limited knowledge about other units: only units "closely" related to the current unit.
* Each unit should only talk to its friends; don't talk to strangers.
* Only talk to your immediate friends.

### Back to Coding

When we run our feature test it complains that we haven't defined `facade`.

We need to do some work in our search controller. Sending in a local variable is a little different than sending in an instance variable.

```ruby
def index
  render locals: {
    facade: # ???
  }
end
```

What should we assign this local variable to be? This facade is going to be specific to this view so we should name it in a way that makes the intent clear. Let's continue our declarative programming approach and reference a class we wish existed. For this example, let's go with `HouseMemberSearchResults`.

```ruby
def index
  render locals: {
    facade: HouseMemberSearchResults.new(params[:state])
  }
end
```

Of course this is going to error out since there is no such thing as `HouseMemberSearchResults`. We're going to store this in a new directory to help keep things organized. Create a file under the following path: `app/facades/house_member_search_results.rb`. Rails will automatically load anything in the `app` directory. However, you will need to restart your server if the `facades` directory is new. After the initial restart any new facades placed in there will be loaded and you _do not need to restart your server_.

We're not going to unit test our facade. If we write a good feature tests and our facade simply calls out to other objects that are thoroughly unit tested the functionality should be well covered. There's nothing wrong with testing facades and some might prefer being more thorough.

Let's create our class and run our tests.

```ruby
# app/facades/house_member_search_results.rb

class HouseMemberSearchResults
  def initialize(state)
    @state = state
  end
end
```

We should be seeing an error mentioning something about an undefined method `member_count`.

Easy enough. Let's use declarative programming in this method as well...

```ruby
# app/facades/house_member_search_results.rb

class HouseMemberSearchResults
  # code omitted

  def member_count
    members.count
  end
end
```

Now our tests want a `members` method.

```ruby
# app/facades/house_member_search_results.rb

class HouseMemberSearchResults
  # code omitted

  def members
  end
end
```

Of course this method is returning `nil` and `nil` doesn't have `each` defined
on it which fails our test. Let's try writing an implementation that works first
and refactor once we get things working. This is common in BDD and is frequently
referred to as Red, Green, Refactor.

Before we write code that makes the API call, make sure you are able to access
the API using Postman or cURL.

Once you have a working API call let's transfer that knowledge into our Rails app.


Let's dream drive, or declare, the code we wish existed.

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

Our test now complains that we don't have `Member` defined. When using TDD and
we will frequently run into errors like this. This is the right moment to write
a unit test to drive the design of this code.

```ruby
require "rails_helper"

describe Member do
  it "exists" do
    attrs = {
      name: "Leslie Knope",
      district: "1",
      role: "Representative",
      party: "Pizza"
    }

    member = Member.new(attrs)

    expect(member).to be_a Member
    expect(member.name).to eq("Leslie Knope")
    expect(member.role).to eq("Representative")
    expect(member.party).to eq("Pizza")
    expect(member.district).to eq("1")
  end
end
```

And our model should look something like this.

```ruby
# app/models/member.rb

class Member
  attr_reader :name,
              :role,
              :party,
              :district,
              :seniority

  def initialize(attributes = {})
    @name       = attributes[:name]
    @role       = attributes[:role]
    @party      = attributes[:party]
    @district   = attributes[:district]
    @seniority  = attributes[:seniority].to_i
  end
end
```


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
