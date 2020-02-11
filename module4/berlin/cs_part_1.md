---
title: CS for Interviews, Part 1 -- Base Understandings
layout: page
---

## Learning Goals

* Students will have a basic understanding of what types of challenges they can expect in a technical interview
* Students will understand the limited scope of Computer Science that appears in technical interviews
* Students will build a linked list to illustrate the concept of a data structure
* Students will practice iterating on algorithmically-challenging code in a short period of time

## Warm Up

Before class starts, write notes and thoughts on the following questions:

1. Are you a Computer Scientist? Why or why not?
2. Why do you think Computer Science topics like data structures and algorithms are the focus of some technical interviews?
3. If you were asked "What kind of CS topics have you studied?" what would you answer? Can you come up with at least five specific examples?

## S1: Understanding the Technical Interview (40 minutes)

Let's set some context by discussing the following:

1. Where do technical interviews typically fall in the hiring sequence?
2. What questions does the technical interview attempt to answer?
3. What are the common formats for a technical interview?

*In pairs*: Given that context, do you think the technical interview will be a strength or weakness of your interview process? Why?

### Technical Interview Buckets

Live technical interviews, conducted in-person or remotely, generally fall into one of these buckets:

1. 60 minutes to solve a puzzle or challenge from scratch
2. 30+ minutes to iterate on or refactor your previously submitted take-home challenge solution
3. 60-90 minutes of pairing with a developer at the company to write new features or solve a puzzle
4. 60+ minutes to independently add a feature or fix a bug in an existing app that you haven't seen before

### Pathways to Technical Interview Success

#### 1. Exposure to Common Puzzles

* There is a large set of potential topics and puzzles
* There are a small set of puzzles and concepts that pop up a significant percentage of the time
* [Some common puzzles are collected in turingschool/challenges](https://github.com/turingschool/challenges)
* These are the kinds of things you should be practicing regularly now and throughout the job hunt.
* 30-60 minutes 3+ times/week done consistently would be great.
* There are many sites with other examples like [Exercism](https://exercism.io/) or [LeetCode](https://leetcode.com/)

*In pairs*: Have you used any resources like that to practice already? What have you learned?

#### 2. Practice with Data Structures & Algorithms

* If you got a CS degree, you'd spend at least two semester-long classes on DSA
* If you've written implementations of each of the common challenges two or three times, you're well equipped to succeed
* Common data structures: Linked Lists, Stacks, Queues, Binary Trees, Graphs
* Common sorting algorithms: Bubble, Merge, Insertion, Binary Tree

*In pairs*: What do you think you can individually improve or practice to do your best in a technical interview?

#### 3. Defining a Process

* What do you do when you don't know what to do?
* In flight school, you learn to Aviate, Navigate, Communicate
* If you just "do programming", you'll fail and look bad doing it
* You need to know what your process is and make it easy to get started
* Make the easy things easy: how do you set up your environment? Files? Tests?
* Define success: how will you know when you're done?
* Start small: iterate, learn, prove your progress -- not just one big leap
* Practice being loud and talking it out
* Half, not half-assed

*In pairs*: If you started a 60 minutes code challenge right now with an interviewer watching you, what would be the first three things you'd do?

#### 4. Intentional Practice Not Stupid Practice

* Most people missed the point on the idea of "10,000 hours"
* If it were just a matter of stacking hours, every worker with five years experience could be "world-class"
* Intentional practice means breaking down complex processes and practicing the skills both in isolation and combination
* If you're working on your free-throws in basketball, you might take 50 shots where you're focused on the flick of your wrist
* 50 shots where you focus on the last moment your fingertip touches the basketball
* 50 shots focused on the movement in your hips and knees
* Not just 150 free throws and hope you get better

*In pairs*: Have you ever practiced a skill with real intention? What was it and why were you trying to get better?

### Conclusions

* Technical interviews are not real programming, they are a circus trick
* Like a Rubik's cube, if you know the right steps to take then you can look like a genius
* You can practice and be prepared because success is mostly dependent on _process_ not _knowledge_
* There is knowledge/familiarity worth building to solidify your confidence

## S2: Linked Lists (60 minutes)

We'll use the rest of our time today doing some intentional practice using Linked Lists.

### Conceptual Intro

Let's diagram a Linked List. You should be comfortable defining/using/differentiating all of these terms:

* List and Node
* Data and Link
* Head and Tail
* Push and Pop

Linked Lists can be implemented using an iterative method, a recursive method, or a hybrid of both.

*In pairs*: In an interview, how would you describe the difference between an iterative approach and a recursive approach?

### Setup

Please follow all instructions carefully and completely.

* Clone the repo at [turingschool/data_structures_and_algorithms](https://github.com/turingschool/data_structures_and_algorithms)
* Move into the `linked_lists` subdirectory
* With your pair, add the day of the month that each of you were born _(ex: Feb 12 + Nov 23 = 35)_
* If the result is `>=31`, you're working in JavaScript. `<30` then you're working in Ruby
* Move into the subdirectory for the language you'll be using

### Paired Work Challenge

The repo you've cloned is an example of how some technical challenges are communicated. Rather than laying out complex
instructions in English, it just gives you tests to pass. But our point here is to practice our *process* more than it is to complete building a Linked List. Instead of just pushing ahead as fast as you can, follow these steps:

1. Write the class files you need to get the tests running with no errors (only skips)
2. Unskip the tests that focus on the functionality of a `Node` (ruby) or `ListNode` (js)
3. Work to make those tests pass
4. Switch which of you is typing and who is talking
5. Find the tests that emphasize using `push` to add a node onto the list. Work through making these pass.
6. Delete your implementation of the `push` functionality. Yes, seriously. `skip` tests until you're back to the beginning of working on `push`
7. Switch typer/talker (aka driver/navigator) roles. Rebuild the `push` functionality again.
8. Stay with the same roles and work through the `pop` functionality until tests are passing
9. Delete your `pop` functionality and switch roles, then rebuild it step by step.
10. Stay in your roles and build the `lastNode` functionality.
11. Swap roles and build the `include` functionality
12. Swap roles and build the `find` functionality
13. If time allows, continue to build out `delete` and `insert` operations

### Review

* Look at the code you've written. Is it complex? Which was slower, writing the code or figuring out what to write?
* What does that imply about how you should spend your time in a technical interview?
* As the functions got more complicated, were you gaining momentum or slowing down?
* How did the role reversals affect your process?
* How does exploring a problem like this in pairs influence your ability to do it solo?

## S3: Intentional Practice (50 minutes)

Let's treat this period a little more like a technical interview.

You *should not*...

* Use the web/Google. There are no complex methods or classes you need to implement these solutions and googling "recursive linked list in javascript" is just cheating ;)
* Let yourself get stuck. You're practicing your problem solving. If you really can't get over it, move around it.

You *should*...:

* Work solo
* `git reset --hard` to get back to a blank repo just like we started with
* Code in the language of your choice

You *may*...:

* Ask staff members conceptual questions, but the programming is up to you.
* Get asked questions by staff members probing to understand your thinking and process

And, most importantly, follow the flow of the test suite working through each individual feature *first implementing it using iteration* and making that pass, deleting that implementation, then *reimplementing it using recursion*. Don't build one entire implementation then the other, do it feature-by-feature.

## S4: Closeout (10 minutes)

Let's spend 10 minutes to reflect on our work today:

* What's one thing you thought you knew but it turned out you didn't?
* Are you going to build Linked Lists on the job? Why learn them?
* Why is practicing your process more powerful than building your knowledge?
* How does today's session change your plan to prepare for technical interviews?
