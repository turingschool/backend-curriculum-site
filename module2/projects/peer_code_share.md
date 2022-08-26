---
layout: page
title: Relational Rails - Peer Code Share
---

_[Back to Relational Rails Home](./relational_rails)_

## Peer Code Share

You will be partnered with another student to review each other's code and provide feedback.

First, exchange Github repository links with the other student, and clone the repository. Set up the application locally by first checking that *their* database is named differently than *yours* - if you `drop` or re-seed a database of the exact same name as your project's, then yours will be affected too! To accomplish this, you could simply add the name of the student at the start of the database name, for example: `brian_relational_rails_development`, `brian_relational_rails_test`. You can find the database configuration in `config/database.yml`. 

Then, in your Terminal, run the following: 
```ruby
bundle install
rails db:{drop,create,migrate,seed}
rails s
```

Then, individually, take about 25 minutes to review the other person's code. You should write down answers to the following questions:

1. Can you launch/use the application? Can the user stories be completed accurately? Do you find any bugs as you navigate through any pages? 
1. Run their overall test suite (`bundle exec rspec`). Are there any failing tests? Are their tests strong/robust? (Strong tests utilize both obvious outcomes and edge cases.)
1. Check their application's Models and the relationship to each other. Does the one-to-many relationship work? Are there any instance methods in their models? Are their models tested sufficiently (100%)? 
1. Check their feature tests (`bundle exec rspec spec/features`). Is the coverage close to `98%`? What kind of `expect` statements are they writing? Are they using `within` syntax, or any Capybara methods you haven't seen before? 
1. In their models and controllers, how is their ActiveRecord usage? Do you see any Controller methods using AR that could instead be in a Model method? Are they using Ruby where an AR method could work better?
1. Look at their `routes.rb` file. Are the routes RESTful? 
1. Are they using any additional gems you haven't used? If so, how do they affect their application or test suites? If not, how could another gem (like `orderly`, for example) help their project?
1. What other feedback do you have for the other person?
1. What other questions do you have for the other person?

Once both students have finished reviewing code, set up a 40 meeting with each other. During that meeting, both students should share their answers to the questions above.
