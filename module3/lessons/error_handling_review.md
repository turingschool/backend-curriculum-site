---
layout: page
title: Error Handling in Rails Applicaitons
length: 120
tags: rails, errors, rescue, raise, exceptions
---

## Vocabulary
* Exception
* Error
* Class Hierarchy
* Rescue

## Learning Goals

* Understand the need as developers to plan for errors and handle exceptions
* Review an object oriented approach to error handling

### Setup

We'll be using the `error_handling_start` branch of [this repository](https://github.com/turingschool-examples/house-salad-7) to review error handling and exceptions in Rails. The completed code can be found on the `error_handling_complete` branch.

Our Facade currently looks like so:

```ruby
class SearchFacade
  def initialize(state = nil, last_name = nil)
    @state = state
    @last_name = last_name
  end

  def all_senate_members
    json = CongressService.new.senate_members[:results][0][:members]
  end

  def senate_member_by_last_name
    match = members_by_last_name(@last_name).first
    SenateMember.new(member)
  end

  def members_by_last_name(last_name)
    all_senate_members.find_all do |member|
      member[:last_name] == last_name
    end
  end

  def house_members
    service = CongressService.new

    json = service.members_by_state(@state)
    
    @members = json[:results].map do |member_data|
      Member.new(member_data)
    end
  end
end
```

We need to build in a condition that checks if the method `#members_by_last_name` returns an empty array. We can do that by changing our code:

```ruby
def senate_member_by_last_name
  if !members_by_last_name(@last_name).empty?
    SenateMember.new(members_by_last_name(last_name).first)
  else
    # This is where we implement our error handling
  end
end

def members_by_last_name(last_name)
  all_senate_members.find_all do |member|
    member[:last_name] == last_name
  end
end
```

So, when `#members_by_last_name` finds a match based on our query param, the `#senate_member_by_last_name` method creates a `SenateMember` object to pass back to our controller. But, when the method doesn't find a match we need to find a way to pass an error object back to the controller.

Lets dream drive this a bit.

```ruby
def senate_member_by_last_name
  if !members_by_last_name(@last_name).empty?
    SenateMember.new(members_by_last_name(last_name).first)
  else
    ErrorMember.new("No members found with the last name: #{@last_name}", "NOT FOUND", 404)
  end
end
```

I've imagined I have an object named `ErrorMember` that takes 3 arguments upon initialization. It takes a helpful message that interpolates the search query param. It takes a status message. And, it takes a status code. This current object is returning a standard [HTTP 404 message](https://en.wikipedia.org/wiki/HTTP_404), but I've created in a way that allows it to be reuseable for other errors that may occur in my program.


If I search with a query param that does not match a senator, then I get the error:
`NameError (uninitialized constant SearchFacade::ErrorMember):`

Lets fix that!

I'll create a file in `app/poros/` called `error_member.rb` with the corresponding class:

```ruby
class ErrorMember

  attr_reader :error_message, :status, :code
  def initialize(error_message, status, code)
    @error_message = error_message
    @status = status
    @code = code
  end
end
```

Now, If I search with a query param that does not match a senator, then I get the error:
`undefined method 'name' for #<ErrorMember:...>`

This is happening because we're passing an `ErrorMember` object, which does not have a `name` attribute, to the view.

Lets pry in to ensure we have an `ErrorMember` object being held by `@results`

```ruby
class SearchController < ApplicationController
  def index
    facade = SearchFacade.new(params[:state], params[:search])
    @results = facade.search_results
    require 'pry'; binding.pry
  end
end
```

```bash_profile
   2: def index
    3:   facade = SearchFacade.new(params[:state], params[:search])
    4:   @results = facade.search_results
 => 5:   require 'pry'; binding.pry

[1] pry(#<SearchController>)> @results
=> [#<ErrorMember:0x00000001100a1ac0 @code=404, @error_message="No members found with the last name: Tyrrell", @status="NOT FOUND">]
```

It looks like that's exactly what I have, so now I need to refactor the controller to handle this condition.

Lets do this:

