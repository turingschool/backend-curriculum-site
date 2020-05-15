# Background Workers
---

## Warm Up

1. What does it mean for a process to execute asynchronously?
1. Why would we want something to execute asynchronously? What advantage does that give us?

---

### Doing Stuff In the background

A background worker allows you to perform time consuming operations outside of
the normal request-response loop.

- Long-running requests are moved to threads outside of the main web application thread for processing,

- This frees up the main web application to continue handling requests from the user.

---

### Why do we need them?
- Certain processes can take a long time and users get bored

- Background workers are a way to optimize the perceived performance of your web application.

---

### What's good to do in the background?
There are 2 main attributes that make something a good candidate for processing in the background:

1. Slow
2. Immediate user feedback is not crucial

---

### Things In Rails Apps That Need Background workers

- Email
- Data Processing - Generating Reports
- Payment processing
- Maintenance - expiring old sessions, sweeping caches

---

### Our Tools
1. Redis - Key/value store database
2. Sidekiq - Background processor designed to work with rails
3. ActiveJob - Rails framework to interface with background processors

---

### How it all works together
1. Rails sends jobs to Redis
2. Sidekiq checks Redis for new jobs
3. Sidekiq executes the jobs it finds in Redis using code defined in Rails

Turn to a neighbor and practice explaining how this works

---

## Questions?

---

## Workshop

## Wrap up Questions

1. When do you want to use a background worker?
2. What is ActiveJob and how is it similar to ActiveRecord
3. What is Sidekiq?
4. What is Redis?
5. Is it possible to define a job that doesn't get sent redis and a background worker?
