---
layout: page
title: User Stories
---

## Story 1: Create Wireframes for Most Important Views

Think about what you think the workflow should be on the site. Which of those views is most important?
In addition to the home page wireframe, create wireframes the page immediately following your Log In and the next most important page for your application.
Examples might be: A users' profile page, a product page, an admin dashboard etc...

## Story 2: Visitor can view items

Background: I have several items and each of them has a title, description, price, and image

As a visitor
When I visit "/items"
I can see all existing items

## Story 3: Browsing Items by category

Background: I have two categories with titles and each has two different items assigned

As a visitor
When I visit "/:CATEGORY_NAME"
I see all items assigned to that category

## Story 4: Adding items to the cart

Background: Items, and a user that is not logged in

As a visitor
When I visit any page with an item on it
I should see a link or button for "Add to Cart"
When I click "Add to cart" for that item
And I click a link or button to view cart
And my current path should be "/cart"
And I should see a small image, title, description and price for the item I just added
And there should be a "total" price for the cart that should be the sum of all items in the cart

## Story 5: Removing an item from my cart

Background: My cart has an item in it

As a visitor
When I visit "/cart"
And I click link "Remove"
Then my current page should be "/cart"
And I should see a message styled in green
And the message should say "Successfully removed SOME_ITEM from your cart."
And the title "SOME_ITEM" should be a link to that item in case the user wants to add it back
And I should not see the item listed in cart

## Story 6: Adjusting the quantity of an item in the cart

Background: My cart has an item in it

As a visitor
When I visit "/cart"
Then I should see my item with a quantity of 1
And when I increase the quantity
Then my current page should be '/cart'
And that item's quantity should reflect the increase
And the subtotal for that item should increase
And the total for the cart should match that increase

## Story 7:

Background: My cart has an item in it

As a visitor
When I visit "/cart"
Then I should see my item with a quantity of 1
When I decrease the quantity
Then my current page should be '/cart'
And that item's quantity should reflect the decrease
And the subtotal for that item should decrease
And the total for the cart should match that decrease

## Story 8: Authenticated User

As a registered user
When I visit "/"
Then I should see a link for "Login"
And when I click "Login"
And I should be on the "/login" page
And I should see a place to insert my credentials to login
And I fill in my desired credentials
And I submit my information
Then my current page should be "/dashboard"
And I should see a message in the navbar that says "Logged in as SOME_USER"
And I should see my profile information
And I should not see a link for "Login"
And I should see a link for "Logout"

## Story 9: New User Can Create an Account

As a visitor
When I visit "/"
Then I should see a link for "Login"
And when I click "Login"
And I should be on the "/login" page
And I should see a link to "Create Account"
And when I click link "Create Account"
And I fill in my desired credentials
And I submit my information
Then my current page should be "/dashboard"
And I should see a message in the navbar that says "Logged in as SOME_USER"
And I should see my profile information
And I should not see a link for "Login"
And I should see a link for "Logout"

## Story 10: Guest User

As a visitor when I have items in my cart
And when I visit "/cart"
I should not see an option to "Checkout"
I should see an option to "Login or Create Account to Checkout"
After I create an account
And I visit "/cart
Then I should see all of the data that was there when I was not logged in

## Story 11: User Can Log Out

As a logged in user
When I click "Logout"
Then I should see see "Login"
And I should not see "Logout"

## Story 12: Viewing past orders

Background: An existing user that has multiple orders

As an Authenticated User
When I visit "/orders"
Then I should see all orders belonging to me and no other orders

## Story 13: Viewing a past order

Background: An existing user that has one previous order

As an authenticated user
When I visit "/orders"
Then I should see my past order
And I should see a link to view that order
And when I click that link
Then I should see each item that was order with the quantity and line-item subtotals
And I should see links to each item's show page
And I should see the current status of the order **(ordered, paid, cancelled, completed)**
And I should see the total price for the order
And I should see the date/time that the order was submitted

If the order was completed or cancelled
Then I should see a timestamp when the action took place

## Story 14: Retired Items

As a user if I visit an item page and that item has been retired
Then I should still be able to access the item page
And I should not be able to add the item to their cart
And I should see in place of the "Add to Cart" button or link - "Item Retired"

