---
layout: page
title: Refactoring API Consumption
length: 120
tags: apis, rails, refactoring
---

## Vocabulary

Refactor:
- to change code in a way that the end functionality still works as intended, but reorganizes it in a way to make it easier to maintain, easier to test, etc

SRP:
- Single Responsibility Principle; the ideal that a piece of code should be responsible for one kind of task
  - this can be at a class level, a method level, etc.

Design Pattern:
- an implementation of code which follows as much "industry standard" as possible to achieve clean organization of our code

MVC:
- Model, View, Controller design pattern; a way of organizing our code into logical portions where our "business logic" is managed by the Controller, the "data logic" is managed by the Models, and the "presentation logic" is managed by the Views


## Learning Goals

By the end of this class, a student should be able to:

* Refactor code that reaches an API from the controller
  - Refactoring will include the Facade design pattern, the Service design pattern

* Utilize two of the pillars of object oriented programming, abstraction and encapsulation, to guide their refactoring.


### Declarative Programming

Throughout this refactor, we will use a technique called [Declarative Programming](https://vimeo.com/131588133). This is also referred to as dream driven development. Simply put, we write the code we wish existed and worry about implementation details later.

We use this strategy in life all the time. A statement such as "I need to travel to New York City." is an example. There is no mention of _how_ we plan to get there. We could take a train, car, plane, bicycle, or some combination but those are details we will worry about later. Depending on your origin different strategies make more sense than others.

It's less likely, although perhaps more exciting, to select a means of travel without knowing the final destination. "I'd like to ride a train for 12 hours, a bus for 3 hours, and a boat for 2 hours. Where can I go?" There's a good chance you won't end up in NYC.

Writing code this way makes it more likely that we'll end up with abstractions that aren't vulnerable to breaking if implementation changes.

For example, currently we are using Propublica to retrieve this data but this data used to be provided by an API called The Sunlight Foundation. Google also makes some of this data available through their Civic API. By deciding how we want to interface with these objects and classes (picking our destination) prior to implementing API calls (how we are going to get there) we make this view more robust and less brittle. Imagine if we were parsing hashes here instead of objects. If the API changes, the keys of that hash likely change and this view suddenly stops working. We want to minimize the number of layers that need to change if we switch out our API.

### Red, Green, Refactor

We will also be using the Red, Green, Refactor technique. Red refers to a failing test, green refers to a passing test, and refactoring refers to making changes to improve code. We want to start with a failing test and then make it pass (red to green). We already did that step in the previous lesson. Then we make a refactor to improve the code. As we make that refactor, our test will most likely break, so our goal is for that refactor to end with our tests passing again. This way, we can use our tests to check our work every step along the way. We want to try to keep our refactors small and get back to green as often as possible to maintain our functionality.

### Member Objects

Right now, our app does what it's supposed to do but there’s a good chance that it doesn’t "feel" right. Specifically, our `index` action in the controller is long, violates SRP and MVC, isn't very abstract, the data isn't well encapsulated, and the logic that lives in it isn’t reusable. Time to refactor.

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = <YOUR API KEY>
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results]
  end
end
```

The first thing we'll tackle is the last line in the controller, `@members = json[:results]`. We are passing an Array of Hashes to the view via `@members`. Let's take a look at the view:

```erb
<h1><%=@members.size%> Results </h1>
<% @members.each do |member| %>
  <ul class="members">
  <li class="name"><%= member[:name]%></li>
  <li class="role"><%= member[:role]%></li>
  <li class="party"><%= member[:party]%></li>
  <li class="district"><%= member[:district]%></li>
</ul>
<% end %>
```

This code is not very abstract since all the implementation details of how to dig through that Hash are exposed. It's also not very encapsulated since all of the data is combined into this one giant array called `@members` rather than organized into logical containers.

So, what we want to do is create objects that will encapsulate that data and abstract away the details of how to interact with that data.

Let's declare the code we wish existed:

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = <YOUR API KEY>
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end
end
```

Here, we are imagining that we can map our Array of Hashes to an Array of Member objects.

When we run the tests, it complains that `Member` does't exist, so let's go make it. We're going to create this as a Plain Old Ruby Object (PORO), and not as a Model, since we don't intend to store this data in our database:


```ruby
# app/poros/member.rb

class Member
end
```

Now our tests says wrong number of arguments for initialize. We need to accept our hash of attributes:

```ruby
class Member
  def initialize(attributes)
  end
end
```

Now our view is complaining about undefined method `[]` for a `Member` object. In our view, we are still treating the `@members` variable as an Array of Hashes, but now it is an Array of objects that we can call methods on:

