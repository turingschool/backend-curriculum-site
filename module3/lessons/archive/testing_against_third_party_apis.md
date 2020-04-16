---
layout: page
title: Testing Against Third Party APIs
length: 90
tags: apis, testing, controller tests, rails
---

## Testing Against 3rd Party APIs

### Overview

As we build more and more sophisticated web applications, we'll frequently want to make use of data we don't control. Generally this data is provided to us by a 3rd party company or organization via a public-facing API on the web.

While it's great to get access to all this data so easily, it can sometimes create headaches for our test suite.

#### 3rd Party API Testing Problems

Let's consider a few difficulties when testing around a 3rd party
API:

* **Speed** -- even a "fast" API will still generally have latencies in the 10s of milliseconds, which can slow our tests down
* **Rate Limits** -- We may be using an API which limits the volume of our usage. We certainly don't want to waste these requests on repetitive test queries
* **Repeatibility** -- The data on many endpoints will change over time. This will cause problems if our tests are designed around 1 set of data but the API starts providing something different. We'd like it to be consistent and repeatable.
* **Network Tolerance** -- Our test suite should be isolated to our machine and shouldn't be affected by network outages. This won't be the case if we're utilizing a real API in the test suite.

#### Solutions

There are a few common solutions we might take for these issues:

* **Stubbing** -- often we can use in-process stubbing libraries to replace our API queries with canned, static responses that will be fast and reliable
* **Network-level Mocking** -- sometimes we might want to capture the whole network response. Fortunately there are tools like VCR available for this.

If you're interested in reading about testing external APIs that don't use VCR check out these two articles as a starting point:

* [How to Stub External Services in Tests](https://robots.thoughtbot.com/how-to-stub-external-services-in-tests)
* [Have you ever... Faked It?](https://robots.thoughtbot.com/fake-it)

### Workshop

We are going to continue with the application that we created yesterday in our [Consuming an API lesson](consuming_an_api).

Add the following gems:

* [VCR](https://github.com/vcr/vcr): records your requests and allows you to reuse the responses whenever you are testing functionality dependent on the return value of those requests
* [webmock](https://github.com/bblimke/webmock): is a library for stubbing and setting expectations on HTTP requests in Ruby

```
# Gemfile
....
group :test do
  gem 'vcr'
  gem 'webmock'
end
```

We need to configure webmock and VCR in our `spec/rails_helper.rb`. Below the line that requires `rspec/rails`, add lines to include `webmock/rspec' and `vcr`. We also add a VCR configuration block where we declare where it should look for cassettes (more on cassettes below).

```rb
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

Additionally, add the following line to your `.gitignore`.

```ruby
/spec/cassettes
```

On the first line of the test we are declaring which VCR cassette we should use for this test. A **cassette** is a recorded response. All of our cassettes will be stored in `spec/cassettes` (as declared in the VCR configs in the test_helper). If VCR cannot find a cassette named `sunlight_service#legislators` it will make the call and save the response. If the cassette already exists, it will read the existing cassette.

```rb
# spec/services/sunlight_service_spec.rb
require 'rails_helper'

describe SunlightService do
  attr_reader :service

    before(:each) do
      @service = SunlightService.new
    end

    describe "#legislators" do
      it "finds all female legislators" do
        VCR.use_cassette("services/find_female_legislators") do
        legislators = service.legislators(gender: "F")
        legislator  = legislators.first

        expect(legislators.count).to eq(20)
        expect(legislator[:first_name]).to eq('Liz')
        expect(legislator[:last_name]).to eq('Cheney')
      end
    end
  end

  describe '#committess' do
    it 'can find a list of committees by chamber' do
      VCR.use_cassette("services/find_list_of_committees") do
        committees = service.committees(chamber: 'senate')
        committee  = committees.first

        expect(committees.count).to eq(20)
        expect(committee[:name]).to eq('Federal Spending Oversight and Emergency Management')
      end
    end
  end
end

```

Using that model, make adjustments to your model tests to also use VCR.

#### Review of the Big Picture

1. A test that makes an API call without a VCR cassette
  * What role do the following pieces play?
    * Rails app
    * External API (github, twitter, etc)
    * Webmock
    * VCR
    * cassettes
    * The Internet
    * Faraday
    * Figaro
1. A test that makes an API call with VCR
  * What role do the following pieces play?
    * Rails app
    * External API (github, twitter, etc)
    * Webmock
    * VCR
    * cassettes
    * The Internet
    * Faraday
    * Figaro
