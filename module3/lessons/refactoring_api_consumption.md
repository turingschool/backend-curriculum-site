---
layout: page
title: Refactoring API Consumption
length: 180
tags: apis, rails, refactoring
---

# Refactoring API Consumption

## Vocabulary

### Refactor

• to change code in a way that the end functionality still works as intended, but reorganizes it in a way to make it easier to maintain, easier to test, etc

### SRP

- Single Responsibility Principle; the ideal that a piece of code should be responsible for one kind of task
    - this can be at a class level, a method level, etc.

### Design Pattern

• an implementation of code which follows as much "industry standard" as possible to achieve clean organization of our code

### MVC

• Model, View, Controller design pattern; a way of organizing our code into logical portions where our "business logic" is managed by the Controller, the "data logic" is managed by the Models, and the "presentation logic" is managed by the Views

## Learning Goals

By the end of this class, a student should be able to:

- Refactor code that reaches an API from the controller
    - Refactoring will include the Facade design pattern and the Service design pattern
- Utilize two of the pillars of object oriented programming, abstraction and encapsulation, to guide their refactoring.

### Declarative Programming

Throughout this refactor, we will use a technique called [Declarative Programming](https://vimeo.com/131588133). This is also referred to as dream driven development. Simply put, we write the code we wish existed and worry about implementation details later.

We use this strategy in life all the time. A statement such as "I need to travel to New York City." is an example. There is no mention of *how* we plan to get there. We could take a train, car, plane, bicycle, or some combination but those are details we will worry about later. Depending on your origin different strategies make more sense than others.

It's less likely, although perhaps more exciting, to select a means of travel without knowing the final destination. "I'd like to ride a train for 12 hours, a bus for 3 hours, and a boat for 2 hours. Where can I go?" There's a good chance you won't end up in NYC.

Writing code this way makes it more likely that we'll end up with abstractions that aren't vulnerable to breaking if implementation changes.

For example, currently we are using Propublica to retrieve this data but this data used to be provided by an API called The Sunlight Foundation. Google also makes some of this data available through their Civics API. By deciding how we want to interface with these objects and classes (picking our destination) prior to implementing API calls (how we are going to get there) we make this view more robust and less brittle. Imagine if we were parsing hashes here instead of objects. If the API changes, the keys of that hash likely change and this view suddenly stops working. We want to minimize the number of layers that need to change if we switch out our API.

### Red, Green, Refactor

We will also be using the Red, Green, Refactor technique. Red refers to a failing test, green refers to a passing test, and refactoring refers to making changes to improve code. We want to start with a failing test and then make it pass (red to green). We already did that step in the previous lesson. Then we make a refactor to improve the code. As we make that refactor, our test will most likely break, so our goal is for that refactor to end with our tests passing again. This way, we can use our tests to check our work every step along the way. We want to try to keep our refactors small and get back to green as often as possible to maintain our functionality.

### Member Objects

Right now, our app does what it's supposed to do but it doesn’t FEEL GOOD. Specifically, our `index`action in the controller is long, violates SRP and MVC, isn't very abstract, the data isn't well encapsulated, and the logic that lives in it isn’t reusable. Time to refactor.

*app/controllers/search_controller.rb*

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results]
  end
end
```

And let’s also look at our view. The first thing we'll tackle is the last line in the controller, `@members = json[:results]`. We are passing an Array of Hashes to the view via `@members`. Let's take a look at the view:

*app/views/search/index.html.erb*

```html
<h1><%= @members.count %> Results</h1>
<% @members.each do |member| %>
  <ul class="member">
    <li class="name"><%= member[:name] %></li>
    <li class="role"><%= member[:role] %></li>
    <li class="party"><%= member[:party] %></li>
    <li class="district"><%= member[:district] %></li>
  </ul>
<% end %>
```

This code is not very abstract since all the implementation details of how to dig through that Hash are exposed. It's also not very encapsulated since all of the data is combined into this one giant array called `@members` rather than organized into logical containers.

So, what we want to do is create objects that will encapsulate that data and abstract away the details of how to interact with that data.

Let's declare the code we wish existed:

*app/controllers/search_controller.rb*

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["PROPUBLICA_API_KEY"]
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

When we run the tests, it complains that `Member` does't exist, so let's go make it. We're going to create this as a Plain Old Ruby Object (PORO), and not as a Model, since we don't intend to store this data in our database. Create a `poros` directory and put a `member.rb` file in there like so:

*app/poros/member.rb*

```ruby
class Member
end
```

Now our tests says wrong number of arguments for initialize. We need to accept our hash of attributes:

*app/poros/member.rb*

```ruby
class Member
  def initialize(attributes)
  end
