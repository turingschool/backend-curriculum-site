# ActiveRecord Associations

---

# Warmup

Describe the relationship between the following entities. Consider the relationship from both sides.

* Person and Social Security number
* Owner and pet
* Student and module
* Film and genre
* Book and author

---

# Types of Relationships

* One-to-One: e.g. person/social security number
* One-to-Many: e.g. student/module
* Many-to-Many: e.g. Book/author

---

# Database Level

* Tables
* Primary Keys
* Foreign Keys

---

# Example: Courses Table

| id | title | description                             |
|----|-------|-----------------------------------------|
| 1  | BE M1 | OOP with Ruby                           |
| 2  | BE M2 | Web Applications with Ruby              |
| 3  | BE M3 | Professional Rails Applications         |
| 4  | BE M4 | Client-Side Development with JavaScript |

---

# Example: Students Table

| id | first_name | last_name | module_id |
|----|------------|-----------|-----------|
| 1  | Sal        | Espinosa  | 4         |
| 2  | Ian     | Douglas   | 2         |
| 3  | Josh       | Mejia     | 3         |
| 4  | Megan      | McMahon    | 4         |
| 5  | Dione        | Wilson | 1         |
| 6  | Brian  | Zanti    | 1         |
| 7  | Mike       | Dao       | 1         |

---

# Model Level

* `has_many`
* `belongs_to`

---

# Example: Course Model

```ruby
class Course < ActiveRecord::Base
  has_many :students
end
```

* Note: `:students` is plural.

---

# Example: Student Model

```ruby
class Student < ActiveRecord::Base
  belongs_to :course
end
```

* Note: `:course` is singular.

---

# New Methods on Student

```ruby
Student.find(1).course # returns course

sal = Student.find_by(first_name: "Sal")
sal.course # returns M2
```

---

# New Methods on Course

```ruby
m2 = Course.find(2)
m2.students #returns a collection of students

Course.find(3).students
m4 = Course.find(4)
jeff = m4.students.create(first_name: "Jeff", last_name: "Casimir")
# creates a new student in M4

jorge = Student.create(first_name: "Jorge", last_name: "Tellez")
m4.students << jorge
# adds Jorge to M4
```

---

# Practice using the Set List Repo

---






file = File.read('comedian.csv')
