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
    CongressService.fetch_senate_members
end

def self.all_senate_members
    call_senate_service[:results][0][:members]
end
```

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
  # By utilizing memoization, the iteration over our all_senate_members array only happens once per request
  @@matches ||= all_senate_members.find_all {|m| m[:last_name] == last_name}
end
```
