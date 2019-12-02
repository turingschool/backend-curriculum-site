---
layout: page
title: Refactoring API Consumption
length: 180
tags: apis, rails, refactoring
---

## Learning Goals

By the end of this class, a student should be able to:

* Refactor code that reaches an API from the controller into single responsibility POROS.

* Utilize two of the pillars of object oriented programming, abstraction and encapsulation, to guide their refactoring.

### Starting The Refactor

Right now, our app does what it’s supposed to do but there’s a good chance that it doesn’t “feel” right. Specifically, our `index` action in the controller is long, violates SRP and MVC, and the logic that lives in it isn’t reusable. Time to refactor.

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = <YOUR API KEY>
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results]
  end
end

```
When we write tests we should write code at the same layer of the application that the test is running. At this point it's common for students to jump to the controller and start the refactor there. This approach tends to lead to code that is difficult to pull together, maintain, and reuse.

We will let our feature test drive us and write the code we wish existed at the view layer.

### Declarative Programming

```
# app/views/search/index.html.erb

<%= search_results.member_count %> Results
<% search_results.members.each do |member| %>
<ul class="member">
  <li class="name"><%= member.name %></li>
  <li class="role"><%= member.role %></li>
  <li class="party"><%= member.party %></li>
  <li class="district"><%= member.district %></li>
</ul>
<% end %>
```

Here's the code we wish existed. Of course this doesn't work yet and we'll need to figure out how to make it work. This is often referred to as dream driven development at Turing and is more commonly referred to as [Declarative Programming](https://vimeo.com/131588133) outside of Turing. Simply put, we write the code we wish existed and worry about implementation details later.

We use this strategy in life all the time. A statement such as "I need to travel to New York City." is an example. There is no mention of _how_ we plan to get there. We could take a train, car, plane, bicycle, or some combination but those are details we will worry about later. Depending on your origin different strategies make more sense than others.

It's less likely, although perhaps more exciting, to select a means of travel without knowing the final destination. "I'd like to ride a train for 12 hours, a bus for 3 hours, and a boat for 2 hours. Where can I go?" There's a good chance you won't end up in NYC.

Writing code this way makes it more likely that we'll end up with abstractions that aren't vulnerable to breaking if implementation changes.

For example, currently we are using Propublica to retrieve this data but this data used to be provided by an API called The Sunlight Foundation. Google also makes some of this data available through their Civic API. By deciding how we want to interface with these objects and classes (picking our destination) prior to implementing API calls (how we are going to get there) we make this view more robust and less brittle. Imagine if we were parsing hashes here instead of objects. If the API changes, the keys of that hash likely change and this view suddenly stops working. We want to minimize the number of layers that need to change if we switch out our API.

### `locals` Instead of Instance Variables

The other thing that might stand out to you in the code above is the use of the local variable `search_results`. So why aren't we using an instance variable?

As the applications you build grow in complexity you'll find yourself using more and more partials. Partials are generally shared between multiple views. And one view can load several partials. There's a good chance you will reuse variable names at some point in some of these partials. Why is this potentially bad?

When you assign an instance variable in your controller it sets that value for _all_ of the views and partials associated with this page load. This makes it likely that someone will at some point override an instance variable accidentally. By using a local variable instead we will need to explicitly pass in our variables making for more robust code.

Another bonus is the errors will also be more helpful and easier to troubleshoot.

So why did we decide we wanted an object called `search_results`?

### The Four Pillars

Remember the four pillars of object oriented programming? These are abstraction, encapsulation, polymorphism, and inheritance. We adhere to these principles in order to help us write code that is readable, easier to maintain, extend and test. Today we will focus on two of the pillars, abstraction and encapsulation. Let's talk about abstraction first.

### Abstraction

Abstraction is a technique that allows us to hide unnecessary details from the user. In this example we will use abstraction to create a PORO, `search_results`, that serves as an interface that hides more complex behavior.

It's common for pages to require data from multiple locations. For example, a dashboard might need to reach out to multiple tables and perhaps make some API calls in order to display all of the required data. One strategy is to send in several instance variables which is likely what you have done up until this point.

Sandy Metz has a [list of rules for developers](https://thoughtbot.com/blog/sandi-metz-rules-for-developers) These rules are based on patterns observed through decades of object oriented programming with the intent of building applications that are less painful to maintain and change. One of those rules is "Controllers can instantiate only one object. Therefore, views can only know about one instance variable and views should only send messages to that object".

Creating a PORO allows us to send one object into the view. With this single object we can hide the implementation details from the view and shield it from changes that may occur in other parts of the application i.e if the JSON structure of our API response changes we do not need to change the view. We're going a step further here by not using an instance variable. The blog post linked above discusses this more in depth and has further reading if you are interested.

### The Law of Demeter

You'll also notice in the code we decided to go with `search_results.member_count` instead of `search_results.members.count`. This is in keeping with the second half of the rule above, `..views should only send messages to that object`. By defining a method in our PORO that contains the logic for counting members and calling that from the view as opposed to allowing the logic for counting members to reside in the view itself, our PORO is adhering to the [Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter).

Here are the core concepts of the LoD.

* Each unit should have only limited knowledge about other units: only units "closely" related to the current unit.
* Each unit should only talk to its friends; don't talk to strangers.
* Only talk to your immediate friends.


### Back to Coding

When we run our feature test it complains that we haven't defined `search_results`.

We need to do some work in our search controller. Sending in a local variable is a little different than sending in an instance variable.

A great way to approach refactoring in Ruby is to keep the working code at the bottom of the method and write the refactored code above the working implementation in that same method. Let’s add several newlines so it’s clear where the refactor attempt ends and the older implementation begins. This creates a nice safety net if the refactor goes poorly and prevents us from trying to remember what used to work.

```ruby
def index
  #app/controllers/search_controller.rb

  # declaring what we wish existed
  render locals: {
    search_results: # ???
  }


  # existing code
  state = params[:state]

  conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
    faraday.headers["X-API-KEY"] = <YOUR API KEY>
    faraday.adapter Faraday.default_adapter
  end

  response = conn.get("/congress/v1/members/house/#{state}/current.json")

  json = JSON.parse(response.body, symbolize_names: true)
  @members = json[:results]
