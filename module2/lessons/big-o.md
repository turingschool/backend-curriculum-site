# Big-O Analysis

## Revisions & To-Dos

- [ ] Set up explicit roles for co-teaching
- [ ] Recap/review the plan with co-teacher
- [ ] Come up with an intentional strategy for pairing and sitting
- [ ] Build slides for the questions/processes

## Learning Goals

* Be able to explain why we care about the algorithmic complexity of our programs on a practical level
* Be able to explain why we analyze algorithms in terms of asymptotic and worst-case performance
* Explore the performance characteristics of some common algorithms/operations

## Lesson Plan

### Prep Needs

* Cut number cards. Use [this document](https://docs.google.com/document/d/1JPCqs418QEbhbUUdqESzkilB7RcOl6CXw8gP2ncqKiU/edit?usp=sharing) with 216 random numbers for at least 10 pairs
* Snack trays to hold number cards
* Post-It notes of 1-12 for instructor board demos
* Printed copies of the algorithm break-out pages

### Pre-Class & Warm-up

Post on the board before class:

* https://www.youtube.com/watch?v=XaqR3G_NVoo on the TV
* Pairings for sitting / Part 1
* Pickup instructions for number cards and trays: each pair should have one tray and pick 10 random number cards
* Write your answer in your notebook: why does the speed of software matter?

### Part 1: Revisiting Algorithms *(25 Minutes)*

#### Why Speed Matters

* fast software makes people happy
* slow software makes people sad
* happy people pay money or pay with their attention
* developers like having jobs
* fast software leads allows you to have a job

#### Collective Bubble-Sort Exercise

Together, illustrate the steps of a bubble sort on the board:

* Post six random post-it numbers
* Eval left to right
* Maintain a CURRENT and PREVIOUS
* Follow this algorithm:

```
1. Start with PREVIOUS pointing at element-0, CURRENT at element-1
2. If CURRENT is > PREVIOUS
  * Move PREVIOUS = CURRENT, CURRENT = CURRENT + 1
  * If CURRENT = nil, you're done!
  * Else, restart Step 2
3. Else (when CURRENT < PREVIOUS)
  * Swap CURRENT and PREVIOUS in the set
  * Return to Step 2
```

##### Check Your Understanding

1. Assuming you have six numbers to sort with this algorithm, what would be the best-case scenario where this algorithm finishes in as little time as possible?
2. What would be the worst-case that takes as long as possible?

#### Paired Bubble-Sort Exercise

##### Round 1: Random Case

* Person on the right is the RECORDER, person on the left is the WORKER
* RECORDER should select six random number cards, shuffle them, hand them to the WORKER
* WORKER lays out the cards in their current order left to right
* RECORDER is going to track how many "operations" it takes to sort the numbers using the Bubble Sort algorithm
  * Make a tally for each *comparison* (a >?< b) and each *swap*
* WORKER executes the bubble sort algorithm talking out loud
* RECORDER notes the total number of operations

*DEMO* with three random numbers with both instructors on the whiteboard

##### Round 2: Random Case Again

* RECORDER shuffles the same six cards
* Repeat the process and get the new operation count

Group questions:

* How did the count of operations differ from your first run? (lots of different answers)
* What does this tell you about bubble sort? (still nothing)

##### Round 3: Measuring Worst-Case

* RECORDER selects three cards from the six at random and puts them in the worst-possible order for this algorithm
* WORKER should sort them while RECORDER tracks the number of operations
* RECORDER adds in one more card and puts them back in the worst order
* WORKER should sort them while RECORDER counts
* RECORDER adds in fifth card and puts them back in the worst order
* WORKER should sort them while RECORDER counts

##### Hypotheses & Conclusions

_Answer these questions then take a short break_

1. Think about the best-case input for a three element set. How many steps would it take to sort it? 
2. If you add one element to the set and it's still in the best-case order, how does that change the number of steps to sort the set? 
3. What algabraic equation would explain how this best case number changes with change to the number of elements in the set?
4. Based on your observations in Round 3, what equation could characterize how many operations are required to sort the worst-case input of *N* elements?

Extension Questions:

1. Bringing together 4 and 5, what can you confidently say about how many operations it takes to sort a set with 10 elements using Bubble Sort?
2. How would your answer to 6 change if you consider 100 elements?
3. What does your answer to 6 and 7 tell you about the viability of bubble sort?

__break__ and set up for station activity

### Part 2: Algorithmic Differences *(45 Minutes)*

#### Prep

* Post the sequences for each pair on the board
* Lay out three stations with the sort documents below
* Each station they have ~13 minutes to complete the exercises, then rotate

#### Materials

* [Station 1: Insertion Sort](https://gist.github.com/jcasimir/be92b0b4fd16aaa90187fbdc17dccd75)
* [Station 2: Merge Sort](https://gist.github.com/jcasimir/6fca38c58e5cc25594eace1d875210c8)
* [Station 3: Binary Sort](https://gist.github.com/jcasimir/7d17f36d17d53ef13b1976e3fa3a7306)

__break__

### Part 3: Talking about Big O *(10 Minutes)*

Cover the following key points in a whole-group lecture with questions:

* Big-O is how we explain how the complexity of executing an algorithm scales with the number of inputs to the algorithm
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

#### Key Closing Points (3 Minutes)

* There's often more than one way to solve a problem
* Everything in software is a collection of tradeoffs
* You might consider...
  * Difficulty of implementation
  * What do you already know about the data?
  * Can you cut/limit the size of inputs?
  * Best-case run time? Worse-case run time?
  * How will the run time change with an increase of N?
  
#### Exit Step (2 Minutes)

_Prep:_ Seed a binary tree near the front with six random but balanced nodes

1. As a pair, bring your numbers to the front
2. Each member of the pair should pull two numbers randomly from your set
3. Put the rest in the collection pile
4. Insert your two numbers into the binary tree on the front table while counting out loud the number of comparisons it takes you to insert the new node
5. Discuss with your pair: why are people who are inserting nodes at basically the same time getting very different numbers of operations?
