---
title: Rails Route Helpers

tags: routes, helpers, rails
---

##  Learning Goals

By the end of this lesson, you will know/be able to:

* Understand the 5 pieces of information `rake routes` gives us.
* Use a route helper to easily refer to a relative and absolute path.
* Understand the difference between what `_url` and `_path` return when combined with a routes prefix.
* Find a routes prefix and use that prefix to build a helper.

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

|Table Heading       |Prefix|Verb|URI Pattern|Controller#Action|
|--------------------|------|----|-----------|-----------------|
|Example Entry       | root |GET | /         |movies#index     |
|Definition (what it does)|      |    |           |                 |

Fill in "Definition" with your understanding of what the column represents/how it can be used. If you're unsure of a definition, enter your best guess. After creating your table, cross reference yours with the table found [here](https://docs.google.com/spreadsheets/d/1AGjUE49UJajPEQHvh3plKjaem5RAGvuv5SNjZzvjD9U/edit#gid=0).

#### Large group share
* What is the path helper for each CRUD action? Which ones take an argument?
* What is the url helper for each? How do these compare to the path helpers? 

#### Independent Practice
Update your test suite to use path helpers instead of direct paths (i.e. "/movies") 

#### Partnered Workshop

Research how to use link helpers with your path helpers to create a navigation bar. This navigation bar would contain a link that leads to all movies and one that leads to all directors. It also includes a link to go home. Your home would show links to create a new movie or director.

#### Partnered Share 

Turn to a new partner and share out how you used path helpers to dry up your code.

### WrapUp

* What does directors_path evaluate to outside of a link helper?
* What does directors_url evaluate to outside of a link helper?
* What does director_path(@director) give you? Why do you need to pass it @director? Which routes do you need to pass a resource?
