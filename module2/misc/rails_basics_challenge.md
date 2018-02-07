---
layout: page
title: Rails Basics Challenge
---

## Learning Goals

* Practice creating a rails application from scratch

## Overview

Create a new rails project from your command line and implement the following user stories. Feel free to review any documentation/projects you have at your disposal.

### Students

Let's start by creating students alone. You should TDD throughout. Styling is also not required for this particular exercise.

#### User Can See an Individual Student

* As a user
* When I visit `/students/:id`
* I see the name of a student

#### User Can See a List of Students

* As a user
* When I visit `/students`
* I see a list of student names

#### User Can Create a Student

* As a user
* When I visit `/students/new`
* And I fill in name
* And I click submit
* I am on the student show page
* And I see that student's name

#### User Can Edit a Student

* As a user
* When I visit `/students/:id/edit`
* And I enter a new name
* And I click submit
* I am on the student show page
* And I can see that student's new name

#### User Can Delete a Student

* As a user
* When I visit `/students`
* And I click "Delete" next to a student's name
* I see the students index
* And that student's name is no longer on the page

#### Navigation

* As a user
* When I visit any page
* I see links to see a list of all students, or create a new student

* As a user
* When I visit `/students`
* And I click on a student's name
* I am taken to a show page for that student

### Addresses (One-to-Many)

Let's add addresses to this application. In this particular scenario assume that a student can have many addresses (i.e. maybe they have a current address, a permanent address, a parent address, a summer address, etc.), and that an address belongs to *only* one student. This might not be a real-life situation (what about brothers and sisters at the same school?), but go with it. For today, this will be a one-to-many relationship.

#### Creating a New Address

* As a user
* When I visit `/students/:id/addresses/new`
* And I fill in description with a description (e.g. "Summer Address")
* And I fill in street with a street address
* And I fill in city with a city
* And I fill in state with a state
* And I fill in zip code with a zip code
* And I click submit
* I am taken to that student's show page
* And I see the description, street, city, state, and zip on that page

#### Student has Many Addresses

* As a user
* When I visit `/students/:id`
* I see all addresses associated with that student (e.g. if that student has two addresses, I see both)

### Courses (Many-to-Many)

Now we want to check that a student can be enrolled in classes. For this section, don't worry about creating a new course. Assume that all courses will be created in the database by an administrator. Also assume that all enrollments (e.g. the particular courses a student will be taking) will be created by an adminstrator. For now, implement the stories below that allow you to view existing relationships.

### Student has Many Courses

* As a user
* When I visit `/students/:id`
* I can see a list of courses that student is taking

### Courses Have Many Students

* As a user
* When I visit `/courses/:id`
* I see the name of that course
* And a list of students enrolled in that course

