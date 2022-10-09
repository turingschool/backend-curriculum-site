---
layout: page
title: Relational Rails
---

## Learning Goals

* Design a one-to-many relationship using a schema designer.
* Write migrations to create tables with columns of varying data types and foreign keys.
* Use Rails to create web pages that allow users to CRUD resources.
* Create instance and class methods on a Rails model that use ActiveRecord methods and helpers.
* Write model and feature tests that fully cover data logic and user behavior.

## Requirements

- must use Rails 5.2.x
- must use PostgreSQL
- must "handroll" all routes (no use of `resources` syntax)

## Permission

- If there is a specific gem you'd like to use in this project that is not mentioned on this project page, you must get permission from your instructors first.

## Setup
Students should create their own new Rails app for this project. Students can reference the [Task Manager tutorial app](https://github.com/turingschool-examples/task_manager_rails) for how to set up a new Rails project. 

Students must host their code in a new repository on GitHub. 

## Peer Code Share
As part of the evaluation, students will be required to complete a peer code share. Instructions can be found [here](./peer_code_share.html).

## Evaluation
Students will meet 1:1 with an instructor after the project is turned in. Be prepared to: 
* Run tests (`bundle exec rspec spec/models` and `bundle exec rspec spec/features`)
* Show your schema & relationships
* Choose a user story to walk through and explain at a high level how your solution works.

## Rubric


| | **Feature Completeness** | **Rails** | **Database Design** | **ActiveRecord** | **Testing and Debugging** |
| --- | --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including edge cases, and at least one extension story completed | Students use the principles of MVC to effectively organize code. | Clear schema design with detailed and accurate diagram. Migration history reflects table alterations not taught in class. All data types in the schema make logical sense. | Inheritance is utilized to DRY up duplicate queries. | 100% coverage for features and models. Either a gem that enhances testing effectiveness is implemented (orderly, factorybot, faker, etc) or within blocks are used throughout tests. |
| **3: Passing** | Students complete all User Stories. No more than 2 Stories fail to correctly implement functionality. | Students can defend any of their design decisions. Routing is organized and consistent and demonstrates use of some RESTful principles. Students can describe how data is passed in their application.| Relationships modeled in the database correctly. Appropriate use of foreign keys. Schema design accurately represents actual database schema and design document is linked in the README | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data. No Ruby is used to process data. All queries functional and accurately implemented.| 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. Students can point to the difference between integration and unit testing. |
| **2: Passing with Concerns** | Students fail to complete 3-5 User Stories. | Students cannot defend some of their design decisions. Students inaccurately describe how some of their data is passed through their application. Routes don't demonstrate any use of RESTful design. | Some errors in database schema. Schema diagram lacks detail or accurate representation in database. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. |
| **1: Failing** | Students fail to complete 6 or more User Stories. | Students do not effectively organize code. | Poor diagram design. Relationships do not make sense or not accurately modeled in the database. Many errors in database schema. | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized. | Below 90% coverage for either features or models. |

---

## Relationships

### Design your database  

Read [this lesson plan](https://backend.turing.edu/module2/lessons/one_to_many_relationships) and use it as a reference when designing your database.

Each student will come up with their own one-to-many relationship. This should represent a real world example of your choice. An example would be:
- Shelters and Pets
- A Shelter has many Pets
- A Pet belongs to one Shelter.

Do not use "Parent"/"Child" as your relationship.

These relationships are yours to create, but instructors are happy to provide feedback on the relationships if asked.

Use [This database design site](https://www.dbdesigner.net/) to design your database with your one-to-many relationships.

Here is an example diagram:

![Example Design](../misc/images/adopt_dont_shop_db_design.jpeg)

You can create as many columns on each table as you would like, but we need a few columns represented on each table:

1. One string column for a 'name'
1. One boolean column
1. One numeric column
1. Two DateTime columns: `created_at` and `updated_at`

A couple of things to keep in mind as you're designing your schema:

* Foreign Keys do not count as an integer column.
* You should not create columns that duplicate data. For example, in Pets/Shelters, a Shelter should not store a "pet_count" column since the count of Pets can also be found by counting the number of associated pets.

**Schema Design will be reviewed as part of our first check-in.**

--------

## User Stories

In these stories, we will refer to the "one" side of the relationship as the "parent" and the "many" side of the relationship as the "children/child". In the Pets/Shelters example, Shelter would be the Parent and Pets would be the Children.

Children can be associated to the Parent. Children belong to a parent. Anywhere you see `child_table_name` think `pets` from our Pets and Shelters example.

Each user story will focus on one of the following:

* __ActiveRecord__
* __CRUD Functionality__
* __Usability__: Users should be able to use the site easily. This means making sure there are links/buttons to reach all parts of the site and the styling/layout is sensible.

_Note_: When writing code for each user story, it is important to go in numerical order; don't jump around. You may notice some later user stories "overwriting" earlier stories - this is intentional and mimics what you may experience on the job when working with real clients. 

## Iteration 1

##### CRUD

```
[ ] done

User Story 1, Parent Index 

For each parent table
As a visitor
When I visit '/parents'
Then I see the name of each parent record in the system
```

```
[ ] done

User Story 2, Parent Show 

As a visitor
When I visit '/parents/:id'
Then I see the parent with that id including the parent's attributes
(data from each column that is on the parent table)
```

```
[ ] done

User Story 3, Child Index 

As a visitor
When I visit '/child_table_name'
Then I see each Child in the system including the Child's attributes
(data from each column that is on the child table)
```

```
[ ] done

User Story 4, Child Show 

As a visitor
When I visit '/child_table_name/:id'
Then I see the child with that id including the child's attributes
(data from each column that is on the child table)
```

```
[ ] done

User Story 5, Parent Children Index 

As a visitor
When I visit '/parents/:parent_id/child_table_name'
Then I see each Child that is associated with that Parent with each Child's attributes
(data from each column that is on the child table)
```

##### ActiveRecord

```
[ ] done

User Story 6, Parent Index sorted by Most Recently Created 

As a visitor
When I visit the parent index,
I see that records are ordered by most recently created first
And next to each of the records I see when it was created
```

```
[ ] done

User Story 7, Parent Child Count

As a visitor
When I visit a parent's show page
I see a count of the number of children associated with this parent
```

##### Usability

```
[ ] done

User Story 8, Child Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Child Index
```

```
[ ] done

User Story 9, Parent Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Parent Index
```

```
[ ] done

User Story 10, Parent Child Index Link

As a visitor
When I visit a parent show page ('/parents/:id')
Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
```

**Iteration 1 will be reviewed at your second check-in**

---

## Iteration 2

##### CRUD

```
[ ] done

User Story 11, Parent Creation 

As a visitor
When I visit the Parent Index page
Then I see a link to create a new Parent record, "New Parent"
When I click this link
Then I am taken to '/parents/new' where I  see a form for a new parent record
When I fill out the form with a new parent's attributes:
And I click the button "Create Parent" to submit the form
Then a `POST` request is sent to the '/parents' route,
a new parent record is created,
and I am redirected to the Parent Index page where I see the new Parent displayed.
```


```
[ ] done

User Story 12, Parent Update 

As a visitor
When I visit a parent show page
Then I see a link to update the parent "Update Parent"
When I click the link "Update Parent"
Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
When I fill out the form with updated information
And I click the button to submit the form
Then a `PATCH` request is sent to '/parents/:id',
the parent's info is updated,
and I am redirected to the Parent's Show page where I see the parent's updated info
```

```
[ ] done

User Story 13, Parent Child Creation 

As a visitor
When I visit a Parent Children Index page
Then I see a link to add a new adoptable child for that parent "Create Child"
When I click the link
I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
When I fill in the form with the child's attributes:
And I click the button "Create Child"
Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
a new child object/row is created for that parent,
and I am redirected to the Parent Childs Index page where I can see the new child listed
```

```
[ ] done

User Story 14, Child Update 

As a visitor
When I visit a Child Show page
Then I see a link to update that Child "Update Child"
When I click the link
I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
When I click the button to submit the form "Update Child"
Then a `PATCH` request is sent to '/child_table_name/:id',
the child's data is updated,
and I am redirected to the Child Show page where I see the Child's updated information
```

##### ActiveRecord

```
[ ] done

User Story 15, Child Index only shows `true` Records 

As a visitor
When I visit the child index
Then I only see records where the boolean column is `true`
```

```
[ ] done

User Story 16, Sort Parent's Children in Alphabetical Order by name 

As a visitor
When I visit the Parent's children Index Page
Then I see a link to sort children in alphabetical order
When I click on the link
I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
```

##### Usability

```
[ ] done

User Story 17, Parent Update From Parent Index Page 

As a visitor
When I visit the parent index page
Next to every parent, I see a link to edit that parent's info
When I click the link
I should be taken to that parent's edit page where I can update its information just like in User Story 12
```

```
[ ] done

User Story 18, Child Update From Childs Index Page 

As a visitor
When I visit the `child_table_name` index page or a parent `child_table_name` index page
Next to every child, I see a link to edit that child's info
When I click the link
I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14
```

---

## Iteration 3

##### CRUD

```
[ ] done

User Story 19, Parent Delete 

As a visitor
When I visit a parent show page
Then I see a link to delete the parent
When I click the link "Delete Parent"
Then a 'DELETE' request is sent to '/parents/:id',
the parent is deleted, and all child records are deleted
and I am redirected to the parent index page where I no longer see this parent
```

```
[ ] done

User Story 20, Child Delete 

As a visitor
When I visit a child show page
Then I see a link to delete the child "Delete Child"
When I click the link
Then a 'DELETE' request is sent to '/child_table_name/:id',
the child is deleted,
and I am redirected to the child index page where I no longer see this child
```

##### ActiveRecord

```
[ ] done

User Story 21, Display Records Over a Given Threshold 

As a visitor
When I visit the Parent's children Index Page
I see a form that allows me to input a number value
When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'
Then I am brought back to the current index page with only the records that meet that threshold shown.
```

##### Usability

```
[ ] done

User Story 22, Parent Delete From Parent Index Page 

As a visitor
When I visit the parent index page
Next to every parent, I see a link to delete that parent
When I click the link
I am returned to the Parent Index Page where I no longer see that parent
```

```
[ ] done

User Story 23, Child Delete From Childs Index Page 

As a visitor
When I visit the `child_table_name` index page or a parent `child_table_name` index page
Next to every child, I see a link to delete that child
When I click the link
I should be taken to the `child_table_name` index page where I no longer see that child
```
---

## Extensions

```
[ ] done

Extension 1: Sort Parents by Number of Children 

As a visitor
When I visit the Parents Index Page
Then I see a link to sort parents by the number of `child_table_name` they have
When I click on the link
I'm taken back to the Parent Index Page where I see all of the parents in order of their count of `child_table_name` (highest to lowest) And, I see the number of children next to each parent name
```

```
[ ] done

Extension 2: Search by name (exact match)

As a visitor
When I visit an index page ('/parents') or ('/child_table_name')
Then I see a text box to filter results by keyword
When I type in a keyword that is an exact match of one or more of my records and press the Search button
Then I only see records that are an exact match returned on the page
```

```
[ ] done

Extension 3: Search by name (partial match)

As a visitor
When I visit an index page ('/parents') or ('/child_table_name')
Then I see a text box to filter results by keyword
When I type in a keyword that is an partial match of one or more of my records and press the Search button
Then I only see records that are an partial match returned on the page

This functionality should be separate from your exact match functionality.
```
