# Relate and Create
BE Mod 2 Week 1-2 Pair Project

## Learning Goals

### Rails

* Implement CRUD functionality for a resource using forms (form_tag), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Create routes for
  - standalone resources
  - nested resources
* Template a view in Rails using a templating language (eg, `erb`)


### ActiveRecord

* Create instance methods on a Rails model that use ActiveRecord associations
* Use ActiveRecord helpers
* Create class methods on a Rails model that can perform basic queries for all records of that model
* Use built-in ActiveRecord methods to:
* create, read, update, and destroy records in a database
* create records with relationships to other records in a database

### Databases

* Describe Database Relationships, including the following terms:
* Primary Key
* Foreign Key
* One to Many
* Write migrations to create tables and relationships between tables
* Describe ORMs and their advantages and use cases

### Testing and Debugging

* Write feature tests utilizing:
* RSpec and Capybara
* Model testing
* CSS selectors to target specific areas of a page
* Use Pry in Rails files to get more information about an error
* Use `save_and_open_page` to view the HTML generated when visiting a path in a feature test
* Utilize the Rails console as a tool to get more information about the current state of a development database
* Use `rails routes` to get additional information about the routes that exist in a Rails application

### Layout

* Create basic Web Pages using the following tags:
* `<h1>`, `<h2>`, etc.
* `<p>`
* `<body>`
* `<a>` and the `href` attribute
* `<img>` and the `src` attribute
* `<div>`
* `<section>`
* `<ul>`, `<ol>`, and `<li>`
* `<form>`
* `<input>`

### Web Applications

* Describe the HTTP request/response cycle
* Describe the different parts of HTTP requests and responses

## Requirements

- must use Rails 5.2.4.3
- must use PostgreSQL
- must "handroll" all routes (no use of `resources` syntax)
- must use `form_tag` for all forms (no use of `form_for`)

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors first

## Rubric


| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** |
| --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including edge cases, and at least one extension story completed | Students implement strategies not discussed in class to effectively organize code using POROs or sad paths and adhere to MVC | Highly effective and efficient use of ActiveRecord beyond what we've taught in class. Even `.each` calls will not cause additional database lookups (We load the data as efficiently as possible every time we visit the DB). | Very clear Test Driven Development. Test files are extremely well organized and nested. Students utilize `before :each` blocks. 100% coverage for features and models, sad path testing, and a 4 on Feature Completeness |
| **3: Passing** | Students complete all User Stories. No more than 2 Stories fail to correctly implement functionality. | Students use the principles of MVC to effectively organize code. Students can defend any of their design decisions (REST or not). | Relationships students have created make logical sense and ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data. No Ruby is used to process data. All queries functional and accurately implemented and inheritance is utilized to DRY up duplicate queries| 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. Student scored a 3 on Feature Completeness|
| **2: Passing with Concerns** | Students complete all but 3-5 User Stories | Students utilize MVC to organize code, but cannot defend some of their design decisions. | Ruby is used to process data that could use ActiveRecord instead. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. |
| **1: Failing** | Students fail to complete 12 or more User Stories | Students do not effectively organize code| Ruby is used to process data more often than ActiveRecord | Below 90% coverage for either features or models. |


---

## User Stories

Use Pets/Shelters as example throughout

Add in check-in expectations associated with story completion
## Relationships
### Design your database  

Do not use Parent/Child as your relationship

Each person will come up with their own one to many relationship. This should represent a real world example of your choice. An example would be Shelters and Pets. A Shelter has many Pets. And, thus, a Pet belongs to a Shelter. These relationships are yours to create, but we instructors are happy to provide feedback on the relationships if asked.

