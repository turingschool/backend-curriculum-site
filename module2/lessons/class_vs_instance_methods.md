---
title: Class vs Instance Methods
length: 90
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
* What does an instance of a model represent in our DB?
* What does the class of a model represent in our DB?

## SetList Activity 1

For each method you create, answer the following questions:
* What is self when you pry into the method?
* Can you call your ActiveRecord helper?
* Can you call a model directly inside this method?
* Which ActiveRecord methods can you call in the current context of self?  

In your SetList app:

* Create a test for a corresponding method that returns an artist name given a song
* Create a test for a corresponding method to retrieve a random song
* Create a test for a corresponding method that returns an artist's song given a song id and an artist
* Create a test for a corresponding method that will find all song ids

## SetList Activity 2

For each method you create, answer the following questions:
* What is self when you pry into the method?
* Can you call your ActiveRecord helper?
* Can you call a model directly inside this method?
* Which ActiveRecord methods can you call in the current context of self?

In your SetList app:
* Create a test for a corresponding method to retrieve a random song given an artist
* Create a test for a corresponding method that orders an artist's songs by name
* Create a test for a corresponding method that will return all song ids given an artist
* Create a test for a corresponding method that will find all artist names given a collection of song ids

## SetList Activity 3

For each method you create, answer the following questions:
* What is self when you pry into the method?
* Can you call your ActiveRecord helper?
* Can you call a model directly inside this method?
* Which ActiveRecord methods can you call in the current context of self?

In your SetList app:
* Create a test for a corresponding method that finds an artist's longest song
* Create a test for a corresponding method that finds the song with the most plays
* Create a test for a corresponding method that order artists by the time they were created at OR the time they were updated at (add a migration for these columns if you need to)
* Create a test for for a corresponding method that orders an artist's songs by play_count and returns the top 5


## Checks for Understanding

* How do you know whether a task requires a class or an instance method?
* What are some common error messages we might see if we confuse a class method with an instance method and vice versa?
* How can we list the methods available for self in pry?
* What does an instance of a model represent in our DB?
* What does the class of a model represent in our DB?