## Story 15: Checking out

Background: An existing user and a cart with items

As a visitor
When I add items to my cart
And I visit "/cart"
And I click "Login or Register to Checkout"
Then I should be required to login

When I am logged in
And I visit my cart
And when I click "Checkout"
Then the order should be placed
And my current page should be "/orders"
And I should see a message "Order was successfully placed"
And I should see the order I just placed in a table

## Story 16: Authenticated users security

Background: An authenticated user

As an Authenticated User
I cannot view another user's private data (current or past orders, etc)
I cannot view the administrator screens or use admin functionality
I cannot make myself an admin

## Story 17: Unauthenticated users security

Background: An unauthenticated user and their abilities

As an Unauthenticated User
I cannot view another user's private data, such as current order, etc.
I should be redirected to login/create account when I try to check out.
I cannot view the administrator screens or use administrator functionality.
I cannot make myself an administrator.

## Story 18: Admin User Dashboard

As a logged in Admin
When I visit "/admin/dashboard"
I will see a heading on the page that says "Admin Dashboard"

As a registered user
When I visit "/admin/dashboard"
I get a 404

As an unregistered user
When I visit "/admin/dashboard"
I get a 404

## Story 19: Admin logs in

As an Admin
When I log in
Then I am redirected to "/admin/dashboard"

## Story 20: Admin cannot modify users

As a logged in Admin
I can modify my account data

But I cannot modify any other user's account data


## Story 21: Admin views an individual Order

As an authenticated Admin, when I visit an individual order page
Then I can see the order's date and time.
And I can see the purchaser's full name and address.
And I can see, for each item on the order:
  - The item's name, which is linked to the item page.
  - Quantity in this order.
  - Price
  - Line item subtotal.
And I can see the total for the order.
And I can see the status for the order.

## Story 22: Admin Item Creation

As an authenticated Admin:
I can create an item.
- An item must have a title, description and price.
- An item must belong to at least one category.
- The title and description cannot be empty.
- The title must be unique for all items in the system.
- The price must be a valid decimal numeric value and greater than zero.
- The photo is optional. If not present, a stand-in photo is used.

## Story 23: Admin Viewing items

As an Admin
When I visit "/admin/dashboard"
Then I should see a link for viewing all items
And when I click that link
Then my current path should be "/admin/items"
Then I should see a table with all items (active and inactive)
And each item should have:
- A thumbnail of the image
- Title that links to the item
- Description
- Status
- Ability to Edit Item
- Ability to Retire/Reactivate Item

## Story 24: Admin edits an item

Background: an existing item

As an admin
When I visit "admin/items"
And I click "Edit"
Then my current path should be "/admin/items/:ITEM_ID/edit"
And I should be able to update title, description, image, and status

## Story 25: Admin Orders

As an Admin
When I visit the dashboard
Then I can see a listing of all orders
And I can see the total number of orders for each status **("Ordered", "Paid", "Cancelled", "Completed")**
And I can see a link for each individual order
And I can filter orders to display by each status type  **("Ordered", "Paid", "Cancelled", "Completed")**
And I have links to transition between statuses
- I can click on "cancel" on individual orders which are "paid" or "ordered"
- I can click on "mark as paid" on orders that are "ordered"
- I can click on "mark as completed" on orders that are "paid"

## Story 26: Analytics Dashboard

As an admin
When I visit the admin dashboard
I can see a link to the analytics dashboard
When I click the link I am redirected to "/admin/analytics-dashboard"

## Story 27: User Breakdown

On the analytics-dashboard
I see the user who has placed the most orders

## Story 28: Category Breakdown

On the analytics-dashboard
For each category, I see the highest price item for the category and then
I see a breakdown of how many orders have been placed for the category.

## Story 29: Retired Item Analytics

On the analytics-dashboard
I see a list of items that have ever been retired, including their item name, current status (retired or active) and total retired count. Items should be ordered by how many times they have been retired (retired count).

## Story 30: Orders by State

On the analytics-dashboard
I see a state by state (alphabetically) breakdown of how many **completed** orders were "sent" there.
I also have a sort button that allows me to arrange my states by order count.
