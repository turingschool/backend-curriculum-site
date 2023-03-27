---
layout: page
title: Lunch and Learn Project Rubric
---

## Evaluation Rubric

### Technical Presentation

* **Exceeds Expectations:** The student has a well organized presentation that addresses each point directly and uses technical vocabulary correctly throughout the presentation.
* **Meets Expectations:** Student presents their code and is able to talk about all of the presentation points below.
* **Approaching Expectations:** Student presents their code and is able to talk about 3 of the presentation points, but does not discuss specific pieces of code.
* **Below Expectations:** Student is unprepared for the presentation and requires prompts from the instructor to talk about the code.

Presentation Points:

- [ ] Demonstration of understanding for project's [learning goals](./index)
- [ ] Demonstration of functional completeness using Postman and live demo
- [ ] Discussion of technical quality & code organization
- [ ] Discussion of test coverage (happy and sad path and edge case testing)

### Feature Delivery

* **Exceeds Expectations:** API completely satisfies the needs of the front-end developers and is very convenient and easy to use showing great developer empathy. Project implements all 3 extensions listed on the requirements page. 
* **Meets Expectations:** API satisfies the exact needs of the frontend developers. No unnecessary information is sent in a response.
* **Approaching Expectations:** One or Two of the API endpoints does not completely satisfy the needs of the front-end developers per the project requirements.
* **Below Expectations:** More than two API endpoints is not functioning per the requirements (such as sending query parameters to a POST endpoint), or multiple endpoints do not satisfy the needs of the front-end developers.

### Technical Quality

* **Exceeds Expectations:**  Student can articulate how their project achieves each of the four pillars of OOP. Project meets expectations from number 3 above.
* **Meets Expectations:**  Project demonstrates abstraction and encapsulation in ways that make it easy to change (example: if an API changes, for example, FLickr to Unsplashed, we make changes in as few places as possible.). Project shows a solid understanding of MVC principles (this may include but is not limited to: no logic in serializers, clean controllers, serializers and presenters to handle formatting rather than models etc.) and includes all expectations of numbers 1 and 2 above.
* **Approaching Expectations:**  MVC is overall good but might have 1 or 2 examples of logic or hashes in the serializers, formatting in models, or controllers with complex logic. Project demonstrates some amount of abstraction and encapsulation, but may need additional refactoring to make code easy to change.
* **Below Expectations:**  Project has significant gaps in understanding of MVC with several examples of logic or hashes in the serializers, controllers remain un-refactored, and models are used for formatting data.

### Testing

* **Exceeds Expectations:** Project achieves 100% test coverage and includes below expectations.
* **Meets Expectations:** Project achieves 90% or greater test coverage. In addition to "happy path", project also includes "sad path"/edge case testing. At least one of the tests that require an external API call make use of VCR and/or Webmock for mocking. Tests check payload content a little deeper such as inspecting data type of an attribute. Testing also checks that unnecessary information is NOT present in response data.
* **Approaching Expectations:** Project achieves 80-90% test coverage. Project may not include "sad path" or edge case testing. Testing only checks for presence of attributes in payloads of data without inspecting further.
* **Below Expectations:** Project does not achieve 80% test coverage.
