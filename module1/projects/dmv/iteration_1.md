---
layout: page
title: Iteration 1 - Learning an Existing Codebase
---

_[Back to The DMV Home](./index)_
_[Back to Requirements](./requirements)_

## Exploring an Existing Codebase
We'll start this iteration by taking some time to get to know the code we're starting with. You didn't write this code, so take a look around.

You should explore:
* The classes available to you
* The tests that already exist for these classes
* Take note of the project folder structure. Is there anything you haven't seen before?

### Debugging
If you haven't already, run the tests now. You should see some failing tests. Work through fixing the code until the tests pass. You only change the application code, not the tests. It might be helpful to run each test one at a time and fix one by one.

_**TIPS**_

* You should not have any failures in `spec/dmv_data_service_spec.rb`. If you do, please notify an instructor.
* You should not change any of the existing tests for the debugging portion of the project. Change the application code, not the specs.

You should see the following errors:

![Imgur](https://i.imgur.com/nzUB9wG.png)

### Reflection
Before moving on to the next portion of this iteration, reflect on your process of learning a new codebase. In your project's README, reflect on the following:

1. Describe the steps you took to dig in to this code base. What was your process? If you don't feel you had a process, define one that you might like to try next time.
2. What was hard about working with code you did not write?
3. What was easier than you expected about jumping in to an unfamiliar codebase? What made it easy? If nothing felt easy, what would've helped you feel more comfortable more quickly? 

## Add a Registrant Class

Let's create a `Registrant` class so our visitors can use our services. Your registrant should have a `name`, `age`, `permit`, and `license_data` attributes. If no value is provided for `permit`, it should [default to false](https://medium.com/@sologoubalex/parameters-with-default-values-in-ruby-74cd0e830681). We should also be able to change a `permit` from `false` to `true` after a `Registrant` has earned their permit. There is no age limit to when someone can earn their permit.

You are required to use TDD to create your class. Use the interaction pattern to determine what a method should do and write one or more tests to verify that expected behavior. Then you can implement the method. You should always write code with the purpose of making a test pass.

Use the following interaction pattern to build out your `Registrant` class

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

pry(main)> registrant_1.permit?
#=> true

pry(main)> registrant_1.license_data
#=> {:written=>false, :license=>false, :renewed=>false}

pry(main)> registrant_2.name
#=> "Penny"

pry(main)> registrant_2.age
#=> 15

pry(main)> registrant_2.permit?
#=> false

pry(main)> registrant_2.license_data
#=> {:written=>false, :license=>false, :renewed=>false}

pry(main)> registrant_2.earn_permit

pry(main)> registrant_2.permit?
#=> true
```
