---
title: Organizing Client-Side JavaScript Code
subheading: A Workshop
---

## Intro (5 minutes)

As you learned to build more complex applications, we gave you Rails. As a framework, one of Rails' jobs is to help you organize your code. Logic that is related to a resource belongs in that resource's model. Logic related to a view belongs in a helper.

This doesn't just help you organize your files -- it helps you organize divide responsibilities in your code.

JavaScript is not just a new language, but a new environment and we've taken away any opinionated framework from you. Now, the responsibility division and code organization is completely your responsibility.

## Learning Goals

By the end of this workshop, you should be able to:

- Understand Murphy's Four Areas of Responsibility
- Come up with a file structure to organize your client-side JS

## Testable Javascript and How it Relates to Code Organization (20 minutes)

Although the following reading is focused on unit testing JavaScript, Murphy does a great job of describing separation of responsibilities.

Reading: [Writing Testable JavaScript](https://alistapart.com/article/writing-testable-javascript)

After 15 minutes, turn to the person next to you and compare/discuss interesting parts of the reading.

### Murphy's Four Areas of Responsibility

- Presentation and interaction
- Data management and persistence
- Overall application state
- Setup and glue code to make the pieces work together

## Activity (10 minutes)

Pair up with your QS partner. With the Four Areas of Responsibility in mind along with projects specs, come up with a file structure you could use to organize your project. Be prepared to show this to the class.

## Review (20 minute)

Have each group show the file structures they have come up with.
* Compare and contrast.
* What are some similarities we are seeing?
* What are some differences?
* Should we all be using similar structures? What does that look like?

## Interview Question

You're building the front-end for an weather app in vanilla JavaScript. It displays the current temperature, 10-hour and 7-day forecasts, and has a search bar where the user can change the location. What might your file structure look like?
