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

### What is an Exception? (In Ruby)
An [exception](https://ruby-doc.org/core-2.5.3/Exception.html) represents an error condition in a program. Exceptions provide a mechanism for stopping the execution of a program. They function similarly to “break,” in that they cause the instruction pointer to jump to another location. Unlike break, the location may be another layer of the program stack. Unhandled exceptions cause Ruby programs to stop.

### What is an Error? (In Ruby)
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


### Error Handling in Rails

#### Setup
We'll be using the `error_handling_start` branch of the [Building Internal APIs repo](https://github.com/turingschool-examples/building_internal_apis_7/tree/main) for this lesson.

Let's run the sad path test from `/spec/requests/api/v1/books_request_spec.rb` in isolation:

```ruby
describe "Books API" do
  ... 

  describe 'sad paths' do
    it "will gracefully handle if a book id doesn't exist" do
      get "/api/v1/books/1"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Book with 'id'=1")
    end
  end
end
```

What is the outcome of this test? Is it currently passing or failing?

It's not a trick question, and if you said "failing," you're correct! We do want to return an error response of some kind, but our application never gets the chance to do so, because it is rudely interrupted by a _raised Exception_. 

Remember, Exceptions are a type of error that 'fails loudly.' While this might be the desired behavior, we should still handle the Exception gracefully for a better user experience.

Following the stack trace, let's put a `pry` in the `Api::V1::BooksController`:

```ruby
  def show
    require 'pry'; binding.pry
    render json: BookSerializer.new(Book.find(params[:id]))
  end
```

Running `Book.find(params[:id])` here will return the following:
```
ActiveRecord::RecordNotFound: Couldn't find Book with 'id'=1
```

We can implement error handling in this controller action by rescuing from the specific Exception that was raised in the case of our sad path test. 

```ruby
  def show
    begin
      render json: BookSerializer.new(Book.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => exception
      require 'pry'; binding.pry
    end
  end
```

Run your test and verify that this part works by hitting the pry.

Let's get the test to pass by returning a json error response within the `rescue`!

```ruby
def show
  begin
    render json: BookSerializer.new(Book.find(params[:id]))
  rescue ActiveRecord::RecordNotFound => exception
    render json: {
      errors: [
        {
          status: "404",
          title: exception.message
        }
      ]
    }, status: :not_found
  end
end
```

This works, but we could refactor for a simpler controller action by creating a serializer.

### Hand-rolling an Error Serializer

Unfortunately, the jsonapi gem doesn't do a good job of this auto-magically. We'll create one by hand.
```
$ touch app/serializers/error_serializer.rb
```

```ruby
class ErrorSerializer
  def initialize(error_object)
    @error_object = error_object
  end
end
```

The `ErrorSerializer` will accept a PORO as an argument to the `initialize` method. An `ErrorMessage` PORO allows us to encapsulate data about each particular error before serializing and rendering a JSON response.

Let's continue to dream-drive this behavior in the controller.

```ruby
def show
  begin
    render json: BookSerializer.new(Book.find(params[:id]))
  rescue ActiveRecord::RecordNotFound => exception
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end
end
```

Time to actually create a `poros` directory and a file for `ErrorMessage`:
```
$ mkdir app/poros
$ touch app/poros/error_message.rb
```

The `ErrorMessage` PORO should have two attributes-- a message and a status code.

```ruby
class ErrorMessage
  attr_reader :message, :status_code

  def initialize(message, status_code)
    @message = message
    @status_code = status_code
  end
end
```

Now we have everything we need to finish the `ErrorSerializer#serialize_json` method.

```ruby
class ErrorSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def serialize_json
    {
      errors: [
        {
          status: @error_object.status_code.to_s,
          title: @error_object.message
        }
      ]
    }
  end
end
```

When you run the sad path test, it should still be passing! This is awesome, but what if we want to rescue from the `ActiveRecord::RecordNotFound` exception in other controller actions? Adding a `rescue` block to every action that uses `Book.find(params[:id])` isn't very DRY.

That's where the Rails `rescue_from` syntax comes in! `rescue_from` behaves as a Rails filter that creates a rescue for each action in this controller. 

```ruby
class Api::V1::BooksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  ...
end
```

`:not_found_response` will direct Rails to invoke a method of the same name whenever `ActiveRecord::RecordNotFound` is raised. The Exeception will auto-magically be passed, so we need to define this method and make sure it accepts an argument.

```ruby
class Api::V1::BooksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  ...

  def show
    render json: BookSerializer.new(Book.find(params[:id])) 
  end

  ...

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    render json: BookSerializer.new(book)
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    render json: BookSerializer.new(book)
  end

  private
 
  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end
end
```

This is much better, because now our `update` and `destroy` actions will handle that exception the same way. The `show` action goes back to one line, just how it was before we started this process.

We can keep our code _even more DRY_ by rescuing from a given exception across all controllers.

### Practice

In your breakout rooms, use inheritance to abstract the exception handling we've created so far.

### Thinking About Patterns

Take a few minutes on your own to answer the following questions:

* What do you like about this approach?
* What do you not like about this approach?
* How could you use `rescue` in conjunction with ActiveRecord validations?

### Resources

* [Rebased on API error handling](https://blog.rebased.pl/2016/11/07/api-error-handling.html)
* [Stackify on rescuing exceptions in ruby](https://stackify.com/rescue-exceptions-ruby/)
* [Geeks for Geeks on hanling exceptions in ruby](https://www.geeksforgeeks.org/ruby-exception-handling/)
