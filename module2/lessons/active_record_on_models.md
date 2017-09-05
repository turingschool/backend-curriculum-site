---
title: ActiveRecord on Models
length: 60
tags: activerecord, models, rails
---

## Goals

* Access attributes for an instance of a resource from within a method on its model.
* Create class and instance methods on models.
* Call class methods on a subset of instances of a class.
* Practice creating class and instance methods.

## Slides

* Available [here](../slides/active_record_on_models)

## Warmup

Assume I have a Horse model and that Horses belong to Owners.

* How do I access the age of a particular horse?
* How do I access the owner of a particular horse?
* How do I generate an array of all horse names?
* How do I determine the average horse age?

## Background

In the past much of the ActiveRecord we have used has been in the rails console or a controller.

For example:

```ruby
#rails c
> Horse.find(1).age
```

Or from a controller:

```ruby
def show
  @horse = Horse.find(params[:id])
end
```

## Methods on AR Models

When writing methods on an ActiveRecord model, we can access attributes of a particular instance directly on an instance of a model from within that model.

```ruby
def years_until_30
  30 - age
end
```

We can also access relationships from within an instance of a model.


```ruby
def owner_name
  owner.name
end
```

We can do both of these things because ActiveRecord is giving us access to `age` and `owner` methods, which we are calling from within the `#years_until_30`, and `#owner_name` methods above.

## Class Methods

We can also create class methods. One of the nice things about class methods on our models is that they can be called on any collection of instances of the Model. For example, if we have the following method on our `Horse` model:

```ruby
def self.names
  pluck(:name)
end
```

We can use that method on a collection of all horses:

```
# In our Horse index view, where @horses has been set to Horse.all
@horses.names
```

Or on a smaller collection of horses:

```
# In our Owner model, returning names of only those horses that belong to a particular owner.
def horse_names
  horses.names
end
```

## Practice

Clone the repo [here](https://github.com/turingschool-examples/election). Bundle, `rake db:create db:migrate`, and then run the test suite using `rspec`. Work to make all of the failing tests pass.
