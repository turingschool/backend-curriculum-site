---
title: Class vs Instance Methods
length: 90
layout: page
---

## Learning Goals

- Identify use cases for class methods and instance methods in the context of a Rails app
- Identify available AR methods depending on current context of `self`
- Differentiate when to use a class method or an instance method

## Set Up

This lesson plan starts with the `class-vs-instance-setup` branch of our good old Set List Tutorial Repo. Get it [here](https://github.com/turingschool-examples/set-list-7/tree/class-vs-instance-setup). Then, follow the normal setup tasks:

- Run `bundle install`
- Run `rails db:{drop,create,migrate,seed}`

## Exploration

Open up `artist.rb` and `artist_spec.rb` side-by-side in your code editor. You'll notice a `pry` in some of the methods defined in the Artist class. You can run the spec with `bundle exec rspec spec/models/artist_spec.rb` to hit the first pry. You can enter `exit` into pry to continue on to the next pry. Use the code, test, and each of the `prys` to answer the following questions with your group in a break out room:

For each of the methods defined in the Artist class:

- Is the method defined as a class or instance method?
- What is the value of `self` inside the method?
- How do you call the method? In other words, what can you call the method on?
- How can you update the method body to use `self`?

**Discussion Questions**

- What is a class method?
- What is an instance method?
- What is self in each context?
- What does an instance of a model represent in our DB?
- What does the class of a model represent in our DB?

## Takeaways
<section class="answer">
<h3>Review these after your discussion</h3>
  * In a Rails app, a class method allows you to perform actions on or query data from an entire database table rather than one specific row (or instance) of the data. `self` refers to the entire class or table. 
  * In an instance method, you can perform actions or retrieve information about one instance of the class, which represents one row of data in a database table. `self` in these methods refers to the single model object. 
</section>

## Practice Problems

Using model tests and the corresponding models only, write methods that will:

- Return all songs sorted by title alphabetically
- Return all of an artist's songs sorted by title alphabetically
- Return the `x` shortest songs, where `x` is an argument for the method
- Return the `x` shortest songs for an artist, where `x` is an argument for the method

**Spicy**

- Return a song's artist's name
- Return the number of songs for an artist that have at least 1 play and a length greater than 0
- Return a list of songs that have a title that contains the word "love"
- Return the 3 songs that have the most plays, a length greater than `x` where `x` can be any integer value, and were updated within the last three days

Answers to these practice problems can be found on the `class-vs-instance-solutions` branch [here](https://github.com/turingschool-examples/set-list-7/tree/class-vs-instance-solutions).

## Checks for Understanding
Answer the following questions either in your notebook or by taking [this review quiz](https://forms.gle/BG6JfUSAhSioYero6).

- How do you know whether a task requires a class or an instance method?
- What are some common error messages we might see if we confuse a class method with an instance method and vice versa?
- How can we list the methods available for self in pry?
- What does an instance of a model represent in our DB?
- What does the class of a model represent in our DB?
