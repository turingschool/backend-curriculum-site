---
title: ActiveRecord Obstacle Course
tags: activerecord, rails
---

## Goals

We've gotten fairly familiar with ActiveRecord's most common methods. Let's make sure we don't get rusty with those other less-frequently used methods.

For Backend Module 2 students, this obstacle course is meant to test your knowledge over the course of the endire inning. We do not expect (nor encourage) you to finish this early. **A pull request is due in week 6 as a deliverable to graduate the module.**

The first few portions of this obstacle course are meant to test your knowledge around processing things in Ruby to put more of that work on the database (PostgreSQL) to make our own code easier to maintain. Your job will be to remove the code that processes data in Ruby, and replace that code with proper ActiveRecord commands to do the exact same work.

The remaining portions of the obstacle course will increase in difficulty and will teach you how to turn raw SQL into proper ActiveRecord commands.


## Instructions

1. Fork the [Storedom](https://github.com/turingschool-examples/storedom-5) repo to your own GitHub account, then clone down your fork. Then, do the following:

```bash
# add Turing's repo as a 'remote'
git remote add turing git@github.com:turingschool-examples/storedom-5

# fetch all of Turing's branches
git fetch turing

# check out Turing's `activerecord-obstacle-course` branch
git co turing/activerecord-obstacle-course

# make a branch for your repo
git co -b activerecord-obstacle-course

# push the branch to your repo
git push -u origin activerecord-obstacle-course
```

2. Do the usual setup

```bash
bundle install
bundle update
rake db:{drop,create,migrate,seed}
rspec spec/models/activerecord_obstacle_course_spec.rb
# you should see several passing tests, and a few skipped tests
```

3. Start with the top test within `spec/models/activerecord_obstacle_course_spec.rb` and work in order.

4. To run your tests, you can run `rspec spec/models/activerecord_obstacle_course_spec.rb`

5. If you want to run one specific test, you can run `rspec spec/models/activerecord_obstacle_course_spec.rb:LINE_NUMBER`.

    * For example: `rspec spec/models/activerecord_obstacle_course_spec.rb:34`

    * Note: There's one skipped spec at the very end. Ignore it until all other tests are finished.

6. Most of the tests follow the same format...

    * Leave the Ruby as is or comment it out -- Don't erase it.

      ```ruby

      # -----------------------------
      # A section with some Ruby code
      # -----------------------------

      ```

    * Write a refactored implementation using ActiveRecord. Assign to the same variables as above.

      ```ruby
      # -----------------------------
      # A section for you to write refactor the Ruby or raw SQL code
      # -----------------------------
      ```

    * Leave the expectations alone. They will determine whether you have a working solution.

      ```ruby
      # -----------------------------
      # The expectation
      # -----------------------------
      ```

7. You must not change the setup or expectations of any test.

## Extensions

If you finish everything in here before week 6, you're welcome to take on the following extensions:

* Break your solutions into scopes and/or class methods.
* Try to implement one example using ActiveRecord's `merge`.
