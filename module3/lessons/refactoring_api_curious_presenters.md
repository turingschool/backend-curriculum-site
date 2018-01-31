---
layout: page
title: Refactoring API Curious
---

## Learning Goals

* Students understand refactor techniques using presenters
* Understand the decorator pattern and how it can be used to make code cleaner and more maintainable
* Understand the theory and purpose of a presenter object

## Warmup

* What new uses of Rails were you exposed to during API curious?
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

* Similar to Decorators, Presenters are a pattern for abstracting
  complexity in our view/presentation layer
<!-- * Decorator -- Adds functionality (often view-related) to a single object (or possibly collection of objects) -->
* Presenter -- Combines functionality across _multiple objects_
  into a single interface
* A presenter is just another domain object -- one that represents
  a larger abstraction across multiple objects
<!-- * In more complicated scenarios, Presenters and Decorators can be used in conjunction -->
* No library needed -- just POROs!

## Workshop:  Refactor API Curious

Go ahead and spin up your Rails server. Log into the application through GitHub and check out what information shows up on your user show page.

Looks like a lot of the data we'd want, right?

Let's check out our `UsersController` now.

What do we see that conflicts with the advice we read from Sandi Metz above?

Let's think through how a Presenter object could clean this up for us.

### POROs

PORO == Plain Old Ruby Object

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
