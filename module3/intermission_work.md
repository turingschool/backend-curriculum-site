# Assignments to Prep for Module 3

## Most Important

### HTTP Request/Response

**Using paper and a writing utensil:**

* On one piece of paper, write out all of the parts of an example HTTP GET request
* On a separate piece of paper, write out an example 200 response to that request with all of the parts.
* Bring this to class day 1. This is your ticket into Mod 3 :)


### SQL/ActiveRecord

Entering Module 3 with a solid understanding of ActiveRecord and SQL is key to getting the module off to a good start. Make sure you are able to write and understand queries that involve multiple `JOIN` statements and that combine math functions.

1. Complete and understand the [Intermediate SQL I](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/intermediate_sql.md) challenges.
1. Complete and understand the [Intermediate SQL II](https://gist.github.com/case-eee/5affe7fd452336cef2c88121e8d49f5d) challenges.
1. Complete and understand [ActiveRecord American Gladiators](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/active_record_american_gladiators.md). If you have not completed, (http://backend.turing.io/module2/misc/active_record_obstacle_course)[ActiveRecord Obstacle Course], we recommend reviewing/completing that prior to tackling this.

### APIs

Additionally, in Module 3 we will be creating applications to deliver and consume APIs. What is an API, you might ask? Watch [this video](https://www.youtube.com/watch?v=7YcW25PHnAA) to find out more.

## Next Most Important

### Rails Routing

Rewrite your Bike Share `routes.rb`:

Module 3 requires you to know URLs, paths and HTTP verbs inside and out. Rewrite the routes file for your Little Shop to use only methods that map directly to HTTP verbs: `get`, `post`, `put`, `patch` and `delete`. You will probably need to add `to:` and `as:` parameters to make sure your apps continue to work, and tests continue to pass.

If you wrote your routes that way already, replace them using `resources`.

If you do not own the repo for your project, fork it, and rewrite the routes file individually.

NOTE: This is not because one way is better, but it's extremely important to understand what every line of your routes file is doing. Rails Engine demands a solid understanding of Rails routing.

## Optional (Choose Your Own Adventure)

### API Learning Spike (I want a little head start on M3)

*Option 1:* See if you can create a Rails API that responds to a request to `/api/v1/items` with JSON. Review the video above to see what this will look like in your browser. Hint: that looks an awful lot like a double nested route to me.

* Don't worry if you can't get this to work.
* Don't worry about testing.
* Timebox your work so that you come to M3 refreshed.
* The goal here is to tinker and see if you can get a thing to work. Stop working if it stops being fun.
* Use the internet to see what you can find about creating a simple Rails API.
* Feel free to talk to mentors or colleagues about potential resources.
* Don't just use the first resource you find. Cast your net wide and then pick a few resources to use as touchstones.

*Option 2:* Download [Postman](https://www.getpostman.com/) or sign up for an [apigee](https://apigee.com/) account. Dig into the documentation for an API and see all the different data you can get back.

* [ProPublica Congress API](https://projects.propublica.org/api-docs/congress-api/)
* [Facebook](https://developers.facebook.com/docs/graph-api)
* [Twitter](https://dev.twitter.com/rest/public)
* [SoundCloud](https://developers.soundcloud.com/docs/api/guide)
* [GitHub](https://developer.github.com/v3/)

### Reading (My laptop and I are on a break)

[Practical Object-Oriented Design in Ruby](http://www.amazon.com/gp/product/0321721330): Sandi Metz's book permanently changed the way I program. In this book, she teaches you how to write exceptionally well-factored code. At least try to read the first three chapters if you can.
[Head First SQL](https://www.amazon.com/Head-First-SQL-Brain-Learners/dp/0596526849/ref=sr_1_1?ie=UTF8&qid=1488547158&sr=8-1&keywords=head+first+sql): A nice introduction to SQL.

### JavaScript/JQuery (What's this JavaScript I keep hearing about?)

[Codecademy JavaScript Track](http://www.codecademy.com/en/tracks/javascript)

JavaScript is the scripting language of web browsers. During Module 3 we'll start getting our first introductions to JS and we'd like you to work through some basic materials as a preparation.

Focus primarily on the sections for:

* Functions
* Control Flow
* Data Structures
* Objects I and Objects II

[jQuery](https://www.codeschool.com/courses/try-jquery)

Jquery is a popular javascript library for manipulating the content of web pages. Dip your toes in with this introductory Jquery class.

### Front-End Development (Where do the FE kids get those cool backpacks?)

* Revisit your personal site. See if you can upgrade the styling. Consider using [Sass](http://sass-lang.com/guide).
* Re-style your Rails Mini-Project or Job Tracker.
* Dive into some tools
    * [Good old fashioned HTML & CSS](http://www.htmlandcssbook.com/)
    * [Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/): newer HTML & CSS
    * [CSS Selectors](https://css-tricks.com/how-css-selectors-work/)
    * [Sass](http://sass-lang.com/guide)
    * [Bourbon, Neat, Bitters](http://bourbon.io/)
    * [Materialize](http://materializecss.com/)
    * [Bootstrap](http://getbootstrap.com)
* Explore an alternative templating language
    * [HAML](http://haml.info/tutorial.html)

### Other Frameworks (I learned a lot about English in all those Spanish classes I took)

* Back End
    * [Express](http://expressjs.com/)
    * [Django](https://www.djangoproject.com/)
    * [Phoenix](http://www.phoenixframework.org/)
* Front End
    * [Ember](http://emberjs.com/)
