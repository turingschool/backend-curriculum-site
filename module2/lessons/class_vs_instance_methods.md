---
title: Class vs Instance Methods
length: 120
layout: page
---

## Learning Goals

* Identify use cases for class methods and instance methods in the context of a Rails app
* Identify available AR methods depending on current context of `self`
* Differentiate when to use a class method or an instance method

# Lesson

## Discussion Questions

* What is a class method?
* What is an instance method?
* What is self in each context?

## SetList Activity

In your SetList app:

* Create a method that returns an artist name given a song
* Create a method to retrieve a random song
* Create a method to retrieve a random song given an artist
* Create a method that orders an artist's songs by name
* Create a method that finds an artist's longest song
* Create a method that finds the song with the most plays

**Extensions**

## Discussion Questions pt. 2


## Checks for Understanding

* What is a database? How does a database relate to web applications? What is Postgresql?
* What is the database schema?
* What is an ORM? What is ActiveRecord? How do they relate to the database?
* What is a model in a Rails application?
* Assuming you have a `Song` model, what ActiveRecord methods would you use to do the following?
    * Retrieve a Song from the DB with a specific ID
    * Retrieve all Songs from the DB
    * Store a new Song in the database
    * Change the attributes of an existing Song in the DB
    * Delete a particular Song from the DB
