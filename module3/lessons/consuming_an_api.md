# Consuming an API

## Learning Goals

By the end of this class, a student will be able to: 

- Set up and configure Faraday for use with a Rails application.
- Use Faraday to connect and retrieve information from third party external APIs.
- Parse the information retrieved from a third party API.

This lesson was built on Ruby 3.2.2 and Rails 7.0.5.1

## Warm Up

- How does a developer interact with an API?
- What are the benefits of using an API?

## Summary

What we are going to be working on today is creating an app that reaches out and consumes data from an external API, and then displays and formats that data on a web page. The API we will be using is the ProPublica API, and we will be using it to grab a list of Representatives from Congress.

We will accomplish that by starting with a user story.

```markdown
As a user
When I visit "/"
And I select "Colorado" from the dropdown
And I click on "Locate Members of the House"
Then my path should be "/search" with "state=CO" in the parameters
And I should see a message "7 Results"
And I should see a list of the 7 members of the house for Colorado
And I should see a name, role, party, and district for each member
```

As you can see, it lines out all that we will do. Let’s get started.

## Setup

We start by spinning up our rails app. We are going to call it House Salad.

Because we're getting information about the House of Representatives and we're gonna toss it around. Kind of.

```bash
$ git clone https://github.com/turingschool-examples/house-salad-7
$ cd house-salad-7
```

```bash
$ rails db:create
$ rails db:migrate
```

Yes, we haven't created any migrations, but running rails db:migrate will generate the `schema.rb` so we don't get an error when we start running tests.

## Testing, All Day, Every Day

So we've got the basic setup.

Let's create our first test files.

```bash
$ mkdir spec/features/
$ touch spec/features/user_can_search_by_state_spec.rb
```

Now let's open up that file and translate our user story into a test.

*spec/features/user_can_search_by_state_spec.rb*

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
    # And I click on "Locate Members of the House"
    expect(current_path).to eq(search_path)
    # Then my path should be "/search" with "state=CO" in the parameters
    expect(page).to have_content("8 Results")
    # And I should see a message "8 Results"
    expect(page).to have_css(".member", count: 8)
    # And I should see a list of 8 the members of the house for Colorado

    within(first(".member")) do
      expect(page).to have_css(".name")
      expect(page).to have_css(".role")
      expect(page).to have_css(".party")
      expect(page).to have_css(".district")
    end
    # And I should see a name, role, party, and district for each member
  end
end
```

*I do want to note that as of the writing of this - Colorado has 8 Congressional Districts. Up from previously 7. This may change in the future. If you’re getting errors, do a quick Google search just to verify.*

And so we run our tests. We should get an error concerning a `search_path`.

Our form is sad about where we are trying to send information. So we are going to have to add a route.

*config/routes.rb*

```ruby
get "/search", to: "search#index"
```

And of course, we need to create a controller with an index action and then create a corresponding view.

*app/controllers/search_controller.rb*

```ruby
class SearchController < ApplicationController
  def index
  end
end
```

```bash
$ mkdir app/views/search
$ touch app/views/search/index.html.erb
```

Now we get the error, `expected to find text "8 Results"`.

## Consuming the API

At this point, we are going to have to consume the Propublica API to get the data we need. Read through the [Propublica API documentation](https://projects.propublica.org/api-docs/congress-api/) and try to pull out the relevant pieces of information. Yes, you actually have to read it.

### API Keys

One thing you'll notice when reading the docs is that it requires us to sign up for an api key. An api key is a way for the api's owners to authenticate users. Most apis will require that you sign up for a key. This allows the api owners to track who is using their api and how much. Most apis limit the rate at which you can use the api for free, and typically you have to pay to increase this usage. You'll see an example of this in the Propublica docs: "Usage is limited to 5000 requests per day". In this case, avoid running your code 5000 times and you should be good.

If you haven't already, sign up for a Propublica API key.

### Authentication

Another key piece to pull out of the Propublica documentation is the section on "Authentication". Now that we have an API key, this tells us how to use it:

```bash
The API key must be included in all API requests to the server, as a header:

