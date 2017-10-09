# Joins, Group, & Order

---

# Learning Goals

* Use `joins` to collect information from multiple tables
* Use `group` to group results by a common characteristic
* Use `order` to order grouped results

---

# Warmup

* What new ActiveRecord methods did you learn over the weekend?

---

# Joins

---

# Courses Table

| id | title | description                             |
|----|-------|-----------------------------------------|
| 1  | BE M1 | OOP with Ruby                           |
| 2  | BE M2 | Web Applications with Ruby              |
| 3  | BE M3 | Professional Rails Applications         |
| 4  | BE M4 | Client-Side Development with JavaScript |

---

# Students Table

| id | first_name | last_name | module_id |
|----|------------|-----------|-----------|
| 1  | Sal        | Espinosa  | 2         |
| 2  | Ilana      | Corson    | 2         |
| 3  | Josh       | Mejia     | 3         |
| 4  | Casey      | Cumbow    | 4         |
| 5  | Ali        | Schlereth | 1         |
| 6  | Victoria   | Vasys     | 1         |
| 7  | Mike       | Dao       | 1         |

---

# SQL JOIN Query

```SQL
SELECT * FROM courses JOIN students ON students.module_id = courses.id;
```

---

# SQL JOIN Result

| id | title | description                             | id | first_name | last_name | module_id |
|----|-------|-----------------------------------------|----|------------|-----------|-----------|
| 1  | BE M1 | OOP with Ruby                           | 5  | Ali        | Schlereth | 1         |
| 1  | BE M1 | OOP with Ruby                           | 6  | Victoria   | Vasys     | 1         |
| 1  | BE M1 | OOP with Ruby                           | 7  | Mike       | Dao       | 1         |
| 2  | BE M2 | Web Applications with Ruby              | 1  | Sal        | Espinosa  | 2         |
| 2  | BE M2 | Web Applications with Ruby              | 2  | Ilana      | Corson    | 2         |
| 3  | BE M3 | Professional Rails Applications         | 3  | Josh       | Mejia     | 3         |
| 4  | BE M4 | Client-Side Development with JavaScript | 4  | Casey      | Cumbow    | 4         |

---

# ActiveRecord `joins`

```ruby
# In the Course model
def self.with_students
  joins(:students)
end

# From Tux
Course.joins(:students)
```

Adding `.count(:id)` to the end of those statements => 7
Will only have access to Course attributes

---

# `joins` with `select`

```ruby
# In the Course model
def self.with_students
  select("courses.*, students.*").joins(:students)
end

# From Tux
Course.select("courses.*, students.*").joins(:students)
```

Still returns 7 objects.
Will have access to attributes on both tables.

---

# Using Attributes from the Combined Table

```
Course.selct("courses.*, students.*")
  .joins(:students)
  .first
  .first_name
```

---

# Group

```ruby
# In the Student model
def self.count_by_module_id
  group(:module_id).count
end
```

Returns:

```ruby
{1 => 3, 2 => 2, 3 => 1, 4 => 1}
```

---

# Order

```ruby
# In the Student model
def self.count_by_module_id
  group(:module_id).order("count_all").count
end
```

Returns:

```ruby
{3 => 1, 4 => 1, 2 => 2, 1 => 3}
```

---

# `group`, `order`, and a Calculation

```ruby
Genre.select("genres.*, sum(box_office_sales) AS total_sales")
  .joins(:films)
  .group(:genre_id)
  .order("total_sales DESC")
```

Returns a collection of Genre objects.

Could then call `total_sales` on the first element of the returned array.

---

# Checks for Understanding

* What does a `.joins` query do in ActiveRecord?
* `.group`?
* `.order`?
* `.select`?
* What does a `.group` query return when you have `.count` on the end?
* Without it?
