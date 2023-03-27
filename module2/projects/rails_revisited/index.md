---
layout: page
title: Rails Revisited
---

This project is an extension of the Relational Rails solo project. You will add a new relationship to your existing Parent/Child schema design. 

## Learning Goals

* Refactor an existing codebase and bring all existing **features & tests** up to quality expectations for the end of the mod
* Design a many-to-many relationship using a schema designer, and implement it into an existing application.
* Write migrations to create tables and relationships between tables.
* Implement CRUD functionality for a resource using forms & any applicable View Helpers (form_with, button_to, etc.)
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Use querying skills (SQL & AR) effectively to join multiple tables of data, make calculations, and group data based on one or more attributes

## Deets

* This is a solo project, to be completed alone without assistance from cohortmates, alumni, mentors, rocks, etc.
* Additional gems to be added to the project must have instructor approval. (RSpec, Capybara, Shoulda-Matchers, Orderly, HTTParty, Launchy, Faker and FactoryBot are pre-approved)
* Scaffolding is not permitted on this project.

## Setup

This project is an extension of [Relational Rails](projects/../relational_rails/). Students have two options for setup:

1. If you were able to get through Iteration 2 in your Relational Rails project, you can use it as a starting point for this project. 
1. If you were unable to get through Iteration 1 of Relational Rails project, contact your instructors so they can provide you with a different repo to build off of for this final project. 


## Requirements

- Must use Ruby 3 & Rails 7
- Must use PostgreSQL
- Must use `resources` syntax
- Must deploy completed application to Heroku
- Must have 100% coverage in both features and models, including model validations and sad path testing.
- Must include a README with the project, including a description of the base app and high-level details of the refactoring process (a “change log”). 
- Must use `form_with @model` syntax


## Evaluation
Evaluation information for this project can be found [here](./evaluation).


## Task 1: Refactoring
1. Routes should use all `resources` syntax, no hand-rolled routes
2. Forms (New and Edit) should use `form_with @model` syntax.
3. Fix any MVC violations (data logic in views or controllers, Ruby in AR methods, etc.)
    - Document these fixed violations by either: 
        1. Keeping a **Changelog** section in your ReadMe
        2. Use Issues in a project board 
4. Testing should be at 100% for both features and models before starting new user stories.
    - Reminder: Run `rspec spec/models` and `rspec spec/features` to test your model and feature coverage independently from each other. 


## Task 2: Database Setup
1. Looking at your original Parent-Child relationship, design an additional Tertiary model that may relate to your Parent-Child in some way.
    - Example 1: Shelters (parent) to Pets (children) may have a FosterParents table.
    - Example 2: Bike Shops (parent) to Employees (children) might have a Brands table.
2. Then, create many-to-many relationship(s) that makes sense with your app idea. Add this to your original schema design and include a screenshot of the design in your repo.
    - Example 1: Pets can have many FosterParents, FosterParents can have many Pets.
    - Example 2: Bike Shops have many Brands that they carry, Brands are sold at many Bike Shops
3. Your additional Model should include the following datatypes:
    - Primary key (ID, integer)
    - Name (string)
    - Integer (primary key does not count)
    - Boolean



## Task 3: User Stories

Once you've decided what your 3rd model will be, and which existing table it will have a `many-to-many` relationship with, you'll need to come up with your User Stories. 

Overall, you should have **AT LEAST** 9 User Stories. Those User Stories must contain the following:

- 6 User Stories - CRUD functionality
    1. New Model Index 
    2. New Model Show 
    3. New Model Create 
    4. New Model Update 
    5. New Model Destroy 
    6. Associate New Model with Existing Table
        - Ex: If I had the tables of Schools(Parent), Students(Child), and Clubs(New Model), and my `many-to-many` relationship is between Students and Clubs. I will implement functionality such that a Student can be added to an Existing Club OR a Club can add an existing Student. 
- 2 User Stories - Advanced ActiveRecord 
    * Demonstrate your understanding of Advanced ActiveRecord by coming up with 2 AR Queries to display within your Web App. 
        - Ex: If I had the tables of SkiShops(Parent), Employees(Child), and Brands(New Model), and my `many-to-many` relationship is between SkiShops and Brands. I might come up with the following functionality to demonstrate my understanding of ActiveRecord:
            1. On the Employee Show Page, display Brands that the employee has current experience selling.
            2. On Brands Index Page, list out Brands in order of popularity (number of ski shops carrying that brand).
- 1 User Story - API Consumption
    * Use the Next Public Holidays Endpoint in the [Nager.Date API]("https://date.nager.at/swagger/index.html") to list out upcoming Holidays. This can be displayed on whatever page you choose would be best to display this information.




**If you need help coming up with user stories, you can try using the User Story Generator below. Keep in mind, you might need to tweak them to fit your exact scenario, but you might find them useful in at least getting started.** <br>

<label>Enter your <b>Existing Parent Model</b> name (singular): </label>
<input type="text" id="parent_model_name_input"> <br>

<label>Enter your <b>Existing Child Model</b> name (singular): </label>
<input type="text" id="child_model_name_input"> <br>

<label>Enter your <b>New Model</b> name (singular): </label>
<input type="text" id="new_model_name_input"> <br>

<label>Will your New Model have a many-to-many relationship with your Parent Model or Child Model?
<select id="related_table_type_input">
  <option value="parent">Parent</option>
  <option value="child">Child</option>
</select>

<br>
<button id="tertiary-btn" type="submit" onclick="updateUserStories()">Generate User Stories</button>

<div id="child_many_to_many_html"></div>
<div id="parent_many_to_many_html"></div>

<script>
    $(function() {
        $("#child_many_to_many_html").load("child_many_to_many.html");
        $("#parent_many_to_many_html").load("parent_many_to_many.html");
    });
</script>
<script src="./index.js"></script>