---
layout: page
title: Testing in the world of services
---

## Learning Goals

- Can explain the value of testing
- Can put the right test in the right service
- Can determine what needs to be mocked, and what doesn't
- Can mock HTTP
- Can read someone else's code
- Can adapt someone else's code to solve your own problems

## Let's talk about Testing

- What do you actually want to be testing?
- How might you determine that?

### Things to test

- Am I sending the right thing?
- Am I handing the response correctly?
- Can I gracefully handle an error?

## Remember VCR?

Our goal is to be able to test our main application, without needing to spin up another server. We already know how to do that.

- Review VCR
- Love/Hate spectrum for VCR
- Discuss pros and cons of VCR

## Using Github to learn how to do a thing

Someone else is already testing code that depends on Who else has this same problem?

_API client gem writers_

### What can we learn from them?

- Do they use VCR?
- What gems are they using? What do they do?
- Is there common pattern in their tests?
- Which tests need HTTP and which don't? How can we tell?

Take a look at <https://github.com/sferik/twitter/>

- Poke around for 5 minutes. Share with the class what you found. Share with the class what you still don't know.
- Do some more poking. Try to break apart the pattern they're using for mocking the twitter API

### The twitter gem mocking pattern

Break down the pattern

- helper functions that include the baseurl
- Stubs a whole section (context) with a get or a post
- tests request and response separately
- uses `json` files in fixtures to simplify mock responses

#### More questions

- Do we need to make any changes to this pattern for our own purposes?
- Is there anything in this pattern that is still magic? Gems? Methods?

## Implementing The Pattern

- Add webmock gem
- Copy some of the helper methods
- Do the things

## Integration testing

Inspired by omniauth. The interface they have is decent, but I don't really like the code

We should use a pattern like factory girl or fixtures, but something that's really like that is kind of overkill. What are some features we'd like in our integration testing?

- A "test mode" that will prevent any attempts at an HTTP request
- While in "test mode", we can still CRUD records

## Next Steps
- Using Sinatra to mock your service
  - https://robots.thoughtbot.com/how-to-stub-external-services-in-tests#create-a-fake-hello-sinatra
  - http://asquera.de/blog/2015-03-30/testing-external-apis-in-ruby/
- Try only mocking in development. Expect a service in staging. How can you modify your tests based on environment?
- Sad path testing. What if you ask for something that doesn't exist? What if you try to create something that's invalid.
