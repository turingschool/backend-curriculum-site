---
layout: page
title: Intro to React
subheading: Return of Quantified Self
---

Learning Goals
---------------

-   Student can break down user stories into components
-   Student can communicate decisions made in component architecture
-   Student can build React components from user stories
-   Student has next steps in mind for learning React

### Outline

-   Review Yesterday's content
-   We do: Breaking down foods table user stories into components
-   Split
    We do: Creating the meal table
    Pairs do: Create the foods table
-   Come back together to review solutions
-   Everybody You Do
    You do: Build a diary page with multiple meals, and a foods list
    You do+: Add the create foods form
-   Come back together to review solutions
-   Split: Make the "Add to Meal" buttons
    We do
    You do with some help
    You do without me

Review
-------

Yesterday, we introduced some concepts, and built some React

-   What were the new concepts we covered?
-   How would you define them?
-   What is still fuzzy about React

Quantified Self in React
-----------

Let's return to our week 1 project, [Quantified Self](../projects/quantified-self/quantified-self).

Instead of using `localstorage`, I've built an API to store our data. You can access it at: <https://quantified-api.herokuapp.com>. I'll draw the schema on the board so you can more easily work with the API

### User Stories >> Components

Let's say we wanted to build the foods table for our Manage Foods page. Let's not worry about creating the foods yet, just displaying the foods. Here's the relevant user story:

-   I should see a table of all my foods, with Name, Calories and a delete icon for each food

Together, let's break this down into components, props and state on the whiteboard