end
```

What should we assign this local variable to be? This PORO is going to be specific to this view so we should name it in a way that makes the intent clear. Let's continue our declarative programming approach and reference a class we wish existed. For this example, let's go with `HouseMemberSearch`.


```ruby
#app/controllers/search_controller.rb

def index

  # declaring what we wish existed
  render locals: {
    search_results: HouseMemberSearch.new(params[:state])
  }


  # existing code
  state = params[:state]

  conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
    faraday.headers["X-API-KEY"] = <YOUR API KEY>
    faraday.adapter Faraday.default_adapter
  end

  response = conn.get("/congress/v1/members/house/#{state}/current.json")

  json = JSON.parse(response.body, symbolize_names: true)
  @members = json[:results]
end
```

Of course this is going to error out since there is no such thing as `HouseMemberSearch`. We're going to store this in a new directory to help keep things organized. Create a file under the following path: `app/poros/house_member_search.rb`. Rails will automatically load anything in the `app` directory. However, you will need to restart your server if the `poros` directory is new. After the initial restart any new POROS placed in there will be loaded and you _do not need to restart your server_.

We're not going to unit test this PORO. This is because this particular PORO's job is to pull in information from different places and combine it, in order to pass a single object to the view. If we write good feature tests and our PORO simply calls out to other objects that are thoroughly unit tested, the functionality should be well covered. However, there's nothing wrong with testing this PORO if you would like to and some might prefer being more thorough.

Let's create our class and run our tests.

```ruby
# app/poros/house_member_search_results.rb

class HouseMemberSearch
  attr_reader :state

  def initialize(state)
    @state = state
  end
