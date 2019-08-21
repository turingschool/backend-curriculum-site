---
layout: page
title: Consuming an API Redux
length: 180
tags: apis, rails, faraday
---

## Consuming an API

### Learning Goals

By the end of this class, a student will be able to:

* Use BDD to build complex features
* Set up and configure Faraday for use with a Rails application.
* Use Faraday to connect to and retrieve information from third party external
APIs.
* Parse the information retrieved from a third party API.
* Create models to contain and model the information returned from an external
API.

### Summary

What we are going to be working on today is creating an app that reaches out
and consumes data from an external API, and then displays and formats that
data on a web page. The API we will be using is the ProPublica API, and we will
be using it to grab a list of Representatives from Congress.


We will accomplish that by starting with a user story.


```
As a user
When I visit "/"
And I select "Colorado" from the dropdown
And I click on "Locate Members of the House"
Then my path should be "/search" with "state=CO" in the parameters
And I should see a message "7 Results"
And I should see a list of 7 the members of the house for Colorado
And they should be ordered by seniority from most to least
And I should see a name, role, party, and district for each member
```

As you can see, it lines out all that we will do. Let's get started.


### Setup

We start by spinning up our rails app. We are going to call it House Salad.

Because we're getting information about the House of Representatives and we're
gonna toss it around. Kind of.

```sh
$ git clone https://github.com/turingschool-examples/house-salad-base house-salad
$ cd house-salad
```

```sh
$ rails db:create
$ rails db:migrate
```

Yes, we haven't created any migrations, but running rails db:migrate
will generate the `schema.rb` so we don't get an error when we start running
tests.

### Testing, All Day, Every Day

So we've got the basic setup.

Let's create our first test files.

```sh
$ mkdir spec/features/
$ touch spec/features/user_can_search_by_state_spec.rb
```

Now let's open up that file and translate our user story into a test.

```ruby
require 'rails_helper'


feature "user can search for house members" do

  scenario "user submits valid state name" do
    # As a user
    # When I visit "/"
    visit '/'

    select "Colorado", from: :state
    # And I select "Colorado" from the dropdown
    click_on "Locate Members of the House"
    # And I click on "Locate Members from the House"
    expect(current_path).to eq(search_path)
    # Then my path should be "/search" with "state=CO" in the parameters
    expect(page).to have_content("7 Results")
    # And I should see a message "7 Results"
    expect(page).to have_css(".member", count: 7)
    # And I should see a list of 7 the members of the house for Colorado

    within(first(".member")) do
      expect(page).to have_css(".name")
      expect(page).to have_css(".role")
      expect(page).to have_css(".party")
      expect(page).to have_css(".district")
    end
    # And they should be ordered by seniority from most to least
    # And I should see a name, role, party, and district for each member

  end
end
```

This test should look pretty straightforward.

And so we run our tests. We should get an error concerning a `search_path`.

Our form is sad about where we are trying to send information. So we are
going to have to add a route.

```ruby
get "/search", to: "search#index"
```

And of course, we need to create a controller with an index action and then create a corresponding view.

```ruby
# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
  end
end

```

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

The [Faraday gem](https://github.com/lostisland/faraday) is a library that will
allow us to make HTTP requests using Ruby. Rather than memorize the syntax we
use in this tutorial, make sure you get used to referencing the documentation of
whichever library you decide to use. Different APIs will have different
requirements for interacting with them and memorizing the syntax in this
tutorial won't be enough.

```ruby
# app/facades/house_member_search_results.rb

class HouseMemberSearchResults
  # code omitted

  def members
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['PROPUBLICA_API_KEY']
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  private
  attr_reader :state
end
```

When we assign `conn`, does this make an HTTP request? What are these lines of
code doing? (review the docs if you aren't sure)

You'll also notice we set the API key to reference an environment variable
(`ENV['PROPUBLICA_API_KEY']`). There are multiple ways to set this up. We'll
use [Figaro](https://github.com/laserlemon/figaro) since it also plays nice with
Heroku. Read the docs to see how it's used. It's worth noting that anytime we add a new
environment variable to our Rails app we will need to restart the server. If we
don't it will show up as `nil`.

In the code above, we set up a variable to hold the connection
information, we tell it the name of the server, and our API Key, which
is our password to be able to access the API. And then we use the get method
on the connection and pass it the end point we want to access. We store that
in the response local variable, and then we parse it.

At this point, we are sending the parsed result of the response to the view.
The view happily accepts this, but if we run the test, we can see that it's not
happy.

What do we get if we call `.class` on this `members` method? What do we get if we
call class on the first element in `members`?

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

### Checks for Understanding

* What does Faraday do?
* What is an API Key?
* What is a connection?
* What are headers?
* What don't you like about this code?
* Is our feature test enough?
* What are we missing?
* Do you like the index action in the search controller?
* How would you start to refactor this?

Our next step is to refactor this.
