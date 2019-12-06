---
layout: page
title: Intro to Postman and Faraday
length: 180
tags: apis, rails, faraday
---

### Getting started

First, we'll need a Rails project with simple CRUD functionality. If you don't have something on your local machine you can set up this simple project...

```
$ git clone git@github.com:turingschool-examples/little_shop_1906.git
$ cd little_shop_1906
$ bundle
$ rake db:{create,migrate}
$ rails s
```

### Mom, how do forms work?

Navigate to `localhost:3000/merchants/new` and create a new merchant record using the form.

You've done this countless number of times but do you know what's really happening?

#### Exercise - How You Think They Work (In Pairs - 5 min)

Sketch out a diagram of what happens when we submit this form. (Be ready to share out)

#### Whole Group

What did you all come up with?

#### Exercise - How They Really Work Postman Edition (In Pairs - 30 min)

Time to test your understanding... Make the same call using Postman.

*Heads-up:* At some point you will see an `ActionController::InvalidAuthenticityToken` error. You aren't doing anything wrong but you will need to alter your Rails app to get this to work. Google your way to victory.

*Be ready to answer:* How did you resolve the error above? How does this impact the app's security? Would you use this same technique on a production code base? Explain.

#### Whole Group

Was there anything that differed from your diagram in the beginning?

#### Exercise - How They Really Work Faraday Edition (In Pairs - 30 min)

* Install the [Faraday gem](https://github.com/lostisland/faraday)
* Create a ruby file and require the Faraday library along with your debugger of choice.
* In this newly created Ruby file, make the same HTTP request as the two previous challenges.

#### Whole Group

What is challenging about working with Faraday?

### When to Teach Your Kids About API Consumption

You now have experience building an API using Rails. In our next class we will be consuming an API in the context of Rails project. These next few exercises will prepare you for the most difficult concepts we cover in Mod 3. Struggle is more important than completion.

The user story we will be working on during our next class is as follows:

```
As a user
When I visit "/"
And I select "Colorado" from the dropdown
And I click on "Locate Members of the House"
Then my path should be "/search" with "state=CO" in the parameters
And I should see a message "7 Results"
And I should see a list of 7 the members of the house for Colorado
And they should be ordered by seniority from most to least
And I should see a name, role, party, and district for each member
```

This user story requires us to use the Propublica API to determine the members of the house for a given state. The [Lists of Members](https://projects.propublica.org/api-docs/congress-api/members/#lists-of-members) documentation tells us how to retrieve this data.

#### Exercise - Make an API Call Using Postman (In Pairs)

_Instructor Note: Send out API keys._

* Step 1: Draw two circles.
* Step 2: Make the API call using Postman.

#### Exercise - Make the Same API Call Using Faraday (In Pairs)

Do this in a similar way as the previous Faraday challenge where you write your code in a simple Ruby file.

#### Whole Group (20 min)

Q&A
