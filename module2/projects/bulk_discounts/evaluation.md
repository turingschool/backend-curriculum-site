---
layout: page
title: Bulk Discounts - Evaluations
---


## Evaluation
This evaluation will be live with one instructor. Below are the presentation points expected in your evaluation

- [ ] Demonstration of functional completeness: How to add a bulk discount, edit that discount, and see the overall revenue change on invoices. 
- [ ] Walkthrough/Discussion of Technical Quality and Code Organization
- [ ] Discussion of Problem Solving: Focusing on user stories 6-8, how did you arrive at your solutions? What steps did you take to break down the problem into manageable chunks? What was the most challenging piece of these stories?
- [ ] Discussion of test coverage: Happy & Sad Path


**Please prepare the flow of your presentation in advance**.

## Rubric

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging**                                                                                                                                                                                               | **Technical Presentation** |
| --- | ---------------------------------------------------------------------------------------------------------------------------| --- | --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| **Exceptional**  | One or more additional extension features complete. | Students implement strategies not discussed in class and can defend their design decisions (callbacks, scopes, application_helper view methods are created, etc) | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data including use of grouping, aggregating, and joining. No Ruby is used to process data. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students can point to multiple examples of edge case testing that are not included in the user stories. | The student has a well organized presentation that addresses each point directly, uses technical vocabulary correctly throughout the presentation, and can speak to the iterations of their progress on complex queries using visuals. |
| **Meets Expectations** | Bulk discount is 100% complete| Students use the principles of MVC to effectively organize code with only 1 - 2 infractions. Routes and Actions mostly follow RESTful conventions | ActiveRecord helpers are utilized most of the time. ActiveRecord grouping, aggregating, and joining is used to process data at least once.  Queries are functional and accurate. Very little Ruby is used to process data | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. All tests passing. TDD Process is clear throughout commits. Some sad path and edge case testing. Tests utilize within blocks to target specific areas of a page. | Student has a well-organized presentation that addresses each presentation point directly, and can speak to how they arrived at their solutions to the complex, logic-heavy user stories. |
| **Approaching Expectations** | One to two of the completion criteria for Bulk Discount features are not complete | Students utilize MVC to organize code, but cannot defend some of their design decisions. 3 or more infractions are present. RESTful conventions are only sometimes followed. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective, or tests do not utilize within blocks. Missing sad path or edge case testing.                                | Student presents their code and is able to talk about 3 of the presentation points, but does not speak to how they arrived at complex solutions in their code. |
| **Below Expectations** | More than two of the completion criteria for Bulk Discount feature is incomplete| Students do not effectively organize code using MVC. | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized.| Below 90% coverage for either features or models. TDD was not used. | Student is unprepared for the presentation and requires prompts from the instructor to talk about the code. 
