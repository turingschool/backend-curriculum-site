---
title: Private Methods
length: 60 - 90
tags: ruby, encapsulation, private_methods
---

### Learning Goals

* Explain why we restrict access to parts of classes
* Explain what tools can be used to expose state and hide behavior
* Understand that encapsulation involves intentionally exposing only certain beahvior/state

### Structure

* 5 - WarmUp
* 10 - Encapsulation 
* 15 - Private Methods
* 10 - Indepent Practice
* 15 - Paired Implementation 
* 5 - WrapUp 

### Vocabulary  
* Encapsulation 
* Private Method

### Warm Up
* Why might we hide things in a class?
* What tools do you use to expose/hide information in an object? 

## Encapsulation
A language mechanism for restricting direct access to some of the object's components. - Making a capsule/bubble  

**Turn & Talk**  
`attr_reader`, `attr_accessor`, `attr_writer`  
When should you use them? What is a good thought process for this decision?  

## Private Methods
### Intro to Private Methods
A way to organize your code, so only the necessary methods are exposed to outside use.  

Let's take a look at this [reunion repo](https://github.com/AliSchlereth/reunion). What methods does the interaction pattern expected to be called from the outside?   

The methods not called from the outside, the helper methods, can be moved to be private methods. We do this by putting the keyword `private` once above all the methods we want to be hidden.   

### Testing & Private Methods
When we move these methods to private, how does this impact our test suite?  

You may be tempted to skip the units test for these methods from the get go. *HOWEVER* TDD each of your methods, once you're sure it is all built nicely and working properly delete your unit tests for the now private methods.  


### Independent Practice 
Clone down this [Allergen Evaluator](https://github.com/AliSchlereth/morning_exercises/tree/master/allergy_codes) exercise.  
Refactor this code to use private methods. 

**Turn & Talk**   
Compare implementations  

### Paired Implementation
Get together with your current project pair. Analyze your project. Are there any places where you could implement private methods?  


### Final Notes 
* While making methods private restricts access to them, it is important to note that there are tools for getting around the private setting such as using .send(). Just know that something from the outside may still access this functionality - so be careful. Also note, that if you are using someone else's code and there are private methods it is your job to respect the intention of those methods not being used from the outside. 
  
* Often times you will see a pattern emerging where the private methods clump together and achieve similar type goals. When we see this happening in our code, it should make us consider (at least) extracting them to another object. 

## WrapUp

Here are some questions to check your understanding of encapsulation:

* What is ecapsulation? Why do we use it?  
* When should you use `attr_readers`, `attr_accessors`, `attr_writers`, and `private` methods?   


## Additional Resources  

Sandi Metz's Talk [The Magic Tricks of Testing](https://www.youtube.com/watch?v=URSWYvyc42M)