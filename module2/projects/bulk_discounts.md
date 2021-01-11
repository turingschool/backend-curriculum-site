# Bulk Discounts

This project is an extension of the Little Esty Shop group project. You will add functionality for merchants to create bulk discounts for their items. A "bulk discount" is a discount based on the quantity of items the customer is buying, for example "20% off orders of 10 or more items".

## Learning Goals

* Write migrations to create tables and relationships between tables
* Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
* Write model tests that fully cover the data logic of the application
* Write feature tests that fully cover the functionality of the application

## Requirements

### CRUD Bulk Discounts

Tasks:
* Merchants should have full CRUD functionality over their bulk discounts including index and show pages for discounts
* Merchant invoice show page should reflect discounted total
* Admin invoice show page should reflect discounted total

```
Merchant Bulk Discounts Index

As a merchant
When I visit my merchant dashboard
Then I see a link to view all my discounts
When I click this link
Then I am taken to my bulk discounts index page
Where I see all of my bulk discounts including their
percentage discount and quantity thresholds
And each bulk discount listed includes a link to its show page
```

```
Merchant Bulk Discounts Show

As a merchant
When I visit my bulk discount show page
Then I see the bulk discounts quantity and price
```

```
Merchant Invoice Show Page: Total Revenue includes discounts

As a merchant
When I visit my merchant invoice show page
Then I see that the total revenue for my merchant includes bulk discounts in the calculation
```

```
Merchant Invoice Show Page: Link to applied discounts

As a merchant
When I visit my merchant invoice show page
Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)
```

```
Admin Invoice Show Page: Total Revenue includes discounts

As an admin
When I visit an admin invoice show page
Then I see that the total revenue includes bulk discounts in the calculation
```

* Bulk discounts should have a percentage discount as well as a quantity threshold
* Bulk discounts should belong to a Merchant

* A Bulk discount is eligible for all items that the merchant sells. Bulk discounts for one merchant should not affect items sold by another merchant
* Bulk discounts should apply on a per-item basis
    * If the quantity of an item ordered meets or exceeds the quantity threshold, then the percentage discount should apply to that item only. Other items that did not meet the quantity threshold will not be affected.
    * The quantities of items ordered cannot be added together to meet the quantity thresholds, e.g. a customer cannot order 1 of Item A and 1 of Item B to meet a quantity threshold of 2. They must order 2 or Item A, or 2 of Item B, or both.
* Merchants can have multiple bulk discounts
    * If an item meets the quantity threshold for multiple bulk discounts, only the one with the greatest percentage discount should be applied


* All revenue calculations should include discounts
* Merchant invoice show page should show which discounts were applied
