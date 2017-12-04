---
layout: page
title: The Four Pillars of Object Oriented Programming
length: 60
---

## Learning Goals

- Students are able to identify the four pillars in their own code

## Vocabulary

- Abstraction
- Encapsulation
- Inheritance
- Polymorphism

## Intro/Hook

At Turing, we've always been pretty good at making students productive. We teach you how to code, how ruby works, how to collaborate, how to break down a problem. But there are some things that students from a traditional CS program get that our students haven't. We found our students struggling with some of the basic CS theory that employers have come to expect, since most of their employees got a CS degree.

One of those things is the 4 pillars of OOP. You're going to spend the rest of your time here at Turing writing object oriented code. Here are the 4 pillars of object oriented programming.

## Warmup

- What is Abstraction?
- What is Encapsulation?
- What is Inheritance?
- What is Polymorphism?

## The 4 Pillars

### Abstraction

Quite simply, abstraction is the concept of wrapping up complex actions in simple verbs. Describe each thing you've abstracted clearly, and hide the complexity. Someone can always pop the hood if they need to.

To use a cooking metaphor: Puff pastry is incredibly hard to make. Even professionals don't make their own puff pastry. I don't need to know how puff pastry is made in order to buy it and use it.

#### Y tho?

We can't really work until we can hold the problem in our minds. I takes time and effort to build up a mental picture of your code, and the larger that mental picture is, the more likely you are to make a mistake.

[A web comic](http://heeris.id.au/2013/this-is-why-you-shouldnt-interrupt-a-programmer/)

#### Where have you seen this?

The `append` and `insert` methods of your data structures. Instead of calling keep_going_until_you_find_a node_that_is_nil_and_create_a_new_node_and_fill_it_with_this_data, we can call `append` or `insert`

### Encapsulation

As much as you can, keep state and logic internal. This can mean have as few attr readers as possible, or as few instance vars as possible. The less you have to keep track off at any given time, the better.

To use a cooking metaphor: Have you ever seen a recipe where they split out some of the incredients into other recipes. Maybe you're baking a cake, and instead of the butter and powdered sugar being a part of the cake recipe, the cake simply asks for "frosting", and links to another recipe to make the frosting.

[Cake Recipe](https://addapinch.com/the-best-chocolate-cake-recipe-ever#easyrecipe-4801-0)

#### Y tho?
Code organization. Where does it make sense to keep things together, and where are responsibilities seperate

#### Where have you seen this?

In battleship, I asked you to think about what responsibilities belonged where. There wasn't a right answer to this question, but everyone created multiple classes, and grouped things that belonged together. Then you can just call a few methods to access a wealth of complexity.

### Relating the two

Abstraction and encapsulation support each other. If you don't group like things together, then you're going to have a harder time abstracting them. They'll have to be passing data back and forth.

- Turn to a partner and tell them in your own words what we mean by abstraction and encapsulation.

### Inheritance

Classes can have parent classes. Child classes will inherit all of the behavior and attributes of the parent class. Child classes can then choose to overwrite some of those as necessary.

To use a cooking metaphor: Every omelette follows basically the same process. Break some eggs, cook those eggs, add some ingredients, serve. All omelette But a Denver omelette is not the same as an omelette du fromage.

#### Y tho?

Code organization. Where does it make sense to keep things together, and where are responsibilities separate

- As our applications become more complex, we can find that we often have classes that are very similar. And there is often a hierarchy to them.
- DRY. If I change something in the parent class, all the children also get that change.

#### Where have you seen this?

Minitest. Your tests are classes. Every test file you create is a new class. You're using methods like `assert` and `refute`, and when you create a `setup` method, you don't have to call it. The parent class calls it. There are all kinds of behavior that your tests have because they inherit from Minitest::Test

### Polymorphism

Defined as "the condition of occurring in several different forms". Basically, it just means that we can call the same method on different objects.

#### Y tho?

Naming is hard. If there's a verb/method name that works for similar processes, just use that same name. Even if it doesn't actually refer to the same thing happening

It also allows you to send different types of objects to the same method. If both `Student` and `Teacher` have an `email` attribute, then they can both be sent as a parameter to `send_email`.

To use a cooking metaphor: You don't need a new verb to `slice` each food. You can slice an apple, and a carrot and a watermelon. Your process might differ for each food, and it might not, but you can use the same verb.

#### Where have you seen this?

- Strings and arrays both have length. They both return integers, and they both mean roughly the same thing, but the internal operation differs between the two classes.
- In the inheritance lesson, you saw that all employee types had a `total_compensation` method, but the behavior of that method differs.

### Relating the two

Inheritance and Polymorphism kind of go together. At least in the sense that all child classes will have the methods and attributes that were defined on the parent class.

- Turn and talk to your partner about what inheritance and polymorphism are in your own words

## Wrap up

Each of the 4 pillars relate to the other three. There's a lot of overlap in these concepts.

- How is abstraction related to the other 3 pillars? i.e. How do the other three pillars support or utilize it?
