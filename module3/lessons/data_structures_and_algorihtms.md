---
title: Data Structures and Algorithms
layout: page
tags: interview prep, sorting, linked list, binary tree
---

## Learning Goals

* Introduce you to a few programming algorithms & data structures
* Spark your curiosity to further explore these concepts
* You may see these concepts as part of your interview process

## Sorting Algorithms

Sorting algorithms are used to organize an array or list of elements. For example, if you have a list of words and they need to be arranged in alphabetical order, or arranging numbers from least to greatest.

There are _multiple_ different methods for sorting the information depending on how the elements are broken up or compared to other elements. [Here](https://www.geeksforgeeks.org/sorting-algorithms/) you can find a list of various sorting algorithms; however, we are only going to look into three sorting algorithms.

### Bubble Sort

Bubble sort is completed by iterating over each element and comparing it to the _next_ adjacent element and then swapping places if the elements are not in the correct order. It repeats this process until all elements in the array are sorted.


<details open><summary><i>Bubble Sort Gone Wrong</i></summary>
  <iframe src="https://giphy.com/embed/A21xqd8A2RCko" width="480" height="270" frameBorder="0" class="giphy-embed" allowFullScreen>
  </iframe>
  <p>
    <a href="https://giphy.com/gifs/A21xqd8A2RCko">via GIPHY</a>
  </p>
</details>

<details open><summary><i>Bubble Sort Visual</i></summary>
  <a title="Swfung8, CC BY-SA 3.0 &lt;https://creativecommons.org/licenses/by-sa/3.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Bubble-sort-example-300px.gif"><img width="256" alt="Bubble-sort-example-300px" src="https://upload.wikimedia.org/wikipedia/commons/c/c8/Bubble-sort-example-300px.gif"></a>
</details>


_Think About It_
* How long would it take to complete a bubble sort?
* Write pseudo code for how you might sort this array `[7, 3, 4, 9]`.

## Pseudo Solution

<details><summary>Review Solution</summary>
<ol>
  <li> Starting Array [7, 3, 4, 9] </li>
  <li> Find length of Array</li>
  <li> Compare each adjacent element until end is reached</li>
  <li> Start with index 0 and continue until last index equals array</li> length -1
  <li> If element with smaller index is greater swap elements</li>
  <li> Repeat process until array is sorted</li>
</ol>
</details>


### Insertion Sort

Insertion sort is done by sectioning the list or array into sorted and unsorted sections. Elements are then taken from the unsorted section and inserted into the correct position in the sorted section. The current element is compared to the _prior_ element. The value that is greater is then shifted forward to make room for the smaller element.

<details open><summary><i>Insertion Sort Visual</i></summary>
  <a title="Swfung8, CC BY-SA 3.0 &lt;https://creativecommons.org/licenses/by-sa/3.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Insertion-sort-example.gif"><img width="256" alt="Insertion-sort-example" src="https://upload.wikimedia.org/wikipedia/commons/9/9c/Insertion-sort-example.gif"></a>
</details>

_Think About It_
* How long would it take to complete an insertion sort?
* How does insertion sort compare to bubble sort?

### Merge Sort

Merge sort takes the __divide and conquer__ approach to sorting the list or array of elements. The array is continually split until only single elements of the array remain. Then the elements are compared to one another and merged in chunks. Once the elements have been broken into multiple single element arrays, the elements are then compared to make paired arrays. This process will continue by comparing the first element of the array to the first element of the other array until all the chunks are broken and combined to form a single array.

<details open><summary><i>Merge Sort Visual</i></summary>
  <a title="Swfung8, CC BY-SA 3.0 &lt;https://creativecommons.org/licenses/by-sa/3.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Merge-sort-example-300px.gif"><img width="256" alt="Merge-sort-example-300px" src="https://upload.wikimedia.org/wikipedia/commons/c/cc/Merge-sort-example-300px.gif"></a>
</details>

_Think About It_
* How long would it take to complete a merge sort?
* How does this sort compare to bubble and insertion?

## Data Structures

A data structure encompasses how the data is organized, managed, and what actions can be performed on the data. There are multiple types of data structures in programming and in order to determine the type of structure to use you might start by asking the following questions:
  * How does the data need to be stored?
    - The size of the data might help determine the answer to this question.
  * What is the relationship between the elements of the data?
  * How is the data used? What type of operations need to be performed to the data?

We are only going to explore 2 data structures, binary trie & linked list. If you want to research the others [here](https://www.geeksforgeeks.org/data-structures/) might be a good place to start.

### Binary Trie

A binary trie is a type of data structure that organizes data in a way that allows for faster look-ups when searching through the data. There are 3 main operations that can be performed on the data: insertion, deletion, and search. The data is structured so that there is a `root` node, the starting point, and each node can point to two other nodes. In order to travers the trie for a search, the element is compared to a node and determined whether it is greater than, less than, or equal to the element.

<details open><summary><i>Binary Trie Search Compared to a Sorted Array Visual </i></summary>
  <iframe src='https://gfycat.com/ifr/GrandShortCowrie' frameborder='0' scrolling='no' allowfullscreen width='640' height='582'></iframe>
  <p>
    <a href="https://gfycat.com/grandshortcowrie">via Gfycat</a>
  </p>
</details>

_Think About It_
* When might a binary trie be a beneficial structure to use?
* Why is it more advantageous to use a binary trie than an array?

### Linked List

A linked list is a data structure that organizes the data as a linear collection. However, unlike arrays, linked lists do not need to be stored with the data all together in memory. It is able to achieve this because each node contains the element data and a pointer to the next node in the list. Linked list operations include appending, deleting, and inserting data. There are also different types of linked lists: singly linked, doubly linked, and circularly linked.

<details open><summary><i>Singly Linked List Example</i></summary>
<br>
  <a title="Derrick Coetzee, Public domain, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Singly_linked_list_insert_after.png"><img width="300" alt="Singly linked list insert after" src="https://upload.wikimedia.org/wikipedia/commons/0/00/Singly_linked_list_insert_after.png"></a>
</details>
<br>
_Think About It_
* What is the advantage of using a linked list?
* What is the difference between a singly linked, doubly linked, and circularly linked list?

#### Looking for More?

[This repo](https://github.com/turingschool/data_structures_and_algorithms) has several computer science exercises to deepen your understanding.
