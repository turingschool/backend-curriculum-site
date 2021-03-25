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
    -   We do: Creating the meal table
    -   Pairs do: Create the foods table
-   Come back together to review solutions
-   Everybody You Do
    -   You do: Build a diary page with multiple meals, and a foods list
    -   You do+: Add the create foods form
-   Come back together to review solutions
-   Split: Make the "Add to Meal" buttons
    -   We do
    -   You do with some help
    -   You do without me

Review
-------

Yesterday, we introduced some concepts, and built some React

-   What were the new concepts we covered?
-   How would you define them?
-   What is still fuzzy about React

Quantified Self in React
-----------

Let's return to our week 1 project, [Quantified Self](../projects/quantified-self/quantified-self).

Instead of using `localstorage`, I've built an API to store our data. You can access it at: <https://quantified-api.herokuapp.com/>. I'll draw the schema on the board so you can more easily work with the API

### User Stories to Components

Let's say we wanted to build the foods table for our Manage Foods page. Let's not worry about creating the foods yet, just displaying the foods. Here's the relevant user story:

-   I should see a table of all my foods, with Name, Calories and a delete icon for each food

Together, let's break this down into components, props and state on the whiteboard

### Split up options time!

Here's your options for the next step:

#### We do

Let's break down these user stories into components, and then build those components, together.

-   Each meal table has a list of foods by name and calorie
-   Each meal table has Total Calories below, which is the sum of calories for each food in that meal
-   Each meal table has Remaining Calories, which is the goal calories minus the total calories. Goal calories are as follows: 200 for Snacks, 400 for Breakfast, 600 for Lunch and 800 for Dinner
-   When I visit index.html (or just `/`), I see tables for each meal for today

#### You do

Actually build the components for the foods table that we just broke down. When that's finished, see if you can add the following stories to your application:

-   When I click "Add Food", and all fields are filled, the food will appear at the top of the table below
-   When I click the "Delete" icon next to a food, it will be removed from the list.

### Back together

Let's all come back together and review each other's solutions.

### Split again

For the next section, we're all going to have the same task, but varying levels of collaboration and instruction. You aren't locked into the option you choose in the beginning. If you'd like to move to a different group at any time, go for it.

We're going to create our "Add to" buttons for each of the meal tables. Here's the user stories:

-   When I click one of the meal buttons under the Add Selected To header, I should see any checked foods appear in the meal table for the clicked meal on the date currently being viewed.
-   After adding a food to a meal, I should see any relevant Calorie totals update.
-   After adding a food to a meal, I should see the checkboxes in the Foods table clear.

In the original project, you had separate tables to manage foods, and to add foods to the meal tables. For this lesson, it's fine to combine them into one component on the same page.

#### Guided work

I'll be with you right from the beginning. I'll guide you through most of the steps, and maybe even do some coding along. I may have to step away periodically to work with this second option

#### Head Start

You'll be on your own at first, but I'll come by to check on you periodically to make sure you aren't stuck.

#### I got this

You don't need my help, you need to get coding. I encourage you to work in pairs, and to work through the whole user stories > whiteboard > components > code process.

### Reflection and next steps

With our remaining 15 minutes, let's talk about what we've covered, and possible next steps for your relationship with React

Same questions as yesterday. Define the following React terms in your own words:

-   JSX
-   Component
-   Prop
-   State

And reflect on a few things:

-   How is React different from the front-end development you've done?
-   What surprised you about React?
-   What do you still need to learn to be an effective developer of React applications?

And also:

-   What are your next steps with React, in your capstone project and after Turing?

If you'd like to learn more about using React in Rails, [Lovisa's Creact tutorial](https://github.com/applegrain/creact) has been a trusted Turing resource for a while now.
