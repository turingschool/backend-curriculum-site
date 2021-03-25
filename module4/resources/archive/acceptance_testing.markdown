---
layout: page
title: Acceptance Testing
---

## Learning Goals

* Students can explain the concept of acceptance testing
* Students can explain feature testing and how it relates to acceptance testing
* Students can translate a story into an executable acceptance test
* Students can describe the different perspectives of an acceptance/feature tester versus a unit-tester/implementer

Mastery Expectation: HIGH. By the end of this lesson, students should feel completely confident in the definitions and expectations of topics covered here.

## Plan

### Lecture/Discussion (45 Minutes)

Walk through the tutorial/discussion below to highlight key points and answer questions.

### Group Activity (30 Minutes)

In your project groups:

1. Pick a single story from your project tracker
2. Individually sketch out an acceptance test using capybara syntax
3. Compare/contrast your sketched test implementation to look for differences and similarities
4. Together brainstorm features tests so you have one feature test per group member
5. Each take one unique feature test and sketch and implementation
6. If you have time, review each other's sketches

### Group Review (15 Minutes)

We have one or two individuals show off what they and their group wrote. We look out for any questions or misunderstandings.

## Tutorial

Let's recap and dive a little deeper into testing. We use the terms "acceptance tests" and "feature tests" to mean almost the same thing -- with a nuanced difference.

### Acceptance Tests Emulate End Users

Acceptance tests exercise your application *just like a real user*. They therefore depend on the full stack from your models up through your controllers, helpers, view templates, web server, database, and middleware.

Acceptance tests are typically a translation of a user story:

```plain
As a [user]
When I [do action]
  and [do other action]
Then I observe [result 1]
  and observe [result 2]
```

Proper acceptance tests use your application as a *black box*. They know nothing about what happens under the hood, they just interact with the interface and observe the results.

Acceptance tests are the 30,000-foot view of your application. They're focused on the happy-path, the business value driving the creation of the application.

When your user stories have been translated to acceptance tests and those tests pass, then your application is finished! Until the product owner writes more stories...

**Every completed story should have one or more acceptance tests that are a translation of the story into executable code**.

### Feature Tests are for Clients & Developers

But there are often a lot of details a little bit under the surface. What about when things go wrong? What happens when a user tries to save an article without a title? Or a title that's too short?

Maybe your product owner has infinite time to be writing stories for every edge case. But, more than likely, they need you to fill in the gaps, to anticipate what's going to go wrong. We can use several feature tests to drive more of the development.

### Breaking Down an Example

Let's talk about creating an article on a blog.

#### Acceptance Test

The acceptance test might go like this:

```plain
As an authenticated user
  and I'm on the articles index
When I click the new article link
  and I enter a title
  and I enter a body
  and I click the submit button
Then I observe the title I entered
  and I observe the body I entered
```

That's the happy path. Translated to Minitest and Capybara, that might go like this:

```ruby
def test_an_authenticated_user_creates_an_article
  login_as_user # you'd write this method elsewhere
  visit article_path
  click_on('new-article')
  fill_in('title', :with => "My Tester Title")
  fill_in('body', :with => "My Tester Body")
  click_on('save')
  assert page.has_css?("#title", :text => "My Tester Title")
  assert page.has_css?("#body", :text => "My Tester Body")
end
```

#### Feature Tests

The feature tests drill down just a bit deeper:

##### Create and Redirect

The concept of the feature could be characterized like this, even if we don't write it as a story:

```plain
As an authenticated user
  and I'm on the new article page
When I enter a title
  and I enter a body
  and I click the submit button
Then I am redirected to the article page
```

Seems pretty much the same? The detail about being redirected is key -- a typical user doesn't care whether their browser is redirected or not. They just want to see the content they expect. This test is starting to move towards characterizing the implemention.

Turing this ides into executable code:

```ruby
def test_an_authenticated_user_creates_an_article
  login_as_user
  visit new_article_path
  fill_in('title', :with => "Hello, World")
  fill_in('body', :with => "My Tester Body")
  click_on('save')
  id_from_path = current_path.scan(/\d+$/).first
  assert_match article_path(id_from_path), current_path
end
```

##### Body is Required

Then I start thinking about problems that are likely to pop up:

```plain
As an authenticated user
  and I'm on the new article page
When I enter a title
  but I do not enter a body
  and I click the submit button
Then I am returned to the form
  and I see an error message that a body is required
```

This requirement might get overlooked by the product owner, but as a responsible developer I need to be thinking about what happens when things go wrong. Implemented with Capybara:

```ruby
def test_an_authenticated_user_creates_an_article
  login_as_user
  visit new_article_path
  fill_in('title', :with => "Hello, World")
  fill_in('body', :with => "")
  click_on('save')
  assert_equal new_article_path, current_path
  assert page.has_css?("#error", :text => "body")
end
```

##### Titles Are Unique

Or a different kind of problem:

```plain
As an authenticated user
  and I'm on the new article page
  and there's an article in the system with the title "Hello, World"
When I enter a title of "Hello, World"
  and I enter a body
  and I click the submit button
Then I am returned to the form
  and I see an error message that the title has already been used
```

Implemented with Capybara:

```ruby
def test_an_authenticated_user_creates_an_article
  login_as_user
  visit new_article_path
  create_article(:title => "Hello, World") # write this method elsewhere
  fill_in('title', :with => "Hello, World")
  fill_in('body', :with => "My Tester Body")
  click_on('save')
  assert_equal new_article_path, current_path
  assert page.has_css?("#error", :text => "title")
end
```

### Maintaining the Veil

Both acceptance and feature tests should know very little about how your application is setup internally. If the tests need data to exist before they can demonstrate functionality then the test needs to create that data first.

But that can be a real pain, not to mention slow. Imagine you're writing a suite of tests focused on the admin functionality in your application. If you keep your suite conceptually pure, then **every test** needs to start with:

* Register a new user
* Confirm a user
* Upgrade the user to an administrator (how does this even happen?)

Each of those happens *before* you get to the meat of the test. You could easily wait a second for all that to complete, end up with a slow test suite, and either (A) waste development time or (B) stop running the tests. Both are bad.

#### Making Compromises

When you write these kinds of tests you'll have to make compromises. But you want to *encapsulate* those cheats so you can easily change them later.

In the examples above, we used this method:

```
login_as_user
```

You can assume what that method does, but how does it do it? From the test, *you don't care*. By abstracting the steps for that method, the test can maintain a consistent level of abstraction from the application's implementation.

*Inside* the method, it very well might do something like this:

```ruby
def login_as_user
  visit new_user_path
  fill_in "name", :with => "Sample User"
  fill_in "password", :with => "samplepass"
  fill_in "password_confirmation", :with => "samplepass"
  click_on "save"
  visit login_path
  fill_in "name", :with => "Sample User"
  fill_in "password", :with => "samplepass"
  click_on "login"
end
```

But that's slow, right? You could also implement it in a way that reaches directly into the application to shorten the process:

```ruby
def login_as_user
  User.create(:name => "Sample User", :password => "samplepass")
  visit login_path
  fill_in "name", :with => "Sample User"
  fill_in "password", :with => "samplepass"
  click_on "login"
end
```

This compromise saves a bit of test time but also emulates the user's experience.

#### Diving In

Once you have the feature test in place, it's time to switch roles. You move over the the implementer, the developer who understands how things are put together on the inside. If helpful, you start writing unit tests. You build up functionality until that feature test passes.

Then you switch back to the outside perspective. Does the acceptance test now pass? If not, what could be the next feature test? Write it, then switch back to the implementer side with unit tests. Repeat until your acceptance test passes.
