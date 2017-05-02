---
title: Factory Girl Exploration in Rails
length: 60
tags: factories, factory_girl, rails, testing, tdd, documentation
---

## Goals

* Understand what Factory Girl does
* Use Factory Girl documentation to set up factories in an existing product

## Warmup (10 minutes)

Visit the following [link](https://github.com/s-espinosa/bike-share/blob/testing_sample/spec/models/example_spec.rb).

* Describe what's happening in the setup in non-technical language.

## Introducing Factory Girl (5 minutes)

Is there a better way to do this? Factory Girl could help us out.

Clone the project [here](https://github.com/s-espinosa/guaranty_bank_500) and let's take a look at the spec folder.

### Overview

A factory is an object whose job it is to create other objects. What's the purpose of Factory Girl? Check out [this StackOverflow answer](http://stackoverflow.com/questions/5183975/factory-girl-whats-the-purpose).

It comes with some fancy tricks to allow you to set default parameters, override those parameters, create multiples of a particular object, etc.

You can use it in your test as follows:

```ruby
station         = create(:station)
invalid_station = create(:station, city_id: nil)
three_stations  = create_list(:station, 3)
```

## Testing Guaranty Bank 500 (15 minutes)

The application that you've cloned is meant to eventually track cars, owners, drivers, and their races. Currently, functionality has been built to allow users to create Owners, Cars, and Drivers, as well as calculating the average maximum speed for a collection of cars.

We also have some basic testing. Let's see how we can use Factory Girl to create information for our tests. Currently there are three skipped tests. Let's start with the test for a car.

### Discuss: `:car` Factory (10 minutes)

In the application that you've cloned, take a look at the `spec/models/car_spec.rb` and `spec/models/car_fg/spec.rb` files. While our `:race` factory was so simple as to not be useful, here we can see how Factory Girl can actually save us work.

Below is the setup for the first `.average_max_speed` test without using Factory Girl.

```
  owner  = Owner.create(name: "Scrooge McDuck")
  driver = Driver.create(name: "Baloo")
  Car.create(owner: owner, driver: driver, max_speed: 1, monetary_value: 2)
  Car.create(owner: owner, driver: driver, max_speed: 2, monetary_value: 2)
```

Compare that to the same setup in the `.average_max_speed` setup in the first test of the `car_fg_spec.rb` file.

```
  car1, car2 = create_list(:car, 2)
```

Behind the scenes, this one line is also creating an Owner and a Driver, but since those items are not pertinent to the test at hand Factory Girl allows us to just create them as valid instances of those things. Additionally, since the `monetary_value` of these cars is not important to the test at hand, we use Factory Girl to create cars with valid attributes without worrying about specifying their value.

We can also specify certain values by passing an additional argument:

```
  car1, car2 = create_list(:car, 2, max_speed: 4)
```

Or create single instances using a `create` method:

```
car1 = create(:car)
car2 = create(:car)
```

If we want to create a single instance with specific attributes, we can pass those as additional arguments as well:

```
car1 = create(:car, max_speed: 4)
car2 = create(:car, max_speed: 6)
```

### Code Along: Create a `:race` Factory (5 minutes)

Create a Factory for `race` that returns 2015 as the year. Also, in the second test in that file, find a way to use the same Factory, but specifying a different year.

## With a Partner: Create an `owner_with_cars` Factory (20 minutes)

Using the documentation availabile [here](http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md), create a factory called `:owner_with_cars` that creates an owner with 3 cars by default. Use this factory to make the remaining skipped test pass.

## Share (10 minutes)

## Additional Time

* Implement a `#max_car_speed` method on driver that finds the maximum speed of all of the cars they drive.
* Test this using Factory Girl by creating a `:driver_with_cars` Factory

### Further Reading

* [Getting Started with Factory Girl](http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md)
