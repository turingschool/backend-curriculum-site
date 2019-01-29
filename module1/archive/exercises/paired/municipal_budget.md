---
layout: page
title: Practice Paired Assessment
---

### Iteration 1

Clone the following repository: `git@github.com:turingschool-examples/municipal-budget.git`

Use the tests in `budget_category_test.rb` and `department_test.rb` to drive the development of the functionality described below.

```ruby
department = Department.new("Parks and Recreation")
#=> <Department...>
department.name
#=> "Parks and Recreation"
department.expenses = []

budget_category = BudgetCategory.new("Appliances")
#=> <BudgetCategory...>
budget_category.name
#=> "Appliances"
```


### Iteration 2

Writing your own tests to drive development, create an `Expense` and `MunicipalBudget` class with the functionality described below.

```ruby
d = Department.new("Parks and Recreation")
bc = BudgetCategory.new("Appliances")
expense = Expense.new(d, bc, "656.50")
#=> <Expense...>
expense.department
#=> <Department...>
expense.budget_category
#=> <BudgetCategory...>
expense.amount
#=> 656.50 (float)

municipal_budget = MunicipalBudget.new
municipal_budget.expenses
#=> []
```


### Iteration 3

Writing your own tests to drive development, create the functionality for the `MunicipalBudget` class described below.

```ruby
municipal_budget = MunicipalBudget.new
department = Department.new("Parks and Recreation")
budget_category = BudgetCategory.new("Appliances")
expense_1 = Expense.new(department, budget_category, "656.50")

municipal_budget.add_expense(expense_1)
municipal_budget.expenses
#=> [<Expense...>]
municipal_budget.expenses.count
#=>1

expense_2 = Expense.new(department, budget_category, "20.45")

municipal_budget.add_expense(expense_2)
municipal_budget.expenses
#=> [<Expense...>, <Expense...>]
municipal_budget.expenses.count
#=>2

municipal_budget.departments
#=> [<Department...>, <Department...>]

municipal_budget.budget_categories
#=> [<BudgetCategory...>, <BudgetCategory...>]
```


### Iteration 4

Writing your own tests to drive development, add the following features to `MunicipalBudget`.

```ruby
municipal_budget = MunicipalBudget.new
department = Department.new("Parks and Recreation")
budget_category_1 = BudgetCategory.new("Printing")
expense_1 = Expense.new(department, budget_category_1, "656.50")

budget_category_2 = BudgetCategory.new("Appliances")
expense_2 = Expense.new(department, budget_category_2, "20.45")

municipal_budget.add_expense(expense_1)
municipal_budget.add_expense(expense_2)

municipal_budget.total_expenses
#=> 676.95

municipal_budget.alphabetical_budget_categories
#=> ["Appliances", "Printing"]
```
