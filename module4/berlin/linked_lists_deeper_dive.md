---
title: Linked Lists Deeper Dive
layout: page
---

##  Learning Goals

* Understand the cost/benefit trade-offs of using arrays via linked lists
* Understand and speak to several optimizations for linked lists
* Utilize problem solving process to solve linked-list problems

##  Warm Up (7 mins)

_Part I:_  Prework Review (3 mins)
* Talk about the Stack Overflow thread from the [prep work](https://stackoverflow.com/questions/393556/when-to-use-a-linked-list-over-an-array-array-list) with the person next to you (3 mins)
* Describe a linked list
* Compare and contrast linked lists with arrays
* What criteria would you use to assess whether to use a linked list or an array?

_Part II:_ Group Synthesis (4 mins)

## Memory management (5 mins)

### Random Access Memory
  * Memory => storage shelfs
  * Memory controller does read/write
  * Processor connected directly to a memory controller
  * Nearby addresses are cached
  * Processor saves time when pulling from nearby memory addresses/cache
    * Linked Lists => non-contiguous storage
      * better insertion/deletion
    * arrays => contiguous storage
      * better search

## Optimizations (5 mins)

### Doubly Linked Lists

##### Advantages

* traverse forward and backward (better for searching)
* can be used to implement queues

##### Disadvantages

* extra memory -> previous pointer

### Circular Linked Lists

##### Advantages

* Solving circular problems => Round Robin
* List can be traversed starting at any node

##### Disadvantages

* Finding end/beginning of list is harder with no null

### Runner Technique

* AKA Floyd’s Cycle Algorithm or Tortoise & Hare
* Iterate through LL with 2 pointers simultaneously

##### The algorithim

1. Initialize two pointers (tortoise and hare) that both point to the head of the linked list
2. Loop as long as the hare does not reach null
3. Set tortoise to next node
4. Set hare to next, next node
5. If they are at the same node, a loop is confirmed.

## Paired Challenge (25 mins)

#### # 1 Reverse a singly linked list (without recursion)

[Repl.it - Reverse linked list](https://repl.it/@thatpamiam/Reverse-linked-list)  
*Example:*  
*Input:* 1->2->3->4->5->NULL  
*Output:* 5->4->3->2->1->NULL  

***Extension:*** _How would you reverse a doubly linked list?_ 

#### # 2 Detecting a loop in a singly linked list

[Repl.it - Detecting a loop](https://repl.it/@thatpamiam/Detecting-a-loop)  
*Example:*  
*Input:* 1->2->3->4->5->1->2->3->4->5->1…  
*Output:* TRUE  

***Extension:*** _How would you determine what node is the "start" of the loop?_ 

## Closing Reflection (8 mins)

* Why use a linked list over an array? Or an array over a linked list?
* What went well with your process during the paired challenge? What didn't go well? What can you change for next time?

[Instructor Resources](https://github.com/turingschool/front-end-keys/blob/master/module-4/berlin/cs_2_linked_list_solutions.md)
