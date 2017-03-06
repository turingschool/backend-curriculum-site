---
layout: page
title: Module 2
subheading: Success
---

## <center>Graduation Requirements</center>

In order to graduate from Module 2, students must complete each of the following:

-------

### Final Assessment

Students must earn a score of 3 or greater in each category of the final assessment rubric.

-------

### Group Work

Students are expected to be a contributing team member in both of their group project in module 2, and receive 3s or upward sloping trend in a lower score on the first project.

-------

### Blog Post

Write a minimum of 1 technical blog post about a topic of your choice and post it to medium, or your personal blog site.

-------

### Community Involvement

In addition to Gear Up and Posses, there are various way to contribute to the community. Students are expected to contribute in a way that most suites themselves and relay the contribution to Instructors during their portfolio review.

-------

### Professional Development

Students are expected to contribute during the Professional Development session and deliver deliverables from that session.

-------

### Non-Graded work

Module 2 is heavily weighted by non-graded work. Students are expected to participate in and deliver work that is not evaluated. If a student consistently ignores or does not finish the non-graded work in module 2 they may not complete the module or may be asked to complete work they did not finish before moving forward with the program.

These works include:

TaskManager, Blogger, Mix-Master, Mini-Project, JobTracker, Checks For Understanding, Other homeworks, and any other assigned but not evaluated materials.

------

## Skills and Topics

The following list includes everything you will see throughout the module. You should be familiar enough with the following list to at least speak about and identify each of the following in a project codebase:

1. #### Project Management & Professional Skills
  * Employ effective communication in order to facilitate collaboration.
  * Apply best practices in project management and Git workflow.
  * Effectively contribute to group projects
  * Apply good communication practices with pairs, groups, teams etc
  * Consistent punctuality to all obligations, meetings, check-ins etc
1. #### Understanding and interpret errors and error messages
  * Where in your code is there error?
  * What was the code trying to accomplish when it failed?
  * What caused it to fail?
  * Using a debugging tool like pry or byebug to sort through the error
  * "puts driven development"
1. #### Diagram and explain the MVC model and and HTTP Request - Response cycle
1. #### HTTP Fundamentals
  * 7 HTTP Verbs
  * Describe the HTTP request/response cycle
  * Explain what happens when a client visits a website
  * Request
    * URI/URL
    * Headers
    * Body
  * Response
    * Redirect / Render
    * Status Codes
    * What the common codes represent: `200`, `302`, `404`, `500` etc.
    * 1xx: Informational - Request received, continuing process
    * 2xx: Success - The action was successfully received,
      understood, and accepted
    * 3xx: Redirection - Further action must be taken in order to
      complete the request
    * 4xx: Client Error - The request contains bad syntax or cannot
      be fulfilled
    * 5xx: Server Error - The server failed to fulfill an apparently
      valid request
    * Body
1. #### HTML/CSS
  * Understand basic html tags/elements/nodes including but not limited to:
    * Forms `<form action='/path_to_submit' method='put'></form>`
      * Why do we need forms?
      * The name attribute represents what value comes through to params.
      * The value attribute represents what the the content of the form field is.
    * The innate verbs associated with specific tags:
      * link: `get`
      * button: `post`
      * form:  `put`
    * Divs `<div></div>`
    * Headers `<h1></h1>`, `<h2></h2>` ... `<h6></h6>` etc
    * Lists `<ul></ul>`, `<ol></ol>`, `<li></li>`
    * Tables `<table></table>`, `<th></th>`, `<td></td>`, `<tr></tr>`
    * Paragraphs `<p></p>`
  * Add classes and ids to html tags/elements/nodes
  * Send params through url: `'example.com/things?param1=valueOfP1&param2[nested1]=value-of-nested1&param2[nested2]=nested-value-2'`
  * Target specific HMTL content with css selectors:
    * `.class_name`
    * `#name_of_id`
    * `div`
    * `div p`
    * `div.with_this_class_name`
    * `tr#with_id_named_this`
    * `ul li:nth-child(3)`
  * Explain hierarchy/ancestry of HTML
1. #### Model Testing
  * RSpec syntax
  * data preparation/manipulation
  * validation testing
  * relationship testing
  * reading errors
1. #### Feature Testing
  * RSpec syntax
  * Capybara methods
    * `within`, `find`, `visit`, `page`, `current_path`, `have_content`, `click_on` and more
  * Big picture - What needs to be tested here?
  * Data preparation - least necessary data to represent functionality
  * Feature Exercise (visiting, clicking around, interacting as a user would interact)
  * Expectation syntax/methods
1. #### SQL
  * Writing basic sql select statements
  * Writing insertion statements
  * Calculation statements
  * Joins
  * Group
  * Order
  * .schema
1. #### Database planning, Migrations and Relationships
  * Design database schemas to represent relationships between objects
  * Clearly articulate a relational database structure ( one-to-one, one-to-many, many-to-many)
  * Write an ERD for Teams, Players, Coaches, Games
  * What tables and models do we need and what migrations do we need to get there?
    * Rails CLI generator commands
  * What methods do we need for relationships (has_many, belongs_to, through)
  * What methods do we get when we set up relationships?
  * Presence and Uniqueness Validations
1. #### Views
  * Enough HTML to create headers, paragraphs, tables, and lists in a view.
  * How to use erb tags in a view to display information.
  * How to iterate over a collection of ActiveRecord objects in a view.
  * How to create a form in a view using Ruby, including a form using nested resources.
1. #### Controllers
  * Inspect and understand params. Where they come from and what they contain.
  * How to prepare data for your views.
  * How to use strong params.
  * Refactoring best practice for MVC ( fat models skinny controllers )
1. #### Routes
  * 7 Restful routes - verb path combinations - for a resource
  * How to create routes using `resources`
  * How to handwrite a route
  * route_helpers (ex. `edit_item_path(item)`)
  * Explain what each column of the `rake routes` output represents and allows the developer to do.
  * `:only` `:except`
  * Route modifiers: `:module`, `:path`, `:scope`
  * `namespace` and nested `resources`
1. #### ActiveRecord
  * ActiveRecord query methods - differences between `find` `find_by` and `where`
  * Difference between class and instance methods
  * Calculation methods
  * Creating associated records with AR. Connecting records with AR methods
  * Understand how AR `create` and a `new` instance + `save` are related
  * Knowing where and when to include an instance method for an ActiveRecord model
  * What methods do we need for relationships (has_many, belongs_to, through)
  * What methods do we get when we set up relationships
  * Validations - Presence, Uniqueness
  * Use AR relationship methods within ActiveRecord/Model instance methods
  * Use AR relationship methods within ActiveRecord/Model class methods
  * Scopes
