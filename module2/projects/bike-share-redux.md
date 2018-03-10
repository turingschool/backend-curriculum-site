# Bike Share

## Abstract

In this project you'll use Ruby, Rails, and Activerecord to build a site that analyzes bike share usage in San Francisco and allows a user to purchase bike accessories via an online store.

In this project you'll use Ruby on Rails to build an online commerce platform to facilitate online ordering.

This application will collect data in two ways:
  1. Through web forms allowing users to enter trip/station/weather information
  2. By consuming CSV files with historical information for stations, trips, and weather. In addition to creating and storing this information for viewing at a later date, this application will provide a number of user dashboards with higher level analysis of trends in bike share usage.

## Learning Goals

### ActiveRecord

* Use ActiveRecord migrations to create a normalized database
* Use intermediate ActiveRecord queries to calculate and report on information in the database
* Utilize ActiveRecord methods and relationships to efficiently query the database

### User Experience and Conventions

* Use Rails and ERB templates to render views to create, read, update, and delete resources using RESTful routes and appropriate HTTP verbs
* Use Rails and ERB templates to display a dashboard not related to a specific resource saved in the database
* Practice mixing HTML, CSS, and templates to create an inviting and usable User Interface
* Deploy an application to Heroku
* Write an articulate README documenting features and functionalities of application
* Build a logical user-flow that moves across multiple controllers and models
* Navigation links are present for all functionality

### Code Organization/Quality

* Differentiate responsibilities between components of the Rails stack
* Design a system of models which use one-to-one, one-to-many, and many-to-many relationships
* Organize code using best practices (use POROs when appropriate, avoid long methods, logic lives in appropriate places, etc.)
* Create methods using ActiveRecord on the appropriate class.

### Testing

* Use RSpec to drive development at the feature and model levels.

### Working Collaboratively

* Use Git and GitHub to work collaboratively, develop in smaller groups, and resolve merge conflicts.
* Use Git Rebase workflow.
* Practice an agile workflow and improve communication skills working within a team

## Process

Each team will have an assigned project manager that will be the primary point of contact between the product owner (instructor) and the rest of the team.

All base stories will be provided by the product owner. You will be asked to write your own stories for extensions and they should follow the same format as the ones that are provided to you.

You should not write code or migrations until a story calls for it.

Teams can self-pace but will have a number of stories required to be completed at each check-in. Teams will meet with the product owner regularly and demo completed stories. Project scope and requirements can change at the discretion of the product owner so following an agile approach is really important.

It is expected that teams will have meaningful discussions and code reviews using comments on Github. Your instructors will be looking for this. Commits should also have meaningful messages. Be careful about what type of commits are being made, i.e. "Cleanup Hound violations". If you want to learn more about squashing commits, see [here](http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html).

It is also expected that teams will use a Pull Request Template, as described [here](https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/).

The master branch of your project should always remain in a state where it can be demoed and deployed... yes, even days that you don't have any _planned_ meetings.

Everyone will provide feedback for group members at the end of the project.

### Restrictions

Project implementation may **not** use:

* Any external library for authentication except `bcrypt`

### Getting Started

