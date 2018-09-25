# An Introduction to Object-Oriented JavaScript

Instructor Notes

This lesson mainly follows the resource at './intro_to_oojs'. A few additions for instructors to be aware of:
- Warm Up and Wrap Up slides gives explicit directions for student actions, and teacher notes.
- Activity on Classical Inheritance vs. Prototypal Inheritance is in slides, not mentioned in student-facing resource.

Prep:
- Write learning goals, vocab, and rough agenda on board.
- Prep partners for whiteboard (and after) activity. They are in a solo project during this week.
- Prep slide or printouts of Animal/Dog classes for whiteboard inheritance activity

## Warm Up

Jot down your answers to the following in your notebook:

1. What are the main components of Object Oriented Programming?
2. What do you like/dislike about OOP?
3. What's one way to create a new object in JavaScript?
4. What's your experience in making your JavaScript object-oriented thus far?

^ Facilitation:
- 4 min: students writing silently in notebooks
- 30 sec: students talk with partner about #1
- 1 min: students talk with different partner about #3-4 (it may be very likely that many students respond "none" to #4 and is totally ok! Reassure them of this - that's today's goal.)
- (During this time, instructor is circulating, looking for strong responses to each)
- 2 min: Instructor calls on already-selected students to answer #1, #3, and #4

## Learning Goals

By the end of this lesson you should...

* be able to apply OO patterns to JavaScript functions *(mastery)*
* explain the difference between OOP and JavaScript's Prototypal Inheritance *(functional)*
* better understand and make use of `this` in multiple contexts *(functional)*

## Vocabulary

- Object Oriented Programming
- Classical Inheritance
- constructor functions
- prototype
- Prototypal Inheritance
- `this`

## Introduction

JavaScript can behave as an object-oriented programming language, but it follows a slightly different approach than what we know from Ruby. Instead of creating classes, constructor functions can be used to construct new objects in JavaScript.

It's not a rule baked into the language, but — by convention — most JavaScript developers capitalize the names of functions that they intend on using as object constructors.

## Constructors
A **constructor function or object constructor** can be thought of as a blueprint (similar to classes), or—better yet—as a casting mold from which new objects are minted. The constructor function includes basic information about the properties of an object and uses a special syntax that allows us to build new objects quickly using the template defined by the constructor.

Object constructors can be called using the `new` keyword.

SLIDE:
```js
function Dog() {}

var sodie = new Dog();
```

SAY:
`sodie` in the example above will be a new object — albeit, a very simple one.
Let's add to our `Dog()` constructor.

SLIDE:
```js
function Dog(name) {
  this.name = name;
  this.legs = 4;
}

var sodie = new Dog('Sodie');
var oscar = new Dog('Oscar');

sodie.name;
sodie.legs;
oscar.name;
```

SAY:
Here, we are taking an argument to customize a property:
- What would this look like in a Ruby class (STUDENT_NAME)? - initialize
- What would you expect to return for sodie.name (STUDENT_NAME), ('Sodie')
    sodie.legs (STUDENT_NAME), (4)
    oscar.name (STUDENT_NAME)? ('Oscar')

- Now, let's talk about the way we are using **`this`** here. We know that the default behavior of `this` is to bind to the global object; clearly that's not happening. `Dog` is just a regular function, with a `this` context, so the context is DOG!


## Functions and `this` revisited

If you recall, there are a few ways we can call a function:

* Using a pair of parenthesis as the end of the functions name (e.g. `someFunction()`).
* Using the `call()` method (e.g. `someFunction.call()`).
* Using the `apply()` method (e.g. `someFunction.apply()`).

### NEW Keyword

When we are writing object-oriented JavaScript, we have a fourth way of invoking a function: the `new` keyword. The `new` keyword invokes the function _as a constructor_, which causes it to behave in a fundamentally different way.

When we use the `new` keyword to call our function as a constructor, a few things happen under the scenes:

1. `this` is set to a new empty object
2. The prototype property of the constructor function (`Dog.prototype` in the example above) is set as the prototype of the new object, which was set to `this` in the first step
3. the body of our function is run
4. our new object, `this`, is returned from the constructor

## The `prototype` Property

SLIDE:
```js
function Dog() {}
function Cat() {}

Dog.prototype; // {}
Cat.prototype; // {}
```
SAY:
This property is set to an empty object — `{}` — by default.


SLIDE:
```js
function Dog(name) {
  // `this` is set to a new object
  // the prototype is set to `Dog.prototype`
  this.name = name;
  this.legs = 4;
  // return this;
}

var sodie = new Dog("Sodie");
```

