---
layout: page
title: Rails Revisited - Evaluations
---


<style>
summary:hover {
  background-color: #bbe5fa;
}
</style>
  

## Evaluation

This evaluation will be live with one instructor. It is a requirement that you come prepared to give a presentation that demonstrates your understanding and competancy of the learning goals for this project. We suggest spending about **1 hour** to prep for this evaluation. 

It is ultimately up to you how you'd like to present your project, but we've provided an example of a good presentation outline below. Click each header to see more details pop up. 


<details markdown="1"><summary><h3> 👋🏾 1. Introduce your application (30 seconds)</h3></summary>

* What does your project do? 
    - This shouldn't be technical, just a quick description of what the app does. You can think of it like a project description you'd put on a resume. (Ex: "This app keeps track of students across multiple schools, and also allows students to sign up for clubs that are at their school")
</details>
<details markdown="1"><summary><h3> 🧑🏼‍🎨 2. Talk through database design (1 minute)</h3></summary>

* Pull up your schema.
* Talk through the tables/relationship that you started with.
* Explain the new tables/relationships that you added for this project, and how they relate to one (or both) of your original two tables you had when starting this project.
</details>
<details markdown="1"><summary><h3> 💁🏿 3. Demo your app (2 minutes)</h3></summary>

* Pull up your app in the browser and demonstrate your **new** functionality.
    * **THIS IS SOMETHING YOU NEED TO PRACTICE!**
        - Plan out a flow for how you want to demonstrate the user's experience for your application. You want this to be as seamless and efficient as possible. 
        - You do not need to talk about your code at this point, you should just be demoing the user experience. 
</details>
<details markdown="1"><summary><h3> 🔄 4. Talk through how you refactored your code (4 minutes)</h3></summary>

 * Pull up your changelog/projectboard to show how you organized the refactors that you needed to make for this project. 
 * Switch back to your code, pull up your `routes.rb` file, an example of a form refactor, and 1 other area of code where you made a MVC refactor.
* For each instance that you show above, give a brief explanation as to why you made that refactor. For example, did that refactor better align with a particular pillar of OOP, or maybe better rails/ruby convention?
</details>
<details markdown="1"><summary><h3> 💯 5. Show your testing coverage (1 minute)</h3></summary>

* Run `bundle exec rspec spec/models` to show your coverage percentage for your models.
* Run `bundle exec rspec spec/features` to show your coverage percentage for your features.
* If either of the percentages are below 100%, pull up your coverage report to show what was not tested. (`open coverage/index.html`)
</details>

<details markdown="1"><summary><h3> 🗣 6. Talk through 1 CRUD user story (3 minutes)</h3></summary>

 * Choose a CRUD user story that you are most proud of. 
    - Talk through the test(s) and the code for that feature.
        * This should be a high level overview of your code implementation. You should not talk through your code line by line, but rather, talk through the flow of your code, and the responsibilities of the methods/files that your flow passes through. 
        <details markdown="1"><summary><h4>✅ Examples of what a high-level explanation might sound like</h4></summary>

        **Example 1:**
        ```
        When a user clicks on the button to add a student to a teacher's roster, a POST request is sent to /student_teachers and the student id and the teacher id are sent in the body of the request. That route takes me to the create action in my StudentTeacherController, which creates a new resource in my student_teachers table for that teacher and that student. And then, upon successful creation of that new resource, I redirect back to the teacher's show page.
        ```

        **Example 2:**
        ```
        To test this feature, I tested that when a user navigates to a teachers show page, and adds a new student via the form on the page, that they're redirected to the Teacher Show Page and they can see that new student appear on that teacher's roster list. I also make sure that a new StudentTeacher resource is added in my database. 
        ```
        </details>
        <details markdown="1"><summary><h4>❌ Examples of what a line-by-line explanation might sound like</h4></summary>

        **Example 1:**
        ```
        I created a route for POST /student_teachers which goes to the create action in the StudentTeachersController. In the create action, first, I get the teacher id by doing params[:teacher_id] and save that into a variable called teacher_id. Then, I get the student id by doing params[:student_id] and saving that into a variable called student_id. Then, I call StudentTeacher.new, and pass in teacher_id and student_id. Then on the last line I call redirect_to and I redirect to teacher_path and pass in the teacher id.
        ```

        **Example 2:**
        ```
        To test this feature, I made a "describe" block for "Student Teacher Creation" and then I made an "it" block within that "describe" block, called "Teacher can add a student to their roster". First, I created a teacher and saved that into a variable called "teacher", and then I went to that teachers show page by doing  "visit teacher_path" and passing in the teacher variable that I have on the line above.... 
        ```
        </details>

</details>
<details markdown="1"><summary><h3> 🤯 7. Talk through 1 Advanced ActiveRecord query (1 minute)</h3></summary>

* Describe the functionality you needed the query for.
* Pull up your code for the query, and talk about what it's doing.
</details>
<details markdown="1"><summary><h3> 🎉 8. Talk through your implementation of the API story (2 minutes)</h3></summary>

* This should also be explained at a high level, just like the CRUD user story. 
</details>
<details markdown="1"><summary><h3> 🙋🏻‍♀️ 9. Ask a Question </h3></summary>

* What's something you'd like feedback on? 
</details>


## Rubric

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging**                                                                                                                                                                                               |
| --- | ---------------------------------------------------------------------------------------------------------------------------| --- | --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Exceptional**  | One or more additional extension features complete. | Students implement strategies not discussed in class and can defend their design decisions (callbacks, scopes, application_helper view methods are created, etc) | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data including use of grouping, aggregating, and joining. Very little Ruby is used to process data. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students can point to multiple examples of edge case testing that are not included in the user stories. |
| **Meets Expectations** | All 3 tasks are 100% complete| Students use the principles of MVC to effectively organize code with only 1 - 2 infractions. Routes and Actions mostly follow RESTful conventions | ActiveRecord helpers are utilized most of the time. ActiveRecord grouping, aggregating, and joining is used to process data at least once.  Queries are functional and accurate.| 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. All tests passing. TDD Process is clear throughout commits. Some sad path and edge case testing. Tests utilize within blocks to target specific areas of a page. |
| **Approaching Expectations** | Tasks 1 and 2 are complete, but one or two user stories from Task 3 are not complete/functional | Students utilize MVC to organize code, but cannot defend some of their design decisions. 3 or more infractions are present. RESTful conventions are only sometimes followed. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective, or tests do not utilize within blocks. Missing sad path or edge case testing.                                |
| **Below Expectations** | Tasks 1 and 2 are complete may or may not be complete, and three or more user stories from Task 3 are not complete/functional| Students do not effectively organize code using MVC. | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized.| Below 90% coverage for either features or models. TDD was not used.
