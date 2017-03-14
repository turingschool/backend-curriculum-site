# Callbacks & Scopes

---

# Part 1: Refactoring Into Callbacks & POROs

---

# Warmup

* What's a PORO? Why might you use one?
* What are some of the tools that you've used so far in Rails?

---

# Intro to Callbacks

Kind of like filters for models.

1. before_validation
1. after_validation
1. before_save
1. before_create

**write to the database**

---

# Callbacks Continued

1. after_create
1. after_save
1. before_update
1. after_update
1. before_destroy
1. after_destroy

---

# Kitty Castle

* What's happening in the `create` method on the `ReservationsController`?

---

# Pair Refactor Using Callbacks

With a partner, refactor the `ReservationsController` by moving code to callbacks.

---

# Group Share

---

# POROs

* Plain Old Ruby Object
* The problem with callbacks...

---

# Pair Refactor Using a PORO

* Did you use `after` callbacks in your `Reservation` class?
* Did you leave actions not related to the request/response in your `ReservationsController`?
* See if you can refactor those out to a PORO that will complete these actions.

---

# Group Share

---

# Part 2: Scopes

---

# Let's start with Class Methods

* What's the difference between class and instance methods?
* How do I indicate to Ruby that I've created a class method?
* What are some class methods that ActiveRecord gives us?

---

# Class Methods to Narrow Things Down

* Finding today's reservations

```ruby
  def today
    where('start_date >= ?', Time.zone.now.beginning_of_day)
  end
```

---

# Pair Creating a Class Method

* Create a class method on `Reservation` that returns all completed reservations.
* Create a class method on `Reservation` to return all resrvations after a date specified by an argument.
* Hint: take a look at the schema to see what attributes a reservation has.

---

# Creating Scopes

* 'Stabby lambda' syntax

```ruby
  scope :today -> { where('start_date >= ?', Time.zone.now.beginning_of_day) }
```

---

# Why Scopes?

* Scopes can always be chained.
* Class methods can be chained only if they return an object that can be chained.
* Can set up a default scope (don't do this)

