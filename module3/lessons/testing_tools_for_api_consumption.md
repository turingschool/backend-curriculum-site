---
layout: page
title: Testing Tools for API Consumption
length: 90
tags: apis, rails, faraday, refactoring, VCR
---

# Testing Tools for API Consumption

## Resources

- [Josh Mejia walks through WebMock and VCR as testing tools](https://youtu.be/Okck4Fc557o)
- [2011 Lesson w/ Ian Douglas](https://youtu.be/dlhgKYtXBoY)

## Learning Goals

After this class, a student should be able to:

- Explain why we don’t want our tests to make real API calls
- Understand how to stub network requests using WebMock and VCR

## Optional

Slides are available [here](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module3/slides/testing_api_consumption.md).

## Required Setup

[📺 Here is a walkthrough video to help you set up your Rails Application Credentials.](https://drive.google.com/file/d/1Cy598b1W1d7nZ-gv6ur_gPmAGOmaD3Gi/view?usp=sharing)

- [Request a Propublica API Key](https://www.propublica.org/datastore/api/propublica-congress-api)
- Clone [the House Salad 7](https://github.com/turingschool-examples/house-salad-7/tree/testing-setup) 
  - (forking is optional since we won't ask you to push up any changes)
- In the `testing-setup` branch, run setup steps:
```bash
bundle
rails db:{create, migrate}
```
- Verify that you are able to launch VS Code from the command line. `code`
  - If the following steps don't work, you'll need to follow [these 'Launching From the Command Line' steps](https://code.visualstudio.com/docs/setup/mac#:~:text=Keep%20in%20Dock.-,Launching%20from%20the%20command%20line,code) to configure the command
- Generate what is called a 'master key' by running `EDITOR="code --wait" rails credentials:edit` in the command line
  - This will create a new key in `config/master.key` and a temporary YAML file which will open in your text editor.
- Add your Propublica API Key to the opened file

```
propublica:
  key: asdsa3498serghjirteg978ertertwhter

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: ugsdfeadsfg98a7sd987asjkas98asd87asdkdwfdg876fgd
```

- Save and close the file, and you should see in your terminal that the file was encrypted and saved.
- Note: To use these credentials and environment variables with a team you'll need to share the contents of the `config/master.key` file with your teammates securely, and they'll need to create this file with that key as the contents. 

## Optional Manual Setup

You can start this class from this branch [here](https://github.com/turingschool-examples/house-salad-7/tree/testing-setup), or you can follow along these instructions below. Strongly recommend that you start from the branch.

Add this route:

*config/routes.rb*

```ruby
post "/search", to: "search#search"
```

Add in a new form to search for Senators:

*app/views/welcome/index.html.erb*

```html
<%= form_with url: search_path, local: true do |form| %>
  <%= form.label :search, 'Search For Senators By Last Name:' %>
  <%= form.text_field :search %>
  <%= form.submit 'Search' %>
<% end %>
<% if @member %>
    <h5>Senator <%= @member[:first_name].concat(" ").concat(@member[:last_name]) %> was found! Their twitter is: <%= @member[:twitter_account] %></h5>
<% end %>
```

And let’s add a search method for our search controller:

*app/controllers/search_controller.rb*

```ruby
def search
    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = Rails.application.credentials.propublica[:key]
    end
    response = conn.get("/congress/v1/116/senate/members.json")

    data = JSON.parse(response.body, symbolize_names: true)

    members = data[:results][0][:members]

    found_members = members.find_all {|m| m[:last_name] == params[:search]}
    @member = found_members.first
    render "welcome/index"
  end
```

For simplicity’s sake we aren’t going to use the refactored pattern, we are just going to leave all of the code in your controller.

You can test this code is working correctly in the browser if you can find a Senator by last name. `@member` will be a hash of that Senator’s data.

Note: In order to future proof this lesson, this API is calling to get the results only for the 116th session of Congress, so you will likely not get good results searching for a Senator. For example, it will find a result if you search for say Sanders or Booker, but not Fetterman.

When it exists, we will grab some data from `@member` and display it on the welcome page We can test this functionality by adding a test called: `user_can_search_by_senator_last_name_spec.rb` 

This is what lives in that test file:

*spec/features/user_can_search_by_senator_last_name_spec.rb*

```ruby
require 'rails_helper'

RSpec.describe 'Senator Search' do
  describe 'happy path' do
    it 'allows user to search for Senators by last name' do
      visit root_path

      fill_in :search, with: 'Sanders'
      click_button 'Search'

      expect(page.status_code).to eq 200
      expect(page).to have_content("Senator Bernard Sanders was found!")
      expect(page).to have_content("SenSanders")
    end
  end
end
```

---

## Mocking Network Requests

The [setup branch](https://github.com/turingschool-examples/house-salad-7/tree/testing-setup) for this class has implemented a test to ensure that we are able to hit our API and display some data from the response. However, our test is actually hitting the Propublica API every time it runs. There are many reasons we wouldn't want to do this:

1. We could hit API rate limits much faster.
2. Our test suite will be slower.
3. If someone working on our team doesn't have an API key set up, we make it that much harder for them to jump into our code base.
4. If we ever need to work without WiFi, or if the WiFi is down, or if the API we're using goes down (for maintenance, for example), we make it impossible to keep working on the app.

Rather than making real HTTP requests, we want to make Mock HTTP Requests.

## WebMock

We will be using [WebMock](https://github.com/bblimke/webmock) to mock our HTTP requests. As always, you should peruse the docs to get an idea of how it works.

## Install the Gem

Looking at the "Installation" section of the docs, we can see we need to `gem install webmock`, but since we're using Bundler we can add it to our Gemfile which handles our gem installation. Add `gem "webmock`" to the `:test` block of your Gemfile. DO NOT add it to the `:development, :test` block (more on that in a second). Run `bundle install`.

Finally, we can see a section for "RSpec" in the Installation instructions. This tells us to add `require 'webmock/rspec'` to our `spec/spec_helper`. Do that now.

Let’s run our Senator search test:

```bash
$ bundle exec rspec spec/features/user_can_search_by_senator_last_name_spec.rb
```

Now we will se a big ol’ error message:

```bash
Failure/Error: response = conn.get(url)

     WebMock::NetConnectNotAllowedError:
       Real HTTP connections are disabled. Unregistered request: GET https://api.propublica.org/congress/v1/members/house/CO/current.json with headers {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.4', 'X-Api-Key'=>'S9JON3ruNOI6XiyymcnZ7gtsjnToPxuXyT0bgeaX'}

       You can stub this request with the following snippet:

       stub_request(:get, "https://api.propublica.org/congress/v1/members/house/CO/current.json").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.7.4',
       	  'X-Api-Key'=>'S9JON3ruNOI6XiyymcnZ7gtsjnToPxuXyT0bgeaX'
           }).
         to_return(status: 200, body: "", headers: {})

       ============================================================
```

This means it's working! WebMock not only allows us to mock real HTTP requests, but also **prevents** us from making real HTTP requests. While this is good for our test suite (which we run very frequently), we do want to see the real requests being made at some point, so we want to allow HTTP requests in development. This is why we only added the gem to the `:test` block of our Gemfile and not `:development, :test`.

## Stubbing the Request

Looking at the docs, we can see some examples of how to stub requests. Let's add one to our test:

********spec/features/user_can_search_by_senator_last_name_spec.rb********

```ruby
require 'rails_helper'

RSpec.describe 'Senator Search' do
  describe 'happy path' do
    
    it 'allows user to search for Senators by last name' do
      stub_request(:get, "https://api.propublica.org/congress/v1/116/senate/members.json").
        to_return(status: 200, body: "")
      visit root_path

      fill_in :search, with: 'Sanders'
      click_button 'Search'

      expect(page.status_code).to eq 200
      expect(page).to have_content("Senator Bernard Sanders was found!")
      expect(page).to have_content("SenSanders")
    end
  end
end
```

We can put this right above the `visit root_path`.

Now, when we run the test, we get a new error.

```bash
1) Senator Search happy path allows user to search for Senators by last name
     Failure/Error: data = JSON.parse(response.body, symbolize_names: true)

     JSON::ParserError:
       unexpected token at ''
     # ./app/controllers/search_controller.rb:12:in `search'
     # ./spec/features/user_can_search_by_senator_last_name_spec.rb:12:in `block (3 levels) in <top (required)>'
```

If we look at the stub we just put in the test, we are returning an empty body, so it makes sense that we're getting an error when trying to parse the response body as JSON.

We need to replace the empty body with an actual JSON response. We *could* copy and paste a body right into this test, but then our test file would get quite messy. What we'll do instead is make a `spec/fixtures` directory with a file that we can read:

```bash
$ mkdir spec/fixtures
$ touch spec/fixtures/members_of_the_senate.json
```

And then we have to update our test to use this fixture file:

*spec/features/user_can_search_by_senator_last_name_spec.rb*

```bash
require 'rails_helper'

RSpec.describe 'Senator Search' do
  describe 'happy path' do
    
    it 'allows user to search for Senators by last name' do
      json_response = File.read('spec/fixtures/members_of_the_senate.json')
      stub_request(:get, "https://api.propublica.org/congress/v1/116/senate/members.json").
        to_return(status: 200, body: json_response)
      visit root_path

      fill_in :search, with: 'Sanders'
      click_button 'Search'

      expect(page.status_code).to eq 200
      expect(page).to have_content("Senator Bernard Sanders was found!")
      expect(page).to have_content("SenSanders")
    end
  end
end
```

We're still returning an empty body because our file is empty, so let's add some actual JSON data to that file **That mimics how the JSON Data looks when we hit the real API**. Use Postman to hit the ProPublica API to get a JSON response and copy and paste it in. Your test should be passing once again.

If this is *really* working, we should be able to turn off our WiFi and see the test is still working.

## VCR

Another handy tool for mocking these requests is [VCR](https://github.com/vcr/vcr). You can think of it as an extension of WebMock. We will still be stubbing requests, but now rather than manually creating the mock JSON response, VCR will allow us to make one real HTTP request the first time, record its response, and use that response as the stub for future requests. VCR refers to these recorded responses as `cassettes`. We are going to implement VCR on the other half of our app here, the one where we search for the Members of Congress by state.

## Setup

First, add `gem "vcr`" to the `:test` block of your Gemfile and `bundle install`.

Then, add this at the bottom of your `rails_helper`:

*spec/rails_helper.rb*

```ruby
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
```

In the first line of the block, we tell VCR where we want to store the the `cassettes`. We are making use of the `spec/fixtures` folder we already created.

The second line tells VCR what library it should use for intercepting these requests, which will be WebMock. So we are still using WebMock, but VCR is adding additional functionality for recording responses.

Now, let’s run our test.

```bash
$ bundle exec rspec spec/features/user_can_search_by_state_spec.rb
```

You’re going to see a big error, but the important part is:

```ruby
# --- Caused by: ---
     # VCR::Errors::UnhandledHTTPRequestError:
     #
     #
     #   ================================================================================
     #   An HTTP request has been made that VCR does not know how to handle:
     #     GET https://api.propublica.org/congress/v1/members/house/CO/current.json
```

This means that it’s working. 

## Stubbing the Request

In order to use VCR, we wrap our test in a `VCR.use_cassette` block:

*spec/features/user_can_search_by_state_spec.rb*

```ruby
require 'rails_helper'

feature "user can search for house members" do
  scenario "user submits valid state name" do
    # As a user
    # When I visit "/"
    VCR.use_cassette("propublica_members_of_the_senate_for_CO") do
      visit '/'

      select "Colorado", from: :state
      # And I select "Colorado" from the dropdown
      click_on "Locate Members of the House"
      # And I click on "Locate Members from the House"
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
    end
    # And I should see a name, role, party, and district for each member
  end
end
```

The string we passed to `use_cassette` is an identifier for the cassette, so it doesn't really matter what you pass it.

Run your tests and they should be passing. If you look under `spec/fixtures/vcr_cassettes` you should see a `.yml` file that contains your recorded response.

## Filtering Sensitive Data

If you look closely in that `.yml` file you can see our API key in there. We will be pushing these cassettes to GitHub, so we don't want the actual API key to be recorded for the same reasons we don't want our `application.yml` file pushed and we don't want to hardcode the API key in our code. We will use a VCR option to replace the actual API key with a placeholder. Open up your `rails_helper.rb` and add another line to the VCR configuration:

*spec/rails_helper.rb*

```ruby
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<PROPUBLICA_API_KEY>') { Rails.application.credentials.propublica[:key] }
end
```

Then, delete your VCR cassettes directory:

```bash
$ rm -rf spec/fixtures/vcr_cassettes
```

Run your test suite again, and you should see a new VCR cassette in the  `vcr_cassettes` directory. Open it up and confirm that your api key is now being replaced with `<PROPUBLICA_API_KEY>`.

**You will need to add a `filter_sensitive_data` block for EACH thing you want to filter. If you're building an app using several API keys, make sure you add a filter for each thing in your `config/application.yml` that you want to have hidden!**

## Using RSpec Metadata

VCR has a handy feature that allows us to use the names of our tests to name cassettes rather than having to manually wrap each test in a `VCR.use_cassette` block and give the cassette a name. Add one more line to your VCR config block:

*spec/rails_helper.rb*

```ruby
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<PROPUBLICA_API_KEY>') { Rails.application.credentials.propublica[:key] }
  config.configure_rspec_metadata!
end
```

Now in our tests, we can delete the `VCR.use_cassette` block and tell the test to use VCR by passing it `:vcr`:

*spec/features/user_can_search_by_state.rb*

```ruby
require 'rails_helper'

feature "user can search for house members" do
  scenario "user submits valid state name", :vcr do
    # As a user
    # When I visit "/"
    visit '/'

    select "Colorado", from: :state
    # And I select "Colorado" from the dropdown
    click_on "Locate Members of the House"
    # And I click on "Locate Members from the House"
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

Run your tests again and you'll notice a new directory and file in your `vcr_cassettes` directory that matches the names of the blocks in the test. Now when we want a test to use VCR, we just have to pass it `:vcr` and we're good to go. Much easier!****

## But manually deleting VCR cassettes is like, SO annoying

Thankfully the VCR team have come up with a way to set an expiration on our VCR cassettes, and we can do it one of two ways (or both)

On a per-cassette level, we can set it up like this:

```ruby
VCR.use_cassette('name_of_cassette', re_record_interval: 7.days) do
  # test code goes here
end
```

There's no easy way to configure this on tests which use the `:vcr` flag, though. One way would be for one test to use the `:vcr` flag, and another test which makes the same API call to use the `VCR.use_cassette()` setting above. When the test executes which has the `re_record_interval` option set to a value, it may 'expire' cassette and re-record it if the cassette passes that threshold.

We can also set a global configuration which will apply to all VCR-enabled tests, including those using the `:vcr` flag, but changing our `spec/rails_helper.rb` configuration slightly:

```ruby
VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('DONT_SHARE_MY_PROPUBLIC_SECRET_KEY') { Rails.application.credentials.propublica[:key] }
  config.default_cassette_options = { re_record_interval: 7.days }
  config.configure_rspec_metadata!
end
```

This example uses a "default cassette options" flag, setting a re-record interval of 7 days for all cassettes. You can still override this on individual tests which use `VCR.use_cassette()`, so you could set a general flag of, say, `30.days` but a particular test could be set to `7.days` instead to expire earlier.

## Checks for Understanding

- What are some reasons we don't want our tests to make real API calls?
- What does WebMock do?
- What does VCR do?
- Why don't we want VCR to record our API key?
- How are WebMock and VCR similar? different?

You can find this code complete on this branch [here](https://github.com/turingschool-examples/house-salad-7/tree/testing-tools-complete).
