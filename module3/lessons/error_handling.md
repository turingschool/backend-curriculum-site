---
layout: page
title: Error Handling in Rails Applicaitons
length: 120
tags: rails, errors, rescue, raise, eceptions
---

## Vocabulary
* Exception
* Error
* Class Hierarchy
* Rescue

## Learning Goals

* Understand the need as developers to plan for errors and handle exceptions
* Use Rails built in `raise` and `rescue_from` methods
* Take an object oriented approach to error handling

## What is an Exception? (In Ruby)
An [exception](https://ruby-doc.org/core-2.5.3/Exception.html) represents an error condition in a program. Exceptions provide a mechanism for stopping the execution of a program. They function similarly to “break,” in that they cause the instruction pointer to jump to another location. Unlike break, the location may be another layer of the program stack. Unhandled exceptions cause Ruby programs to stop.

## What is an Error? (In Ruby)
An error is an unwanted or unexpected event, which occurs during the execution of a program, i.e. at run time, that disrupts the normal flow of the program’s instructions.

### Breakout Room Discussion - 10 minutes
Lets talk about some of the common errors you've seen thus far in your development. These can be errors you've seen in mod 1 in pure ruby or errors that you've seen as you've begun developing professional quality rails applications ie: ActiveRecord, Routing, ApplicationController, Status Codes, etc.

* Make a list of all of the errors you can think of.
* Make a list of the approaches that you've used thus far to handle each of those errors.

### The Exception Tree
Lets take a look at how Ruby has organized its exception hierarchy. Remember, exceptions are simply classes that the Ruby library has predefined for us.

Below is a list of exception classes that ship with Ruby's standard library. Third-party gems like Rails will add additional exception classes to this chart. Every additional exception from Rails will inherit from some class on this list.

```ruby
Exception
 NoMemoryError
 ScriptError
   LoadError
   NotImplementedError
   SyntaxError
 SignalException
   Interrupt
 StandardError
   ArgumentError
   IOError
     EOFError
   IndexError
   LocalJumpError
   NameError
     NoMethodError
   RangeError
     FloatDomainError
   RegexpError
   RuntimeError
   SecurityError
   SystemCallError
   SystemStackError
   ThreadError
   TypeError
   ZeroDivisionError
 SystemExit
 fatal
 ```

**`Exception` is at the top level of this inheritance tree. This is why we should never explicitly rescue the `Exception` class. If we do that, then we are catching ALL exceptions that inherit from `Exception`, which is all of these errors! Not only do we need to be more specific than that in order to have a better idea about what exactly went wrong in our application, but rescuing from `Exception` can cause unintended consequences as you are catching exceptions that Ruby uses internally.**

Here are some examples of exceptions that we need to ensure behave as intended within our program:

* **SignalException::Interrupt** - If you rescue this, then you can't exit your app by pressing `control + C`.

* **ScriptError::SyntaxError** - Rescuing syntax errors means that things like `p "Forgot to close out this quote` will fail silently.

* **NoMemoryError** - I wonder what will happen if the Ruby program continues execution even though there isn't any RAM left on your machine? 🤯🤯 Do not try this at home.

So, the highest level of exception handling we should ever commit to is on the [StandardError class](https://ruby-doc.org/core-2.5.3/StandardError.html).

Looking above at our tree. Which errors do you recognize that inherit from StandardError?
Take a minute to think about this on your own.

Lets see an example:

Create a ruby file called `exception_handling.rb` and place the code below in it. Then, let's run that file.

```ruby
begin
  "Lets call a method that does not exist on the string class".hello_friends
rescue StandardError => e
  require "pry"; binding.pry
end
```

Take a five minutes on your own to answer the following questions:
* Why did we hit the pry?
* What is `e`?
* What class is `e`
* Which methods look useful on `e`?
* Which classes does `e` inherit from?

### Error Serialization

According to the [json:api specification](https://jsonapi.org/format/#error-objects)

**Error objects provide additional information about problems encountered while performing an operation. Error objects MUST be returned as an array keyed by errors in the top level of a JSON:API document.**

Unfortunately, the FastJsonapi gem [does not have any hard or fast opinions](https://github.com/Netflix/fast_jsonapi/issues/53) on error handling, and thus did not build in functionality specific to errors. So, we need to handle errors on our own, while still following the json:api specification.

Let's imagine a scenario where a user searches for a senator by last name, but no senator with that last name exists.

If we fill in the search box with our own last name such as "Tyrrell" then we get an unhandled error. Let's handle that.

Our Facade currently looks like so:

```ruby
class CongressFacade
  def self.house_members(state_abbreviation)
    json = CongressService.fetch_house_members(state_abbreviation)
    json[:results].map do |member_info|
      HouseMember.new(member_info)
    end
  end

  def self.all_senate_members
    CongressService.fetch_senate_members[:results][0][:members]
  end

  def self.member_by_last_name(last_name)
    SenateMember.new(members_by_last_name(last_name).first)
  end

  def self.members_by_last_name(last_name)
    all_senate_members.find_all {|m| m[:last_name] == last_name}
  end
end
```

First, lets isolate our call to our service.

```ruby
def self.call_senate_service
  @@service_result ||= CongressService.fetch_senate_members
end

def self.all_senate_members
  call_senate_service[:results][0][:members]
end
```
Isolation helps on a few fronts. It's more SRP. We can properly test this method. And, we can take advantage of memoization to ensure our we only ever make one external API call per request.

Because we are memomizing within a class method, we need a class variable to hold the result of our service call. An instance variable or local variable will not memoize properly.

Now, we can build in some sad path and edge case handling within our facade.

We need to build in a condition that checks if the method `::members_by_last_name` returns an empty array. We can do that by changing our code:

```ruby
def self.member_by_last_name(last_name)
  if !members_by_last_name(last_name).empty?
    SenateMember.new(members_by_last_name(last_name).first)
  else
    # This is where we implement our error handling
  end
end

def self.members_by_last_name(last_name)
  # By utilizing memoization, the iteration over our all_senate_members array only happens once per request.
  @@matches ||= all_senate_members.find_all {|m| m[:last_name] == last_name}
end
```

So, when `::members_by_last_name` finds a match based on our query param, we create a `SenateMember` object to pass back to our controller. But, when the method doesn't find a match we need to find a way to pass an error object back to the controller.

Lets dream drive this a bit.

```ruby
def self.member_by_last_name(last_name)
  if !members_by_last_name(last_name).empty?
    SenateMember.new(members_by_last_name(last_name).first)
  else
    ErrorMember.new("No members found with the last name: #{last_name}", "NOT FOUND", 404)
  end
end
```

I've imagined I have an object named `ErrorMember` that takes 3 arguments upon initialization. It takes a helpful message that interpolates the search query param. It takes a status message. And, it takes a status code. This current object is returning a standard [HTTP 404 message](https://en.wikipedia.org/wiki/HTTP_404), but I've created in a way that allows it to be reuseable for other errors that may occur in my program.


If I search with a query param that does not match a senator, then I get the error:
`NameError (uninitialized constant CongressFacade::ErrorMember):`

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
`FastJsonapi::MandatoryField (id is a mandatory field in the jsonapi spec):`

This isn't quite as helpful of an error, but it's happening because we're passing the `SenateMemberSerializer` an ErrorMember object without an id. Currently our controller looks like this:

```ruby
class CongressController < ApplicationController
  def search
    @member = CongressFacade.member_by_last_name(params[:search])
    render json: SenateMemberSerializer.new(@member)
  end

  def search_state
    @members = CongressFacade.house_members(params[:state])
    render "welcome/index"
  end
end
```

Quick tangent: This is currently the same error message if I search for a current Senator with the CORRECT last name. Because we are using FastJsonapi to serialize this object, that library expects the object we pass to our serializer to have an attribute called `id`. I can add a line to my `SenateMember` to take care of this for now:

```ruby
class SenateMember

  attr_reader :id,
              :first_name,
              :last_name,
              :twitter_account
  def initialize(attributes)
    @id = 1
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @twitter_account = attributes[:twitter_account]
  end
end
```

We will only ever render one senator, so we can hard code `id` here to be `1`, and it works when you search for a current senator such as `Sanders`. However, we know this isn't best practice, and there are some other approaches we could take for a collection, like say setting the id to `index + 1` within an `each_with_index` block. Lets just say that the fast_jsonapi API is heavily opinionated, and if we're creating workarounds for it to work, then it may not be the best tool for the job.

Moving on...

Lets pry in to ensure we have an `ErrorMember` object being held by `@member`

```ruby
class CongressController < ApplicationController
  def search
    @member = CongressFacade.member_by_last_name(params[:search])
    require "pry"; binding.pry
    render json: SenateMemberSerializer.new(@member)
  end

  ...
```

```bash_profile
2: def search
   3:   @member = CongressFacade.member_by_last_name(params[:search])
=> 4:   require "pry"; binding.pry
   5:   render json: SenateMemberSerializer.new(@member)
   6: end

[1] pry(#<CongressController>)> @member
=> #<ErrorMember:0x00007fe313dd0ee8 @code=404, @error_message="No members found with the last name: Tuyr", @status="NOT FOUND">
```

It looks like that's exactly what I have, so now I need to create a path within my controller for this `ErrorMember` to be serialized.

Lets do this:

```ruby
class CongressController < ApplicationController
  def search
    @member = CongressFacade.member_by_last_name(params[:search])
    if @member.class == SenateMember
      render json: SenateMemberSerializer.new(@member)
    else
      render json: ErrorMemberSerializer.new(@member)
    end
  end

  ...
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
class CongressController < ApplicationController
  def search
    @member = CongressFacade.member_by_last_name(params[:search])
    if @member.class == SenateMember
      render json: SenateMemberSerializer.new(@member)
    else
      render json: ErrorMemberSerializer.new(@member).serialized_json
    end
  end

  ...
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

Instructor will now drive using a different approach to handling errors using a combination of `raise`, `rescue_from`, and serialization.


### Resources

* [Rebased on API error handling](https://blog.rebased.pl/2016/11/07/api-error-handling.html)
* [Stackify on rescuing exceptions in ruby](https://stackify.com/rescue-exceptions-ruby/)
* [Geeks for Geeks on hanling exceptions in ruby](https://www.geeksforgeeks.org/ruby-exception-handling/)
