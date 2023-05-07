---
layout: page
title: Coupon Codes
---

This project is an extension of the Little Esty Shop group project. You will add functionality for merchants to create coupons for their shop. 

## Learning Goals

* Write migrations to create tables and relationships between tables
* Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
* Write model tests that fully cover the data logic of the application
* Write feature tests that fully cover the functionality of the application

## Deets

* This is a solo project, to be completed alone without assistance from cohortmates, alumni, mentors, rocks, etc.
* Additional gems to be added to the project must have instructor approval. (RSpec, Capybara, Shoulda-Matchers, Orderly, HTTParty, Launchy, Faker and FactoryBot are pre-approved)
* Scaffolding is not permitted on this project.
* This project must be deployed to Heroku.

## Setup

This project is an extension of Little Esty Shop. Students have two options for setup:

1. If your Little Esty Shop project is complete, you can use it as a starting point for this project. If you are not the repo owner, fork the project to your account. If you are the repo owner, you can work off the repo without forking, just make sure your teammates have a chance to fork before pushing any commits to your repo
1. If your Little Esty Shop project is not complete, fork [this repo](https://github.com/turingschool-examples/little_esty_shop_bulk_discounts) as a starting point for this project.
1. Scaffolding is not permitted for this project.
1. Additional gems for this project needs to be approved by instructors.

## Evaluation
Evaluation information for this project can be found [here](./evaluation).

-----

## Functionality Overview
​
1. Merchants have a link on their dashboard to manage their coupons.
1. Merchants have full CRUD functionality over their coupons with criteria/restrictions mentioned below:
   - merchants can have a maximum of 5 coupons enabled in the system at one time
   - merchants can not delete a coupon, but rather activate/inactivate them.
   - A coupon will have a name, unique code, and either percent-off or dollar-off value. The code must be unique in the whole database.
1. Coupons will be added to Invoices. 
   - Only one coupon code can be on an invoice
1. If a coupon's dollar value ($10 off) exceeds the total cost of that merchant's items in the invoice, the discounted total for that merchant's items is $0.
1. A coupon code from a merchant only applies to items sold by that merchant.
1. The Merchant and Admin Invoice Show Pages should show the coupon code used, the amount that was discounted, the grand total (as you had it originally), and finally, the “discounted total”. 

​
## User Stories

```
1. Merchant Coupons Index 

As a merchant
When I visit my merchant dashboard page
I see a link to view all of my coupons
When I click this link
I'm taken to my coupons index page
Where I see all of my coupon names including their amount off 
And each name listed links to it's show page
```

```
2. Merchant Coupon Create 

As a merchant
When I visit my coupon index page 
I see a link to create a new coupon
When I click that link 
I am taken to a new page where I see a form to add a new coupon
When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
And hit submit
I'm taken back to the coupon index page 
And I can see my new coupon listed
```

* Sad Paths to consider: 
1. Merchant already has 5 enabled coupons
2. Coupon code entered is NOT unique

```
3. Merchant Coupon Show Page 

As a merchant 
When I visit a merchant coupon's show page 
I see that coupon's name and code 
As well as the percent/dollar off 
As well as it's status (active or inactive)
And I see a count of how many times that coupon has been used
```

```
4. Merchant Coupon Deactivate

As a merchant 
When I visit one of my activated coupons show pages
I see a link to deactivate that coupon
When I click that link
I'm taken back to the coupon show page 
And I can see that it's status is now listed as 'inactive'
```
* Sad Paths to consider: 
- A coupon can not be deactivated if there are any pending invoices with that coupon.

```
5. Merchant Coupon Activate

As a merchant 
When I visit one of my inactive coupons show pages
I see a link to activate that coupon
When I click that link
I'm taken back to the coupon show page 
And I can see that it's status is now listed as 'active'
```

```
6. Merchant Coupon Index Sorted

As a merchant
When I visit my coupon index page
I can see that my coupons are separated between active and inactive coupons
Within those sections
The coupons are ordered by popularity
```

```
7. Merchant Invoice Show Page: Total Revenue and Discounted Revenue 
As a merchant
When I visit one of my merchant invoice show pages
I see the total revenue for my merchant from this invoice (not including discounts)
And I see the name and code of the coupon used
And I see the total revenue before and after the coupon was applied. 
And the name of the coupon is a link to that coupons show page
```

```
7. Admin Invoice Show Page: Total Revenue and Discounted Revenue 
As an admin
When I visit one of my admin invoice show pages
I see the name and code of the coupon that was used (if there was a coupon applied)
And I see the total revenue from that invoice before and after the coupon was applied.
```

```
8: Holidays API

As a merchant
When I visit the coupons index page
I see a section with a header of "Upcoming Holidays"
In this section the name and date of the next 3 upcoming US holidays are listed.

Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)

```


## Extensions

* Coupons can be used by multiple customers, but may only be used one time per customer. (Validation for Invoice Model)
* Inactive coupons can not be added to an Invoice (Validation for Invoice Model)
* Holiday Coupons can be used up to 1 week from the actual holiday date. The coupon should automatically inactivate once someone tries to create an Invoice with that Coupon after a week of the holiday.
* Generate unique coupon codes as suggestions when creating a new coupon


```
Create a Holiday Coupon

As a merchant,
when I visit my coupons index page,
In the Holiday Coupons section, I see a `create coupon` button next to each of the 3 upcoming holidays.
When I click on the button I am taken to the new coupon page where I see a prefilled name in the form, something like:

   Name: <name of holiday> coupon
   Code: <uniquely generated code>

All other fields, I will need to fill out myself
I can leave the information as is, or modify it before saving.
I should be redirected to my coupons index page where I see the newly created coupon added to the list.
```

```
View a Holiday Coupon

As a merchant (if I have created a holiday coupon for a specific holiday),
when I visit my coupon index page,
within the `Upcoming Holidays` section I should not see the button to 'create a coupon' next to that holiday,
instead I should see a `view coupon` link.
When I click the link I am taken to the coupon show page for that holiday coupon.
```

