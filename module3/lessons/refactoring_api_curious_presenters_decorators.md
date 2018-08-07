---
layout: page
title: Refactoring API Curious
subheading: Presenters and Decorators
---

## Learning Goals

* Students understand refactor techniques using presenters and decorators
* Students understand the theory and purpose of a presenter object vs a decorator object
* Students understand the benefits of `SimpleDelegator`

## Slides

Available [here](../slides/refactoring_api_curious_presenters_decorators)

## Warmup

* What new uses of Rails were you exposed to during API Curious?
  * What specifically was beyond the traditional scope of MVC?
* Did any of our controllers or models have more than one responsibility?
* How many instance variables were we using to send information to our views?

## Setup

```bash
git clone git@github.com:turingschool-examples/apicurious_to_refactor.git
cd apicurious_to_refactor
bundle
bundle exec rake db:{create,migrate}
bundle exec figaro install
```

Within `config/application.yml`, paste:

```ruby
GITHUB_KEY: <YOUR GITHUB CLIENT ID>
GITHUB_SECRET: <YOUR GITHUB CLIENT SECRET>
```

## Intro to Presenters

### Presenter Basics

Consider these 4 rules from Sandi Metz for practicing good Rails
hygiene:

1. Your class can be no longer than 100 lines of code.
2. Your methods can be no longer than five lines of code.
3. You can pass no more than four parameters and you can't just make it one big hash.
4. When a call comes into your Rails controller, you can only instantiate one
   object to do whatever it is that needs to be done. And your view can only know about one instance variable.

The first 3 are probably familiar to us at this point (even if we
grumble about them), but what about that last one?

We've certainly seen Rails controllers and views that utilized more
than one object. So how can we reconcile the need to get things done
with this outline for code cleanliness?

Presenters are a technique for solving this problem.

* Presenters are a pattern for abstracting complexity in our view/presentation layer
* Presenters combine functionality across _multiple objects_ into a single interface
* No library needed -- just POROs!

### Workshop:  Refactor API Curious with Presenters

Go ahead and spin up your Rails server. Log into the application through GitHub and check out what information shows up on your user show page.

Looks like a lot of the data we'd want, right?

Let's check out our `UsersController` now.

What do we see that conflicts with the advice we read from Sandi Metz above?

Let's think through how a Presenter object could clean this up for us.

#### Our Goal: One Instance Variable Sent to View

> PORO == Plain Old Ruby Object

Think back to life before ActiveRecord - we modeled our data in regular old Ruby classes. We're going to bring this concept back as we implement presenter objects. These objects will allow us to fully remove hashes from our view, as well as remove all but one instance variable being sent to the view.


```bash
mkdir app/presenters
touch app/presenters/dashboard_presenter.rb
```

Within `dashboard_presenter.rb`, let's define our PORO:

```ruby
class DasboardPresenter
end
```

We'll likely want to initialize this with some information about the current user.

Let's go ahead and begin moving instance variables defined in our controller over to our presenter.

Our end goal should leave us with one instance variable in our controller method whose value points to an instance of `DashboardPresenter`.

## Intro to Decorators

You may be thinking our code looks pretty good now. You're right!

As always, though, there's room to go further.

We're going to look into the concept of **decorators**. These will feel similar to presenters, but often are used to add extra functionality to objects.

### Decorator Basics

* Decorators are a Software Pattern for applying object-oriented techniques to handling
application presentation logic
* Decorators are often used to solve similar problems as `Helpers` in Rails, but rather than mixing the helper methods into our view template, we will create an object that provides the desired behavior
* Most implementations of the Decorator pattern are built around "wrapping" and "delegation"
* Decorators are a good demonstration of
  the [Open/Closed Principle](https://en.wikipedia.org/wiki/Open/closed_principle) --
  we are able to add functionality to the wrapped object without
  modifying it directly
* Decorators in Ruby also exploit Ruby's use of duck typing -- since
  they delegate unknown methods to the internal/wrapped object, they
  effectively preserve the same interface and can be used
  interchangeably.

#### Our Goal: Add Functionality to User Objects (Without Modifying them Directly)

Let's take a moment to think of our `User` objects within API Curious.

We've purposefully not saved many attributes for a user single to the database.
As far as single responsibility goes, this makes sense.

In the context of our application, however, we know that there are attributes of each user that we do frequently want to access.

Let's take, for example, users' repositories. When cloning GitHub, it makes sense that we'd want to `GET` repositories for each user, but we know that it wouldn't make sense to create a `respositories` column on the `users` table.

What we can do here is **decorate** the `User` object.

For this, we'll be creating a `GithubUser` decorator object.  It'll allow us to keep the sanctity and single responsibility of the `User` class as-is, while adding additional functionality on top - such as a `#repositories` method.


```bash
mkdir app/decorators
touch app/decorators/github_user.rb
```

Within `github_user.rb`, let's define our decorator PORO:

```ruby
class GithubUser
end
```

We're going to want to initialize instances of `GithubUser` with a `User` object.

By doing this, we'll keep all access to data within the `User` object, but we'll also be able to customize that data as needed **AND** add functionality via methods on the `GithubUser` object.

### Understanding `SimpleDelegator`

Ruby's got a built-in class to help with decorating objects.

Take a few minutes to read up on this: [https://ruby-doc.org/stdlib-2.4.2/libdoc/delegate/rdoc/SimpleDelegator.html](https://ruby-doc.org/stdlib-2.4.2/libdoc/delegate/rdoc/SimpleDelegator.html)

Let's look at the Ruby doc's `SimpleDelegator` usage. Pop the following code into `pry` and play around.

What does this help with? What advantages does `SimpleDelegator` have for us?

```ruby
class User
  def born_on
    Date.new(1989, 9, 10)
  end
end

class UserDecorator < SimpleDelegator
  def birth_year
    born_on.year
  end
end

decorated_user = UserDecorator.new(User.new)
decorated_user.birth_year  #=> 1989
decorated_user.born_on  #=> #<Date: 1989-09-10 ((2447780j,0s,0n),+0s,2299161j)>
```

Essentially, we're able to remove the extra layer our `Decorator` class was adding on top of the `User` class.

Knowing this, let's refactor once more for our `GithubUser` decorator to inherit from `SimpleDelegator`.

#### What About `initialize`?

Notice how our decorator can be initialized without an `initialize` method defined.

So long as the object you're decorating is the **only** argument that needs to be passed to the decorator, `initialize` is not needed.

If additional information (besides the object) must be passed to the decorator, you **will** need to define `initialize`.

Let's try that out:

```ruby
class User
  def born_on
    Date.new(1989, 9, 10)
  end
end

class UserDecorator < SimpleDelegator
  attr_reader :user, :extra_info

  def initialize(user, extra_info)
    @extra_info = extra_info
    super(user)
  end

  def birth_year
    born_on.year
  end
end

decorated_user = UserDecorator.new(User.new, "some info!")
decorated_user.birth_year  #=> 1989
decorated_user.born_on  #=> Sun, 10 Sep 1989
```

Now knowing this, let's add functionality to our application's users with the `GithubUser` decorator we created.