end
```

Now our view is complaining about undefined method `[]` for a `Member` object. In our view, we are still treating the `@members` variable as an Array of Hashes, but now it is an Array of objects that we can call methods on:

*app/views/search/index.rb*

```html
<h1><%= @members.size %> Results </h1>
<% @members.each do |member| %>
  <ul class="member">
  <li class="name"><%= member.name %></li>
  <li class="role"><%= member.role %></li>
  <li class="party"><%= member.party %></li>
  <li class="district"><%= member.district %></li>
</ul>
<% end %>
```

Now we get undefined method `name` for our Member objects. All that's left to do is expose that data through `attr_readers`:

*app/poros/member.rb*

```ruby
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

*spec/poros/member_spec.rb*

```ruby
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

*app/controllers/search_controller.rb*

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end
end
```

It's still pretty long, violating SRP, and not abstract. A common refrain when developing rails apps is lightweight controllers. Ideally, the controller doesn't do any work itself but rather just coordinates between other parts of the application. Think of it as a CEO: it doesn't actually do anything, it just tells others what to do.

Let's do a little bit of declarative programming and write code that represents what we want it to look like. 

*app/controllers/search_controller.rb*

```ruby
class SearchController < ApplicationController
  def index
    @facade = SearchFacade.new(params[:state])
    # state = params[:state]

    # conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
    #   faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    # end

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

When we create Facades, we generally want to instantiate them because this will make things easier for us when our views may need to make multiple API calls. We can continue to only send one object to the view, as per the [Rules for Developers](https://thoughtbot.com/blog/sandi-metz-rules-for-developers).

### Back to Code:

So our long term goal is that we are going to send an Facade object to the view and this object will have a method called members, which will give us the members we need. Note that we’ve commented out all of the code in our controller that we are going to abstract away

When we run the tests here, we will get an error saying that it doesn’t know anything about a SearchFacade, so we are going to make it. First we are going to make a directory, `app/facades`

*app/facades/search_facade.rb*

```ruby
class SearchFacade
  def initialize(state)
    @state = state
  end

  def members
  end
end
```

We’ve made some changes now and since we are now sending a facade object to the view, we need to change our view to reflect this.

*app/views/search/index.html.erb*

```ruby
<h1><%= @facade.members.count %> Results </h1>
<% @facade.members.each do |member| %>
  <ul class="member">
  <li class="name"><%= member.name %></li>
  <li class="role"><%= member.role %></li>
  <li class="party"><%= member.party %></li>
  <li class="district"><%= member.district %></li>
