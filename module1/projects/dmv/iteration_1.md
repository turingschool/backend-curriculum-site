---
layout: page
title: Iteration 1 - Learning an Existing Codebase
---

_[Back to The DMV Home](./index)_

## Exploring an Existing Codebase
We'll start this iteration by taking some time to get to know the code we're starting with. You didn't write this code, so take a look around.

You should explore:
* The classes available to you
* The tests that already exist for these classes
* Take note of the project folder structure. Is there anything you haven't seen before?

### Debugging
If you haven't already, run the tests now. You should see some failing tests. Work through fixing the code until the tests pass. You only change the application code, not the tests. It might be helpful to run each test one at a time and fix one by one.

INSERT SCREENSHOT HERE




## Test Driven Development
In this iteration, you are required to use TDD to create your classes. Use the interaction pattern to determine what a method should do and write one or more tests to verify that expected behavior. Then you can implement the method. You should always write code with the purpose of making a test pass.

### Add a Registrant Class

Let's create a `Registrant` class so our visitors can use our services. Your registrant should have a `name`, `age`, and `permit` attributes. If no value is provided for `permit`, it should default to false. We should also be able to change a `permit` from `false` to `true` after a `Registrant` has earned their permit.

Use TDD and the following interaction pattern to build out your `Registrant` class

```ruby
pry(main)> require './lib/registrant'
#=> true

pry(main)> registrant_1 = Registrant.new('Bruce', 18, true )
#=> #<Registrant:0x000000015c10bed8 @age=18, @license_data={:written=>false, :license=>false, :renewed=>false}, @name="Bruce", @permit=true>

pry(main)> registrant_2 = Registrant.new('Penny', 15 )
#=> #<Registrant:0x000000015c0778c8 @age=15, @license_data={:written=>false, :license=>false, :renewed=>false}, @name="Penny", @permit=false>

pry(main)> registrant_1.name
#=> "Bruce"

pry(main)> registrant_1.age
#=> 18

pry(main)> registrant_1.permit
#=> true

pry(main)> registrant_2.name
#=> "Penny"

pry(main)> registrant_2.age
#=> 15

pry(main)> registrant_2.permit
#=> false

pry(main)> registrant_2.earn_permit
#=> true

pry(main)> registrant_2.permit
#=> true
```
