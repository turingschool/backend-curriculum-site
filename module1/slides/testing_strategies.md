# Testing Strategies

---

# Sketching Tests for Markdown Parser

If we wanted to turn this: 

```markdown
This is *a sample* with some **emphasis**.
```

Into this: 

```html
<p>This is <em>a sample</em> with some <strong>emphasis</strong>.</p>
```

* What are the differences?
* What might we want to test? Write one test.
* What questions do you have about testing?

---

# Testing Mindsets

* Write the test
    * In my dream world, how would this work?
    * How can I break this problem down?
    * What are my inputs/outputs?
    * What are classes/methods named?
* Make it pass
    * How do I do this in Ruby?

---

# Types of Tests

* **Acceptance Test:** a collection of user functionalities that delivers business value.
* **Feature Test:** a single feature as experienced by a user.
* **Integration Test:** tests multiple interdependencies or coordinating components.
* **Unit Test:** tests one component in isolation.

*In M1 need both Unit and Integration tests!*

---

# Hierarchy of Tests

![inline](test-pyramid.png)

---

# Practice

You're writing a whole Markdown processor which takes in complete Markdown files and outputs full HTML files.

* Review the tests you listed before
* Identify the following for each test you described:
    * Type
    * Question
    * Why
    * Input
    * Output
* If you only have unit or integration tests, see if you can add one or two of the other type

---

# Summary

* Testing mindsets
* Types of tests
* Hierarchy of tests

---

# Mixed Pairs

* Find someone *who is not your partner* on the current project
* Compare test suites
* **If you have not written tests** plan for five tests you could write
