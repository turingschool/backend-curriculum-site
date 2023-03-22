---
layout: page
title: Relational Rails - Evaluation Day Peer Code Share
---

_[Back to Relational Rails Home](./)_

## Peer Code Share

On eval day, you will be partnered with another student to review each other's code and provide feedback.

First, exchange Github repository links with the other student, and clone the repository.

Then, in your Terminal, run the following:
```ruby
bundle install
rails db:{drop,create,migrate,seed}
rails s
```

Then, individually, take about 25 minutes to review the other person's code. You should write down answers to the following questions:

1. Can you launch/use the application? Can you perform the actions described in the user stories? Do you find any bugs as you navigate through any pages?
1. Run their overall test suite (`bundle exec rspec`). Are there any failing tests? Are their tests strong/robust? (Strong tests utilize both obvious outcomes and edge cases.)
1. Check their application's Models and the relationship to each other. Does the one-to-many relationship work? Are there any instance methods in their models? Are there any operations in a controller or view that should be model methods instead? Are their models tested sufficiently (100%)?
1. Check their feature tests (`bundle exec rspec spec/features`). Is the coverage close to `98%`? What kind of `expect` statements are they writing? Are they using `within` syntax, or any Capybara methods you haven't seen before?
1. In their models and controllers, how is their ActiveRecord usage? Do you see any Controller methods using AR that could instead be in a Model method? Are they using Ruby where an AR method could work better?
1. Look at their `routes.rb` file. Are the routes RESTful?
1. Are they using any additional gems you haven't used? If so, how do they affect their application or test suites? If not, how could another gem (like `orderly`, for example) help their project?
1. What other feedback do you have for the other person?
1. What other questions do you have for the other person?

Once both students have finished reviewing code, set up a 45-minute meeting with each other. During that meeting, both students should share their answers to the questions above.