SAY:
- Let's take a look at `this` in the context of our `Dog()` constructor: (talk through code on slide)
- What is `Dog.prototype` and where does it come from?
- Functions are objects and all functions in JavaScript have a `prototype` property.


With regular functions, we generally don't use the `prototype` property — it's like an appendix. But, this special little object comes in to play when we use the function as a constructor.

You may have heard that JavaScript has something called _prototypal inheritance_. This is a very complicated term for a relatively simple concept.

## **Classical Inheritance v. JS Prototypal Inheritance Whiteboard Activity**

#### OO - Classical Inheritance

With your partner, whiteboard out how you would visualize classical inheritance with OO for something like this:

```ruby
class Animal
  def eat
    puts "yum!"
  end

  def breathe
    puts "inhale and exhale"
  end
end

class Dog < Animal
  def speak
    puts "bark"
  end
end
```

Consider:
- How can you diagram the relationship between Animal and Dog?
- How can you diagram the relationship between Animal and eat?
- How can you diagram the relationship between Dog and eat?

^ We would expect students to diagram something that indicates Dog is copied from Animal, and eat comes from Animal, and eat comes from Dog.
Discuss the idea of 'copying' - we've always used the blueprint or cookie cutter analogy to make sense of OO. JS tries to make it _look_ like that's what happening, but it's not what's happening.
!! Instruct student to move their stuff and find a seat with their whiteboard partner. !!

#### JavaScript - Prototypal Inheritance

(the following progression of ideas and diagrams are from Kevin Simpson's FE Masters Deep JS Foundations)
SLIDE:
- Prototypes are where all other OOP patterns in JavaScript stem.
- Objects are built by constructor class (a function call with `new` keyword).

SLIDE
"A constructor makes and object based on it's own prototype."

SAY:
Because of what we know about OOP, this makes sense. Your diagrams showed copies of Animals, Dogs copying Animal information, etc. The thing is, that's NOT what is happening under the hood in JS.

SLIDE:
- "A constructor makes and object _linked to_ it's own prototype."

SAY:
JS does not do copying, but it **does** create a link to the object.

DRAW OUT DIAGRAM & TALK THROUGH
[Diagram]('./assets/prototype_chain_diagram.JPG')
[Diagram with Explanation](./assets/prototype_chain_explained.JPG)

## Back to Dog Example

REFER TO NOTES - RUN THIS CODE IN CONSOLE

When we call a property on an object (e.g. `sodie.name`), JavaScript checks the object to see if it has a `name` property. If it does, then it hands us that property. If not, then it checks the object's prototype. If the object's prototype doesn't have that property, then it check's the prototype's prototype, and so on. It continues this process until it reaches the top of the chain. If it still hasn't defined this property, then it returns `undefined`.

By default, all objects inherit from `Object`, which has a few methods on it. One of these methods is `toString()`.

```js
function Dog(name) {
  this.name = name;
  this.legs = 4;
}

var sodie = new Dog('Sodie');

sodie.legs; // 4
sodie.toString(); // [object Object]
```

When we call `sodie.legs` in the example above, JavaScript checks `sodie` to see if it has a `legs` property. It does, so JavaScript returns the value, `4`.

In the next line, we call `toString()`. Well, `sodie` doesn't have a `toString` property, so we check `sodie`'s prototype, which is `Dog.prototype`. That's an empty object, so it certainly doesn't have that property.

Eventually, we work our way up to `Object.prototype`, which has a to `toString` property set to a built-in function. JavaScript calls the `toString()` method that it found up the chain, which returns `[object Object]`.

We could, however, set our own `toString()` method that would return something a little more helpful.

```js
function Dog(name) {
  this.name = name;
}

var sodie = new Dog('Fido');

sodie.toString = function() {
  return '[Dog: ' + this.name + ']';
};

sodie.toString(); // [Dog: Fido]
```

JavaScript finds the `toString` property immediately and doesn't have to look up the chain of prototypes. But, only `sodie` has this fancy new `toString` property. It would be nice if all dogs could share this new functionality. (BTW, we shouldn't ever override built-in methods like `toString` - this was just to illustrate the concepts!)

