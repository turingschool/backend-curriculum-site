---
title: Insertion Sort
layout: page
---

## Learning Goals

- Understand how the insertion sort algorithm works
- Understand the advantages/disadvantages of insertion sort
- Continue to hone & refine your problem solving skills

##  Warm Up

Watch the instructor take an array of unsorted numbers, `[ 1, 0, 4, 3, 2 ]`, and sort them one by one.  Pay attention to both the numbers compared and the order in which those comparisons are made.

*Follow Up:*

* On a high level, write in your notebook what you saw and how you think the algorithm works.
* Discuss with the person next to you what the algorithm is for insertion sort.

## Insertion Sort

![Graphical Example of Insertion Sort](https://upload.wikimedia.org/wikipedia/commons/0/0f/Insertion-sort-example-300px.gif)

Insertion sort works by adding items to a sorted array. Typically sorting is done in place inside the array which needs sorting. The first element in the array becomes the sorted array. We iterate through the set to be sorted, pulling one element at a time, then inserting it into its correct position in the sorted section of the array.

You can [see another visualization of the algorithm here](https://www.youtube.com/watch?v=8oJS1BMKE64).

### Breakdown

Here is a breakdown of what you saw earlier:

#### Pass 1

A list with only one item is always sorted, so we start our sorted list with the first element in our array:

```
original array: [ 1, 0, 4, 3, 2 ]

                [ sorted        | unsorted   ]
original array: [ 1,            | 0, 4, 3, 2 ]
```

#### Pass 2

We pull the first unsorted element, the `0`, and compare it to the last element of the sorted set, `1`. Since `0` is less than `1`, we swap it with the `1`:

```
unsorted:      [0, 4, 3, 2]
to insert:     0

                [ sorted        | unsorted   ]
before insert:  [ 1,            | 0, 4, 3, 2 ]

                [ sorted        | unsorted   ]
after insert:   [ 0, 1,         | 4, 3, 2    ]

```

#### Pass 3

We pull the first unsorted element, the `4`, and compare it to the last element of the sorted set, `1`. Since `4` is greater than `1`, we add the `4` to the end of the sorted array.

```
unsorted:      [4, 3, 2]
to insert:     4

                [ sorted        | unsorted   ]
before insert:  [ 0, 1,         | 4, 3, 2    ]

                [ sorted        | unsorted   ]
after insert:   [ 0, 1, 4,      | 3, 2       ]
```

#### Pass 4

We pull the first unsorted element, the `3`, and compare it to the last element of the sorted set, `4`. Since `3` is less than `4`, we swap the `3` and `4`. We then compare the `3` with the previous position of the sorted set, `1`. Since `3` is greater than `1` we have the `3` in the correct position.

```
unsorted:      [3, 2]
to insert:     3

                [ sorted        | unsorted   ]
before insert:  [ 0, 1, 4,      | 3, 2       ]

                [ sorted        | unsorted   ]
after insert:   [ 0, 1, 3, 4,   | 2          ]
```

#### Pass 5

We pull the first unsorted element, the `2`, and compare it to the last element of the sorted set, `4`. Since `2` is less than `4` we swap the `2` and `4`. We then compare the `2` with the previous position of the sorted set, `3`. Since `2` is less than `3`, we swap the `2` and `3`. Then we look at the previous position of the sorted set, `1`. Since `2` is greater than `1` we have the `2` in the correct position.

```
unsorted:      [2]
to insert:     2

                [ sorted        | unsorted   ]
before insert:  [ 0, 1, 3, 4,   | 2          ]

                [ sorted        | unsorted   ]
after insert:   [ 0, 1, 2, 3, 4 |            ]
```

Since we have no more elements in the unsorted section of our array, we are done with the algorithm.

## Performance

### Advantages

* Implementation compared to other sorting algorithms is simple
* More efficient than other sorting algorithms like `bubble sort` or `selection sort`
* Is effecient for small data sets that are already mostly sorted

### Disadvantages
* Very impractical for sorting large arrays of data
  * The threshold can vary, but it's typically only good for arrays of 10-50 values
  * Arrays with larger datasets are better sorted with algorithms like `merge sort` and `quicksort`

As a result, a hybrid approach is often implemented for optimization, using a simpler algorithm like `insertion sort` for smaller datasets. 

## Your Turn: Implementation

Using Repl, implement a sorting function that takes an array as an argument and returns the sorted array using the `insertion sort` algorithm.  (feel free to use the language you are most comfortable with)

**Note:** For now, do NOT look up solutions!  It's easy to find solutions to many sorting algorithms on the web which can be useful when comparing your implementation later, but for now focus on taking what you already know about how `insertion sort` works and use your problem solving skills to implement that functionality.

Start with a smaller dataset for now as you start out implementing the functionality.  For more advanced testing, you will need to generate arrays of numbers to see how large of an array your `insertion sort` function can sort.