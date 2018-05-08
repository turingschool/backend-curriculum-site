# Database Relationships & Visualizations

---

# Warm-Up

* Draw a diagram of the table in our Task Manager database. What information lives in that table?
* Assume we want to expand this application to allow for more than a single user. Each user should have multiple tasks. What changes would we need to make to our existing database?
* What changes would we need to make to our models in order to take advantage of the changes we made to our database?

---

# Schema Designer

* [Link in lesson plan](http://ondras.zarovi.cz/sql/demo/)
* Group: create a schema for users/tasks.
* Independent: dealerships/cars
* Share

---

# Many-to-Many Relationships

* Assume we now want to create a relationship between tasks and labels (e.g. `urgent`, `chore`, etc.)
* How would you create this relationship at the database level?

---

# Many-to-Many (continued)

* Tasks/labels
* Independent: Students/Courses
* Share

---

# Many-to-Many: Models

* What models will need to exist in our tasks/labels example?
* What will be the relationships on each of those models?
* How do you know?

---

# Model Relationships: Task

```ruby
class Task < ActiveRecord::Base
  has_many :label_tasks
  has_many :labels, through: :label_tasks
end
```

---

# Model Relationships: Label

```ruby
class Label < ActiveRecord::Base
  has_many :label_tasks
  has_many :tasks, through: :label_tasks
end
```

---

# Model Relationships: LabelTask

```ruby
class LabelTask < ActiveRecord::Base
  belongs_to :label
  belongs_to :task
end
```

---

# CFUs

* What is a primary key?
* What is a foreign key?
* What is a schema?
* How does a one-to-many relationship differ from a many-to-many relationship?
* Describe the relationship between a foreign key on one table and a primary key on another table.

