## Getting Started with OAuth

---

# Warmup

With the person next to you, take turns sharing your professional story in no more than 90 seconds.

---

## What is OAuth?
* OAuth == Open Authorization
* An open standard for token-based authentication and authorization on the internet.
* Allows an end user's account information to be used by third-party services without exposing the user's password.

---

## Historical Context for this lesson plan

* We used to teach this class using a gem since that’s how most of us do it on the job.
* We saw a big difference in understanding for students who were able to hand roll the handshake and those that used a gem.
* Students struggled troubleshooting the gem if they didn’t understand the process.
* This lesson is built showing how to hand roll the OAuth process.

---

## Learning Goals

* Explain the tradeoffs of using OAuth vs. building authentication from scratch.
* Implement the OAuth handshake using an HTTP library.
* Understand the value of using Omniauth to handle this handshake.
* Understand where to store and how to use a user's access token

---

## Exercise 1

Based on this [video](https://www.youtube.com/watch?v=tFYrq3d54Dc) and the [github oauth documentation](https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#web-application-flow)

In groups of 3, draw a diagram of the requests/responses that are involved in getting a token for a user.
    * What parties are involved?
    * What are the URLs for each request?

---

## Exercise 2

* In your group, redraw your diagram of the requests/responses that are involved in getting a token for a user based on our discussion.

---

## Further Conceptual Discussion

* What are the advantages/disadvantages of using an outside party to verify someone's identity?
* Why bother with the OAuth handshake? What's the purpose of the `code` the OAuth provier passes us?
* Why not get a token directly from a user?

---

## Advantages Of OAuth

* Removing security complexities
* Service Authorization/Authentication

---

## Disadvantages of OAuth

* Loss of control
* Account requirement
* Data duplication

---

## Omniauth

* Take 5 minutes to read through this [blog post](https://medium.com/@ali_schlereth/omniauth-is-not-a-scary-monster-a23b21c4f739)
* What is the value of using Omniauth to handle the OAuth handshake?
* At what layer are the responses from the OAuth Provider being intercepted?

---

## Workshop

* consider using a service and facade to refactor OAuth logic out of the sessions controller.

---

## Wrap up Questions

* What is OAuth?
* Where do you store a users access token?
* How do you use the access token?
