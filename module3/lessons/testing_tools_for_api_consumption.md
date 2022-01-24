---
layout: page
title: Testing Tools for API Consumption
length: 90
tags: apis, rails, faraday, refactoring, VCR
---

## Resources

* [Josh Mejia walks through webmock/vcr as testing tools](https://youtu.be/Okck4Fc557o)
* [2011 Lesson w/ Ian Douglaas](https://youtu.be/dlhgKYtXBoY)

## Learning Goals

After this class, a student should be able to:

* Explain why we don't want our tests to make real API calls
* Understand how to stub network requests using WebMock and VCR

## Slides

Available [here](../slides/testing_api_consumption)

## Required Setup
* Install figaro (Add to :development, :test block in gemfile)
* `bundle`
* Request a Propublica API key
* Add the key to `application.yml` and name it: `govt_api_key`

## Optional Manual Setup
The rest of this setup is on [this setup branch](https://github.com/turingschool-examples/congress-tracker-2108/tree/api_testing_tools_setup) if you'd like to pull it down and start from that point instead:

* Add the faraday gem just below bcrypt in gemfile

Add this route:
```ruby
post '/search', to: 'congress#search'
```

Add this code to your `welcome/index.html.erb`
```ruby
<%= form_with url: search_path, local: true do |form| %>
  <%= form.label :search, 'Search For Senators By Last Name:' %>
  <%= form.text_field :search %>
  <%= form.submit 'Search' %>
<% end %>
<% if @member %>
  <h5>Senator <%= @member[:first_name].concat(" ").concat(@member[:last_name]) %> was found! Their twitter is: <%= @member[:twitter_account] %></h5>
<% end %>

```

Add this controller named congress_controller.rb:

```ruby
class CongressController < ApplicationController
  def search
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV['govt_api_key']
    end
    response = conn.get("/congress/v1/116/senate/members.json")

    data = JSON.parse(response.body, symbolize_names: true)

    members = data[:results][0][:members]

    found_members = members.find_all {|m| m[:last_name] == params[:search]}
    @member = found_members.first
    render "welcome/index"
  end
end
```

You can test this code is working correctly in the browser if you can find a member of congress by last name.
`@member` will be a hash of that congress members data.

When it exists, we will grab some data from `@member` and display it on the welcome page
We can test this functionality by adding a test called: `search_congress_members_spec.rb`
This is what lives in that test file:

```ruby
require 'rails_helper'

RSpec.describe 'Govt Search' do
  describe 'happy path' do
    it 'allows user to search for govt members' do
      visit root_path

      fill_in :search, with: 'Sanders'
      click_button 'Search'

      expect(page.status_code).to eq 200
      expect(page).to have_content("Senator Bernard Sanders was found!")
      expect(page).to have_content("SenSanders")
    end

    it 'allows user to search for another govt member' do
      visit root_path

      fill_in :search, with: 'Booker'
      click_button 'Search'

      expect(page.status_code).to eq 200
      expect(page).to have_content("Senator Cory Booker was found!")
      expect(page).to have_content("SenBooker")
    end
  end
end
```

## Mocking Network Requests

The [setup branch](https://github.com/turingschool-examples/congress-tracker-2102/tree/pre_api_testing_tools_setup) for this class has implemented a test to ensure that we are able to hit our API and display some data from the response. However, our test is actually hitting the Propublica API every time it runs. There are many reasons we wouldn't want to do this:

1. We could hit API rate limits much faster.
1. Our test suite will be slower.
1. If someone working on our team doesn't have an API key set up, we make it that much harder for them to jump into our code base.
1. If we ever need to work without WiFi, or if the WiFi is down, or if the API we're using goes down (for maintenance, for example), we make it impossible to keep working on the app.

Rather than making real HTTP requests, we want to make Mock HTTP Requests.

## WebMock

We will be using [WebMock](https://github.com/bblimke/webmock) to mock our HTTP requests. As always, you should open up the docs to get an idea of how it works.

### Install the Gem

Looking at the "Installation" section of the docs, we can see we need to `gem install webmock`, but since we're using Bundler we can add it to our Gemfile which handles our gem installation. Add `gem 'webmock'` to the `:test` block of your Gemfile. DO NOT add it to the `:development, :test` block (more on that in a second). Run `bundle install`.

Finally, we can see a section for "RSpec" in the Installation instructions. This tells us to add `require 'webmock/rspec'` to our `spec/spec_helper`. Do that now.

Now, when we run our tests we can see a big error message:

```sh
WebMock::NetConnectNotAllowedError:
      Real HTTP connections are disabled. Unregistered request: GET https://api.propublica.org/congress/v1/116/members/senate/members.json with headers {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.15.4', 'X-Api-Key'=>'opyjcKdEUKllG8P5V15kv3yKKbx1KwkGQwXbfCF3'}

      You can stub this request with the following snippet:

      stub_request(:get, "https://api.propublica.org/congress/v1/116/members/senate/members.json").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v0.15.4',
         'X-Api-Key'=>'opyjcKdEUKllG8P5V15kv3yKKbx1KwkGQwXbfCF3'
          }).
        to_return(status: 200, body: "", headers: {})

      ============================================================
```

This means it's working! WebMock not only allows us to mock real HTTP requests, but also **prevents** us from making real HTTP requests. While this is good for our test suite (which we run very frequently), we do want to see the real requests being made at some point, so we want to allow HTTP requests in development. This is why we only added the gem to the `:test` block of our Gemfile and not `:development, :test`.

### Stubbing the Request

Looking at the docs, we can see some examples of how to stub requests. Let's add one to our test:

```ruby
scenario "user submits valid state name" do
    stub_request(:get, "https://api.propublica.org/congress/v1/116/members/senate/members.json").
        to_return(status: 200, body: "")
    # As a user
    # When I visit "/"
    visit '/'
```

Now when we run the tests, we get `JSON::ParserError: 743: unexpected token at ''`. The stack trace points us to the `CongressController` on the line where we do `json = JSON.parse(response.body, symbolize_names: true)`. If we look at the stub we just put in the test, we are returning an empty body, so it makes sense that we're getting an error when trying to parse the response body as JSON.

We need to replace the empty body with an actual JSON response. We *could* copy and paste a body right into this test, but then our test file would get quite messy. What we'll do instead is make a `spec/fixtures` directory with a file that we can read:

```sh
mkdir spec/fixtures
touch spec/fixtures/members_of_the_senate.json
```

And update our test:

```ruby
json_response = File.read('spec/fixtures/members_of_the_senate.json')
stub_request(:get, "https://api.propublica.org/congress/v1/116/members/senate/members.json").
  to_return(status: 200, body: json_response)
```

We're still returning an empty body because our file is empty, so let's add some actual JSON data to that file **That mimics how the JSON Data looks when we hit the real API**. Use Postman to hit the ProPublica API to get a JSON response and copy and paste it in. Your test should be passing once again.

If this is *really* working, we should be able to turn off our WiFi and see the test is still working.

## VCR

Another handy tool for mocking these requests is [VCR](https://github.com/vcr/vcr). You can think of it as an extension of WebMock. We will still be stubbing requests, but now rather than manually creating the mock JSON response, VCR will allow us to make one real HTTP request the first time, record its response, and use that response as the stub for future requests. VCR refers to these recorded responses as `cassettes`.

### Setup

First, add `gem 'vcr'` to the `:test` block of your Gemfile and `bundle install`.

Then, add this at the bottom of your `rails_helper`:

```ruby
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
```

In the first line of the block, we tell VCR where we want to store the the `cassettes`. We are making use of the `spec/fixtures` folder we already created.

The second line tells VCR what library it should use for intercepting these requests, which will be WebMock. So we are still using WebMock, but VCR is adding additional functionality for recording responses.

Go back into the test and comment out the lines where we stubbed the request with WebMock:

```ruby
scenario "user submits valid state name" do
    # json_response = File.read('spec/fixtures/members_of_the_senate.json')
    # stub_request(:get, "https://api.propublica.org/congress/v1/116/members/senate/members.json").
    #   to_return(status: 200, body: json_response)
    # As a user
    # When I visit "/"
    visit '/'
```

Run the tests and you should see `VCR::Errors::UnhandledHTTPRequestError:`. That means it's working!

### Stubbing the Request

In order to use VCR, we wrap our test in a `VCR.use_cassette` block:

```ruby
scenario "user submits valid state name" do
  # json_response = File.read('spec/fixtures/members_of_the_senate.json')
  # stub_request(:get, "https://api.propublica.org/congress/v1/116/members/senate/members.json").
  #   to_return(status: 200, body: json_response)
  # As a user
  # When I visit "/"

  VCR.use_cassette('propublica_members_of_the_senate_for_co') do
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
    # And I should see a list of 7 the members of the senate for Colorado

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

The string we passed to `use_cassette` is an identifier for the cassette, so it doesn't really matter what you pass it.

Run your tests and they should be passing. If you look under `spec/fixtures/vcr_cassettes` you should see a `.yml` file that contains your recorded response.

### Filtering Sensitive Data

If you look closely in that `.yml` file you can see our API key in there. We will be pushing these cassettes to GitHub, so we don't want the actual API key to be recorded for the same reasons we don't want our `application.yml` file pushed and we don't want to hardcode the API key in our code. We will use a VCR option to replace the actual API key with a placeholder. Open up your `rails_helper.rb` and add another line to the VCR configuration:

```ruby
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<govt_api_key>') { ENV['govt_api_key'] }
end
```

Then, delete your VCR cassettes directory:

```sh
rm -rf spec/fixtures/vcr_cassettes
```

Run your test suite again, and you should see a new VCR cassette in the `vcr_cassettes` directory. Open it up and confirm that your api key is now being replaced with `<govt_api_key>`.

**You will need to add a `filter_sensitive_data` block for EACH thing you want to filter. If you're building an app using several API keys, make sure you add a filter for each thing in your `config/application.yml` that you want to have hidden!**

### Using RSpec Metadata

VCR has a handy feature that allows us to use the names of our tests to name cassettes rather than having to manually wrap each test in a `VCR.use_cassette` block and give the cassette a name. Add one more line to your VCR config block:


```ruby
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<govt_api_key>') { ENV['govt_api_key'] }
  config.configure_rspec_metadata!
end
```

Now in our tests, we can delete the `VCR.use_cassette` block and tell the test to use VCR by passing it `:vcr`:

```ruby
scenario "user submits valid state name", :vcr do
    # json_response = File.read('spec/fixtures/members_of_the_senate.json')
    # stub_request(:get, "https://api.propublica.org/congress/v1/116/members/senate/members.json").
    #   to_return(status: 200, body: json_response)
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
    # And I should see a list of 7 the members of the senate for Colorado

    within(first(".member")) do
      expect(page).to have_css(".name")
      expect(page).to have_css(".role")
      expect(page).to have_css(".party")
      expect(page).to have_css(".district")
    end
    # And they should be ordered by seniority from most to least
    # And I should see a name, role, party, and district for each member
  end
```

Run your tests again and you'll notice a new directory and file in your `vcr_cassettes` directory that matches the names of the blocks in the test. Now when we want a test to use VCR, we just have to pass it `:vcr` and we're good to go. Much easier!


## But ... manually deleting VCR cassettes is a pain!!!

Thankfully the VCR team have come up with a way to set an expiration on our VCR cassettes, and we can do it one of two ways (or both)

On a per-cassette level, we can set it up like this:

```ruby
VCR.use_cassette('name_of_cassette', re_record_interval: 7.days) do
  # test code goes here
end
```

There's no easy way to configure this on tests which use the `:vcr` flag, though. One way would be for one test to use the `:vcr` flag, and another test which makes the same API call to use the `VCR.use_cassette()` setting above. When the test executes which has the `re_record_interval` option set to a value, it may 'expire' cassette and re-record it if the cassette passes that threshold.

We can also set a global configuration which will apply to all VCR-enabled tests, including those using the `:vcr` flag, but changing our `spec/rails_helper.rb` configuration slightly:

```ruby
VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('DONT_SHARE_MY_PROPUBLIC_SECRET_KEY') { ENV['PROPUBLICA_KEY'] }
  config.default_cassette_options = { re_record_interval: 7.days }
  config.configure_rspec_metadata!
end
```

This example uses a "default cassette options" flag, setting a re-record interval of 7 days for all cassettes. You can still override this on individual tests which use `VCR.use_cassette()`, so you could set a general flag of, say, `30.days` but a particular test could be set to `7.days` instead to expire earlier.


## Checks for Understanding

* What are some reasons we don't want our tests to make real API calls?
* What does WebMock do?
* What does VCR do?
* Why don't we want VCR to record our API key?
* How are WebMock and VCR similar? different?
