---
layout: page
title: Auth Exploration - Iteration 4
---

### Release 4:  Implement Authorization

To this point, we've been dealing with *authentication*:  answering the question, "Who are you?"  Now we're going to handle *authorization*:  answering the question, "What do you have permission to do?"

In applications there are different use cases for authorization.  For example, an application might have a group of administrators with special privileges.  Perhaps they can edit content, delete posts, etc., while other users cannot.  In our application, we'll authorize all logged in users to view the content of our site.  If users have not logged in, they will not be authorized to view the content.

What is our content?  We're practicing authorization, so let's just create a "secret" page, at the path '/secret'.  Users should be authorized to see the secret page only if they're logged in.  If visitors try to access the secret page when they're not logged in, they should be redirected to the login page.

One way to restrict access to authorized users is a [filter](http://guides.rubyonrails.org/action_controller_overview.html#filters).  This is not the only way to accomplish this and not necessarily the best way in this case.  But it's one tool to implement this kind of pre-route logic.  For an application this simple, it's ok to put the authorization logic in the controller action itself. Use the following user stories to build out this functionality.

```
As a visitor
When I visit '/secret'
I am returned to the login path ('/login')
```
```
As a logged in user
I can visit '/secret'
and my current path is '/secret'
```

[Back to Auth Exp Home](./auth_exploration)
