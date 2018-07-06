---
layout: page
title: Testing Strategies
tags: basics, testing, encapsulation
length: 60
---

## Learning Goals

* Understand that TDD is about asking questions and making decisions
* Understand the role of TDD in streamlining the problem-solving and design process.
* Be able to name and explain the four key types of tests

## Slides

Available [here](../slides/testing_strategies_4)

### Vocabulary
* Encapsulation
* Unit Tests
* Integration Tests
* Feature Tests
* Acceptance Tests

### Structure  
* 5min - WarmUp  
* Testing Patterns  
* Hierarchy of Tests  
* 5min - WrapUp  

### WarmUp  
* What is your current workflow in regards to testing and writing code?  
* What are some benefits of writing tests before your code?  
* What are some different types and purposes of your tests?  

### Testing Patterns  

It can be especially difficult to get started on a new project or even a new iteration of a project. The essence of testing is asking questions and coming up with difficult answers.     

* Testing compels you to make hard decisions early, and up front.
  * This is scary because you are making decisions in a context you don't understand.
* Testing (especially in the context of TDD) is a discipline tool -- forces you to a) be **specific** about what you are trying to do and b) stay **focused** on that objective  

* Four-phase testing
  1.  Setup - sometimes in test, sometimes separate method
  2.  Exercise
  3.  Verify
  4.  Teardown

#### Isolating Functionality - Encapsulation 

* What makes a test easy to write? What makes it hard?
  * Being specific with the behavior you're testing makes writing the test easier.
* Write the test
  * In my dream world, how would this work?
  * How can I break this problem down?
  * What are my inputs/outputs?
  * What are classes/methods named?
* Make it pass
  * How do I do this in Ruby?

```ruby 
  def test_translate_returns_a_string_of_translated_characters  
    input           = "hello world"
    expected_output = "idolvhendid"
    
    translator = Translator.new  
    actual_output   = translator.translate(input)  
    
    assert_equal expected_output, actual_output 
  end 
```
Same test written with asserting the intended output against the method call. 

```ruby 
  def test_translate_returns_a_string_of_translated_characters  
    translator = Translator.new  
    
    assert_equal "idolvhendid", translator.translate("hello world")   
  end 
```
**Turn & Talk**  
How have you approached breaking down a problem? How have you used tests in this process?   

#### Top-Down  

This style is also known as Dream Driven Development.  As a programmer, you know the big idea of what you need to accomplish so you write a test for your dream.  As you begin to implement your dream, you may need to write smaller tests and methods to accomplish your big task. You may spend a long time with that one test in a red state while you make smaller tests pass by writing supporting methods.    

* You can solve difficult logic first before testing, then dream-drive

#### Bottom-Up  

This style is where you start with the supporting pieces, cobbling them together to build up to your final goal. In a bottom up approach, you will take each chunk of functionality piece by piece. You may have a quicker cycle of red-green-refactor, but it may be a bit more unclear at the beginning where you will end up.  

#### Edge Case Testing  

When breaking down a strategy, it may be difficult to come up with a solution that works for all scenarios on your first try. A common practice is to first build a test that checks against the smallest possible scenario. If we go back to our translator above, before we get anywhere near testing `"hello world"` we probably just want to test that translated a single letter.  

```ruby  
def test_translate_returns_a_single_translated_character  
    input           = "a"
    expected_output = "v"
    
    translator = Translator.new  
    actual_output   = translator.translate(input)  
    
    assert_equal expected_output, actual_output 
  end 

```  

After we get that first single letter test passing, test how it stretches. Does it work for two letters?  

```ruby
def test_translate_returns_a_string_of_two_translated_characters  
    input           = "at"
    expected_output = "vs"
    
    translator = Translator.new  
    actual_output   = translator.translate(input)  
    
    assert_equal expected_output, actual_output 
  end 
```  

Then maybe we want to test for five letters:   

```ruby
def test_translate_returns_a_string_of_translated_characters  
    input           = "hello"
    expected_output = "dkssp"
    
    translator = Translator.new  
    actual_output   = translator.translate(input)  
    
    assert_equal expected_output, actual_output 
  end 
```  

You could keep going with a translator, checking for sentences, paragraphs etc. Maybe you want to check for special characters or punctuation. This process helps you incrementally ensure your method works for your intended purpose and for a number of scenarios.  

**Turn & Talk**
Consider this combination of test and code. What are the dangers illustrated here? What implications does this have for your testing practice?   

```ruby  
  def test_translate_returns_a_string_of_translated_characters  
    input           = "hello"  
    expected_output = "dkssp"
    
    translator = Translator.new  
    actual_output   = translator.translate(input)  
    
    assert_equal expected_output, actual_output 
  end 
```  

```ruby 
 class Translator
 
    def translate(message)
      "dkssp"
    end 
 end 
```  


### Types of Tests  

When writing a program, you will likely have smaller methods that support each other to create greater functionality. Often these might be wrapped in some kind of runner method, or chained together for a grand result. We saw this in the discussion above regarding both Top-Down and Bottom-Up strategies. The tests for these methods are actually different kinds of tests. There are four commonly referred to types of tests which build upon each other:  

* Programmer-centric:
  * **Unit Test** - tests one component in isolation.
  * **Integration Test** - tests multiple interdependencies or coordinating components.
* Customer-centric:
  * **Feature Test** - a single feature as experienced by a user.
  * **Acceptance Test** - a collection of user functionalities that delivers business value.

Especially when you move into web development projects in later modules you'll rely more heavily on Acceptance and Feature tests to verify the behavior of your application as it will eventually be experienced by a user.

In Module 1, on the other hand, we will rely much more heavily on **Unit** and **Integration** tests -- and it's very
important to have a good mix of both!  

### Hierarchy of Tests

A Turing Version of [Martin Fowler's test pyramid](http://martinfowler.com/bliki/TestPyramid.html):

![TestPyramid](https://goo.gl/NYQcSd)

**Turn & Talk**
What kind of test would the above translator test (for the runner method) be? What might the other kind of test and corresponding method look like?

### WrapUp  
* How does letting tests drive your development lead you to stronger code?  
* What are the four types of tests?  What is the role of each type of test?  