end
```

We should be seeing an error mentioning something about an undefined method `member_count`.

Easy enough. Let's use declarative programming in this method as well...

```ruby
# app/poros/house_member_search.rb

class HouseMemberSearch
  attr_reader :state

  def initialize(state)
    @state = state
  end

  def member_count
    members.count
  end
end
```

Now our tests want a `members` method.

```ruby
# app/poros/house_member_search.rb

class HouseMemberSearch
  attr_reader :state

  def initialize(state)
    @state = state
  end

  def member_count
    members.count
  end

  def members
  end
end
```

Of course this method is returning `nil` and `nil` doesn't have `count` defined on it which fails our test. Let's try writing an implementation that works first and refactor once we get things working. This is common in feature testing and is frequently referred to as Red, Green, Refactor.

Let's move the code that makes the api call from the controller into the `members` method

```ruby
class HouseMemberSearch
  # code omitted

  def members
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = <YOUR API KEY>
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    json[:results]
  end
end
```

Our test now complains that we don't have a method `name` defined. When using TDD we will frequently run into errors like this. Our `members` method is returning a hash, however our test is looking for an object to be returned with a method `name` defined on it. Let's dream drive our object.


```ruby
class HouseMemberSearch
  # code omitted

  def members
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = <YOUR API KEY>
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    member_search_data = JSON.parse(response.body, symbolize_names: true)[:results]

    member_search_data.map do |member_data|
      Member.new(member_data)
    end
  end
end
```

Now our `members` method maps through the data returned from the api and returns an array of `Member` objects. Notice that as we dream drove we utilized more descriptive variables, changing our `json` variable to `member_search_data` so that you can easily tell what we are working with. Our test now complains that `Member` is undefined. Now is a great time to create a unit test to drive the design of our member object. we will place this PORO in our models directory because it's responsibility is to model or format the data we are receiving from the API.


```ruby
# spec/models/member_spec.rb

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

Our tests pass! Before we forget, let's remove the code we no longer need from the search controller. Before deleting the code, let's comment it out and make sure our tests still pass.

```ruby
#app/controllers/search_controller.rb

def index

  render locals: {
    search_results: HouseMemberSearch.new(params[:state])
  }


  # existing code
  # state = params[:state]
  #
  # conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
  #   faraday.headers["X-API-KEY"] = <YOUR API KEY>
  #   faraday.adapter Faraday.default_adapter
  # end
  #
  # response = conn.get("/congress/v1/members/house/#{state}/current.json")
  #
  # json = JSON.parse(response.body, symbolize_names: true)
  # @members = json[:results]
end
```

Run the tests and they should pass. Now it's safe to delete.

```ruby
#app/controllers/search_controller.rb

def index
  render locals: {
    search_results: HouseMemberSearch.new(params[:state])
  }
end

```

Right now, our app does what it's supposed to do but there's still a few things we need to clean up. Specifically, our `members` method in our `HouseMemberSearch` PORO is long, violates SRP, and the logic that lives in it isn't reusable. Time to refactor.

```ruby
class HouseMemberSearch
  def initialize(state)
    @state = state
  end

  def member_count
    members.count
  end

  def members
    # Declaring what we wish existed
    service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end



    # existing code
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = <YOUR API KEY>
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

One thing you may have noticed in the code above is that we have changed `attr_reader :state` into a private method. By doing so, we have utilized encapsulation.

### Encapsulation
Encapsulation is an OOP principle that allows us to simplify how we interface with an object by hiding the internal state and implementation details of the object and interacting only with public methods defined on the object. This prevents the internal state of the object from being modified unexpectedly by external code.


### Service objects
Why did we settle on using a local variable of `service`? Service objects are a way to create a layer of abstraction on top of logic that doesn't quite fit into our current MVC structure. We use service objects extensively in Rails applications, especially when we are dealing with logic that interacts with several objects or the complexity of a task doesn't fit neatly into any of the MVC layers we currently have.

Of course `service` isn't defined so let's do that.

```ruby
class HouseMemberSearch
  # code omitted

  def members
    # Declaring what we wish existed
    service = PropublicaService.new
    service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end

    # existing code
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

