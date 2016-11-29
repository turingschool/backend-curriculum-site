---
title: Intro to CRUD in Sinatra Redux
length: 120
tags: crud, sinatra
---

### Goals

By the end of this lesson, you will know/be able to:

* define CRUD in the programming sense of the word
* understand functionality to of *U*pdate and *D*elete of CRUD for a Sinatra app
* divide responsibilities between the controller, views, and models

### Warm Up

We'll go through the questions answered last night for homework [here](https://gist.github.com/case-eee/1f066fa3be100f8f18f4d31f521a3da4).

### MVC Overview

We'll talk about MVC and diagram what this looks like on the board.

### CRUD Overview

Assuming we want to create full CRUD functionality in our Sinatra app for users accessing our site through a browser, there are seven routes that we will need to define. Let's make a chart together.

(Here's a [completed chart](https://www.dropbox.com/s/qfh9zmca7i7r3u4/CRUD%20%26%20Sinatra.jpg?dl=0), but don't open it until you're finished!)

### CRUD Homework Recap

* What was the most difficult piece about adding edit/delete functionality?
* What are you still curious about?

### Worktime

#### Robot World

You'll be working in pairs for this challenge. 

Fork [this repository](https://github.com/turingschool-examples/robot-world) and CRUD out a robot. This app should be a directory of robots. A robot has a name, city, state, and department. Users should be able to enter a robot (create), see a list of all of the robots, see each robot individually (read), edit a robot (update), and delete a robot (delete).

### Optional (possibly helpful) Setup

Want a better error page? What about a layout to connect your stylesheet? Check out the [Sinatra View Boilerplate](https://github.com/turingschool/challenges/blob/master/sinatra_view_boilerplate.markdown).

### Extensions:

* Add an avatar for each robot. Use [http://robohash.org/](http://robohash.org/) for pictures. 
* Add a dashboard that shows statistical data: a breakdown of how many robots and number of robots in each department/city/state.
* Can you use [HAML](http://haml.info/) for your html templates instead of ERB?
* Can you use a [partial](http://www.sinatrarb.com/faq.html#partials) in your views?
* Can you use the Pony gem to [send an email](http://www.sinatrarb.com/faq.html#email) from your Sinatra app?
* Can you protect your app using [HTTP Basic Auth](http://www.sinatrarb.com/faq.html#auth)?
* Use [Faker gem](https://github.com/stympy/faker) to get dynimac content in your app

### Other Resources:

* [Jumpstartlab IdeaBox Tutorial](http://tutorials.jumpstartlab.com/projects/idea_box.html)
