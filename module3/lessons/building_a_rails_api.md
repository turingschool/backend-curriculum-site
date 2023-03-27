# Building a Rails API

## Learning Goals

- Understand how an API works at a conceptual level
- Use request specs to TDD an API
- Understand what makes a valid JSON data structure
- Learn how to parse and create JSON in Ruby

## Warmup

- What is an API in the context of web development?
- Why might we decide to expose information in a database we control through an API?
- What do we need to test in an API?
- How will our tests be different from feature tests we have implemented in the past?
- What is REST and why do we need it?

## Reviewing REST

> It’s a CONCEPT, not a LAW.
> 

We want to practice REST as much as possible, but we should consider it a "very strongly encouraged guideline" and not a strict immovable law of how to develop software.

REST, as a concept, came from the need to mimic some amount of "state" between HTTP requests and responses, since HTTP is a stateless protocol. It ties together the idea of HTTP verbs and URI paths/routes into a uniform interface by which we can state "I want to create a new resource" or "I want to change something about a specific resource".

### Rails likes RESTful things

Rails makes it very easy to build CRUD interfaces for resources, and doesn't care if our response to a user is HTML, JSON, XML, plaintext, or something else.

The controller actions (create, destroy, update, etc) aren't exactly the same as the HTTP verbs specified with a URI path, but it's easy to draw the comparison.

In the end, though, as developers we have a choice to make around our development interface (sometimes called Developer Experience, similar to User Experience for UI), and making our code easy to maintain.

### RESTful Wrap-Up

REST is language-agnostic, and is a standard we should continue to build, but we ARE allowed some flexibility.

## APIs

API = Application Programming Interface

An API is effectively a "domain specific language" (DSL) between a system which can perform an instruction, and a user who wants to perform that instruction.

Ruby, as a language, has APIs. These are the Ruby methods like `.each` or `.new` or `def` to make methods. In this case, the "user" is you as a human, entering instructions for the Ruby interpreter to perform a task.

There are also "external" APIs, which is the more common use of the "API" term, and pertains to Internet-based information systems, such as GitHub, Google, Yelp, and so on, from whom we can send/retrieve data to perform a task. In this case, a tool like Faraday is the "user", asking an external service to do an instruction like "fetch a list of public repos for the `turingschool` account"

The rest of this lesson will discuss APIs in the context of these external Internet-based "services".

## Why use (external, Internet-based) APIs?

APIs provide a means for us to transmit data between web-based applications without worrying about all the overhead associated with HTML.

- Create an application that uses client-side JavaScript to update a page without a full-page refresh.
    - eg, the front-end developer only needs to fetch a little bit of data, not a whole HTML page
- Provide a means for developers at other companies to use a service that we provide.
- Split the work of our application service into smaller application services that are each deployed separately (service-oriented architecture)

## Background: JSON

### Exploration

Discuss the examples of JSON linked below with a partner and describe what you notice.

- [Example 1](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON#json_structure:~:text=application/json.-,JSON%20structure,-As%20described%20above)
- [Example 2](https://www.petfinder.com/developers/v2/docs/)

### More Notes To Read Later

[Here are more notes about JSON for API Development](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module3/notes/json_for_api_development.html)

## New Tools

Before we begin, let's take a look at some of the new tools you'll be using.

### JSON and Ruby

Let's play around with it in our `pry` consoles.

```bash
require 'json'
my_hash = { hello: "goodbye" }
puts JSON.generate(my_hash) #=> "{"hello":"goodbye"}"
puts  my_hash.to_json #=> "{"hello":"goodbye"}"
```

```bash
person = '{"name":"Jennifer Lopez","street":"641 Pine St.","phone":true,"age":50,"pets":["cat","dog","fish"]}'
parsed_person = JSON.parse(person) #=> {"name"=>"Jennifer Lopez", "street"=>"641 Pine St.", "phone"=>true, "age"=>50, "pets"=>["cat", "dog", "fish"]}
puts parsed_person
puts parsed_person['pets']
```

## Building an API in Rails

We will start by using a new `--api` flag when we call "rails new".

**WE WILL REQUIRE THAT YOU USE --api FOR MOD 3 API PROJECTS -- DO NOT FORGET TO USE THIS FLAG!**

This flag should only create the following paths inside `/app/`:

- channels
- controllers
- jobs
- mailers
- models
- views

If you see `/app/assets` and `/app/helpers` in your project then you did not use the `--api`
 flag. You may get asked to start over!

## Think about testing and TDD at a high level

- Can more of our code be tested in a way that feels more like unit testing?
- What kinds of Capybara syntax will we no longer need to use?

### Using JSON in Rails Testing

- `get 'api/v1/items'`: submits a get request to your application (like `visit`, but without all of the Capybara bells and whistles)
- `response`: captures the response to a given request (like `page` when using Capybara)
- `JSON.parse(response)`: parses a JSON response

PLEASE PLEASE PLEASE use Faker and FactoryBot for your testing!

## Namespacing and Routing will be extra important!

You'll be building lots of "versioning" into your routes, to make URI paths like "/api/v1/something"

## Our controllers will be very different now, too

Our controllers will no longer be calling a view which builds HTML, and we can no longer rely on the "magic" of Rails finding a "view" path named after our controller, and an ERB file named after our action.

### Using JSON in the Controller

```ruby
class MyController << ApplicationController
  def index
    render json: Item.all
  end
end
```

## OOP Principles at Play

Aim to have very "thin" controllers -- very little code. Any "helper" methods should be put into a "Facade", named after the controller, like a WeatherController would have a WeatherFacade.

The Facade will be in charge of fetching data for the controller. The controller doesn't need to know where or how, we're going to "abstract" that away.

The Facade may get data from a Model using ActiveRecord, or call a service using Faraday, for example a "WeatherService".

The Facade's job, then, is to make sure the controller ONLY gets object data back. No JSON, no hashes. Just Objects, or arrays of Objects.

The controller, then, will hand off that data to a Serializer, which can be appropriately-named for the data it contains like RoadTripWeatherSerializer or something like that, and given the Object data from the database or other source.

## Practice

Complete the exercise [here](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module3/lessons/exercises/building_an_api.md)

## Checks for Understanding

- What are some reasons you'd want to create an API?
- At its core, what is JSON?
- What are the main differences between creating a traditional Rails application and creating an API?
