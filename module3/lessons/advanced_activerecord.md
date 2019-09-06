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

How many of you have attempted to build a complex ActiveRecord query by throwing spaghetti at the wall? Eventually something will stick. But there's a better way.

As you start to dive into more difficult problems, problems that have many moving parts, it will become more and more difficult to hold all of the relevant information in your head. Another common issue is starting with a clear goal but slowly drifting and building the wrong thing. Starting with a clear goal and a plan will increase the likelihood of you hitting your target in a timely fashion.

There are official ways of diagramming SQL queries but we're going to do something a little different. This technique isn't an official technique so feel free to tweak or find something that works for you. If you're interested in diving deeper into a more official strategy check out this blog post on [Introductory SQL Diagramming](http://www.davidclement.org/tipsntrx/tnt10.6.html).

Let's start by first sketching out all of the columns we need and which table we can find them.

*Instructor Note:* Give students some time to sketch things out on their own before doing this as a group. Once they appear to be done call on students to mention the columns we will need to use. When finished it should look something like this:

![relevant database tables and columns](./images/advanced_activerecord/activerecord-query-diagram-1.jpeg)

Next up, let's make a note about all of the things we think need to happen with each of these columns.

*Instructor Note:* Maybe call on individual students to pick a thing to make note of on the diagram. Having the students drive what is added to the diagram seems to create engagement. When it's all done it should look something like this:

![tables and columns with SQL terms and why we need them](./images/advanced_activerecord/activerecord-query-diagram-2.jpeg)

### Converting to ActiveRecord

As we work through the next section we should update the diagram if our understanding changes or if we successfully accomplish one of our goals. We can do something simple like adding a checkmark when we successfully account for each item we documented. When complete we could have a board that looks like this:

![query plan with checkmarks](./images/advanced_activerecord/activerecord-query-diagram-3.jpeg)

To start through this process let's fire up a Rails console. We'll start by building our query slowly, piece by piece. People often struggle with where to start. When we are writing a query that needs to return specific rows, invoices in this case, we should _start by writing our query from the Model representing those rows_. Sometimes, there will be a temptation to start with a join table since they are similar to a hub with spokes that branch out to the tables we need. Avoid this temptation. This will usually result in needing to make more queries than is necessary.

The next thing that is usually good to try is to tack on the easiest portions of the query first and read the output in the console to make sure it matches our expectations.

```
irb(main):001:0>
```



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
