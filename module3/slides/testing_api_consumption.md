# Testing API Consumption

---

# Goals

* Understand reasons for not making a real API calls in our tests
* Be familiar with how to stub network requests with WebMock & VCR

---

# Warmup

* Why might you not want to make real API calls in your tests?
* What is a mock?

---

# Defining a Mock

* A mock is a method/object that simulates the behavior of a real method/object in a controlled way

---

# Reasons to Mock API calls

1. Avoid hitting our API limit faster
2. Increase the speed of our tests
3. Allows teammates to jump into code even if they are waiting for an API Key
4. Able to continue working if there is no wifi or the API is under maintenance

---

# Exploration

* Using the docs and lesson plan
    * Add WebMock to our existing house-salad test
    * Then add VCR configuration

---

# Wrap Up

* What does WebMock do?
* What does VCR do?
* Why don’t we want VCR to record our API key?
