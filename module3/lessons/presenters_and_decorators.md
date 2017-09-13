---
title: Decorators & Presenters
length: 90
tags: presenters, decorators, rails, refactoring, mvc
---

## Learning Goals

* Understand the decorator pattern and how it can be used to make code cleaner and more maintainable
* Understand the theory and purpose of a presenter object

## Lecture: Intro to Decorators

### Q and A Discussion: What Problem are Decorators trying to Solve?

* __Q:__ What is the standard tool in rails for abstracting view-layer
  responsibilities?
* __Q:__ What are some downsides to this approach? (hint: when you see a method
  called in a view template, how do you determine where this method is defined?)
* __Q:__ What might a more object-oriented approach to view-layer
  interactions look like?

### Decorator Basics

* Decorators are a Software Pattern for applying object-oriented techniques to handling
application presentation logic
* Decorators are often used to solve similar problems as `Helpers` in Rails, but rather than mixing the helper methods into our view template, we will create an object that provides the desired behavior
* Most implementations of the Decorator pattern are built around "wrapping" and "delegation"
* Decorators are a good demonstration of
  the [Open/Closed Principle](https://en.wikipedia.org/wiki/Open/closed_principle) --
  we are able to add functionality to the wrapped object without
  modifying it directly
* Decorators in ruby also exploit ruby's use of duck typing -- since
  they delegate unknown methods to the internal/wrapped object, they
  effectively preserve the same interface and can be used
  interchangeably.

### Wrapper / Delegator Pattern

It's often useful on OO design to create an object which adds additional functionality
as a "layer" on top of another object. We could use inheritance for this, but it's
not always an accurate expression of the relationship -- my new object might not really
be a "descendant" of the original one, but it can still be involved in enhancing its
functionality.

A common approach to this type of relationship is to define the second object as a "delegator"
or "wrapper" around the first. When creating an instance of Object B, we will pass it an
instance of Object A. In some cases Object B will define its own methods, but in some
cases it will simply "pass through" methods that are called on it to Object A.

Let's look at a more concrete example.

```ruby

class ObjectA
  def pizza
    "pizza"
  end

  def calzones
    "calzones"
  end
end

class ObjectB
  def initialize(object_a)
    @object_a = object_a
  end

  def pizza
    @object_a.pizza
  end

  def calzones
    @object_a.calzones.upcase
  end
end

obj = ObjectB.new(ObjectA.new)
obj.pizza
=> "pizza"
obj.calzones
=> "CALZONES"
```

As we said, ObjectB takes as its initialization argument an instance
of ObjectA. The methods we define on ObjectB either delegate directly
to methods on ObjectA, or add small modifications on the equivalent method
from ObjectA.

This pattern gives us 2 main advantages:

1. Since ObjectB defines the same suite of methods as ObjectA
we can use them interchangeably (recall what we said about Duck Typing before)
2. Since ObjectB has the ability to modify the return values of methods from
ObjectA, we can use it as a way to add small tweaks onto these existing
behaviors. This can be very useful for presentation logic, which we often want to keep
out of the main model methods.

### Decorator Pattern in Ruby

**TODO:** Create a project where we can try this out on and have the students work through it.

The Decorator Pattern is an OO concept and is not specific to Ruby. Ruby offers us a simple, built-in way to use the Decorator Pattern: `SimpleDelegator`.

Let's take a look at how we could use a Decorator to clean up our view and prevent logic from leaking through.

Let's say we're storing our cart contents in a session so that the key points to an item's id and the value points to the quantity of that item in the cart. If we called `session[:cart]` from a Rails controller and it returned `{"1" => 2, "3" => 1}` we would have 2 `Item`s with an id of 1 and 1 `Item` with an id of 3. Displaying this cart content in the view can be tricky since we want to load the `Item` objects and display things like their names and prices, but also the quantity in the cart. We could do something like this:

```
<% session[:cart].each do |item_id, quantity| %>
  <% item = Item.find(item_id) %>
  <tr>
    <td><%= item.name %></td>
    <td><%= item.name %></td>
    <td><%= quantity %></td>
  </tr>
<% end %>
```

Gross. We are making database queries and accessing the `session` directly in our view. One way we could improve this is to use the Decorator Pattern. The end goal would be for our view to look like this:

```
<% @cart_items.each do |cart_item| %>
  <tr>
    <td><%= cart_item.name %></td>
    <td><%= cart_item.name %></td>
    <td><%= cart_item.quantity %></td>
  </tr>
<% end %>
```

This feels a lot better and more in line with the purpose of a view. Iterating over an array of objects instead of a hash is also preferred and will lead to more maintainable software. So what does the code behind this need to look like?

In the controller:

```
def show
  @cart_items = Cart.new(session[:cart]).cart_items
end
```

In `cart.rb`

```
class Cart
  def initialize(raw_contents = {})
    @raw_contents = raw_contents
  end

  def cart_items
    raw_contents.map do |item_id, quantity|
      item = Item.find(item_id)
      CartItem.new(item, quantity)
    end
  end

  private
    attr_reader :raw_contents
end
```

In `cart_item.rb`

```
class CartItem < SimpleDelegator
  attr_reader :quantity

  def initialize(item, quantity)
    super(item)
    @quantity = quantity
  end
end
```

We now have several single responsibility objects which might on the surface seem more complex. But as this project grows in complexity we will have a much easier time deciding where to put logic. Is the code specific to the cart? Put it in the `Cart` class. Is it specific to an item in the cart? Put it in the `CartItem`. If we don't do this refactor and leave it the way it was, most of the logic lives in the view. If any of this logic needs to be used in multiple views, let's say a main cart view and a smaller cart side-bar, we'll likely have duplicate logic making changes more difficult to maintain.

#### A Deeper Dive to Solidify Understanding

Take some time to experiment and research the following questions

1. In our `CartItem` we define `initialize`. Is this always necessary with `SimpleDelegator`? (Experiment: Create a more simple class that inherits from `SimpleDelegator` that doesn't require two parameter to initialize)
1. In the `initialize` method, what is the purpose of the `super(item)` line?
1. Does `super` always require a parameter?
1. How does the Decorator Pattern utilize the Four Pillars of Object Oriented Programming?

## Lecture: Intro to Presenters

### Presenter Basics


Consider these 4 rules from Sandy Metz for practicing good Rails
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
* Decorator -- Adds functionality (often view-related) to a single
  object (or possibly collection of objects)
* Presenter -- Combines functionality across _multiple objects_
  into a single interface
* A presenter is just another domain object -- one that represents
  a larger abstraction across multiple objects
* In more complicated scenarios, Presenters and Decorators can be
  used in conjunction
* No library needed -- just POROs!
* Example: creating a `Dashboard` presenter

## Code: Creating a Dashboard
Using the Blogger project, create a presenter for the Dashboard such
that the **only** instance variable in `views/dashboard/show.html.erb` is
`@dashboard`.

If you get that working, try creating a `DashboardDecorator`. What logic can
you pull out of the view template into the decorator?
