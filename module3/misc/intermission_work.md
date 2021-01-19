---
layout: page
title: Module 3
subheading: Intermission Work
---

# Required

You must complete and submit all of these assignments. *It is due the Saturday before the start of the inning at 5pm*

Submit your work here: [Survey Link](https://forms.gle/XFpSYyKY3NtmWQVd8)

### Professional Development

* Do [this](https://github.com/turingschool/career-development-curriculum/blob/master/module_three/pre_work.md)

### Ruby and Rails Versions

Follow [this guide](./ruby_and_rails_versions) to make sure your versions are correct.

## Core Learning Goals of Mod 3

* API Development
* Authentication / Authorization systems
* Managing deeply-nested data collections
* Refactoring code into new Design Patterns

---

### Intro to APIs

Everything we build in Mod 3 will focus on the theme of building and consuming APIs.

Work through [this tutorial](https://gist.github.com/BrianZanti/e9d73508062fdcb78225906a6d97686d) to review an intro to APIs.


### Authentication / Authorization

* TBD


### Deeply Nested Collections

When consuming APIs, the data is often returned in deeply nested collections, so you will need to tap into your Mod 1 skills to practice digging through them to retrieve the data you need.

Fork and clone [Here Be Dragons](https://github.com/turingschool-examples/here-be-dragons). Get the tests to pass.

### Refactoring Workshop

In Mod 3, we will focus not only on getting code to work but also writing high quality code. This will involve topics covered in mod 1 such as creating classes and methods, adhering to SRP, and general refactoring principles. Review these topics by forking and cloning [the refactoring workshop](https://github.com/turingschool-examples/neos). Work through the activity in the README. This was designed as a partnered activity. You may choose to pair with a classmate or work solo. If working alone, write answers to the questions in your notebook instead of discussing.

### HTTP Request/Response

* On one piece of paper, write out all of the parts of an example `HTTP GET` request (Diagram the DNS look-up as well as how a Rails Application would handle the request via MVC)
* On a separate piece of paper, write out an example 200 response to that request with all of the parts
* **Bonus** write your explanation as a metaphor
* Bring this to class day 1.

### Rails "params" magic.

How does "params" get built in Rails, and what precidence is given for query parameters (ie `?id=5` in a URL) versus dynamic placeholders (ie `/book/:id`) versus data sent in the body of a request from a form.

Start writing up some notes based on the Rails documentation:
* https://guides.rubyonrails.org/action_controller_overview.html#parameters

### Rails Routing

Rewrite your Monster Shop `routes.rb`:

Module 3 requires you to know URLs, paths and HTTP verbs inside and out. Rewrite the routes file for your Monster Shop to use only methods that map directly to HTTP verbs: `get`, `post`, `put`, `patch` and `delete`. You will probably need to add `to:` and `as:` parameters to make sure your apps continue to work, and tests continue to pass.

If you wrote your routes that way already, replace them using `resources`.

If you do not own the repo for your project, fork it, and rewrite the routes file individually.

NOTE: This is not because one way is better, but it's extremely important to understand what every line of your routes file is doing. Rails Engine demands a solid understanding of Rails routing.

### SQL/ActiveRecord

Entering Module 3 with a solid understanding of ActiveRecord and SQL is key to getting the module off to a good start. Make sure you are able to write and understand queries that involve multiple `JOIN` statements and that combine math functions.

1. Complete and understand the [Intermediate SQL I](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/intermediate_sql.md) challenges.
1. Complete and understand the [Intermediate SQL II](https://gist.github.com/case-eee/5affe7fd452336cef2c88121e8d49f5d) challenges.

### Reading

We will discuss the following on the first day of the inning:

* [Thinking Fast and Slow](https://drive.google.com/file/d/1tBU_FF_kYLHltyvc6ZEPfb3LiYYQRreT/view?usp=sharing)

# For further exploration

If you have time, here are some activities that will be valuable not only in Mod 3, but in Mod 4 and the job hunt as well.

### Data Structures And Algorithms

We are going to be covering various data structures to prepare you for the job hunt and technical interviews. Complete this former M1 project, [Jungle Beats](https://backend.turing.io/module1/projects/jungle_beat)

### JavaScript/jQuery (What's this JavaScript I keep hearing about?)

[Eloquent JavaScript](http://eloquentjavascript.net/)

JavaScript is the scripting language of web browsers. During Module 3 we'll start getting our first introductions to JS and we'd like you to work through some basic materials as a preparation.

You are to complete Chapters 1-5 of Eloquent Javascript.

We are mainly looking for you to get experience with the syntax, and at a minimumum you should understand the JS Data Types, Conditionals, and Looping.

[jQuery](https://www.tutorialrepublic.com/jquery-tutorial/jquery-syntax.php)

jQuery is a popular javascript library for manipulating the content of web pages. Dip your toes in with this introductory jQuery tutorial.


## Optional Reading on Security topics

* [Rails Security](https://guides.rubyonrails.org/security.html)
