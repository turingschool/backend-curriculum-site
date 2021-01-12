## Getting Started with OAuth

---

# Warmup

* Share in your groups what you took away from your job shadow experience yesterday.

---

## What is OAuth?
* A standard for token-based authentication and authorization on the internet.
* Allows an end user's account information to be used by third-party services without exposing the user's password.

---

## Learning Goals
* Can explain the tradeoffs of using OAuth vs. building authentication from scratch.
* Can implement the OAuth handshake using an HTTP library.
* Understands the value of using Omniauth to handle this handshake.
* Understands where to store and how to use a user's access token

---

## Exploration

Watch & Explore
1. [OAuth Overview](https://www.youtube.com/watch?v=tFYrq3d54Dc)
2. [GitHub OAuth](https://vimeo.com/173947281)
3. [GitHub OAuth Docs](https://docs.github.com/en/free-pro-team@latest/developers/apps/authorizing-oauth-apps#web-application-flow)

Draw a diagram of the requests/responses that are involved in getting a token for a user.
    * What parties are involved?
    * What information is included in the request/response?

---

## Pros & Cons of OAuth
* What are the advantages/disadvantages of using an outside party to verify someone's identity?
* Why bother with the OAuth handshake? What's the purpose of the `code` the OAuth provider passes us?

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
* What is the value of using OmniAuth to handle the OAuth handshake?

---

## Wrap up Questions
* What is OAuth?
* Where do you store a users access token?
* How do you use the access token?