Use [This database design site](https://www.dbdesigner.net/) to design your database with **2** one to many relationships.

Here is an example:

![Example Design](../misc/images/db_designer_example.pdf)

```
[ ] done

User Story 1, Schema Design

 You can create as many columns on each table as you would like, but we need one boolean column, one numeric column, and at least two datetime columns represented across all tables. And, each table must have a name column.

 of a diagram made on dbdesigner.net

This will be reviewed at our first check-in
```

## CRUD Functionality
### Parent
```
[ ] done

User Story 3, Parent Index (x2)

For each parent table
As a visitor
When I visit '/parents'
Then I see the name of each parent record in the system
```

```
[ ] done

User Story 3, Parent Show (x2)

As a visitor
When I visit '/parents/:id'
Then I see the parent with that id including the parent's:
- data from each column that is on the parent table
```

```
[ ] done

User Story 4, Parent Creation (x2)

As a visitor
When I visit the Parent Index page
Then I see a link to create a new Parent record, "New Parent"
When I click this link
Then I am taken to '/parents/new' where I  see a form for a new parent record
When I fill out the form with a new parent's:
- all column data
And I click the button "Create Parent" to submit the form
Then a `POST` request is sent to the '/parents' route,
a new parent record is created,
and I am redirected to the Parent Index page where I see the new Parent displayed.
```

```
[ ] done

User Story 5, Parent Update (x2)

As a visitor
When I visit a parent show page
Then I see a link to update the parent "Update Parent"
When I click the link "Update Parent"
Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's data including:
- all column data
When I fill out the form with updated information
And I click the button to submit the form
Then a `PATCH` request is sent to '/parents/:id',
the parent's info is updated,
and I am redirected to the Parent's Show page where I see the parent's updated info
```

```
[ ] done

User Story 6, Parent Delete (x2)

As a visitor
When I visit a parent show page
Then I see a link to delete the parent
When I click the link "Delete Parent"
Then a 'DELETE' request is sent to '/parents/:id',
the parent is deleted, and all child records are deleted
and I am redirected to the parent index page where I no longer see this parent
```

---

### Children
Children can be associated to the Parent. Children belong to a parent.

```
[ ] done

User Story 7, Child Index (x2)

As a visitor
When I visit '/child_table_name'
Then I see each Child in the system including the Child's:
- all column data
```

```
[ ] done

User Story 8, Parent Childs Index (x2)

As a visitor
When I visit '/parents/:parent_id/child_table_name'
Then I see each Child that is associated with that Parent with each Child's:
- all column data
```

```
[ ] done

User Story 9, Child Show (x2)

As a visitor
When I visit '/child_table_name/:id'
Then I see the child with that id including the child's:
- all column data
```

```
[ ] done

User Story 10, Parent Child Creation (x2)

As a visitor
When I visit a Parent Childs Index page
Then I see a link to add a new adoptable child for that parent "Create Child"
When I click the link
I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
When I fill in the form with the child's:
- all column data
And I click the button "Create Child"
Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
a new child object/row is created for that parent,
and I am redirected to the Parent Childs Index page where I can see the new child listed
```

```
[ ] done

User Story 11, Child Update (x2)

As a visitor
When I visit a Child Show page
Then I see a link to update that Child "Update Child"
When I click the link
I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's data including:
- all column data
When I click the button to submit the form "Update Child"
Then a `PATCH` request is sent to '/child_table_name/:id',
the child's data is updated,
and I am redirected to the Child Show page where I see the Child's updated information
```

```
[ ] done

User Story 12, Child Delete (x2)

As a visitor
When I visit a child show page
Then I see a link to delete the child "Delete Child"
When I click the link
Then a 'DELETE' request is sent to '/child_table_name/:id',
the child is deleted,
and I am redirected to the child index page where I no longer see this child
```

---

## ActiveRecord

```
[ ] done

Order by recency
User Story 13, Records with a Datetime Column Automatically Sort by the Most Recently Created Records on Their Index Page (x2)

As a visitor
When I visit the '/parents' or '/childs' index page for a parent or child table that has a datetime column
I see the most recently created records in order by recency from top to bottom
I also see the Datetimes next to each of the records in a reasonably formatted manner

```

```
[ ] done

User Story 14, Parent Child Count (x2)

As a visitor
When I visit a parent's child_table_name index page
I see a count of the number of child_table_name associated with this parent
```

```
[ ] done

User Story 15, Boolean Column `true` Records are Displayed First on All Index Pages

As a visitor
When I visit the '/parents' or '/childs' index page for a parent or child table that has a boolean column
I see the records that have a `true` above/before the records that have a false

```

```
[ ] done

User Story 16, Display Records Over a Given Threshold if the Records Have a Numeric Column

As a visitor
When I visit the '/parents' or '/childs' index page for any parent or child table that has a numeric column
I see a form that allows me to input a number value
When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'
Then I am brought back to the current index page with only the records that meet that threshold shown.
```

```
[ ] done

User Story 17, Sort Parents by Number of Children (x2)

As a visitor
When I visit the Parents Index Page
Then I see a link to sort parents by the number of child_table_name they have
When I click on the link
I'm taken back to the Parent Index Page where I see all of the parents in order of their count of child_table_name (highest to lowest) And, I see the number of children next to each parent name
```

```
[ ] done

User Story 18, Sort Parent's Children in Alphabetical Order by name (x2)

As a visitor
When I visit the Parent's children Index Page
Then I see a link to sort children in alphabetical order
When I click on the link
I'm taken back to the Parent's children Index Page where I see all of the parents in alphabetical order
```

---

## Usability

Users should be able to use the site easily. This means making sure there are links/buttons to reach all parts of the site and the styling/layout is sensible.

```
[ ] done

User Story 19, Parent Update From Parent Index Page (x1)

As a visitor
When I visit the parent index page
Next to every parent, I see a link to edit that parent's info
When I click the link
I should be taken to that parents edit page where I can update its information just like in User Story 5
```

```
[ ] done

User Story 20, Parent Delete From Parent Index Page (x1)

As a visitor
When I visit the parent index page
Next to every parent, I see a link to delete that parent
When I click the link
I am returned to the Parent Index Page where I no longer see that parent
```

```
[ ] done

User Story 21, Child Update From Childs Index Page (x1)

As a visitor
When I visit the child_table_name index page or a parent child_table_name index page
Next to every child, I see a link to edit that child's info
When I click the link
I should be taken to that child_table_name edit page where I can update its information just like in User Story 11
```
```
[ ] done

User Story 22, Child Delete From Childs Index Page (x1)

As a visitor
When I visit the child_table_name index page or a parent child_table_name index page
Next to every child, I see a link to delete that child
When I click the link
I should be taken to the child_table_name index page where I no longer see that child
```

```
[ ] done

User Story 23, Parent Links

As a visitor
When I click on the name of a parent anywhere on the site
Then that link takes me to that Parent's show page
```

```
[ ] done

User Story 24, Child Links

As a visitor
When I click on the name a child anywhere on the site
Then that link takes me to that Child's show page
```

```
[ ] done

User Story 25, Child Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Child Index
```

```
[ ] done

User Story 26, Parent Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Parent Index
```

```
[ ] done

User Story 27, Parent Child Index Link

As a visitor
When I visit a parent show page ('/parents/:id')
Then I see a link to take me to that parent's child_table_name page ('/parents/:id/child_table_name')
```

## Extensions

dependent destroy as extension?

Search by name (exact match)

Search by name (partial match)
