---
layout: page
title: Rails Engine Extensions
length: 1 week
tags:
type: project
---

Complete the following task for the Rails-Engine backend:

```
As a developer, I would like to make a rake task such as "rake seed:csv" which populates my database with the CSV data in a reproducable way.

This Rake Task should:
- Clear your Development database to prevent data duplication
- Seed your Development database with the CSV data
- Be invokable through Rake, i.e. you should be able to run `bundle exec rake <your_rake_task_name>` from the command line
- Convert all prices before storing. Prices are in cents, therefore you will need to transform them to dollars. (`12345` becomes `123.45`)
- Reset the primary key sequence for each table you import so that new records will receive the next valid primary key.
```

Complete the following stories on the Front End, Rails Driver:

Story 1:

```
As a user, when I visit /items/:id
then I should see the name of the merchant associated with that item
```

Story 2:

```
As a user, when I visit /admin/merchants/:id
then I should see the revenue that merchant has generated
```

Story 3:

```
As a user, when I visit /items
Then I should see an input to search for an item by name
When I fill in that input with some text
And I click the button 'Search for Item'
Then I should see a list of items with names that match my input
```

Story 4:

```
As a user, when I visit /admin
And I fill in the search field
And I click the "Search for Merchants" button
And I click the "Search for Merchants" button again,
Then I should not see duplicate results
```
