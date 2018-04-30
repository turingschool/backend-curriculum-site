---
layout: page
title: Rails Mini-Project
subheading: Putting it all Together
---

### Setting Expectations

Use [this question guide](https://gist.github.com/rwarbelow/0fed3529495a814eabb1) to establish group norms if you're working with someone else.

### Code Review

This is a non-assessed project. In order to get feedback on your code, consider tagging the following in PRs:

- Peers
- Mentors
- Instructors

If you tag someone in a PR. Make sure to point them to a specific part of a specific file. Have a question in mind beyond "Will you take a look at this." General questions can also be asked by tagging others in GitHub issues.

### Project Options

- IdeaBox
- GifGenerator
- PointBox
- Original Idea

### Project Option 1: IdeaBox

Let's create an app to record your ideas. Host your app live on Heroku.

#### Ideas

- [ ] An idea can be created by a user.
- [ ] An idea can be edited/updated only by the user that created it.
- [ ] An idea can be destroyed only by the user that created it.
- [ ] When a user types a new idea into the form, there is a [selection dropdown](http://guides.rubyonrails.org/form_helpers.html#option-tags-from-a-collection-of-arbitrary-objects) for choosing the correct category. See Categories below for more information.

#### Categories

- [ ] Ideas belong to a category.
- [ ] Categories can be created and destroyed by a logged-in admin user (regular logged in users cannot create categories).
- [ ] Categories can be destroyed by a logged-in admin user (regular logged in users cannot destroy categories).

#### Images

- [ ] Users can add an image to their own idea.
- [ ] An image can have many ideas and an idea can have many images.
- [ ] Images can only be created by an admin user.
  - The most simplistic way to implement images is to store a url to an online image. If you're feeling fancy and want to upload your own images, check out [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) or [Paperclip](https://github.com/thoughtbot/paperclip).

#### Authentication and Authorization

- [ ] Users need to log in to see their ideas.
- [ ] Users can only see their own ideas -- they should not be able to visit another user's page.
- [ ] Users cannot create ideas for other users.
- [ ] Users cannot create new categories -- only the admin can do that.
- [ ] Users cannot create images -- only the admin can do that; however, a user can assign an image to their idea.
- [ ] Visitors can create user accounts.

### User Experience

- [ ] The application has been styled.
- [ ] The application uses a balanced, considered color scheme.
- [ ] The application implements a font (that is not the default font).
- [ ] The application utilizes a nav bar. 
- [ ] The style shows evidence of intentional layout. 
- [ ] Space and text is balanced. White space is used to visually separate content. 
- [ ] The application is easily usable. The user can intuitvely navigate between different portions of the application without manually entering the URL into the nav-bar or using the back button on their browser.

### Database

- [ ] Properly implements a one-to-many relationship
- [ ] Properly implements a many-to-many relationship
- [ ] Utilizes primary and foreign keys appropriately

### Code Quality

- [ ] Logic lives in the appropriate files
- [ ] Methods are refactored and follow SRP
- [ ] Naming follows convention

### Testing

- [ ] Project has a running test suite
- [ ] Test suite includes robust feature tests
- [ ] Test suite includes tests for validations
- [ ] Test suite includes tests for methods that they have created on the models

#### Optional Extensions

- Implement Twitter, Github, or Facebook OAuth login
- Use HAML for your views
- TDD using RSpec instead of Test::Unit

### Project Option 2: GifGenerator

Create an app where users can "favorite" gifs. Host your app live on Heroku.

#### Gifs

- [ ] Admins can generate gifs by entering a one-word search term in field and then clicking "generate gif". This should create a new gif in the database. This feature is not available to regular users.
  - Gifs should have an image_path. See above "Images" in project #1 for more info on implementing images.
  - Use the [GiphyApi](https://github.com/giphy/GiphyAPI) to generate gifs.

#### Favoriting

- [ ] Regular users can mark a gif as "favorite".
- [ ] Regular users can see a list of all of the gifs they've marked as favorites.
- [ ] Regular users cannot delete a gif; they can only "unfavorite" it for themselves.
- [ ] Regular users should be able to see all gifs sorted by category.
- [ ] Regular users should be able to see favorited gifs sorted by category.

#### Categories

- [ ] Gifs belong to a category (category is the original word that was searched for by the admin).
- [ ] categories can be created by a logged-in admin user (regular logged in users cannot create categories).
- [ ] categories can be destroyed by a logged-in admin user (regular logged in users cannot destroy categories).

#### Authentication and Authorization

- [ ] Users need to log in to see their favorited gifs.
- [ ] Users can only see their own favorited gifs -- they should not be able to visit another user's page.
- [ ] Users cannot create favorites for other users.
- [ ] Users cannot create new categories -- only the admin can do that.
- [ ] Users cannot create gifs -- only the admin can do that.
- [ ] Visitors (non-registered users) can create user accounts.

#### User Experience

- [ ] The application has been styled.
- [ ] The application uses a balanced, considered color scheme.
- [ ] The application implements a font (that is not the default font).
- [ ] The application utilizes a nav bar. 
- [ ] The style shows evidence of intentional layout. 
- [ ] Space and text is balanced. White space is used to visually separate content. 
- [ ] The application is easily usable. The user can intuitvely navigate between different portions of the application without manually entering the URL into the nav-bar or using the back button on their browser.

#### Database

- [ ] Properly implements a one-to-many relationship
- [ ] Properly implements a many-to-many relationship
- [ ] Utilizes primary and foreign keys appropriately

### Code Quality

- [ ] Logic lives in the appropriate files
- [ ] Methods are refactored and follow SRP
- [ ] Naming follows convention

#### Testing

- [ ] Project has a running test suite
- [ ] Test suite includes robust feature tests
- [ ] Test suite includes tests for validations
- [ ] Test suite includes tests for methods that they have created on the models

#### Optional Extensions

- Implement Twitter, Github, or Facebook OAuth login
- Use HAML for your views
- TDD using RSpec instead of Test::Unit

### Project Option 3: PointBox

Create an app where an admin (let's say for example, Richard) can assign points to users and users can redeem those points for rewards. Host your app live on Heroku.

#### Points

- [ ] Points can be created ("assigned to a user") and destroyed only by the admin.
- [ ] Points can be destroyed only by the admin.
- [ ] Users can see their total number of points on their dashboard

#### Rewards

- [ ] Rewards can be created only by the admin.
- [ ] Rewards can be edited only by the admin.
- [ ] Rewards can be updated only by the admin.
- [ ] Rewards can be destroyed only by the admin.
- [ ] The list of possible rewards can be seen by regular users.

#### Redeeming Points

- [ ] Users can redeem their points for a reward.
- [ ] When users redeem their points, the points are NOT destroyed; instead, they are marked as "redeemed".
- [ ] when a user redeems points for a reward, the user can see that reward on their dashboard.

#### Authentication and Authorization

- [ ] Users need to log in to see their points and rewards.
- [ ] Users can only see their own points and rewards -- they should not be able to visit another user's page.
- [ ] Users cannot add points to their account.
- [ ] Users cannot create new rewards to add to the list.
- [ ] A user cannot redeem another user's points.
- [ ] Admin can create a user.

#### User Experience

- [ ] The application has been styled.
- [ ] TThe application uses a balanced, considered color scheme.
- [ ] The application implements a font (that is not the default font).
- [ ] The application utilizes a nav bar. 
- [ ] The style shows evidence of intentional layout. 
- [ ] Space and text is balanced. White space is used to visually separate content. 
- [ ] The application is easily usable. The user can intuitvely navigate between different portions of the application without manually entering the URL into the nav-bar or using the back button on their browser.

#### Database

- [ ] Properly implements a one-to-many relationship
- [ ] Properly implements a many-to-many relationship
- [ ] Utilizes primary and foreign keys appropriately

#### Code Quality

- [ ] Logic lives in the appropriate files
- [ ] Methods are refactored and follow SRP
- [ ] Naming follows convention


#### Testing

- [ ] Project has a running test suite
- [ ] Test suite includes robust feature tests
- [ ] Test suite includes tests for validations
- [ ] Test suite includes tests for methods that they have created on the models

#### Optional Extensions

- Implement Twitter, Github, or Facebook OAuth login
- Use HAML for your views
- TDD using RSpec instead of Test::Unit

### Option 4: Original Idea

That's right. You are creative and I believe in you. Feel free to pitch an original idea for the mini-project. Pitch your project through the form your instructor will link in your channel.

#### Must-Haves:

- [ ] Deploy to Heroku
- [ ] Authentication/Authorization
- [ ] One-to-many and Many-to-many relationships
- [ ] Styling

#### Approval

In order to have your project approved, submit your pitch through the form your instructor will link in your channel. Approval is contingent upon:

- [ ] What will a visitor be able to do?
- [ ] What will a logged in user be able to do?
- [ ] What will an admin be able to do?
- [ ] What is a one-to-many relationship you will be using?
- [ ] What is a many-to-many relationship you will be using?

#### Things to Consider

If you choose to do this option make sure you try to implement all the concepts we've touched over the last week. For example:

- [ ] TDD - model and feature tests
- [ ] CRUD
- [ ] 1-1 and 1-many relationships
- [ ] ReST-ful routes
- [ ] Well structured relational database design
- [ ] Rails helpers
- [ ] Sessions, flashes and maybe cookies if you have a good use case for them.
- [ ] Authentication
- [ ] Authorization

#### Rubric for General Parts:
#### User Experience

- [ ] The application has been styled.
- [ ] TThe application uses a balanced, considered color scheme.
- [ ] The application implements a font (that is not the default font).
- [ ] The application utilizes a nav bar. 
- [ ] The style shows evidence of intentional layout. 
- [ ] Space and text is balanced. White space is used to visually separate content. 
- [ ] The application is easily usable. The user can intuitvely navigate between different portions of the application without manually entering the URL into the nav-bar or using the back button on their browser.

#### Database

- [ ] Properly implements a one-to-many relationship
- [ ] Properly implements a many-to-many relationship
- [ ] Utilizes primary and foreign keys appropriately

#### Code Quality

- [ ] Logic lives in the appropriate files
- [ ] Methods are refactored and follow SRP
- [ ] Naming follows convention

#### Testing

- [ ] Project has a running test suite
- [ ] Test suite includes robust feature tests
- [ ] Test suite includes tests for validations
- [ ] Test suite includes tests for methods that they have created on the models

#### Optional Extensions

- Implement Twitter, Github, or Facebook OAuth login
- Use HAML for your views
- TDD using Test::Unit instead of RSpec

### Resources

- [Nested Routes](http://guides.rubyonrails.org/routing.html#nested-resources)
- [Carrierwave](https://github.com/carrierwaveuploader/carrierwave)
- [Paperclip](https://github.com/thoughtbot/paperclip)
- [Form Helpers in Rails](http://guides.rubyonrails.org/form_helpers.html)
