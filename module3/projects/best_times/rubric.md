---
layout: page
title: Best Times Project Rubric
---

## Evaluation Rubric

### Technical Presentation

* **4:** The student has a well organized presentation that addresses each point directly and uses technical vocabulary correctly throughout the presentation.
* **3:** Student presents their code and is able to talk about all of the presentation points below.
* **2:** Student presents their code and is able to talk about 3 of the presentation points, but does not discuss specific pieces of code.
* **1:** Student is unprepared for the presentation and requires prompts from the instructor to talk about the code.

Presentation Points:

- [ ] Demonstration of understanding for project's [learning goals](./index)
- [ ] Demonstration of functional completeness using Postman and live demo
- [ ] Discussion of technical quality & code organization
- [ ] Discussion of test coverage (happy and sad path and edge case testing)

### Feature Delivery

* **4:** API completely satisfies the needs of the front-end developers and is very convenient and easy to use showing great developer empathy. Project implements either caching or background workers to optimize API consumption.
* **3:** API satisfies the exact needs of the frontend developers. No unnecessary information is sent in a response.
* **2:** One of the API endpoints does not completely satisfy the needs of the front-end developers per the project requirements.
* **1:** One or more API endpoints is not functioning per the requirements (such as sending query parameters to a POST endpoint), or multiple endpoints do not satisfy the needs of the front-end developers.

### Technical Quality

* **4:**  Student can articulate how their project achieves each of the four pillars of OOP. Project meets expectations from number 3 above.
* **3:**  Project demonstrates abstraction and encapsulation in ways that make it easy to change (example: if an API changes, MapQuest to Google Maps or Yahoo Maps etc, we make changes in as few places as possible. Or POROs can be used in custom API or in standard views). Project shows a solid understanding of MVC principles (this may include but is not limited to: no logic in serializers, clean controllers, serializers and presenters to handle formatting rather than models etc.) and includes all expectations of numbers 1 and 2 above.
* **2:**  MVC is overall good but might have 1 or 2 examples of logic or hashes in the serializers, formatting in models, or controllers with complex logic. Project demonstrates some amount of abstraction and encapsulation, but may need additional refactoring to make code easy to change.
* **1:**  Project has significant gaps in understanding of MVC with several examples of logic or hashes in the serializers, controllers remain un-refactored, and models are used for formatting data.

### Testing

* **4:** Project achieves 100% test coverage and includes below expectations.
* **3:** Project achieves 90% or greater test coverage. In addition to "happy path", project also includes "sad path"/edge case testing. At least one of the tests that require an external API call make use of VCR and/or Webmock for mocking. Tests check payload content a little deeper such as inspecting data type of an attribute. Testing also checks that unnecessary information is NOT present in response data.
* **2:** Project achieves 80-90% test coverage. Project may not include "sad path" or edge case testing. Testing only checks for presence of attributes in payloads of data without inspecting further.
* **1:** Project does not achieve 80% test coverage.
