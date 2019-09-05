---
layout: page
title: Advanced ActiveRecord
length: 180
tags: rails, active record
---

## Learning Goals

* Students can diagram database relationships.
* Students can identify the tables in a database that hold information required to complete complex queries.
* Students can generate complex ActiveRecord queries using joins, group, order, select, and merge.
* Students can use the rails dbconsole  and rails console to generate ActiveRecord queries.

## Resources

* [Video](https://www.youtube.com/watch?v=OccKyvGvLKE&t=1329s) from a past class and the core ideas

## Objective

```
Find the 5 most expensive invoices with successful transactions.
```

## Warmup (5 mins)

* What tables would we need to query?
* What information would we need from each table?
* What calculations would we need to perform?
* What SQL would we be able to use to create a table with this information?

## Lecture

*WARNING:* This lesson is most beneficial if students don't follow along in class. Students should be called on throughout the lesson to build a solution as an entire group. If students follow along with the lesson plan they will have the answers to the questions and won't learn as much. Guessing is important even if the guess is wrong. The intent of having this lesson plan public is for students to be able to reference it after the class or for those that miss the class.

### Creating a Visual Representation

As you start to dive into more difficult problems, problems that have many moving parts, it will become more and more difficult to hold all of the relevant information in your head. Another common issue is starting with a clear goal but slowly drifting and building the wrong thing. Starting with a clear goal and a plan will increase the likelihood of you hitting your target in a timely fashion.

There are official ways of diagramming SQL queries but we're going to do something a little different. This technique isn't an official technique so feel free to tweak or find something that works for you. If you're interested in diving deeper into a more official strategy check out this blog post on [Introductory SQL Diagramming](http://www.davidclement.org/tipsntrx/tnt10.6.html).

Let's start by first sketching out all of the columns we need and which table we can find them.

*Instructor Note:* Give students some time to sketch things out on their own before doing this as a group. Once they appear to be done call on students to mention the columns we will need to use. When finished it should look something like this:

![relevant database tables and columns](./images/activerecord-query-diagram-1.jpeg)





## Workshop (Usually in the afternoon)

* Divide students into groups of four-ish.
* Have each group pick a business intelligence problem to work on. Preferably, each group will pick a different problem.
* Each group should practice what we demonstrated in the morning class:
  * Diagram their understanding of the problem. Include SQL functions and required columns.
  * Include SQL functions, techniques, and aggregate functions.
  * Have students include their names on their diagram for other students to reach out for help when they get to the same problem.
* After diagramming is complete, each student should work independently near their group and ask for help when they get stuck.
* If a student finishes early, have them pair with one of their partners or bounce around to help.
* With the last 5 minutes of the session have the students walk around the room and review the different diagrams. Keep these diagrams up for the rest of the week.
