# Module 1 Week 4 Diagnostic

This exercise is intended to help you assess your progress with the concepts and techniques we've covered during the week.

For these questions, write a short description or snippet of code that meets the requirement. In cases where the question mentions a "given" data value, use the variable given to refer to it (instead of re-writing the information).

##### 1. Give one difference between Modules and Classes.


##### 2.  Defining Modules

First, create a module `Doughy` which defines a method `has_carbs?` that always returns true. Then, given the following Pizza class, update Pizza to use your new Doughy module to gain the defined `has_carbs?` behavior.

```ruby
class Pizza
  def tasty?
    true
  end
end
```

##### 3. What are two benefits modules provide us in Ruby? Elaborate on each.


##### 4. What values in Ruby evaluate as "falsy"?


##### 5. Give 3 examples of "truthy" values in Ruby.


##### 6.  Git and Branches: give a git command to accomplish each of the following:

*   Switch to an existing branch iteration-1
*   Create a new branch iteration-2
*   Push a branch iteration-2 to a remote origin
*   Merge a branch iteration-1 into a branch master (assume you are not on master to begin with)


##### 7.  Load Paths and Requires

Given a project with the following directory structure, give 2 ways that we could require file_one from file_two.

```ruby
. <you are here>
├── lib
│  │── file_one.rb
│  └── file_two.rb
```


##### 8.  Refactoring: given the following snippet of code, show 2 refactorings you might make to improve the design of this code.

```ruby
class Encryptor
  def date_offset
    date = Time.now.strftime("%d%m%y").to_i
    date_squared = date ** 2
    last_four_digits = date_squared.to_s[-4..-1]
    [last_four_digits[-4].to_i,
    last_four_digits[-3].to_i,
    last_four_digits[-2].to_i,
    last_four_digits[-1].to_i]
  end
end

Encryptor.new.date_offset
```
