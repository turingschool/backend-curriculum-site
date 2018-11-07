# Big-O Analysis

## Revisions & To-Dos

- [ ] Set up explicit roles for co-teaching
- [ ] Find/link the number cards
- [ ] Redo the pseudo-code algorithms for merge and binary sorts
- [ ] Find/review the written changes from last execution of the class
- [ ] Recap/review the plan with co-teacher
- [ ] Come up with an intentional strategy for pairing and sitting

## Learning Goals

* Be able to explain why we care about the algorithmic complexity of our programs on a practical level
* Be able to explain why we analyze algorithms in terms of asymptotic and worst-case performance
* Explore the performance characteristics of some common algorithms/operations

## Lesson Plan

### Prep Needs

* Cut/banded number cards like 1-27
* Snack trays to hold number cards
* Post-It notes of 1-12 for instructor board demos
* Printed copies of the algorithm break-out pages

### Pre-Class & Warm-up

Post on the board before class:

* https://www.youtube.com/watch?v=XaqR3G_NVoo on the TV
* Pairings for sitting / Part 1
* Pickup instructions for number cards and trays
* Write your answer in your notebook: why does the speed of software matter?

### Part 1: Revisiting Algorithms *(20 Minutes)*

* Recap: why speed matters -- fast software makes people happy, slow software makes people sad, happy people pay money, developers like having jobs

#### Collective Bubble-Sort Exercise

Together, illustrate the steps of a bubble sort on the board:

* Post six random post-it numbers
* Eval left to right
* Maintain a current and previous
* Follow this algorithm:

```
1. Start with previous at element-0, current at element-1
2. If current is > previous
  * Move previous = current, current = current + 1
  * If current = nil, you're done!
  * Else, go to Step 2
3. Else (current < previous)
  * Swap current and previous in the set
  * Return to Step 2
```

#### Paired Bubble-Sort Exercise

##### Round 1

* Person on the right is the RECORDER, person on the left is the WORKER
* RECORDER should select six random number cards, shuffle them, hand them to the WORKER
* WORKER lays out the cards in their current order left to right
* RECORDER is going to track how many "operations" it takes to sort the numbers fully
  * Make a tally for each comparison (a >?< b) and each swap
* WORKER executes the bubble sort algorithm talking out loud
* RECORDER notes the total number of operations

Group questions:

* How many operations did it take? (lots of different answers)
* What does this tell you about bubble sort? (nothing)

##### Round 2

* RECORDER shuffles the same six cards
* Repeat the process and get the new operation count

Group questions:

* How did the count of operations differ from your first run? (lots of different answers)
* What does this tell you about bubble sort? (still nothing)

##### Round 3

* Tell the RECORDER to select four cards from the six at random and put them in the worst-possible order for this algorithm
* WORKER should sort them while RECORDER counts
* RECORDER adds in one more card and puts them back in the worst order
* WORKER should sort them while RECORDER counts
* RECORDER adds in sixth card and puts them back in the worst order
* WORKER should sort them while RECORDER counts

Pair Questions:

* How did the operation count grow from 4 to 5 to 6 cards?
* What would you guess about how many operations 7 cards would take? 10?
* What does this tell you about bubble sort?

__break__ and set up for station activity

### Part 2: Algorithmic Differences *(45 Minutes)*

#### Prep

* Post the sequences for each pair on the board
* Lay out three stations with the sort documents below
* Each station they have ~12 minutes to complete the exercises, then rotate

#### Materials

* [Station 1: Insertion Sort](https://gist.github.com/jcasimir/be92b0b4fd16aaa90187fbdc17dccd75)
* [Station 2: Merge Sort](https://gist.github.com/jcasimir/6fca38c58e5cc25594eace1d875210c8)
* [Station 3: Binary Sort](https://gist.github.com/jcasimir/7d17f36d17d53ef13b1976e3fa3a7306)

__break__

### Part 3: Talking about Big O *(20 Minutes)*

Cover the following key points in a whole-group lecture with questions:

* Big-O is how we refer to the algorithmic complexity
* The important part of complexity is how it scales with the number of inputs
* If we only have a dozen or few hundred inputs, complexity usually doesn't matter
* But what about thousands or millions?
* Draw the graph of complexity with a logarithmic Y axis
  * Include O(1), O(log(n)), O(n), O(nlog(n)), O^2, O^3 like https://cdn-images-1.medium.com/max/800/1*_nsMVEEkIr1CH8aHjTNbzA.jpeg
* If your data set is finite or your users don't matter, then who cares?
  * Ex: building a reporting system that runs once a week and could be scheduled for 2AM on Friday morning. If it takes 30 minutes or 3 minutes is irrelevant
* If your data set grows, especially if it grows n^2 as your number of users increases, then you could be in trouble
  * Ex: imagine you're building discussion software or Reddit. As the number of users increases and number of forums increases you get a spiraling quantity of content. Imagine you're pulling the "top 10 threads of the hour" page -- complexity will matter.
* In your web application, your "operation" is probably a SQL query or API call
  * If you have 1, 2, or a fixed number, you're probably OK
  * But if you have N calls for N pieces of data, or 2N, or N^2, you're in trouble
  * Consider: N+1 example like that a news site that lists the top articles on the front page and does a follow up query for each article to get the number of comments

With five minutes left, get into these key understandings:

* There's often more than one way to solve a problem
* Everything in software is a collection of tradeoffs
* You might consider...
  * Difficulty of implementation
  * What do you already know about the data?
  * Can you cut/limit the size of inputs?
  * Best-case run time? Worse-case run time?
  * How will the run time change with an increase of N?
  
#### Exit Step

_Prep:_ Seed a binary tree near the door with six random but balanced nodes

* Grab 6 of your numbers at random and shuffle them
* Insert them into the Binary Tree on the table near the door
* Notice how the tree is or isn't balanced
