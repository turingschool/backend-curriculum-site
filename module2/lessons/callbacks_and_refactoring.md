---
title: Callbacks and Refactoring
---

## Goals

* Understand how callbacks work
* Know some common callbacks
* Use callbacks to your advantage

## Setup

* `git clone git@github.com:turingschool-examples/hotel_callbackfornia.git`

## Too Much Logic in Controller

Check out the `create` action in the `ReservationsController`.

What here might be considered outside the scope of logic a controller action should handle?

```ruby
def create
  @reservation = Reservation.new(reservation_params)

  if @reservation.save
    @reservation.room.booked!
    redirect_to guest_reservations_path(current_guest)
  else
    redirect_to hotel_room_path(@reservation.room.hotel, @reservation.room)
  end
end
```

Should our reservation save, we're then updating the reservation's room's status to `booked` before we redirect our user.

Let's see if we can extract this.

## Callbacks in Models

```ruby
class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :guest

  after_save :book_room

  private

  def book_room
    self.room.booked!
  end
end
```

## [Rails/ActiveRecord Callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)

What are [callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)?

Pick of a few below that sound useful to you. Let's take a few minutes to research those.

1. Creating an Object
  * `before_validation`
  * `after_validation`
  * `before_save`
  * `around_save`
  * `before_create`
  * `around_create`
  * `after_create`
  * `after_save`
  * `after_commit`/`after_rollback`
1. Updating an Object
  * `before_validation`
  * `after_validation`
  * `before_save` **__Note: before_save gets called when we update and when we create.__**
  * `around_save`
  * `before_update`
  * `around_update`
  * `after_update`
  * `after_save`
  * `after_commit`/`after_rollback`
1. Destroying an Object
  * `before_destroy`
  * `around_destroy`
  * `after_destroy`
  * `after_commit`/`after_rollback`

## Where Else Could We Use a Callback?

Check out our seedfile and take a look at how we're creating guests. What information are we requiring? Is anything missing here that is reflected in our schema?

Often, there is information worth storing in your database that isn't worth asking your user to provide.

This could be the full name of a user, the total price of an order, the URL slug of a blog post, etc.

How can we turn our guest's first and last names into a callback?

### Workshop: Full Name

See if you can use a callback to create a guest's full name. Test this callback's functionality in your Rails Console.

## Callbacks Are Often Code Smells

Callbacks are super powerful, but why should we use them with care?

Let's break up into 4 groups to research this.

Try to be diligent with your research and come to your own conclusions. This practice will come in handy when navigating opinionated developers in your career.

## Want More? Research Scopes

Scopes allow you to define and chain query criteria in a declarative and
reusable manner.

Scopes take lambdas - a lambda is a function without a name.

Here are some examples.

```ruby
class Reservation < ActiveRecord::Base

  scope :complete, -> { where(complete: true) }
  scope :today, -> { where("start_date >= ?",
                           Time.zone.now.beginning_of_day) }
end
```

They can also take arguments.

```ruby
class Reservation < ActiveRecord::Base

    scope :newer_than, ->(date) {
        where("start_date > ?", date)
          }

end
```

## Scopes vs Class Methods

* These look eerily similar in usage, but there are key differences.
* Scopes can always be chained.
* Class methods can be chained only if they return an object that can be chained.
* Scopes automatically work on has_many relationships.
* You can set up a default scope.
