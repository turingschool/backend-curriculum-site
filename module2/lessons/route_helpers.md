---
title: Rails Route Helpers

tags: routes, helpers
---

### Goals

By the end of this lesson, you will know/be able to:

* Understand the 5 pieces of information this `rake routes` gives us.
* Use a route helper to easily refer to a relative and absolute path.
* Understand the difference between what `_url` and `_path` return when combined with a routes prefix.
* Find a routes prefix and use that prefix to build a helper.

### Review

* What class do controllers generally inherit from in Rails?
* What class do models generally inherit from in Rails?
* What shortcut does Rails give us to create multiple routes at once?
* What shortcut does Rails give us to create a migration? How do you define attributes and their types in that shortcut?

### Practice

#### Routes

* With your partner, take a look at the entries in the table that `rake routes` gives you and fill out the table below in your notebook or on your computer.

|Table Heading       |Prefix|Verb|URI Pattern|Controller#Action|
|--------------------|------|----|-----------|-----------------|
|Example Entry       |      |    |           |                 |
|Definition          |      |    |           |                 |

Fill in "Definition" with your understanding of what what the column represents/how it can be used. If you're unsure of a definition, enter your best guess.

Large group share.

#### Workshop

See if you can research how to use route helpers to create a navigation bar. This navigation bar would contain a link that leads to all movies and one that leads to all directors. It also includes a link to go home which would show links to create a new movie or director.

Large group share.

What's really going on?

* What does directors_path evaluate to outside of a link helper?
* What does directors_url evaluate to outside of a link helper?
* What about director_path(@director)?
