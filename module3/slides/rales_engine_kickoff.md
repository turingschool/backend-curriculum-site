# Rails Engine

---

# What is it?

* API exposing SalesEngine/Black Thursday Data
* 2 people
* 6 Tables
* 30 Record Endpoints
* 14 Relationship Endpoints
* 11 Business Intelligence endpoints
* 106 Spec Harness Assertions

---

# Goals

* Build Single-Responsibility controllers.
* Provide a well-designed and versioned API.
* Use controller tests to drive your design.
* Use Ruby and ActiveRecord to perform more complicated business intelligence.

---

# Dividing the Work

---

# Record Endpoints

* Person A
    * Merchants
    * Transactions
    * Customers

* Person B
    * Invoices
    * Items
    * Invoice Items

---

# Relationship Endpoints

* Person A
    * Invoices
    * Items
    * Invoice Items

* Person B
    * Merchants
    * Transactions
    * Customers

---

# BI Endpoints A

* GET /api/v1/merchants/:id/revenue
* GET /api/v1/merchants/:id/revenue?date=x
* GET /api/v1/merchants/most_items?quantity=x
* GET /api/v1/customers/:id/favorite_merchant
* GET /api/v1/items/:id/best_day
* GET /api/v1/items/most_items?quantity=x

---

# BI Endpoints B

* GET /api/v1/merchants/:id/customers_with_pending_invoices
* GET /api/v1/merchants/:id/favorite_customer
* GET /api/v1/items/most_revenue?quantity=x
* GET /api/v1/merchants/revenue?date=x
* GET /api/v1/merchants/most_revenue?quantity=x

---

# Technical Expectations

* Endpoints will return JSON data
* Endpoints exposed under an `api` and version (`v1`)
namespace (e.g. `/api/v1/merchants.json`)
* JSON responses will include `ids` only for associated records unless otherwise indicated
* Prices will be displayed in dollars (`12345` becomes `123.45`)
* JSON responses will be valid (contain a key and a value)

---

# Feedback

* No formal check-ins
* PR reviews preferred
* Instructors will also generally be available during the school day

---

# Milestones

* Most difficult work will likely be the business intelligence
* Recommended first step is to lay out milestones
* Provide yourself time to spare

---

# Evaluation

* Completion
* Test-Driven Development
* Code Quality
* API Design
* Queries
