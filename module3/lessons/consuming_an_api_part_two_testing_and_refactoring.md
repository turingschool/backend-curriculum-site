---
layout: page
title: Consuming an API Part Two - Testing and Refactoring
length: 90
tags: apis, rails, faraday, refactoring, VCR
---

### Learning Goals

After this class, a student should be able to:
* Refactor code that reaches an API from the controller into its own service.
* Understand the four main advantages of using a network mocking gem to test
external APIs.
* Understand that stubbing can also help testing APIs.
* Configure and set up tests using VCR.

Right now, we should be very unhappy with how our app looks. Not in terms of what it does, but how it looks. How fat is our controller? Very.

We want to make it so that we have skinny controllers and fat models. So let's
just pull things out of our controller and into our model.

So let's just do a bit of dream driven development here.

What if our controller index action looked like this:

```
# app/controllers/search_controller.rb

class SearchController < ApplicaitonController

	def index
		@members = Member.find_all(params[:state])
	end
end

```

So now, we have to move our code into the model, and that should look like this.

```
# app/models/member.rb

def find_all(state)

    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["propublica_key"]
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("/congress/v1/members/house/#{state}/current.json")

    results = JSON.parse(response.body, symbolize_names: true)[:results]

    @members  = results.map do |result|
      Member.new(result)
    end
end

```

This is a bit better, but it isn't completely what we want. We have moved code out of
the controller but the find_all method here is still a bit much. It's setting up a
connection to the API endpoint, and getting a response, and then parsing it.

We need to pull more out. This is where we implement a service.

We want to pull out all of the code that is involved with the API to a service.

Let's think about what should be in `member.rb` and what should not be in there.

Stuff dealing with contacting the API should be pulled out. Stuff dealing with sorting
and converting to the proper object should remain the same.

Let's do some DDD. We want to call a method on a service that will return us an
array of hashes of raw member info like we had previously.

It should look like this.

```
def find_all(state)
	members = PropublicaService.find_house_members(state).map do |raw_member|
		Member.new(raw_member)
	end

	sort_members(members)
end

```

And we are pulling everything out to a service which will look like this

```
# app/services/propublica_service.rb

class PropublicaService

  def self.find_house_members(state)
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ""
      faraday.adapter  Faraday.default_adapter
    end

    response = @conn.get("/congress/v1/members/house/#{state}/current.json")

    results = JSON.parse(response.body, symbolize_names: true)[:results]
  end
end

```

This is great - we have all of our stuff concerning the connection to the API
and getting information from it in a single place.

But we have to ask the same thing that we did earlier - are we happy with
this method? It's still doing a bit much, so let's pull some stuff out.

```
class PropublicaService

  def initialize(state)
    @state = state
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def find_house_members
    response = @conn.get("/congress/v1/members/house/#{state}/current.json")
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def self.find_house_members(state)
    new(state).find_house_members
  end
end
```

This is great, but we can do one step better.


```
class PropublicaService

  def initialize(state)
    @state = state
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def find_house_members
    get_url("/congress/v1/members/house/#{state}/current.json")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def self.find_house_members(state)
    new(state).find_house_members
  end
end
```

What we've done here is created a get_url method which is a very
general method that will take an endpoint, grab the data, parse it, and
send it back.



### Testing


So we've got everything working, but we haven't really considered testing.

Let's add some gems to our Gemfile.

```
group :test do
  gem 'vcr'
  gem 'webmock'
end
```

We need to configure webmock and VCR in our spec/rails_helper.rb. Below the line that requires rspec/rails, add lines to include webmock/rspec and vcr. We also add a VCR configuration block where we declare where it should look for cassettes (more on cassettes below).


```
# spec/rails_helper.rb

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
end
```

Add this line to your .gitignore

```
/spec/cassettes
```


So now, let's write a test for our service.

```
# spec/services/propublica_service_spec.rb

require 'rails_helper'

describe PropublicaService do

  describe "members" do
    it "finds all CO members" do
      VCR.use_cassette("services/find_co_members") do
        members = PropublicaService.find_house_members("CO")
        member = members.first

        expect(members.count).to eq(7)
        expect(member[:name]).to eq("Diana DeGette")
        expect(member[:party]).to eq("D")
        expect(member[:district]).to eq("1")
      end
    end
  end
end
```

Notice that we've wrapped our standard test in this `VCR.use_cassette`
block. This is the bit of code that is going to depend on VCR to provide
the stuff for us.

We also need to update our previous test.

```
# spec/features/user_can_search_by_state_spec.rb

require 'rails_helper'

feature "user can search for house members" do

  scenario "user submits valid state name" do
    # As a user
    # When I visit "/"
    visit '/'

    # And I select "Colorado from the dropdown
    select "Colorado", from: :state

    # And I click on Locate Members of the house"
    VCR.use_cassette("features/user_can_search_by_state") do
      click_on "Locate Members of the House"

      # Then my path should be "/search" with "state=CO" in the params
      expect(current_path).to eq(search_path)

      # And I should see a message "7 results"
      expect(page).to have_content("7 Results")

      # And i should see name, role, party, district
      within(first(".member")) do
        expect(page).to have_css(".name")
        expect(page).to have_css(".role")
        expect(page).to have_css(".party")
        expect(page).to have_css(".district")
      end
    end
  end

end

```
