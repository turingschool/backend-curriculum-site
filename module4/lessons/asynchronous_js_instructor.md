---
title: Asynchronicity in JavaScript - Instructor
layout: page
---

## Learning Goals

- Students understand how JavaScript executes synchronously vs asynchronously
- Students can read and explain JavaScript that executes asynchronously
- Students are able to explain how asynchronous JavaScript can be handled

## Vocabulary

- synchronous
- asynchronous
- call stack
- queue
- Web APIs
- Event Loop
- JS Engine/runtime

## Materials

- Assign partners, one with a * for who should have computer open in warm-up
- Print out Starbucks customer roles/functions, cut in strips
- Print out and cut up the 4 "Experiments in Ordering" code snippets

## Slides

* Available [here](../slides/async_js_and_promises)

## Warm Up

Take 4 minutes to do some research with your partner on the `setTimeout` Web API. Feel free to go straight to the docs, or use this code snippet below to play around with it in the console. (You can copy and paste it into the console tab of the browser!). During this time, only one computer should be open.

```js
function waitTwoSeconds() {
  console.log("I am starting to wait...");
  setTimeout(function() {
    console.log("I've waited two seconds");  
  }, 2000);
}

waitTwoSeconds();
```

- What does `setTimeout` do?
- In the snippet above -
    * which `console.log` will print first?
    * Will they both print immediately? Why or why not? If not, how long will we have to wait?


## Starbucks Activity

## Drive-Thru

Assign 8 different students a customer role. They will get a strip of paper with a customer number and function declaration and call. They should line up in order, pretending to be in their car approaching the window.

The instructor should be the order taker/barista.

As each customer approaches the window, the barista should write down the order and the time it will take. Then, immediately complete the order. Then, take the next order. Continue.

Customer 1:

```js
function orderCakePop() {
  console.log("Your cakepop is ready!");  
}

orderCakePop();
```

Customer 2:

```js
function orderThreeLattes() {
  console.log("Your lattes are ready!");  
}

orderThreeLattes();
```

Customer 3:

```js
function orderPike() {
  console.log("Your coffee is ready!");
}

orderPike()
```

Customer 4:

```js
function orderBreakfastSandwichandLatte() {
  console.log("Your sandwich and latte are ready!");  
}

orderBreakfastSandwichandLatte();
```

Customer 5:

```js
function orderBreakfastSandwich() {
  console.log("Your sandwich is ready!");  
}

orderBreakfastSandwich();
```

Customer 6:

```js
function orderOneLatte() {
  console.log("Your latte is ready!");  
}

orderOneLatte();
```

Customer 7:

```js
function orderPike() {
  console.log("Your coffee is ready!");
}

orderPike();
```

Customer 8:

```js
function orderDoubleFrapWithExtraWhipAndTenCakePops() {
  console.log("Your double frap with extra whip and ten cake pops are ready!");  
}

orderDoubleFrapWithExtraWhipAndTenCakePops();
```


## Debrief Drive-Thru

