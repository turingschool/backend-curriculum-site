---
title: CRUD in Sinatra Workshop - Robot World
length: 120
tags: crud, sinatra
---

You'll be working in pairs for this challenge.

Fork [this repository](https://github.com/turingschool-examples/robot-world) and CRUD out a robot. This app should be a directory of robots. A robot has a name, city, state, and department. Users should be able to enter a robot (create), see a list of all of the robots, see each robot individually (read), edit a robot (update), and delete a robot (delete).

### Optional (possibly helpful) Setup

Want a better error page? What about a layout to connect your stylesheet? Check out the [Sinatra View Boilerplate](https://github.com/turingschool/challenges/blob/master/sinatra_view_boilerplate.markdown).

### Extensions:

* Use [Faker gem](https://github.com/stympy/faker) to get dynimac content in your app
* Add an avatar for each robot. Use [http://robohash.org/](http://robohash.org/) for pictures.
* Add a dashboard that shows statistical data: a breakdown of how many robots and number of robots in each department/city/state.
* Can you use a [partial](http://www.sinatrarb.com/faq.html#partials) in your views?
* Can you use [HAML](http://haml.info/) for your html templates instead of ERB?
* Can you use the Pony gem to [send an email](http://www.sinatrarb.com/faq.html#email) from your Sinatra app?
* Can you protect your app using [HTTP Basic Auth](http://www.sinatrarb.com/faq.html#auth)?

### Other Resources:

* [Jumpstartlab IdeaBox Tutorial](http://tutorials.jumpstartlab.com/projects/idea_box.html)
