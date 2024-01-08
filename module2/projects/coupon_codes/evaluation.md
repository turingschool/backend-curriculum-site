---
layout: page
title: Coupon Codes - Evaluations
---


## Evaluation
This evaluation will be live with one instructor. 

Please be ready to walk through the front-end of your app, demonstrating coupon CRUD functionality, and seeing the overall revenue change on the merchant and admin invoice show pages. 

* Note - if your deployment is not working at the time your project is turned in, please notify your instructors what you've tried so far, and be prepared to demo on localhost.

Then, we will walk through the same steps in your code and tests. Be ready to answer questions from your instructor about how you came up with your solution, and how you might refactor. 

*Please prepare the flow of your presentation in advance.*



## Rubric

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging**                                                                                                                                                                                               |
| --- | ---------------------------------------------------------------------------------------------------------------------------| --- | --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Exceptional**  | One or more additional extension features complete. | Students implement strategies not discussed in class and can defend their design decisions (callbacks, scopes, application_helper view methods are created, etc) | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data including use of grouping, aggregating, and joining. Very little Ruby is used to process data. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students can point to multiple examples of sad paths and edge case testing that are not included in the user stories. |
| **Meets Expectations** | Coupon Codes is 100% complete| Students use the principles of MVC to effectively organize code with only 1 - 2 infractions. Routes and Actions mostly follow RESTful conventions | ActiveRecord helpers are utilized most of the time. More complex ActiveRecord (joining, grouping, aggregating) is used to process data at least once.  Queries are functional and accurate.| 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. All tests passing. TDD Process is clear throughout commits. Some effective sad path and edge case testing. Tests utilize within blocks to target specific areas of a page. |
| **Approaching Expectations** | One to two of the completion criteria for Coupon Codes are not complete | Students utilize MVC to organize code, but cannot defend some of their design decisions. 3 or more infractions are present. RESTful conventions are only sometimes followed. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective, or tests do not utilize within blocks. Doesn't include any effective sad path or edge case testing.                                |
| **Below Expectations** | More than two of the completion criteria for Coupon Codes is incomplete| Students do not effectively organize code using MVC. | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized.| Below 90% coverage for either features or models. TDD was not used.
