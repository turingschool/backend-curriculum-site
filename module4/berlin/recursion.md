---
title: Recursion
layout: page
---

## Learning Goals

- Understand the concept of recursion
- Understand the limitations of recursion in JS & Ruby
- Know the theory behind Tail Call Optimization
- Be able to solve problems using recursion

## Discussion on Reading

Reflecting on the [article](https://www.sitepoint.com/recursion-functional-javascript/) you read earlier, discuss the following questions with the person next to you:

  * Describe what recursion is? How does it compare to loops?
  * What are some scenarios that recursion is best for?
  * What performance issues does recursion have in languages like JavaScript & Ruby?

## Reviewing Key Concepts

Recursion is an important programming technique in which a function calls itself.  

### Advantages

* Useful for iterative branching including:
  * fractal math
  * sorting
  * traversing nodes of complex/non-linear structures (binary or prefix tries)
* Recursion is more functional in that it doesn't keep track of state (no side effects)

### Disadvantages
* Recursion is not optimized in many languages including JS & Ruby
  * Execution contexts continue to get built on the callstack.
  * With bigger datasets, this can be a problem.
    * Memory consumption can lead to the `maximum call stack size being exceeded`.
    * Loops on the otherhand don't need to add functions to the call stack. (better memory management)

## The anatomy of a recursive function

Every recursive function (reminder, just a function that calls itself) must have these two pieces:

1. A simple **base case** (or cases): a terminating scenario that _does not use recursion_ to produce an answer
2. A **recursive case**: A set of instructions, moving closer towards the base case, that ends in a call to the same function

Let's see this in action with a function that takes a number as an argument and counts down to zero.

```js
countdown( 3 );

// 3
// 2
// 1
// 0
```

**Solution:**
```js
const countdown = number => {
  // check our base case, if statement
  if (!number) {
    return 0;
  }
  
  console.log(number);
  
  // recursive case moving towards base case
  return countdown(number - 1)
}

countdown(3); // 3, 2, 1, 0
```

## Diving Deeper Into The Process

Let's work through one more together and write out a function that takes in an argument of an array of numbers and adds them together.

```js
let numbers = [ 1, 2, 3, 4 ];

getSum(numbers); // 10
```

One of the most basic patterns of recursion is when you can reduce a problem to a smaller one and then keep reducing until you can't do it anymore. This is also known as natural recursion.

It can be helpful to break down what each step of this problem looks like. Here's one way to visualize the call stack:

![visualization of the recursive call stack](https://i.imgur.com/Ly55ggk.png)

**Solution:**
```js
const getSum = nums => {
  // base case
  if (!nums.length) {
    return 0;
  }
  
  // get closer to base case
  let firstNumber = nums.shift();
  
  return firstNumber + getSum(nums);
}
```

### Tail Call Optimization

To get around the stack overflow issue, one can use *tail call optimization*.  A tail call refers to the last action that is **executed**. In this scenario, the recursive call must be the *last statement* of the recursive function.

```js
// Example:
// Create a getSum fn that adds all of the numbers in an array

// Example that is not optimized due to it returning an operation
return firstNumber + getSum(nums);

// Example suited for tail call optimization
return getSum(nums, sum + firstNumber);
```

Notice with the first example, we are returning an operation.  In this scenario, this would need to be added to the callstack because this cannot be executed until we know what `getSum(allNumbers)` returns.  In the second example, we are only returning the recursive function and passing what arguments we need to keep track of the sum, making this perfect for Tail Call Optimization so that it can execute immediately instead of stacking in memory. Taking what we understand from this, let's make some adjustments to the solution we just worked through!

**Solution with Tail Call Optimization:**
```js
const getSum = (nums, sum=0) => {
  // base case
  if (!nums.length) {
    return sum;
  }
  
  // get closer to base case
  let firstNumber = nums.shift();
  
  return getSum(nums, sum + firstNumber);
}
```

Note that for Javascript, this optimization is only available in Safari.  (Chrome, FireFox, and other browsers are not optimized currently).  Read [here](https://stackoverflow.com/questions/54719548/tail-call-optimization-implementation-in-javascript-engines) to understand more of the history about this.

In Ruby, this optimization is not available by default.  You *can* configure the Ruby compiler to enable tail call optimization however.  If you're interested, follow the [article](https://nithinbekal.com/posts/ruby-tco/) here!

## Exercises

The best way to start understanding recursion is to just try doing it!  Feel free to work through these problems in either JavaScript or Ruby.

### Exercise 1

Reverse a string.

```js
// create a function which takes a string of characters and
// recursively calls itself to reverse the string

// e.g.

let reversedString = reverse('Ariel')

console.log(reversedString); // leirA
```

### Exercise 2

Calculate a number to a specific power.

```js
// create a function which takes a number and an exponent and
// recursively calls itself to calculate the product

// e.g.
let base = 2;
let exponent = 4;
let product = power(base, exponent)  // 2 to the 4th power

console.log(product);  // 16
```

### Exercise 3

In mathematics, the factorial of a non-negative integer is the product of all positive integers less than or equal to n. For example, the factorial of 5 is 120.

```js
5 x 4 x 3 x 2 x 1 = 120
```

Write a recursive function that calculates the factorial of a number.

### Exercise 4

The Collatz conjecture applies to positive numbers and speculates that it is always possible to `get back to 1` if you follow these steps:

- If `n` is 1, stop.
- Otherwise, if `n` is even, repeate this process on `n/2`
- Otherise, if `n` is odd, repeat this process on `3n + 1`

Write a recursive function that calculates how many steps it takes to get to 1

n | collatz(n) |Steps
--- | :---: | --- 
2 | 1 | 2 -> 1 
3 | 7 | 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
4 | 2 | 4 -> 2 -> 1
5 | 5 | 5 -> 16 -> 8 -> 4 -> 2 -> 1
6 | 8 | 6 -> 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1


### Bonus
Now try and solve these problems with tail call optimization!