2. One team member creates a repository with the name of your online bike analysis/ordering platform
3. Add the other team members and your instructor(s) as collaborators
4. Add your project to [waffle.io](http://waffle.io) to write and track user stories
5. Create a Pull Request template
6. Add the [user stories](little_user_stories) to waffle.

### Define the Relationship with Your Group

DTR with your group [here](http://backend.turing.io/career_development_curriculum/module_one/dtr_guidelines_memo). One group member should send a link of the forked gist to your anchor as soon as it's complete.

### Requirements

This project must use:

* [PostgreSQL](http://www.postgresql.org/)
* [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html)

You'll want to set up the [DatabaseCleaner](https://github.com/DatabaseCleaner/database_cleaner) gem in order to have a clean database each time you run tests. Follow the instructions for setting up the gem. Due to a bug in the most recent version of the gem, you'll need to use this line when you set the strategy in your test helper file:

```ruby
DatabaseCleaner.strategy = :truncation
```

### Deployment

This project must be deployed with a smaller data set on Heroku.

## User Stories
### As a visitor
- [ ]

```
As a visitor,
When I visit the stations index,
I see all stations (name, dock count, city, installation date)

** All Attributes must be present **
```

- [ ]

```
As a visitor,
When I visit the station show
I see the url '/:station-name' with that station's name instead of :id,
I see all attributes for that station.

** All Attributes must be present **
```

- [ ]


```
As a visitor,
When I visit the trips index,
I see the first 30 trips (duration, start date, start station, end date, end station, bike id, subscription type, zip code),
I also see a button to see more pages of trips,

When I visit a second page, there should be buttons to move both forward and backward in time.

** All Attributes must be present **
```
- [ ]

```
As a visitor,
When I visit the trip show,
I see all attributes for that trip.
```
- [ ]

```
As a visitor,
When I visit the conditions index,
I see all conditions (Date, Max Temperature, Mean Temperature, Min Temperature, Mean Humidity, Mean Visibility (in Miles), Mean Wind Speed (mph), Precipitation (inches))

** All Attributes must be present **
```
- [ ]

```
As a visitor,
When I visit a condition show,
I see all attributes for that condition.

** All Attributes must be present **
```
- [ ]

```
As a visitor,
When I visit "/",
I see a link for "Login",
When I click "Login",
I should be on the "/login" page,
I see a link to "Create Account",

When I click link "Create Account",
I fill in my desired credentials,
And I submit my information,
My current page should be "/dashboard",
I see a message in the navbar that says "Logged in as SOME_USER",
I see my profile information,
I do not see a link for "Login",
I also see a link for "Logout".
```
- [ ]

```
As a visitor,
When I visit '/bike-shop',
I see at least 12 bike accessories (items) for sale,
I see a button near each item that says "Add to Cart".

When I click "Add to Cart",
I see a flash message alerting me that I have added that specific accessory to my cart.
I also see my cart count updated on all pages.
```
- [ ]

```
As a visitor,
When I visit '/cart',
I see all the bike accessory I have added to my cart,
I see a subtotal and quantity breakdown for each accessory,
I see a total for my cart,
After I create an account,
I visit "/cart,
I see all of the data that was there when I was not logged in.
``` 
- [ ]

```
As a visitor,
When I visit "/cart"
And I click link "Remove" next to an accessory,
My current page should be "/cart",
I see a flash message,
The message should say "Successfully removed SOME_ACCESSORY from your cart.",
The flash message should be a link to that accessory in case the user wants to add it back,
I also should not see the accessory listed in cart
```
- [ ]

```
As a visitor,
When I visit an accessory show for a retired accessory,
I am still able to access the accessory page,
I am not able to add the accessory to my cart,
I also see in place of the "Add to Cart" button or link - "Accessory Retired"
```
- [ ]

```
As a visitor,
When I visit "/cart",
I see my item with a quantity of 1,

When I increase the quantity,
The current page should be '/cart',
The item's quantity should reflect the increase,
The subtotal for that item should increase,
Also, the total for the cart should match that increase.
```
- [ ]

```
As a visitor,
When I visit "/cart",
I see my item with a quantity of 1,

When I decrease the quantity,
My current page should be '/cart',
The item's quantity should reflect the decrease,
The subtotal for that item should decrease,
The total for the cart should match that decrease.
```
- [ ]

```
As a visitor,
I cannot view another user's private data, such as current order, etc.
I should be redirected to /login when I try to check out,
I cannot view the administrator screens or use administrator functionality,
I cannot make myself an admin.
```
### As a registered user
- [ ]

```
As a registered user,
When I visit "/",
I see a link for "Login",

When I click "Login",
I should be on the "/login" page,
I see a place to insert my credentials to login,
I fill in my desired credentials,
I submit my information,
My current page should be "/dashboard",
I see a message in the navbar that says "Logged in as SOME_USER",
I see my profile information,
I do not see a link for "Login",
I see a link for "Logout".
```
- [ ]

```
As a registered user,
When I visit '/cart',
I see a small image, title, description and price for each accessory in my cart,
I see a subtotal and quantity breakdown for each accessory,
I see a total for my cart,
I also see a button to "Checkout".
```
- [ ]

```
As a registered user,
After adding a few items to my cart,
When I visit '/cart',
And click "Checkout",
I see my own dashboard,
I also see a flash message telling me I have "successfully submitted your order".
```
- [ ]

```
As a registered user,
When I visit '/dashboard'
And click one of my orders,
My current path should be '/orders/:id'
I see the bike accessories that I ordered broken down by subtotal and quantity,
I see the total for this order,
I see the status of this order (ordered, completed, paid, cancelled)
I see the date/time that the order was submitted,
I do not see the order of another user.

If the order was completed or cancelled,
I see a timestamp when the action took place.
```
- [ ]

```
As a registered user,
I cannot view another user's private data (current or past orders, etc),
I cannot view the administrator screens or use admin functionality,
I cannot make myself an admin.  
```
### As a registered user and admin
- [ ]

```
As a registered user and admin,
When I visit '/stations-dashboard',
I see the Total count of stations,
I see the Average bikes available per station (based on docks),
I see the Most bikes available at a station (based on docks),
I see the Station(s) where the most bikes are available (based on docks),
I see the Fewest bikes available at a station (based on docks),
I see the Station(s) where the fewest bikes are available (based on docks),
I see the Most recently installed station,
I also see the Oldest station.
```
- [ ]

```
As a registered user and admin,
When I visit '/trips-dashboard',
I see the Average duration of a ride,
I see the Longest ride,
I see the Shortest ride,
I see the Station with the most rides as a starting place,
I see the Station with the most rides as an ending place,
I see Month by Month breakdown of number of rides with subtotals for each year,
I see the Most ridden bike with total number of rides for that bike,
I see the Least ridden bike with total number of rides for that bike,
I see the User subscription type breakout with both count and percentage,
I see the Single date with the highest number of trips with a count of those trips,
I see the Single date with the lowest number of trips with a count of those trips.
```
- [ ]

```
As a registered user and admin,
When I visit a station show,
In addition to the user story above,
I see the Number of rides started at this station,
I see the Number of rides ended at this station,
I see the Most frequent destination station (for rides that began at this station),
I see the Most freuqnet origination station (for rides that ended at this station),
I see the Date with the highest number of trips started at this station,
I see the Most frequent zip code for users starting trips at this station,
I see the Bike ID most frequently starting a trip at this station.
```
- [ ]

```
As a registered user and admin,
When I visit '/weather-dashboard',
I see the Breakout of average number of rides, highest number of rides, and lowest number of rides on days with a high temperature in 10 degree chunks (e.g. average number of rides on days with high temps between fifty and sixty degrees),
I see the Breakout of average number of rides, highest number of rides, and lowest number of rides on days with precipitation in half-inch increments,
I see the Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean wind speeds in four mile increments,
I see the Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean visibility in miles in four mile increments.
```
- [ ]

```
As a registered user and admin,
When I visit '/trips-dashboard',
I see the Weather on the day with the highest rides.
I see the Weather on the day with the lowest rides.
```
- [ ]

```
As a registered user and admin,
When I visit '/',
And I click "Logout",
I see "Login",
I do not see "Logout".
```
- [ ]

```
As a registered user and admin,
I can modify my account data,
I cannot modify any other user's account data.
```

### As a admin
- [ ]

```
As a admin,
When I visit the stations index,
I see everything a visitor can see,
I see a button next to each station to edit that station,
I also see a button next to each station to delete that station.
```
- [ ]

```
As an admin,
When I visit the station show,
I see all attributes a visitor can see,
I see a button to delete this station,
I also see a button to edit this station.
```
- [ ]

```
As a admin,
When I visit '/admin/stations/new',
I fill in a form with all station attributes,
When I click "Create Station",
I am directed to that station's show page.
I also see a flash message that I have created that station.

** All Attributes must be present **
```
- [ ]

```
As a admin,
When I visit '/admin/stations/edit,
I fill in a form with all station attributes,
When I click "Update Station",
I am directed that station's show page,
I see the updated station's information,
I also see a flash message that I have updated that station.

** All Attributes must be present **
```
- [ ]

```
As an admin,
When I visit the stations index,
And I click delete next to a station,
I do not see the station on the index.
I also see a flash message that I have deleted that station.
```
- [ ]

```
As a admin,
When I visit the trips index,
I see all attributes that a visitor can see,
I see a button next to each trip to edit that trip,
I also see a button next to each trip to delete that trip.
```
- [ ]

```
As an admin,
When I visit the trip show,
I see everything a visitor can see,
I see a button to delete this trip,
I also see a button to edit this trip.

** All Attributes must be present **
```
- [ ]

```
As a admin,
When I visit '/admin/trips/new',
I fill in a form with all trip attributes,
When I click "Create Trip",
I am directed to that trip's show page.
I also see a flash message that I have created that trip.


** Zip Code is a user-provided field, and may not be present on all records. Otherwise, as with Stations, all attributes of a Trip need to be present to ensure data integrity **
```
- [ ]

```
As a admin,
When I visit '/admin/trips/edit,
I fill in a form with all trip attributes,
When I click "Update Trip",
I am directed to that trip's show page,
I see the updated trip's information,
I also see a flash message that I have updated that trip.

** All Attributes must be present **
```
- [ ]

```
As an admin,
When I visit the trips index,
And I click delete next to a trip,
I do not see the trip on the index.
I also see a flash message that I have deleted that trip.
```
- [ ]

```
As a admin,
When I visit the conditions index,
I see everything that a visitor can see,
I see a button next to each condition to edit that condition,
I also see a button next to each condition to delete that condition.
```
- [ ]

```
As an admin,
When I visit a conditon show,
I see all the attributes a visitor can see,
I see a button to delete this condition,
I also see a button to edit this condition.
```
- [ ]

```
As a admin,
When I visit '/admin/conditions/new',
I fill in a form with all condition attributes,
When I click "Create Condition",
I am directed to a that condition's show page.
I also see a flash message that I have created that condition.

** All Attributes must be present **
```
- [ ]

```
As a admin,
When I visit '/admin/conditions/edit,
I fill in a form with all condition attributes,
When I click "Update Condition",
I am directed to that condition's show page,
I see the updated condition's information,
I also see a flash message that I have updated that condition.

** All Attributes must be present **
```
- [ ]

```
As an admin,
When I visit the conditions index,
And I click delete next to a condition,
I do not see the condition on the index.
I also see a flash message that I have deleted that condition
```
- [ ]

```
As an admin,
When I visit "/",
I see a link for "Login",

When I click "Login",
I should be on the "/login" page,
I see a place to insert my credentials to login,
I fill in my desired credentials,
I submit my information,
My current page should be "/admin/dashboard",
I see a message in the navbar that says "Logged in as Admin User: SOME_USER",
I see my profile information,
I do not see a link for "Login",
I see a link for "Logout"
```
- [ ]

```
As an admin,
When I visit an individual order page,
I see the order's date and time,
I see the purchaser's full name and address,
I see the item's name, which is linked to the item page.
I see the quantity in this order.
I see the line item subtotal,
I see the total for the order,
I also see the status for the order.
```
- [ ]

```
As an admin,
When I visit "/admin/dashboard",
I see a link for viewing all accessories,
When I click that link,
My current path should be "/admin/bike-shop",
I see a table with all accessories (active and inactive)

Each accessory should have:

A thumbnail of the image
Description
Status
Ability to Edit accessory
Ability to Retire/Reactivate accessory
```
- [ ]

```
As an admin,
When I visit '/admin/dashboard',
I see a list of all orders,
I see the total number of orders for each status ("Ordered", "Paid", "Cancelled", "Completed"),
I see a link for each individual order,
I can filter orders to display by each status type ("Ordered", "Paid", "Cancelled", "Completed"),
I have links to transition between statuses

I can click on "cancel" on individual orders which are "paid" or "ordered"
I can click on "mark as paid" on orders that are "ordered"
I can click on "mark as completed" on orders that are "paid"
```
- [ ]

```
As an admin
When I visit 'admin/bike-shop/new'
I can create an accessory,
An accessory must have a title, description and price,
The title and description cannot be empty,
The title must be unique for all accessories in the system,
The price must be a valid decimal numeric value and greater than zero,
The photo is optional. If not present, a stand-in photo is used. (PAPERCLIP)
```

## Details for Seeding CSVs

Download the dataset available [here](https://www.kaggle.com/benhamner/sf-bay-area-bike-share). This will include all of the CSV files that you will be using in this project. Since these files are large, we have set up your project directory structure and .gitignore so that when you add these files to the /db/csv/ directory they will not be pushed up to GitHub. However, this also means that each of the members of your team will need to download these files independently. Please note that there are idiosyncracies in the data that are outlined in some detail [here](https://www.kaggle.com/benhamner/sf-bay-area-bike-share/discussion/23165). These may not be important to you at this moment, but this will be an important reference as you move through future iterations.

Update the seeds file in your /db directory and add the station.csv file to your /db/csv/ directory. When you run rake db:seed your development database should be populated with the information from the station.csv file. Your index should include a total of seventy stations.


## Evaluation Process

For the evaluation we'll work through the expectations above and look at the following criteria:

### 1. Feature Completeness

* Exceeds Expectations: All features are correctly implemented along with two extensions and project is depoyed
* Meets Expectations: All features defined in the assignment are correctly implemented and project is deployed
* Below Expectations: There are one or two features missing or incorrectly implemented and/or project is not fully deployed

### 2. Views

* Exceeds Expectations: Views show logical refactoring into layout(s), partials and helpers, with no logic present
* Meets Expectations: Views make use of layout(s), partials and helpers, but some logic leaks through
* Below Expectations: Views don't make use of partials or show weak understanding of `render`

### 3. Controllers

* Exceeds Expectations: Controllers show significant effort towards refactoring and pushing logic down the stack
* Meets Expectations: Controllers are generally well organized with three or fewer methods that need refactoring
* Below Expectations: There are four to seven controller methods that should have been refactored

### 4. Models

* Exceeds Expectations: Models show excellent organization, refactoring, and appropriate use of Rails features
* Meets Expectations: Models show an effort to push logic down the stack, but need more internal refactoring
* Below Expectations: Models are somewhat messy and/or make poor use of Rails features

### 5. Testing

* Exceeds Expectations: Project has a running test suite that exercises the application at multiple levels and utilizes mocking & stubbing
* Meets Expectations: Project has a running test suite that covers all functionality and tests at multiple levels
* Below Expectations: Project has sporadic use of tests at multiple levels

### 6. Usability

* Exceeds Expectations: Project is highly usable and ready to deploy to customers
* Meets Expectations: Project is highly usable, but needs more polish before it'd be customer-ready
* Below Expectations: Project needs more attention to the User Experience, some views need to use a URL to visit them

### 7. Workflow

* Exceeds Expectations: Excellent use of branches, pull requests, code review and a project management tool.
* Meets Expectations: Good use of branches, pull requests, code review, rebasing, and a project-management tool.
* Below Expectations: Sporadic use of branches, pull requests, and/or project-management tool.
