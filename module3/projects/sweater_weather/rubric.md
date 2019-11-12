---
layout: page
title: Whether, Sweater? Project Rubric
---

## Evaluation Rubric

### Feature Delivery

* **1:** Project did not complete two or more endpoints.
* **2:** Project did not complete one endpoint. Project is in production.
* **3:** Project completed all endpoints.
* **4:** Project implements either caching or background workers.

### Technical Quality

* **1:**  Project has significant gaps in understanding of MVC with several examples of logic or hashes in the view/presentation layer (e.g. serializers), controllers remain un-refactored, and models are used for formatting.
* **2:**  MVC is overall good but might have 1 or 2 examples of logic or hashes in the view/presentation layer (e.g. serializers), formatting in models, or controllers with complex logic. Project demonstrates abstraction and encapsulation, but may need additional refactoring to make code easy to change.
* **3:**  Project demonstrates abstraction and encapsulation in ways that make it easy to change (example: if an API changes, Propublica to Google Civic, we make changes in as few places as possible. Or POROs can be used in custom API or in standard views). Project shows a solid understanding of MVC principles (this may include but is not limited to: no logic in view/presentation layer (e.g. serializers), clean controllers, serializers and presenters to handle formatting rather than models etc.) and includes all expectations of numbers 1 and 2 above.
* **4:**  Student can articulate how their project achieves each of the four pillars of OOP. Project meets expectations from number 3 above.

### Testing

* **1:** Test suite coverage is low (less than 80%).
* **2:** Test suite coverage is greater than 80% but misses the most meaningful functionality and I would not be happy paying for/inheriting it.
* **3:** Project demonstrates high value testing at different layers (above 90%). If I were inheriting or paying someone to build this app I would be happy with the coverage.
* **4:** Project demonstrates exceptional testing using advanced techniques such as spies. Meets expectations of point 3 above.