This test makes sure we are getting back all of the name/value pairs we are dependent on within our app. Let's run it and make it pass.

We already have the code written to make this pass. We just need to get it into the right place.

```ruby
# app/services/propublica_service.rb

class PropublicaService
  def members_by_state(state)
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = <YOUR API KEY>
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    member_search_data = JSON.parse(response.body, symbolize_names: true)[:results]
end
```

You'll notice that we didn't move over the instantiating of the `Member` objects. This is because we want the only job of this service to be to talk to Propublica (SRP). Formatting the data is separate responsibility and should be done elsewhere.

Run our service test and we should be good. Now run the feature test. When it passes we can update our `HouseMemberSearch` PORO. Before deleting code, let's comment it out and make sure the test still passes.

```ruby
class HouseMemberSearch
  # code omitted

  def members
    service.members_by_state(state).map do |member_data|
      Member.new(member_data)
    end




    # conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
    #   faraday.headers["X-API-KEY"] = <YOUR API KEY>
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
class HouseMemberSearch
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

We're getting close but notice that each time we call the `members` method we will make an API call despite the fact that the info will be the same. Let's use memoization to make fewer API calls.

```ruby
class HouseMemberSearch
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

There, that's better. Next up: We need to finish refactoring our service. There's a bit too much logic in one method. One easy refactor is to take local variables that are reusable and split them into their own methods. The `conn` variable is great for this.

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

We could also break out `response` but there's a good chance that we might want to make other API calls from this same class and then calling it response wouldn't make much sense.

Making a `GET` request and parsing JSON seems like a thing we might do over and over. Let's see if we can share that logic using declarative programming.

```ruby
# app/services/propublica_service.rb

class PropublicaService
  def members_by_state(state)
    # Declaring what we wish existed
    get_json("/congress/v1/members/house/#{state}/current.json")




    # Existing code
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
    # Declaring what we wish existed
    get_json("/congress/v1/members/house/#{state}/current.json")




    # Existing code
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

Tests are passing so let's comment out the previous implementation and confirm this works. Once it does delete the commented out code.

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
a module so it's reusable in other services but we'll stop here. It's also worth noting that memoizing at the service layer can lead to unintended consequences since the data we get back might become stale. This is particularly problematic when we run code that might last longer than the typical HTTP request/response cycle. An example of this might be a report that needs to run in the background and might take several minutes or longer to complete. For this reason we should
not memoize in this service.

Now our code does what it is supposed to do and also looks great.

As mentioned above developers have utilized the four pillars of OOP to drive the design and organization of code for several decades. Over time specific ways of organizing code have become industry standards. These are referred to as _design patterns_.

### Design Patterns

Design patterns are reusable solutions to commonly occuring problems. There are a lot of ruby design patterns that exist to solve all kinds of problems. You can find more information on design patterns in ruby in this [blog post](https://bogdanvlviv.com/posts/ruby/patterns/design-patterns-in-ruby.html). Let's focus on one design pattern in particular, the Facade pattern.

### Facade Pattern

The [Facade pattern](https://bogdanvlviv.com/posts/ruby/patterns/design-patterns-in-ruby.html#facade) is used to provide a single simplified interface for a more complex subsystem. Sound familiar? We implemented the Facade pattern when we created our `HouseMemberSearch` PORO. Using this pattern, We split the large multi-responsibility controller action into several well-tested single responsibility POROS while utilizing abstraction and encapsulation. This helped make our code more maintainable, extensible, and testable. Pretty fancy!


### Checks for Understanding
* What is declarative Programming?
* What are the benefits of using local variables rather than instance variables?
* What are the core concepts of the Law of Demeter?
* What is Abstraction in OOP?
* What is Encapsulation in OOP?
* Why are Service objects useful?
