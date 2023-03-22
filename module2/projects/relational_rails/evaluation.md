---
layout: page
title: Relational Rails - Evaluation
---

_[Back to Relational Rails home](./index)_

## Peer Code Share
As part of the evaluation, students will be required to complete a peer code share. Instructions can be found [here](./peer_code_share).

## Evaluation
Students will meet 1:1 with an instructor after the project is turned in. Be prepared to: 
* Run tests (`bundle exec rspec spec/models` and `bundle exec rspec spec/features`)
* Show your schema & relationships
* Choose a user story to walk through and explain at a high level how your solution works.
  * Note: "high level" in this sense doesn't mean *reading* the code out loud. Instead, try to describe what the code you wrote is doing in your own words. 
* Feel free to ask any remaining questions you have during this evaluation time. 

## Rubric


| | **Feature Completeness** | **Rails** | **Database Design** | **ActiveRecord** | **Testing and Debugging** |
| --- | --- | --- | --- | --- | --- |
| **Exceptional**  | All User Stories 100% complete including edge cases, and at least one extension story completed | Students use the principles of MVC to effectively organize code. | Clear schema design with detailed and accurate diagram. Migration history reflects table alterations not taught in class. All data types in the schema make logical sense. | Inheritance is utilized to DRY up duplicate queries. | 100% coverage for features and models. Either a gem that enhances testing effectiveness is implemented (orderly, factorybot, faker, etc) or within blocks are used throughout tests. |
| **Meets Expectations** | Students complete all User Stories. No more than 2 Stories fail to correctly implement functionality. | Students can defend any of their design decisions. Routing is organized and consistent and demonstrates use of some RESTful principles. Students can describe how data is passed in their application.| Relationships modeled in the database correctly. Appropriate use of foreign keys. Schema design accurately represents actual database schema and design document is linked in the README | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data. No Ruby is used to process data. All queries functional and accurately implemented.| 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. Students can point to the difference between integration and unit testing. |
| **Approaching Expectations** | Students fail to complete 3-5 User Stories. | Students cannot defend some of their design decisions. Students inaccurately describe how some of their data is passed through their application. Routes don't demonstrate any use of RESTful design. | Some errors in database schema. Schema diagram lacks detail or accurate representation in database. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. |
| **Below Expectations** | Students fail to complete 6 or more User Stories. | Students do not effectively organize code. | Poor diagram design. Relationships do not make sense or not accurately modeled in the database. Many errors in database schema. | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized. | Below 90% coverage for either features or models. |