X-API-Key: PROPUBLICA_API_KEY
```

### Endpoints

We also need to find the documentation for the endpoints we will need. Explore the docs and see if you can find the endpoint.

Remember, we are trying to get a list of house members from a particular state. There is a button at the top of the page for `Members`. On the `Members` page, there is a table of contents on the left with the option for `Get Current Members by State/District`. That looks promising.

By reading through the documentation for this endpoint, we can determine that we'll need to send a request like:

```bash
GET https://api.propublica.org/congress/v1/members/house/co/current.json
```

along with our API key in a header. Using this information, see if you can hit the API endpoint using Postman. I do want to note that with the request above, we are hardcoding in the fact that we are searching for the Colorado members of Congress. Try crafting your own request so you can get the results of another state.

### Make the Request

Let's run our tests to remind us of where we left off. Oh right, we're getting `expected to find text "8 Results"`.

Now that we know what request we want to send, we need to send it to get the data we want to display.

We will be using the [Faraday Gem](https://github.com/lostisland/faraday) to make HTTP requests using Ruby.

First, we will need to add `gem "faraday"` to our Gemfile. We don't want to add to a `:development`/`:test` block since we will need to make these API calls in all environments. After you add it to your Gemfile, run `bundle install`.

Now that we have it installed, lets use Faraday to make the API call. Rather than memorizing the syntax we use in this tutorial, make sure you get used to referencing documentation.

*app/controllers/search_controller.rb*

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = '<YOUR API KEY>'
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    binding.pry
  end
end
```

Make sure you replace `<YOUR API KEY>` with the Propublica API key you signed up for earlier.

When we assign `conn`, does this make an HTTP request? What are these lines of code doing? (review the docs if you aren't sure)

In the code above, we set up a variable to hold the connection information, we tell it the name of the server, and our API Key, which is our password to be able to access the API. And then we use the `get` method on the connection and pass it the end point we want to access. We store that in the `response` local variable, and then we parse it.

When we run the code and hit the pry, we can visually inspect `response` and `response.body` to make sure it contains data and not an error message or something else unexpected.

Once we've verified our request was successful, we can parse the data and pass it to our view:

*app/controllers/search_controller.rb*

```ruby
json = JSON.parse(response.body, symbolize_names: true)
@members = json[:results]
```

And then we need to add some code to our view:

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

And now our test is passing. As always, run your server and check your work by hand in your development environment. It may not be pretty, but the data is there.

## Environment Variables

There's one more improvement we should make to our code. If you look in the controller, we have hard coded our API key. There's a couple reasons we don't want to do this:

1. It isn't secure. If someone gets access to this code (you should always assume this is possible, even if your project is closed-source), someone could copy our API key and then would be able to masquerade as our application. They could, for example, spam the Propublica API with requests and force us over the rate limit we discussed earlier. If our API key has access to paid features, they could get this access for free.
2. It isn't flexible. If we need to change the API key, we'd need to go into the code base and manually configure it. If we use this API key in multiple places, we'd need to change it in each place.

What we really want is to put our environment configuration somewhere that is specific to this project. Luckily there is a handy gem called [Figaro](https://github.com/laserlemon/figaro) that allows us to do just that. Read through the docs to figure out how it works.

First we will need to add the Figaro gem to our Gemfile outside of the `:development`/`:test` blocks. Then, run `bundle exec figaro install` from the command line. This will create a file `config/application.yml`. This file will contain our keys. We don't want to push this file to GitHub for the same reason we don't want the keys hard coded in our program, so this file should be added to the `gitignore`.

🚨 **NOTE:** Figaro is _supposed_ to add this new config file to your .gitignore automatically, but there is a bug that may produce an error and prevent it from adding it for you. **Before proceeding, manually check your `.gitignore` file and add `config/application.yml` if it is not there!**

Inside the `application.yml` file, add your API key:

*config/application.yml*

```yaml
PROPUBLICA_API_KEY: <YOUR API KEY>
```

And then you’ll have to replace the hardcoded key in your controller.

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

Run the tests again to confirm everything is working.

## Checks for Understanding.

- What does Faraday do?
- What is an API Key?
- What is a connection?
- What are headers?
- What don't you like about this code?
- Is our feature test enough?
- What are we missing?
- What do environment variables do? Why do we use them instead of hardcoding?
- Do you like the index action in the search controller?
- How would you start to refactor this?

Our next step is to refactor this.

You can find a completed working repo for this lesson here: [https://github.com/turingschool-examples/house-salad-7/tree/api-consumption-complete](https://github.com/turingschool-examples/house-salad-7/tree/api-consumption-complete)
