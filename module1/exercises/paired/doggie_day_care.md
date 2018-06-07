---
layout: page
title: Practice Paired Assessment
---

Clone this Repo: git@github.com:turingschool-examples/doggie-day-care.git

### Iteration 1 (Tests provided)

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

```ruby
doggie_1 = Dog.new("Comet", "German Shepherd")
# => <#Dog...>
customer_1 = Customer.new("Alice", "Jones", "2")
# => <#Customer...>
customer_1.add_dog(doggie_1)
# => <#Dog...>
doggie_2 = Dog.new("Lassie", "Collie")
# => <#Dog...>
doggie_3 = Dog.new("Martha", "Bernese Mountain Dog")
# => <#Dog...>
customer_2 = Customer.new("Tracy", "Nguyen", "5")
# => <#Customer...>
customer_2.add_dog(doggie_2)
# => <#Dog...>
customer_2.add_dog(doggie_3)
# => <#Dog...>
day_care = DayCare.new("The Dog Spot")
# => <#DayCare...>
day_care.add_customer(customer_1)
# => <#Customer...>
day_care.add_customer(customer_2)
# => <#Customer...>
day_care.list_dogs
# => "Comet, Lassie, Martha"
day_care.unfed_dogs
# => [<#Dog...>, <#Dog...>, <#Dog...>]
doggie_1.feed
# => "Yum!"
day_care.unfed_dogs
# => [<#Dog...>, <#Dog...>]
```

### Iteration 4

Write a method to charge customers $5 each time their dog is fed.
