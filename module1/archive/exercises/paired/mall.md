---
layout: page
title: Practice Paired Assessment
---

### Iteration 1
Build out an `Employee` and `Store` class.

```ruby
employee = Employee.new("Rachel", 92836, "$32000")
# => #<Employee...>
employee.name
# => "Rachel"
employee.employee_id
# => 92836
employee.salary
# => 32000
```

```ruby
store = Store.new("Brookstone")
# => #<Store...>
store.name
# => "Brookstone"
store.employees
# => []
```

### Iteration 2

Continue to build on the ```Store``` class

```ruby
employee = Employee.new("Rachel", 92836, "$32000")

store.hire_employee(employee)

store.employees
# => [#<Employee...>]
store.employees.count
# => 1
```


### Iteration 3
Build out a `Mall` class

```ruby
mall = Mall.new
# => #<Mall...>
mall.stores
# => []

store = Store.new("Brookstone")

mall.open_store(store)

mall.stores
# => [#<Store...>]
mall.stores.count
# => 1
mall.stores.first
# => #<Store...>
mall.stores.first.employees
# => []

employee_1 = Employee.new("Rachel", 92836, "$32000")
employee_2 = Employee.new("Sid", 17638, "$30000")

mall.stores.first.hire_employee(employee_1)
mall.stores.first.hire_employee(employee_2)

mall.stores.first.employees
# => [#<Employee...>, #<Employee...>]
mall.stores.first.employees.count
# => 2
```

### Iteration 4

Continue to build on the `Mall` class

```ruby
store_1 = Store.new("Brookstone")
store_2 = Store.new("Sharper Image")

mall.open_store(store_1)
mall.open_store(store_2)

mall.store_names
# => ["Brookstone", "Sharper Image"]

employee_1 = Employee.new("Rachel", 92836, "$32000")
employee_2 = Employee.new("Sid", 17638, "$30000")
employee_3 = Employee.new("Jim", 41737, "$13000")

store_1.hire_employee(employee_1)
store_1.hire_employee(employee_3)
store_2.hire_employee(employee_2)

mall.all_employees
# => [#<Employee...>, #<Employee...>, #<Employee...>]

mall.count_all_employees
# => 3
```
