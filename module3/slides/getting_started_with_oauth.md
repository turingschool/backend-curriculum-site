# Getting Started with OAuth

---

# Learning Goals

* Explain the tradeoffs of using OAuth vs. building authentication from scratch.
* Implement the OAuth handshake using an HTTP library.
* Understand the value of using Omniauth to handle this handshake.
* Understand where to store and how to use a user's access token

---

# Options

* If you feel comfortable with this process, feel free to get started on your project.
* If you would like to review the conceptual pieces, we'll start with those.
* If you would like to see a live code of the whole process, we'll end with that.

---

# Warmup

Based on the application you created last Thursday during evals:

* Draw a diagram of the requests/responses that are involved in getting a token for a user.
    * What parties are involved?
    * What are the URLs for each request?
    * What are the status codes for each response (to the nearest 100)?

---

# Further Conceptual Discussion

* What are the advantages/disadvantages of using an outside party to verify someone's identity?
* Why bother with the OAuth handshake? What's the purpose of the `code` the user passes us?
* Why not get a token directly from a user?

---

# Tools: Faraday

* How do you submit a basic request?
* How can you submit a request with params?
* How can you submit a request with headers?
* How do you create a reusable base connection?
* What does that allow you to do?

---

# 1. Register a New OAuth App

---

# 2. Start a New Rails App


---

# 3. Authenticate User on GitHub

* Generate a home page with a link to log in with GitHub.

---

# 4. Get a Token for the User

* Use a SessionsController to capture a `code` for our user.
* Turn that `code` into a token for our user.
* Use that token to access user information.

---

# 5. Save Our User to the Database

* Create a user model/table.
* Use `find_or_create_by` to see if the user already exists.
* Update our user's username, uid, and token.
* Persist our new user.
* Save our `user_id` to a session.

---

# 6. Create a Dashboard for Our User

* Redirect to a `dashboard_path`
* Create a route, a `DashboardController`, and a view.
* Use `current_user` in that view.
* Create `current_user` as a helper method in our ApplicationController.

---

# 7. Hit the API to Access User Data

* Add a line to our `SessionsController` to pull info about our user.
* Use a Faraday request to determine what repos our user has.

---

# Questions
