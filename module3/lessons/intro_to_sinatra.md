# Intro to Sinatra

## Learning goals
- Understand the advantages of using a lightweight DSL/framework
- Build a Sinatra application

### Warm up
- Why do we use Rails? How do we know when we need it?
- What are some ideas you've had for microservices (in Consultancy, or in general)? 
  - Could you build any of these _without_ using Rails? Why or why not?

### What if I want to build a (micro)service without the complexity of Rails?

Ruby on Rails generates a **lot** of things we might not need for simple web apps. All of that boilerplate code has performance implications, as well as introducing a level of complexity we might not want. Other than Rails, there are many Ruby frameworks and DSLs out there, such as [Trailblazer](https://github.com/trailblazer/trailblazer) and [Hanami](https://github.com/hanami/hanami).

For now, let's take a closer look at a very popular choice: [Sinatra](https://github.com/sinatra/sinatra).

## Sinatra

> _When people speak of Ruby web development, it has historically been in reference to the opinionated juggernaut that is Rails. This is certainly not an unfounded association; Hulu, Yellow Pages, Twitter, and countless others have relied on Rails to power their (often massive) web presences, and Rails facilitates that process with zeal._

> _Rails was a breath of fresh air to many developers exhausted by the “old ways”; Sinatra enters the arena with a similar game-changer: a beautifully minimalistic, “I’ll get out of your way” approach. No generators, no complex folder hierarchies, and a brief yet expressive syntax that maps closely to the functionality exposed by the Hypertext Transfer Protocol verbs._

> — Sinatra Up and Running, Alan Harris & Konstantin Haase

Sinatra is minimalistic and tries to stay out of our way, which sounds great, but what does that look like in practice?

Pick one of the projects from the following list, and spend about 10-15 minutes reading the source code on GitHub. 

- [Nesta CMS](https://github.com/gma/nesta/tree/aed57a7752da913be13eee72694de77f0a343306)
- [Mailcatcher](https://github.com/sj26/mailcatcher/tree/98cb69f7f775a332da871dcdab02f0f8c01f71c9)
- [Taskwarrior](https://github.com/theunraveler/taskwarrior-web/tree/bf7f91eca7e27ab09cbfbf20033a8785819d9fcf)
- [Gollum](https://github.com/gollum/gollum)
- [Resque's worker monitoring](https://github.com/resque/resque/blob/master/lib/resque/server.rb)

Then, discuss the following questions with a study partner:

- What did you notice about the project file trees?
- How does routing work in Sinatra? How does this compare to a Rails `routes.rb` file?
- Is there any syntax that feels new/unfamiliar?
- What core pieces of functionality do you think Sinatra provides?

### Practice: building a Sinatra application

It's important to note that Sinatra is **not** a web framework, but rather, a DSL (Domain-Specific Language). Web frameworks tend to enforce a design pattern such as MVC, and include an object-relational mapper. Sinatra does neither of these-- in fact, it's possible to encapsulate an entire Sinatra app in a single file.

To familiarize ourselves with this DSL, we're going to build a basic server. Let's say we've built a Rails app for a local pizza shop. This application provides a variety of features such as generating topping suggestions, order placement, payment processing, a 'contact us' form, and more. It's also scaling rapidly because our clients are so good at making pizza!

We've been tasked with restructuring this monolithic application into a Service-Oriented Architechture, and the first step is building a microservice to handle the task of suggesting pizza topping combinations. 

First we'll need a directory to hold all of our Sinatra code, and a file for our server.

```
mkdir pizza_suggestions
cd pizza_suggestions
touch server.rb
```

We'll require the Sinatra gem at the top of our server file, so install this, and its `rackup` dependency on the command line:

```
gem install rackup
gem install sinatra
```

Now, open `server.rb` and add a route. 

```ruby 
require 'sinatra'

get '/' do
  'Hello, pizza lovers!'
end
```

You should be able to run `ruby server.rb` and visit `localhost:4567` in your browser. Neat!

Using very little code, we've created a server that can respond to HTTP requests. There are a few things happening behind the scenes to make this work.

Sinatra acts as a layer between us (the developers) and the Rack middleware. Using the Sinatra DSL syntax, we can tell our application "hey application, please respond to _HTTP GET requests to the '/' path_ with _whatever I put in this block of code._" Imagine a world where you could nest a controller action underneath a route in the Rails `routes.rb` file-- this is kind of what we're doing here.

Now that we have a basic understanding of how to write an endpoint/route in Sinatra, we should make this file more useful as a microservice.

```ruby
require 'sinatra'

get '/' do
  'Hello, pizza lovers!'
end

get '/suggestion' do
  toppings = ['banana peppers', 'mushrooms', 'pineapple', 'crushed garlic']
  
  "Want something different on your pizza today? Try #{toppings.sample}!"
end
```

This is fine if all we want from the `/suggestion` URI is a plain text list of a few toppings. For anything more complex, we'll want to render a view.

```
mkdir views
touch views/suggestion.erb
```

Note: in Sinatra, the file extension for views should be `.erb` instead of `.html.erb`. 

Just like in Rails, we can pass data to the view using an instance variable. However, unlike rails, Sinatra has no concept of a filetree convention with which to infer which view to render; we'll have to tell it explicitly by passing a symbol to the `erb` keyword at the bottom of the route.

```ruby
# server.rb

get '/suggestion' do
  @toppings = ['banana peppers', 'mushrooms', 'pineapple', 'crushed garlic']
  
  erb :suggestion
end
```

Now add this to the view:

```
# views/suggestion.erb

<h1>Try something new!</h1>

<p>Today's suggestion is: <%= @toppings.sample %>
```

Visit `localhost:4567/suggestion` to verify this is working.

Finally, let's abstract our list of toppings to its own file. That way, it isn't the responsiblity of `server.rb` to maintain this; instead we'll add toppings to a file that gets required and referenced in certain routes.

```
touch topping_list.rb
```

In this file, we'll use a constant for the toppings we want to randomize in suggestions. Because Sinatra wont autoload this, remember to `require './topping_list` in your server file.

```ruby
class ToppingList
  CURRENT = [
    'banana peppers', 
    'mushrooms', 
    'pineapple', 
    'crushed garlic',
    'artichokes',
    'olives'
  ]
  
  def self.suggestion
    CURRENT.sample
  end
end
```

Now we can use this encapsulated list by calling the new class method in our route for better SRP:

```ruby
# server.rb

get '/suggestion' do
  @suggestion = ToppingList.suggestion
  
  erb :suggestion
end
```

### Error handling

Error handlers run within the same context as routes. To handle a missing route or resource matching a request, we can render some output in a `not_found` block.

```ruby
not_found do
  "You requested a route that doesn't exist."
end
```

Visiting `localhost:4567/some_incorrect_route` should display the text.

But what about unhandled exceptions leading to 500 Internal Server Errors? Let's replicate this issue and handle the exceptions in a different type of block.

```ruby
configure do 
  set :show_exceptions, false
end

get '/force_an_error' do
  "hello".gsub
end

error do
  'Sorry, there was an error:' + env['sinatra.error'].message
end
```

Don't skip the 'configure' step! In the development environment, Sinatra will show a stack trace in the browser by default. We want to handle exceptions gracefully instead, which is why we set this configuration to `false`.

Try visiting `localhost:4567/force_an_error` in your browser, and experiment with raising different exceptions in that route. They should all be caught by the `error` block we added, and the correct error message should always be displayed.

### Testing

In the future, we **highly** recommend a TDD approach. For now, let's at least add some tests for everything we built today. 

```
touch server_test.rb
```

In this new test file, set an environment variable to indicate a test environment. Then, require `server.rb`, `rspec`, and `rack/test`.

```ruby
ENV['APP_ENV'] = 'test'

require 'server' 
require 'rspec'
require 'rack/test'
```

Next we'll set up an `RSpec.describe` block. Make sure to include `Rack::Test::Methods`.

```ruby
# server_test.rb

ENV['APP_ENV'] = 'test'

require './server' 
require 'rspec'
require 'rack/test'

RSpec.describe 'Pizza Topping Suggestions App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/' do
    it 'displays a greeting' do
      get '/'
      expect(last_response).to be_successful
      expect(last_response.body).to eq('Hello, pizza lovers!')
    end
  end
end
```

Before you go any further in this lesson plan, try to write tests for the `/suggestion` route on your own.

Did you give it your best effort? Great, here's the finished test file:

```ruby
# server_test.rb
ENV['APP_ENV'] = 'test'

require './server' 
require 'rspec'
require 'rack/test'

RSpec.describe 'Pizza Topping Suggestions App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/' do
    it 'displays a greeting' do
      get '/'
      expect(last_response).to be_successful
      expect(last_response.body).to eq('Hello, pizza lovers!')
    end
  end

  describe '/suggestion' do
    it 'suggests a pizza topping' do
      get '/suggestion'

      expect(last_response).to be_successful
      expect(last_response.body).to include('Try something new!')
    end
  end
  
  describe 'non-existent route' do
    it 'returns an error message' do
      get '/bad_route'

      expect(last_response).to_not be_successful
      expect(last_response.body).to include("You requested a route that doesn't exist.")
    end
  end
end
```

Don't forget to write unit tests for `topping_list.rb`! Those tests won't interact with Sinatra or Rack, so if you need a refresher you can review this [TDD lesson](https://backend.turing.edu/module1/lessons/test_driven_development).

## Sinatra for microservices

**Discuss: why are you considering Sinatra for your microservices in your project?**

As you've seen, Sinatra is a powerful but simple tool for quickly putting together web applications in Ruby. Because it's so flexible, there are many ways you could choose to utilize it in your application architechture, all of which have their own advantages and disadvantages. 

In our Pizza Shop example today, we built a microservice which would return html views with pizza topping suggestions. We did not connect to a database or set up routes to create/update/delete resources, but we certainly could. Take 5-10 minutes to brainstorm other ways we could abstract Pizza Shop App functionality into a Sinatra microservice (consider diagramming these ideas with a peer).

## Further reading
- [Testing in Sinatra](https://sinatrarb.com/testing.html#frameworks)
- [PostgreSQL and ActiveRecord with Sinatra](https://github.com/sinatra/sinatra-recipes/blob/main/databases/postgresql-activerecord.md)
- [Practice: Robot World CRUD app](https://backend.turing.edu/module2/misc/crud_in_sinatra_workshop)