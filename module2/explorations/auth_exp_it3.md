---
layout: page
title: Auth Exploration - Iteration 3
---

# Implement Logging Out

If users can login, we'll also want to allow them to logout.  Implement a controller method that will log a user out when they visit it.  This will most likely involve deleting some content from the `session` hash.  Use the following user story to help guide your implementation:

```
As a registered user
When I am logged in and visiting the users index
And I click on a link to 'Log Out'
Then I am on the users index
And I see a link to 'Log In'
And I do not see a link to 'Log Out'
```

[Next to Iteration 4](./auth_exp_it4)
