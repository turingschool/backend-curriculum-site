# Cart Implementation

---

# Warmup

* Briefly write a user story for adding an item to a cart.
* What tools do we have to store information/state?
* If you were creating a cart, what data type would you use to save items and quantities (in Ruby)?

---

# Tools

* Sessions
* POROs (without a resource in the database)
* Methods on ApplicationController that are inherited by other controllers
* `before_action`

---

# Cart Strategy

* Create a controller to handle cart requests (e.g. `#create`)
* Create a PORO to manage accessing items in the cart
* Create a method in our ApplicationController to set the cart for every request

---

# Adding an Item to the Cart

* Click on "Add Item"
* Route request to `cart#create`
* Get any items already in the session
* In `cart#create` use a PORO to add the item to the cart
* Update the session
* Redirect back to the `items_path`
* In the view, access `@cart` and its methods to display information about the cart on the page

---

# Tutorial

* Code along with the lesson
* If you'd like to push forward by yourself, feel free
* If you'd like to check in, let's plan on 10:50, 11:20, and 11:50
