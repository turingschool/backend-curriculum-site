# Background Workers

---

# Warmup

* What is the bare minimum amount of code that would go in a Item model in Rails?
* What method do you create in a PORO if you want to be able to pass parameters to `.new`?
* What does it mean for a process to execute `asynchronously`?
* When might we want something to process asynchronously? What advantage does that give us?

---

# Tools

* Redis: Key/value store - database.
* Sidekiq: Background processor designed to work with Rails
* ActiveJob: Rails framework to interface with background processors.

---

# Structure

* Redis, Sidekiq, Rails all running in separate processes
    * Rails sends (or persists) a job to Redis
    * Sidekiq checks Redis for new jobs
    * Sidekiq executes the jobs it finds in Redis using Rails codebase

---

# Questions?

---

# Tutorial
