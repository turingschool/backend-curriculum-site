---
title: Rails Route Helpers and View Helpers

tags: routes, helpers, rails
---

##  Learning Goals

By the end of this lesson, you will know/be able to:

* Understand the 5 pieces of information `rake routes` gives us.
* Use a route helper to easily refer to a relative and absolute path.
* Understand the difference between what `_url` and `_path` return when combined with a routes prefix.
* Find a routes prefix and use that prefix to build a helper.
* Understand how to use link_to and button_to view helpers.

## Vocab
* routes
* path_helper
* url_helper

## WarmUp

* How have you been sending a user to another route, say in your tests or in a controller?
* What is the syntax for hand rolling a route?
* What shortcut does Rails give us to create multiple routes at once?

## Routes

With your partner, take a look at the entries in the table that `rake routes` gives you and fill out the table below in your notebook or on your computer.

| Table Heading | Prefix | Verb | URI Pattern | Data Collection | Controller#Action | Redirect or Render? | View | Path Helper | URL Helper |
| photos | photos | get | /photos | Photo.all | photos#index | render | index | photos_path | photos_url |

Fill in your answers [here](https://docs.google.com/spreadsheets/d/1AGjUE49UJajPEQHvh3plKjaem5RAGvuv5SNjZzvjD9U/edit#gid=0).

#### Large group share
* What is the path helper for each CRUD action? Which ones take an argument?
* What is the url helper for each? How do these compare to the path helpers?

#### Independent Practice
Update your test suite to use path helpers instead of direct paths (i.e. "/songs")

#### Partnered Workshop

Research how to use link helpers with your path helpers to create a navigation bar. This navigation bar would contain a link that leads to all songs and one that leads to all artists. It also includes a link to go home. Your home would show links to create a new song or artist.

#### Partnered Share

Turn to a new partner and share out how you used path helpers to dry up your code.

### WrapUp

* What does artists_path evaluate to outside of a link helper?
* What does artists_url evaluate to outside of a link helper?
* What does artist_path(@artist) give you? Why do you need to pass it @artist? Which other routes need you to pass a resource?
