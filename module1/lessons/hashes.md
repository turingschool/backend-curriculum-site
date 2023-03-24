# Hashes

### Learning Goals
- Identify the differences between Hashes and Arrays. 
- Practice building, accessing, and updating Hashes.

### Vocabulary
- Hash
- Symbol
- Key
- Value

### Warm-up
Say we have an array named `grocery_list` that looks like this:
```ruby
grocery_list = ["milk", "eggs", "eggs", "eggs", "eggs", "eggs", "eggs", "avocado", "avocado", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla"]
```

Answer these questions with your group:
1. What is problematic about this data being in this array?
1. How would you prefer this data be stored?


## Part 1: Student Exploration

With our groups, we will be working through [this repository](https://github.com/turingschool-examples/mod-1-be-exercises/blob/main/ruby_exercises/data-types/collections/spec/hashes_spec.rb)

If you have already completed these exercises, delete your work and let's do it again! Repetition is the key to our learning. 

While working through these exercises, write down any important information you come across. 
Take note of:
  - What was challenging? How did you end up solving that challenge?
  - Any keypoints.
  - What questions came up?
  - What questions do you still have?
  - Anything else that seems important.

Resources to use while working through the exercises:
  - Your breakout room mates!
  - Google (ex: `Ruby how to make a new hash with a default value`)
  - [Ruby Docs](https://ruby-doc.org/core-2.7.0/Hash.html)
  - [Intro To Hashes](introducing_hashes.md)
 

## Part 2: Discussion

Take a minute to look through your notes about Hashes. Add your key takeaways (or AHA! moments) to [this Jamboard](https://jamboard.google.com/d/1MEYR4aLk3Sl6slB4Ad5xDlrMzBU3L4cFqoaJYDGz7cA/edit?usp=sharing) : page 1

Take a minute to look through the questions you still have about Hashes. Add them to [this Jamboard](https://jamboard.google.com/d/1MEYR4aLk3Sl6slB4Ad5xDlrMzBU3L4cFqoaJYDGz7cA/edit?usp=sharing) : page 2

### Questions
1. What does it make sense to use a Hash? (As opposed to an array?)
1. How should we name our Hashes?
  
  


For these questions, let's refer to this code snippet:

```ruby

  grocery_items = {
        eggs: 4,
        bread: 2,
        milk: 3,
        cookies: 4  
  }
```
<section class='answer'>
### What data type can a key be?
  
  Keys of a hash can be any data type. 
  Often, we see them as symbols.
  A symbol is an immutable data-type in Ruby. They will start with a `:` (colon).
  Keys can also be seen commonly as strings, however they can be integers as well.
  
</section>