```ruby
class SearchController < ApplicationController
  def index
    facade = SearchFacade.new(params[:state], params[:search])
    @results = facade.search_results
    if @results.is_a?(ErrorMember)
      flash[:error] = "#{@results.error_message}"
      redirect_to root_path
    end
  end
end
```

Our controller gracefully handles three scenarios when a user searches for a member of the House or Senate.
- If the user selects a state from the drop-down, `SearchFacade#search_results` returns an array of `HouseMember` objects.
- If the user enters a valid last name in the text field, `SearchFacade#search_results` returns a `HouseMember` object.
- If the user enters a last name that does not match any senators, `SearchController#index` redirects them to the homepage with a flash message, populated with the error message from our new `ErrorMember` object.

Let's return to the `SearchFacade` and refactor `#senate_member_by_last_name` to rescue an exception:

```ruby
def senate_member_by_last_name
  match = members_by_last_name(@last_name).first
  begin
    SenateMember.new(match)
  rescue NoMethodError => e
    ErrorMember.new("No members found with the last name: #{@last_name}", "NOT FOUND", 404)
  end
end
```

Let's say we're building an API. How would our app handle these scenarios if it needed to return JSON responses?

### Error Serialization

Currently, our API::V1 controller looks like this:

```ruby
class Api::V1::SearchController < ApplicationController
  def index
    results = SearchFacade.new(params[:state], params[:search]).search_results
    render json: HouseMemberSerializer.new.serialize_json(results)
  end
  
  def show
    result = SearchFacade.new(params[:state], params[:search]).search_results
    render json: 
      SenateMemberSerializer.new.serialize_json(result)
  end
end
```

This happy path design assumes that searching by state always returns a collection of `HouseMember` objects, and searching by last name always returns one `SenateMember`.

But what if `SearchFacade#search_results` returns an `ErrorMember`?

```ruby
def show
  result = SearchFacade.new(params[:state], params[:search]).search_results
  if result.class == SenateMember
    render json: 
      SenateMemberSerializer.new.serialize_json(result)
  else
    render json: ErrorMemberSerializer.new(result)
  end
end
```

Now, I've dream driven a serializer that I can pass my `ErrorMember` object to.

Lets create that serializer file named `error_member_serializer.rb` and the corresponding class:

```ruby

class ErrorMemberSerializer
  def initialize(error_object)
    @error_object = error_object
  end
end

```

Notice that we are not using the fast_jsonapi for this serializer. If I search for a senator that doesn't exist with the search parameter "tu" then I'll get some JSON based on my object:

```json
{
  "error_object": {
    "error_message": "No members found with the last name: tu",
    "status": "NOT FOUND",
    "code": 404
  }
}
```

Not quite up to the standards of json:api specification. Lets create a custom method in my serailizer to format this properly:

```ruby
class ErrorMemberSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def serialized_json
    {
      errors: [
        {
          status: @error_object.status,
          messsage: @error_object.error_message,
          code: @error_object.code
        }
      ]
    }
  end
end
```

Now, I'll add the method call to `#serialized_json` in my controller to get the result that I want:

```ruby
class Api::V1::SearchController < ApplicationController
  ...

  def show
    result = SearchFacade.new(params[:state], params[:search]).search_results
    if result.class == SenateMember
      render json: 
        SenateMemberSerializer.new.serialize_json(result)
    else
      render json: ErrorMemberSerializer.new(result).serialized_json
    end
  end
```

Resulting in:

```json
{
  "errors": [
    {
      "status": "NOT FOUND",
      "messsage": "No members found with the last name: tu",
      "code": 404
    }
  ]
}
```

### Thinking About Patterns

Take a few minutes on your own to answer the following questions:

* What do you like about this approach?
* What do you not like about this approach?
* Can you think of a better approach?

The completed code for this lesson is available [here](https://github.com/turingschool-examples/house-salad-7) on the `error_handling_complete` branch.

### Resources

* [Rebased on API error handling](https://blog.rebased.pl/2016/11/07/api-error-handling.html)
* [Stackify on rescuing exceptions in ruby](https://stackify.com/rescue-exceptions-ruby/)
* [Geeks for Geeks on handling exceptions in ruby](https://www.geeksforgeeks.org/ruby-exception-handling/)