> Side note: our custom `toString()` function is an example of the [Template Method Pattern](https://en.wikipedia.org/wiki/Template_method_pattern) in practice

Each dog constructed by the `Dog()` constructor has `Dog.prototype` set as its prototype. This means that each dog looks immediately to `Dog.prototype` if we ask for a property that it doesn't have.

Consider the following:

```js
function Dog(name) {
  this.name = name;
}

Dog.prototype.toString = function () {
  return '[Dog: ' + this.name + ']';
};

var sodie = new Dog('Sodie');
var oscar = new Dog('Oscar');

sodie.toString(); // [Dog: Sodie]
oscar.toString(); // [Dog: Oscar]
```

Prototypes are a great way to share functionality between related objects. We can define any properties we want on `Dog.prototype`.

```js
function Dog(name) {
  this.name = name;
}

Dog.prototype.sayHello = function () {
  return 'Hello, my name is ' + this.name + '.'
};

var sodie = new Dog('Sodie');
var oscar = new Dog('Oscar');

sodie.sayHello(); // Hello, my name is Sodie.
oscar.sayHello(); // Hello, my name is Oscar.
```

## ES6 `class` Syntax

The ES6 `class` keyword has gotten a lot of excitement from newer JS devs, but there are a lot of critics out there. Some things to know:
- syntax looks a lot more like a class system; it is still bound by the prototype system
- classes pretend that copying is going on - it's _not_.
- use the `extends` keyword to inherit
- `super` keyword allows you to go up prototype chain (relative polymorphism)
- `static` keyword (the only thing that's not just syntactic sugar) - adds to class, not just instance.

Here is the same implementation in ES6 syntax:

```js
class Dog {
  constructor(name) {
    this.name = name
  }

  sayHello() {
    return `Hello, my name is ${this.name}.`
  }
}

const sodie = new Dog('Sodie')
const oscar = new Dog('Oscar')

sodie.sayHello() // Hello, my name is Sodie.
oscar.sayHello() // Hello, my name is Oscar.
```

Don't let the `class` keyword fool you **too** much. It still compiles down to a `Dog.prototype` object, it's just wrapped in a container so the syntax is more familiar to other OO languages.

A couple of it's limitations:
- An object cannot be extended
- Classes and Objects cannot be mixed
- **all** classes or **no** classes
- Classes cannot just be called like functions, they can only be used with `new` keyword
- `this` context can be changed with `.call` or `.apply`, but super is static. (This was done for performance, but really messes people up)

> Pro tip: shortcuts in code, such as this `class` syntax is often referred to as **syntactic sugar**

### A OO jQuery Example

You are now familiar with the classic `$(document).ready(() => ... )` setup, which tells the browser to wait for the DOM to load before running your scripts.  Perhaps you've also ended up with a big ol' list of functions in and out of this `ready` block, not really organized in any object-oriented way.

A potential solution for organizing your jQuery setup looks like this:

```js
// some higher-level .js file
$(document).ready(() => {
  new EventHandler()
})
```

```js
// in a separate "eventHandler.js" file:

// ES5
function EventHandler() {
  $("button").on("click", this.doSomething) // this is "listening" upon its construction
}

EventHandler.prototype.doSomething = function() {
  console.log("Handled!")
}

// ES6
class EventHandler {
  constructor() {
    $("button").on("click", this.doSomething.bind(this))
  }

  doSomething() {
    console.log("Handled!")
  }
}
```

## Your Turn: All those Mod 1 Exercises Return!

Go to [this repo](https://github.com/turingschool-examples/bon_appetit_js) and follow the instructions to get set up. Let's take thirty minutes to implement (some of) the Mod 1 exercise using object-oriented JavaScript.

## Prototypes vs. Classes

This is a topic that has been hashed out to great length on the internet. In some ways there are a lot of similarities between classes in a language like Ruby and prototypes in a language like JavaScript:

* Both allow child instances of their type to access their methods and behavior
* Both use a "chain" mechanism to continue searching for requested properties in their parent
* Both can be used (via constructor invocation) to "set up" new objects when they are created

However, there are also some major differences:

* Prototypes don't really provide a mechanism for encapsulation of state, which is one of the major principles of most OO languages.
* JavaScript doesn't provide an OO-style mechanism for "private" functions (although we can achieve something similar with closures).
* Prototypes don't distinguish between their own methods and the methods provided to their children (i.e. class methods vs. instance methods).
* We don't have relative polymorphism like we do in OOP - it's always absolute to the bottom of the chain. You cannot override a function with the prototype system.

## Closing

In your notebook, answer the following:
- What is the `this` keyword in JavaScript?
- What happens when the `new` keyword is used?
- How would describe the differences between "OO" in JavaScript and OO in Ruby?
