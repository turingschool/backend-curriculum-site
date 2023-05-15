---
layout: page
title: Coupon Codes
---

This project is an extension of the Little Esty Shop group project. You will add functionality for merchants to create coupons for their shop. 

## Learning Goals

* Write migrations to create tables and relationships between tables
* Implement CRUD functionality for a resource using forms, buttons, and links, and associated view helpers (`form_with`, `button_to`, etc)
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
* Write model tests that fully cover the data logic of the application
* Write feature tests that fully cover the functionality of the application

## Deets

* This is a solo project, to be completed alone without assistance from cohortmates, alumni, mentors, rocks, etc.
* Additional gems to be added to the project must have instructor approval. (RSpec, Capybara, Shoulda-Matchers, Orderly, HTTParty, Launchy, Faker and FactoryBot are pre-approved)
* Scaffolding is not permitted on this project.
* This project must be deployed to the intenret.

## Setup

This project is an extension of Little Esty Shop. Students have two options for setup:

1. If your Little Esty Shop project is complete, you can use it as a starting point for this project. If you are not the repo owner, fork the project to your account. If you are the repo owner, you can work off the repo without forking, just make sure your teammates have a chance to fork before pushing any commits to your repo.
1. If your Little Esty Shop project is not complete, fork [this repo](https://github.com/turingschool-examples/b2-final-starter-7) as a starting point for this project.

## Evaluation
Evaluation information for this project can be found [here](./evaluation).

-----

## Functionality Overview
​
1. Merchants have a link on their dashboard to manage their coupons.
1. Merchants have full CRUD functionality over their coupons with criteria/restrictions defined below:
   - Merchants can have a maximum of 5 coupons enabled in the system at one time.
   - Merchants cannot delete a coupon, but rather activate/inactivate them.
   - A coupon has a name, unique code, and either percent-off or dollar-off value. The code must be unique in the whole database.
1. A Coupon should belong to one Invoice. 
   - Only one coupon code can be used on an invoice.
     - *Note:* When creating this new association, your existing tests will fail unless the association is *optional*. Use [these guides](https://guides.rubyonrails.org/association_basics.html#optional) as a reference. 
2. If a coupon's dollar value (ex. "$10 off") exceeds the total cost of that merchant's items on the invoice, the discounted total for that merchant's items is $0. (In other words, the merchant will never *owe* money to a customer.)
3. A coupon code from a Merchant only applies to Items sold by that Merchant.
4. The Merchant and Admin Invoice Show Pages should show the coupon code used, the amount that was discounted, the subtotal (as you had it originally), and finally the "grand total" with discount applied. 

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
And each name listed links to its show page
```

```
2. Merchant Coupon Create 

As a merchant
When I visit my coupon index page 
I see a link to create a new coupon
When I click that link 
I am taken to a new page where I see a form to add a new coupon
When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
And click the Submit button
I'm taken back to the coupon index page 
And I can see my new coupon listed


* Sad Paths to consider: 
1. Merchant already has 5 enabled coupons
2. Coupon code entered is NOT unique
```

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
And I can see that its status is now listed as 'inactive'

* Sad Paths to consider: 
1. A coupon cannot be deactivated if there are any pending invoices with that coupon.
```

```
5. Merchant Coupon Activate

As a merchant 
When I visit one of my inactive coupon show pages
I see a link to activate that coupon
When I click that link
I'm taken back to the coupon show page 
And I can see that its status is now listed as 'active'
```

```
6. Merchant Coupon Index Sorted

As a merchant
When I visit my coupon index page
I can see that my coupons are separated between active and inactive coupons
And within those sections
I see that the coupons are ordered by popularity

(Popularity is defined as how many non-cancelled invoices have used a particular coupon.)
```

```
7. Merchant Invoice Show Page: Total Revenue and Discounted Revenue 

As a merchant
When I visit one of my merchant invoice show pages
I see the total revenue for my merchant from this invoice (not including coupon discounts)
And I see the name and code of the coupon used
And I see the total revenue before and after the coupon was applied
And the name of the coupon is a link to that coupon's show page
```

```
8. Admin Invoice Show Page: Total Revenue and Discounted Revenue 

As an admin
When I visit one of my admin invoice show pages
I see the name and code of the coupon that was used (if there was a coupon applied)
And I see the total revenue from that invoice both before and after the coupon was applied.
```

```
9: Holidays API

As a merchant
When I visit the coupons index page
I see a section with a header of "Upcoming Holidays"
In this section the name and date of the next 3 upcoming US holidays are listed.

Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)

```


## Extensions

* Coupons can be used by multiple customers, but may only be used one time per customer. (Validation for Invoice Model)
* Inactive coupons cannot be added to an Invoice. (Validation for Invoice Model)
* A Coupon has a maximum number of uses before it is automatically deactivated. When implemented, prove that the number of times used on the Merchant Coupon Show Page is updated accordingly. 
* Holiday Coupons can be used up to 1 week from the actual holiday date. The coupon should automatically inactivate once someone tries to create an Invoice with that Coupon after a week of the holiday.
* Generate unique coupon codes as suggestions when creating a new coupon.


```
Create a Holiday Coupon

As a merchant,
when I visit my coupons index page,
In the Holiday Coupons section, I see a `Create Coupon` button next to each of the 3 upcoming holidays.
When I click on the button I am taken to the new coupon page where I see a pre-filled name in the form, similar to:

   Name: <name of holiday> coupon
   Code: <uniquely generated code>

All other fields, I will need to fill out myself
I can leave the information as-is, or modify it before saving.
Then, I should be redirected to my coupon index page where I see the newly created coupon added to the list.
```

```
View a Holiday Coupon

As a merchant (if I have created a holiday coupon for a specific holiday),
when I visit my coupon index page,
within the `Upcoming Holidays` section I should not see the button to 'create a coupon' next to that holiday,
instead I should see a `view coupon` link.
When I click the link 
I am taken to the coupon show page for that holiday coupon.
```

