---
layout: page
title: Rails Basics Challenge
---

## Learning Goals

* Practice creating a Rails application from scratch
* Turning User Stories into tests
* Using tests to drive development

## Requirements

- Try to commit code every 15 minutes at a minimum, push to GitHub often
- When finished, send a private message to all of your instructors with your Git repo
- TDD Throughout. Tests should cover all features and all model-level validations and class/instance methods on your models
- include Simplecov, code coverage should be 90% or better

---

# READ ALL OF THE THE USER STORIES BEFORE YOU BEGIN!!

---

## Grading/Rubric

- We're mostly concerned that you're getting the features finished
- Grading also includes:
  - optimal database setup
  - good migrations
  - strong ActiveRecord relationships
  - complete testing at a feature AND model level

**Styling is also not required for this particular exercise.** If you choose to make your code to look nicer, please do so AFTER you finish all other user stories.


## Overview

Create a new Rails project from your terminal, and implement the following user stories.

Feel free to review any documentation/projects you have at your disposal. (this is "open-book")

## User Stories


#### User Can See an Individual Student

```
User Story 1 of 11

As a user
When I visit `/students/:id`
I see the name of a student
```

#### User Can See a List of Students

```
User Story 2 of 11

As a user
When I visit `/students`
I see a list of student names
```

#### User Can Create a Student

```
User Story 3 of 11

As a user
When I visit `/students/new`
And I fill in name
And I click submit
I am on the student show page
And I see that student's name
```

#### User Can Edit a Student

```
User Story 4 of 11

As a user
When I visit `/students/:id/edit`
And I enter a new name
And I click submit
I am on the student show page
And I can see that student's new name
```

#### User Can Delete a Student

```
User Story 5 of 11

As a user
When I visit `/students`
And I click "Delete" next to a student's name
I see the students index
And that student's name is no longer on the page
```

#### Navigation

```
User Story 6 of 11

As a user
When I visit any page
I see links to see a list of all students, or create a new student
```

```
User Story 7 of 11

As a user
When I visit `/students`
And I click on a student's name
I am taken to a show page for that student
```

### Addresses (One-to-Many)

Let's add addresses to this application. In this particular scenario assume that a student can have many addresses (i.e. maybe they have a current address, a permanent address, a parent address, etc.), and that an address belongs to *only* one student (no students share an address). For today, this will be a one-to-many relationship.

#### Creating a New Address

```
User Story 8 of 11

As a user
When I visit `/students/:id/addresses/new`
And I fill in description with a description (e.g. "Summer Address")
And I fill in street with a street address
And I fill in city with a city
And I fill in state with a state
And I fill in zip code with a zip code
And I click submit
I am taken to that student's show page
And I see the description, street, city, state, and zip on that page
```

#### Student has Many Addresses

```
User Story 9 of 11

As a user
When I visit `/students/:id`
I see all addresses associated with that student (e.g. if that student has two addresses, I see both)
```

### Courses (Many-to-Many)

Now we want to check that a student can be enrolled in classes. For this section, don't worry about creating a new course. Assume that all courses will be created in the database by an administrator. Also assume that all enrollments (e.g. the particular courses a student will be taking) will be created by an adminstrator. For now, implement the stories below that allow you to view existing relationships.

### Student has Many Courses

```
User Story 10 of 11

As a user
When I visit `/students/:id`
I can see a list of courses that student is taking
```

### Courses Have Many Students

```
User Story 11 of 11

As a user
When I visit `/courses/:id`
I see the name of that course
And a list of students enrolled in that course
```