</ul>
<% end %>
```

This is a little bit more of that dream driving. We are going to have the facade be in charge of all of the things. The members method will give us an array of member objects and we can also count that collection.

So if we run our tests now, it’s going to complain because we have nothing in our members method, so its going to return us a `nil`. We don’t wait a `nil`. 

We get rid of that nil by moving the code we commented out in our controller and adapting it to the structure we’ve built here.

*app/facades/search_facade.rb*

```ruby
class SearchFacade
  def initialize(state)
    @state = state
  end

  def members
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    end

    response = conn.get("/congress/v1/members/house/#{@state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end
end
```

The big adaptation we are making here is that we aren’t setting the state that is coming in from the params to a local variable. That information is coming in when we instantiate the facade and stored in an instance variable, so when we run that GET request, we’re just going to interpolate. 

So now if we run our tests we’re all GREEN. 

Our controller is now quite lightweight and is truly acting as that CEO.

We're not going to unit test our `SearchFacade` in this lesson, but you should absolutely do so. It is straight forward to test this facade object, because all we have to do is instantiate it with a string as an argument, and its member method should just return us an array of Member objects, making testing very straightforward.

### Service Objects

Looking at our members method, we can see that it is still quite long. It’s violating SRP because it’s both reaching out to the API to get that information we need AND it’s also creating Member objects for us. Our goal here is that we want to take out the code that interacts with the API into a separate class. Lets do some more of that declarative programming, or what I like to call it, Dream Driven Development. We dream about how we’d like our code to work and we make it happen.

*app/facades/search_facade.rb*

```ruby
class SearchFacade
  def initialize(state)
    @state = state
  end

	def members
    # conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
    #   faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    # end

    # response = conn.get("/congress/v1/members/house/#{@state}/current.json")

    # json = JSON.parse(response.body, symbolize_names: true)

    service = CongressService.new

    json = service.members_by_state(@state)
    
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end
end
```

We are making for ourselves a `CongressService` class, and its responsibility is that its going to give us the JSON that we need to make ourselves our Member objects. This service’s responsibility is going to purely focused around interacting with the API and getting us the information we need. It is convention that we call these objects services.

It’s good practice to abstract the name of the API that we are working with so anything outside of this class has no idea of how we are getting this data. Notice that we are calling it `CongressService` instead of `PropublicaService`. This class used to use an API from the Sunlight Foundation. Had we named it `SunlightService`, when the change occurred, we had to change the class name and then hunt for every place that we had referred to it as `SunlightService` by calling it `CongressService` instead, if we have to change what API we are using, any changes only have to occur inside that service.

At this point, if we run our tests it’s going to complain that it doesn’t know anything about our service, and so let’s make a new folder and add the service.

*app/services/congress_service.rb*

```ruby
class CongressService

end
```

We dream drove ourselves to making this service have a `members_by_state` method, and so lets add that.

*app/services/congress_service.rb*

```ruby
class CongressService
  def members_by_state(state)
  end
end
```

And now let’s move the code we had previously implemented in our facade here into our service.

*app/services/congress_service.rb*

```ruby
class CongressService
  def members_by_state(state)
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    JSON.parse(response.body, symbolize_names: true)
  end
end
```

We do have to make some changes to get this to work. We have to change `@state` to `state` as we are using the state that is passed to the method and no longer the instance variable that was stored in the facade.

We also are not going to set the parsed JSON to a variable. Remember that the last line of the method is what gets returned, so no need to store it in a local variable either.

If we run our tests, everything is passing again!

It’s important to note that we did not move over the creation of the `Member` objects. The ONLY job of this service is to talk to the Propublica API. The formatting and massaging of the data is a different responsibility to what happens in the service - it is the job of the facade.

**Keep your service objects super simple. Hit an endpoint, and get the facade a response. That is IT.**

Let's make one more refactor in our service. If we ever need to hit a different Propublica endpoint, for instance, to get members of the Senate, it would be nice if we could reuse that Faraday connection object. This object sets up the base url for the api and the api key, both things that will be consistent across API calls to Propublica, which makes it the perfect candidate to increase reusability. Since our members_of_house method is a class method, our `conn` method will also need to be a class method.

*app/services/congress_service.rb*

```ruby
class CongressService
  def members_by_state(state)
    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    end
  end
end
```

This is great, but our `member_by_state` is still doing too much, and we can pull out some more to make more code reusable even further.

*app/services/congress_service.rb*

```ruby
class CongressService
  def members_by_state(state)
    get_url("/congress/v1/members/house/#{state}/current.json")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    end
  end
end 
```

We should probably write a unit test for our service.

*spec/services/congress_service_spec.rb*

```ruby
require 'rails_helper'

describe CongressService do
  context "class methods" do
    context "#members_by_state" do
      it "returns member data" do
        search = CongressService.new.members_by_state("CO")
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

Note that we aren’t checking for specific data, such as the names of the members of Congress. This is important because API results can change, and having to investigate your tests whenever the API results change is a bad time. We don’t need to check the exact contents of the API results, but we do need to check that it’s giving us the data types we expect to get back.

### Checks for Understanding

- What is declarative Programming?
- What is Red, Green, Refactor?
- For each file we've touched (Controller, CongressFacade, Member, CongressService):
    - Is it Single Responsibility? How would you describe its responsibility?
    - Does it achieve Abstraction?
    - Does it achieve Encapsulation?
    

You can find functioning completed code here: [https://github.com/turingschool-examples/house-salad-7/tree/refactoring-api-consumption](https://github.com/turingschool-examples/house-salad-7/tree/refactoring-api-consumption)