```erb
<h1><%=@members.size%> Results </h1>
<% @members.each do |member| %>
  <ul class="members">
  <li class="name"><%= member.name %></li>
  <li class="role"><%= member.role %></li>
  <li class="party"><%= member.party %></li>
  <li class="district"><%= member.district %></li>
</ul>
<% end %>
```

Now we get undefined method `name` for our Member objects. All that's left to do is expose that data through `attr_readers`:

```ruby
# app/poros/member.rb

class Member
  attr_reader :name,
              :role,
              :party,
              :district

  def initialize(attributes)
    @name       = attributes[:name]
    @role       = attributes[:role]
    @party      = attributes[:party]
    @district   = attributes[:district]
  end
end
```

We should now be back to green! That's a successful refactor. It would also be a good idea to add a test for the Member class:

```ruby
# spec/poros/member_spec.rb

require "rails_helper"

RSpec.describe Member do
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

### SearchFacade Object

Let's look at our Controller in it's current state:

```ruby
class SearchController < ApplicationController

  def index
    state = params[:state]

    conn = Faraday.new(url: 'https://api.propublica.org') do |faraday|
      faraday.headers['X-API-Key'] = ENV["PROPUBLICA_API_KEY"]
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")
    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end

end
```

It's still pretty long, violating SRP, and not abstract. A common refrain when developing rails apps is "Skinny Controllers". Ideally, the controller doesn't do any work itself but rather just coordinates between other parts of the application. Think of it as a CEO: it doesn't actually do anything, it just tells others what to do.

Let's declare what this might look like:

```ruby
class SearchController < ApplicationController

  def index
    @members = SearchFacade.members

    # state = params[:state]
    #
    # conn = Faraday.new(url: 'https://api.propublica.org') do |faraday|
    #   faraday.headers['X-API-Key'] = ENV["PROPUBLICA_API_KEY"]
    #   faraday.adapter Faraday.default_adapter
    # end
    #
    # response = conn.get("/congress/v1/members/house/#{state}/current.json")
    # json = JSON.parse(response.body, symbolize_names: true)
    # @members = json[:results].map do |member_data|
    #   Member.new(member_data)
    # end
  end
end
```

### What is a Facade?

In construction and architecture, a "facade" is like a "faceplate" or something that covers something more complex underneath. In software design, a Facade is a front-facing interface masking more complex underlying or structural code. To use our CEO and "company structure" analogy, a Facade is like "middle management" who knows who to organize to get a job done.

In our code, our Controllers will generally have one Facade, and the Facade should be named similarly to our Controller. In this case, our SearchController will call our SearchFacade.

When we make Facades, we will generally not need to instantiate them, and instead call class methods within them. (all methods defined in the class will need to be prefixed with "self." This saves our Ruby interpreter from having to clean up a lot of leftover objects by the time we're done our code today!

### Back to code:

We are imagining that we have this `SearchFacade` object that can give us all of our members through a single class method, `self.members`. Notice that we've also commented out all the Controller code that we want to abstract away.

When we run the tests, it complains about not finding `SearchFacade`, so let's go make it. First, we're going to create a new directory `app/facades`.

```ruby
# app/facades/search_facade.rb

class SearchFacade

end
```

Rails will automatically load anything in the `app` directory. However, you will need to restart your server if any directories created under /app/ are new. After the initial restart any new files placed in those directories will be loaded and you _do not need to restart your server_.

When we run the tests, it complains about not having a `members` method:

```ruby
# app/facades/search_facades.rb

class SearchFacade

  def self.members
  end

end
```

Now our test says undefined method `size` for `nil`. This makes sense since our members method is return nothing. We want this method to return all of our members. We can accomplish this by moving all that code we commented out before into this members method:

```ruby
# app/facades/search_facade.rb

class SearchFacade

  def self.members
    state = params[:state]

    conn = Faraday.new(url: 'https://api.propublica.org') do |faraday|
      faraday.headers['X-API-Key'] = ENV["PROPUBLICA_API_KEY"]
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")
    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end

end
```

Now our tests give us the error `undefined local variable or method 'params'` for our SearchFacade object. This is a Rails specific error: params are only accessible from the controller. So rather than trying to access them from inside this PORO, let's pass the parameter we want as an argument:

```ruby
class SearchController < ApplicationController

  def index
    @members = SearchFacade.members(params[:state])
  end
end
```

```ruby
# app/facades/search_facade.rb

class SearchFacade

  def self.members(state)
    conn = Faraday.new(url: 'https://api.propublica.org') do |faraday|
      faraday.headers['X-API-Key'] = ENV["PROPUBLICA_API_KEY"]
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")
    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end

