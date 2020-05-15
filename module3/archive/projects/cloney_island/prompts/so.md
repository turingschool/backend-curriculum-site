---
layout: page
title: StackOverflow
length: 2 weeks
tags:
type: project
---

## StackOverflow

You need a way to crowdsource help for specific topics (they don't even have to be technical questions!). You also want to know if those answering your questions can be trusted.

You'll build an application that allows for users to comment and answer on questions posted by other users. They can also vote on the quality of the answers.

### Specific Requirements

* User roles should include: guest, user, admin.
* Registered users should be able to publicly post questions, post answers to specific questions, and comment on both questions and answers.
* Visitors should be able to view questions, answers, comments, and votes all on an individual question page.
* Admin's should be able to revoke user's access to posting answers/comments if they have reached a specific number of downvotes.
* Registered users should be able to vote (up and down) once on questions, answers, comments (polymorphic association).
* The original poster of a question can choose a "best answer" of their question. The specific answer will have a green check mark next to it.
* Registered users can see their profile - most recent questions and answers posted, number of total comments left, etc.