Prep this in your console or a repl (or use [this link](https://repl.it/@ameseee/Sync-Starbucks?language=javascript))

```js
function orderCakePop() {
  console.log("Your cakepop is ready!");  
}

function orderThreeLattes() {
  console.log("Your lattes are ready!");  
}

function orderPike() {
  console.log("Your coffee is ready!");
}

function orderBreakfastSandwichandLatte() {
  console.log("Your sandwich and latte are ready!");  
}

function orderBreakfastSandwich() {
  console.log("Your sandwich is ready!");  
}

function orderOneLatte() {
  console.log("Your latte is ready!");  
}

function orderPike() {
  console.log("Your coffee is ready!");
}

function orderDoubleFrapWithExtraWhipAndTenCakePops() {
  console.log("Your double frap with extra whip and ten cake pops are ready!");  
}

orderCakePop();
orderThreeLattes();
orderPike();
orderBreakfastSandwichandLatte();
orderBreakfastSandwich();
orderOneLatte();
orderPike();
orderDoubleFrapWithExtraWhipAndTenCakePops();
```

Now, show the code that this illustrates:

```
orderCakePop();
orderThreeLattes();
orderPike();
orderBreakfastSandwichandLatte();
orderBreakfastSandwich();
orderOneLatte();
orderPike();
orderDoubleFrapWithExtraWhipAndTenCakePops();
```

Explain that as expected, they did their jobs in order. We kind of 'faked' the amount of time it took to complete each order, but because there is one lane and people are in cars, we know that each person has to wait for all the people in front of them to receive their orders.

This is the way JavaScript behaves by default - **synchronously**.

Now, let the students know that we will move into modeling asynchronous JavaScript with an in-store example.

## In-Store

Pass out customer roles to students who didn't participate in the drive-thru activity. Students should line up in order, this time in front of a 'counter' inside the 'store'.

As the barista (instructor) takes the order, write down the food and time. If there is no time, give it immediately and send the customer to their seat. If not, tell them to wait on the side. If there is a time, it won't be perfect, but wait for at least one other customer to order before giving the pervious person their order.

Customer 1:

```js
function orderCakePop() {
  setTimeout(function() {
    console.log("Your cakepop is ready!");  
  }, 1000);
}

orderCakePop();
```

Customer 2:

```js
function orderThreeLattes() {
  setTimeout(function() {
    console.log("Your lattes are ready!");  
  }, 6000);
}

orderThreeLattes();
```

Customer 3:

```js
function orderPike() {
  console.log("Your coffee is ready!");
}
orderPike();
```

Customer 4:

```js
function orderBreakfastSandwichandLatte() {
  setTimeout(function() {
    console.log("Your sandwich and latte are ready!");  
  }, 7000);
}

orderBreakfastSandwichandLatte();
```

Customer 5:

```js
function orderBreakfastSandwich() {
  setTimeout(function() {
    console.log("Your sandwich is ready!");  
  }, 5000);
}

orderBreakfastSandwich();
```

Customer 6:

```js
function orderOneLatte() {
  setTimeout(function() {
    console.log("Your latte is ready!");  
  }, 2000);
}

orderOneLatte();
```

Customer 7:

```js
function orderPike() {
  console.log("Your coffee is ready!");
}

orderPike();
```

Customer 8:

```js
function orderDoubleFrapWithExtraWhipAndTenCakePops() {
  setTimeout(function() {
    console.log("Your double frap with extra whip and ten cake pops are ready!");  
  }, 12000);
}

orderDoubleFrapWithExtraWhipAndTenCakePops();
```

## In-Person Debrief

Have the students share out what order they remember getting their orders in - what it the same as the drive thru? Why or why not?

Explain that this models **asynchronous** JavaScript. To show the connection to code - copy and paste the 8 functions (below) in your console, then call the functions in order (also below). Tell the students to watch very carefully for the `console.log`s to come in.

After this, students should now get the general idea of synchronous vs. asynchronous code, and understand setTimeouts. They should probably take a pom.


Code for instructor to run in browser (recommend you tee this up before class to avoid wasting time coy and pasting - or use [this link](https://repl.it/@ameseee/Async-Starbucks?language=javascript)):

```js
function orderCakePop() {
  setTimeout(function() {
    console.log("Your cakepop is ready!");  
  }, 1000);
}

function orderThreeLattes() {
  setTimeout(function() {
    console.log("Your lattes are ready!");  
  }, 6000);
}

function orderPike() {
  console.log("Your coffee is ready!");
}

function orderBreakfastSandwichandLatte() {
  setTimeout(function() {
    console.log("Your sandwich and latte are ready!");  
  }, 7000);
}

function orderBreakfastSandwich() {
  setTimeout(function() {
    console.log("Your sandwich is ready!");  
  }, 5000);
}

function orderOneLatte() {
  setTimeout(function() {
    console.log("Your latte is ready!");  
  }, 2000);
}

function orderPike() {
  console.log("Your coffee is ready!");
}

function orderDoubleFrapWithExtraWhipAndTenCakePops() {
  setTimeout(function() {
    console.log("Your double frap with extra whip and ten cake pops are ready!");  
  }, 12000);
}

orderCakePop();
orderThreeLattes();
orderPike();
orderBreakfastSandwichandLatte();
orderBreakfastSandwich();
orderOneLatte();
orderPike();
orderDoubleFrapWithExtraWhipAndTenCakePops();
```

## When Will We Need This?
## Event Loop
## Video

Now is time to show the video from JSConfEU  - https://www.youtube.com/watch?v=8aGhZQkoFbQ - start at 0:52, stop at 17:18.
