---
layout: page
title: Sample Paired Assessment
---

# Doggie Day Care

### Iteration 1

```ruby
doggie = Dog.new("Comet", "German Shepherd")
# => <#Dog...>
doggie.name
# => "Comet"
doggie.breed
# => "German Shepherd"
doggie.fed?
# => false
doggie.feed
# => "Yum!"
doggie.fed?
# => true
```

### Iteration 2

```ruby
doggie = Dog.new("Comet", "German Shepherd")
# => <#Dog...>
customer = Customer.new("Alice", "Jones", "2")
# => <#Customer...>
customer.full_name
# => "Alice Jones"
customer.id
# => 2
customer.dogs
# => []
customer.add_dog(doggie)
# => <#Dog...>
customer.dogs
# => [<#Dog...>]
```

### Iteration 3

A client has contracted you to build a software system for a network of pet day care centers that can track its Customers and their Dogs. Specifically, they need the following features:

  * Each day care has a unique name.
  * A day care enrolls customers.
  * A day care can list all its dogs
  * A day care can list all its dogs that need to be fed.

Build on your code from the previous two iterations to implement this functionality

### Iteration 4

Implement the following functionality:

  * Every time a dog is fed, a customer is charged a fee.
