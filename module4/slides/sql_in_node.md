# SQL in Node

---

# Warmup

Visit the `knexjs.org` website.

* What does Knex do?
* Does this sound like any of the tools you've used previously?

---

# Add Knex to Our SecretBox Project

* See lesson plan

---

# Share

---

# Creating API Routes

Create GET and POST routes for secrets

* GET `api/secrets/:id` returns an object as JSON
* POST `/api/secrets` returns the newly created object as JSON


*Check online to see how to return JSON and how to access URL parameters*

---

# RETURNING

* In SQL can determine what the `INSERT` query returns

---

# Error Handling: GET

* If the SELECT query does not return anything:

```
return res.sendStatus(404)
```

---

# Error Handling: POST

* If the client sends a `POST` request without providing a message:

```
return res.status(422).send({
  error: "No message property provided"
})
```

---

# Node Apps on Heroku

See the lesson for additional information on how to push to Heroku.

---

# Summary

* What differences do you see between Knex and ActiveRecord?
* Do you see any advantages to one approach vs the other?
