---
title: Module 4 Intermission Work
layout: page
---

## Required Work

To prepare for Module 4, please complete & submit the following before 12 noon Sunday, the day before the inning begins. This will allow instructors time to review and provide feedback.

1806 - Submit all links [here](https://goo.gl/forms/B4FAVFjtO8kxxxOn2).

## 1. Cover Letter

Complete a cover letter for a real position (no, you cannot make one up), tailored accordingly. The letter should be formatted professionally and look just as a good as one you would submit for a dream job.

Note - you will be required to submit the link for the job posting.

## 2. Reflection on Learning Experiences

Complete this [exercise](https://gist.github.com/case-eee/6a5b06bf88c3fa82d9498c6763314ae4) to reflect on your learning experience thus far here at Turing.

**Submit: Link to gist.**

## 3. Number Guesser

Complete phases 1-3 of [Number Guesser](./number_guesser.md). You _can_ use jQuery for this. The project spec provides a layout comp - we advise you do _some_ work to make your app resemble the app, but the bulk of your time should be spent on learning to manipulate the DOM with JavaScript.

On a branch called `annotated`, annotate every line of JavaScript (either below/above the line in a comment) to explain what the code is doing. Include any explanation as to why you used ES5 vs. ES6 functions, var vs. let vs. const, etc.

**Submit: Link to Number Guesser Repo AND GitHub Pages deployment link. Make sure this includes the `annotated` branch.**

## 4. JavaScript without a Browser

While JavaScript was originally intended to be a client-side scripting language, it has since made its way server-side thanks to Node.js. We're now able to use the same language for browser-based interactions as well as server-side scripts.

Let's get introduced to JavaScript without a browser. Work through [this lesson](http://backend.turing.io/module4/lessons/javascript_without_a_browser). It will introduce you to Node.js and basic unit-testing using Mocha.

**Submit: Nothing. But you should still do it.**

## 5. Sorting Suite

Complete Sorting Suite in Javascript [here](http://frontend.turing.io/projects/sorting-suite.html). Choose **one** out of the three fundamental sorting algorithms to complete. Use Node.js to run your code, and Mocha/Chai to write your tests. FE2 gets this as a project, so we'll use their project requirements, but you can ignore the rubric. You won't be graded. We just want you to get some practice testing and writing JavaScript.

**Submit: Link to repo for Sorting Suite.**

___

### Tips for JS success

Suggested resources to utilize:

* [Data Types, Variables, Conditionals, Function Basics](http://frontend.turing.io/lessons/module-1/js-1.html)
* [Function Fundamentals, Variable Scope, Loops, Arrays](http://frontend.turing.io/lessons/module-1/js-2.html)
* [Objects, This, Data Structures](http://frontend.turing.io/lessons/module-1/js-4.html)
* [Array Prototype Methods](http://frontend.turing.io/lessons/module-1/array-prototype-methods-intro)
* [ES6, Webpack Tutorial](http://ccoenraets.github.io/es6-tutorial/)

[JavaScript 30](https://javascript30.com/):
  - Array Cardio Days 1
  - Array Cardio Day 2
  - Objects and Arrays
  - Tally String Times with Reduce

Some biggies if you're coming from Ruby:

-   Methods are called Functions
-   You should know the difference between `undefined` and `null`; JS does not have a `nil` like Ruby does
-   `require`ing a file you've written does nothing if you didn't export from that file
-   All `return`s are explicit in Javascript. If you don't use the word `return`, your return value will be `undefined`

Google is your friend. It's totally reasonable to type things like ".each in javascript" or "what is const in javascript"

## Optional Work

All of these things were at one time part of the intermission week work. We've retooled the module, and are focused on getting you coding during intermission week. However, there's some good resources below if you want to pick and choose the things that seem interesting to you.

### Introduction to JavaScript Topics Reading

**Read** the following selections from [Speaking JavaScript](http://speakingjs.com/es5/) & [Eloquent JavaScript](http://eloquentjavascript.net//):

* [Chapter 3 (Speaking): The Nature of JavaScript](http://speakingjs.com/es5/ch03.html)
* [Chapter 3 (Eloquent): Functions](http://eloquentjavascript.net//03_functions.html)
* [Chapter 5 (Eloquent): Higher Order Functions](http://eloquentjavascript.net//05_higher_order.html)
* [Chapter 6: (Eloquent) The Secret Life of Objects](http://eloquentjavascript.net//06_object.html)
* [Chapter 17: Objects and Inheritance (Speaking JavaScript)](http://speakingjs.com/es5/ch17.html)

Then finish it all with [JavaScript Garden](http://bonsaiden.github.io/JavaScript-Garden/).

### All you need to know about importing and exporting files
[ES6 import, export, default cheatsheet](https://hackernoon.com/import-export-default-require-commandjs-javascript-nodejs-es6-vs-cheatsheet-different-tutorial-example-5a321738b50f)

### Exercisms

* Complete *5* of your own completed [exercism.io][exer] exercises in JavaScript
* Review solutions by 5 other people for the same exercises, and compare your solution to theirs

If you have trouble with the exercism UI, you can find other versions of exercisms you submitted at this link:http://exercism.io/tracks/javascript/exercises

[exer]: http://exercism.io/


## Extensions

Then select and complete *one* of the sections below.

### NodeSchool.io

Work through _at least two_ of the following courses:

* [javascripting](https://github.com/sethvincent/javascripting)
* [lololodash](https://github.com/mdunisch/lololodash)
* [ExpressWorks](https://github.com/azat-co/expressworks)

### jQuery Fundamentals

Work through Bocoup's [jQuery Fundamentals](http://jqfundamentals.com).

### CSS Fundamentals

* Work Through This [Introductory Static Site](https://github.com/turingschool-examples/introductory-static-site)
* Work Through These [CSS Layout Challenges](https://github.com/turingschool-examples/css-layout-challenges)

### Scaling Up as a Developer

As we move into the final module of Turing, we're getting fairly competent at producing useful software. But rather than being the end of the journey, this really just opens the door to even deeper rabbit holes—now that I can get something done, what other ways might there be to accomplish the same thing? The same observable effects could be accomplished via numerous different combinations of code. What are the underlying opinions and ideas embodied by each choice?

**Read**: [Sandi Metz' Rules For Developers][sandi] (10 minutes)
* Which of Sandi's rules do you feel like might be the hardest to follow—why?

**Listen**: [Shop Talk: Tom Dale](http://shoptalkshow.com/episodes/147-tom-dale/) (1.5 hours)
* Do you agree with Tom? What parts of his argument are compelling? What parts do you disagree with?

Here are are a few more "philosophical" materials to hopefully help us contemplate this side of the issue:

* [Execution in the Kingdom of Nouns by Steve Yegge](http://steve-yegge.blogspot.ca/2006/03/execution-in-kingdom-of-nouns.html) - You've been doing object-oriented programming for almost 6 months now. What are some of the limitations imposed by this approach? How do Ruby and/or Javascript capture the benefits of OO while avoiding some of the pitfalls?
* [Simplicity Matters by Rich Hickey](https://www.youtube.com/watch?v=rI8tNMsozo0) - As we move into working on larger and more sophisticated systems, some of the approaches that have worked on smaller projects may no longer be so effective. What does Rich Hickey say about the common pitfalls of Ruby and Rails applications?
* [The Birth and Death of Javascript by Gary Bernhardt](https://www.destroyallsoftware.com/talks/the-birth-and-death-of-javascript) - This talk takes a tongue-in-cheek tone, but the concepts discussed are very topical. What does Bernhardt suggest about the role of Javascript in shaping the modern web?
* [Real Software Engineering by Glenn Vanderburg](https://www.youtube.com/watch?v=NP9AIUT9nos) - What does Glenn have to say about Software Engineering as a discipline? How does Software Engineering differ fundamentally from other Engineering disciplines? What can we as Software Engineers take away from other disciplines?

[sandi]: http://robots.thoughtbot.com/sandi-metz-rules-for-developers
[tbruby]: https://github.com/thoughtbot/guides/tree/master/style/ruby
[airbnbjs]: https://github.com/airbnb/javascript
[hound]: http://robots.thoughtbot.com/introducing-hound
[tomdale]: http://shoptalkshow.com/episodes/147-tom-dale/
[speakingjs]: http://speakingjs.com/es5/
[allonge]: https://leanpub.com/javascript-allonge/read