end
```

Our tests are back to green! Another refactor down. Our controller is now quite skinny and is truly acting as that CEO.

We're not going to unit test our `SearchFacade` in this lesson, but it would be a really good idea to do so! Since it is a standalone class method which takes a string of input and returns a payload of data, it is very straightforward on how to write this kind of test and set expectations on what our data should look like. The good news is that if you unit test everything that the Facade interacts with, your Facade test can be quite short -- when I call a class method with this input, I expect to get back, in this case, an array of Member objects.

### Service Objects

Looking at our `.members` method, we can see that it is still quite long, violating SRP because it's also creating Member objects, and not very abstract. Let's separate the responsibility of interacting with the API into a separate class. Let's use declarative programming again:

```ruby
# app/facades/search_facade.rb

class SearchFacade

  def self.members(state)
    # conn = Faraday.new(url: 'https://api.propublica.org') do |faraday|
    #   faraday.headers['X-API-Key'] = ENV["PROPUBLICA_API_KEY"]
    #   faraday.adapter Faraday.default_adapter
    # end
    #
    # response = conn.get("/congress/v1/members/house/#{state}/current.json")
    # json = JSON.parse(response.body, symbolize_names: true)
    json = PropublicaService.members_of_house(state)

    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end

end
```

We're declaring that we have a `PropublicaService` object that has a class method we can call that will give us all the data we need to create our `Member` objects. (Again, we don't have to "new" up an object of our service). That `PropublicaService` method will handle all the details of how to interact with the Propublica API, abstracting away those details. It is convention to call these types of objects "Services".

**Note: It's also good practice to abstract the NAME of the API from which we're gathering data so anything outside of this class doesn't even get a hint of how/where we're getting this data. For example, calling this `GovernmentDataService` might be better, because maybe Propublica goes offline, or gets bought by a giant company and shut down, and now we have a ton of refactoring to do to change the name of our service class.**

When we run the tests, it doesn't know what `PropublicaService` is, so let's go make it. First, we will make a new folder `app/services`:

```ruby
# app/services/propublica_service.rb

class PropublicaService

end
```

Next, we need a `members_of_house` method, which we'll make as a class method:

```ruby
# app/services/propublica_service.rb

class PropublicaService
  def self.members_of_house(state)

  end
end
```

And finally, we need the code to actually hit the api, which is the code we commented out before:

```ruby
# app/services/propublica_service.rb

class PropublicaService
  def self.members_of_house(state)
    conn = Faraday.new(url: 'https://api.propublica.org') do |faraday|
      faraday.headers['X-API-Key'] = ENV["PROPUBLICA_API_KEY"]
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
```

And our test is passing again!

You'll notice that we didn't move over the instantiating of the `Member` objects. This is because we want the only job of this service to be to talk to Propublica (SRP). Formatting the data is separate responsibility and should be done elsewhere.

Let's make one more refactor in our service. If we ever need to hit a different Propublica endpoint, for instance, to get members of the Senate, it would be nice if we could reuse that Faraday connection object. This object sets up the base url for the api and the api key, both things that will be consistent across API calls to Propublica, which makes it the perfect candidate to increase reusability. Since our members_of_house method is a class method, our "conn" method will also need to be a class method.

```ruby
# app/services/propublica_service.rb

class PropublicaService
  def self.members_of_house(state)
    response = conn.get("/congress/v1/members/house/#{state}/current.json")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.propublica.org') do |faraday|
      faraday.headers['X-API-Key'] = ENV["PROPUBLICA_API_KEY"]
      faraday.adapter Faraday.default_adapter
    end
  end
end
```

It's also a good idea to unit test the service:


```ruby
# /spec/services/propublica_service_spec.rb

require 'rails_helper'

describe PropublicaService do
  context "instance methods" do
    context "#members_by_state" do
      it "returns member data" do
        search = PropublicaService.members_of_house("CO")
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array
        member_data = search[:results].first

        expect(member_data).to have_key :name
        expect(member_data[:name]).to be_a(String)

        expect(member_data).to have_key :role
        expect(member_data[:role]).to be_a(String)

        expect(member_data).to have_key :district
        expect(member_data[:district]).to be_a(String)

        expect(member_data).to have_key :party
        expect(member_data[:party]).to be_a(String)
      end
    end
  end
end
```

Notice how we aren't expecting specific data from the API such as the names of the representatives. We don't want our test to be too dependent on an external API where we don't have full control over what data we'll get back. But we SHOULD test that the fields of that data match a data type that we expect, such as strings, integers, arrays, etc.

### Checks for Understanding

* What is declarative Programming?
* What is Red, Green, Refactor?
* For each file we've touched (Controller, SearchFacade, Member, PropublicaService):
    * Is it Single Responsibility? How would you describe its responsibility?
    * Does it achieve Abstraction?
    * Does it achieve Encapsulation?
