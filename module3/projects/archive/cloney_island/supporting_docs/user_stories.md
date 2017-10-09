---
layout: page
title: User Stories
length: 2 weeks
tags:
type: project
---

## User Stories

User stories follow this pattern:

```md
As a `USER`
When I `DO SOMETHING`
Then I `EXPECT SOMETHING`
```

Examples:

```md
As an admin
When I click on dashboard
Then I should be on "/admin/dashboard"
And I should see all users listed
```

```md
As a guest user
When I visit "/password-reset"
And I fill in `Email` with "lauren@example.com"
And I click `Submit`

Then I should be redirected to "/password-confirmation"
And I should see instructions to enter my confirmation code
And I should have received a text message with a confirmation code

When I enter the confirmation code
And I fill in `Password` with `password`
And I fill in `Password Confirmation` with `password`
And I click "Submit"
Then I should be redirected to "/dashboard"
And I should be logged in
And my old password should no longer work for logging in
And my new password should work after logging out and logging back in
```
