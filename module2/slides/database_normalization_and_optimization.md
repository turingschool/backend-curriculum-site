# Database Normalization & Optimization

---

# Warm-Up

* Read [this](https://www.essentialsql.com/get-ready-to-learn-sql-database-normalization-explained-in-simple-english/) article on database normalization.
* In your own words summarize what database normalization is.

---

# Sample Schema

```ruby
ActiveRecord::Schema.define(version: 20171204033005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "course_id"
    t.integer "score"
    t.index ["course_id"], name: "index_students_on_course_id"
  end

end
```

* What if this were a many-to-many relationship?

---

# Why Normalize

Imagine for a moment we did not normalize the database, but instead pursued one of the other solutions described above.

* How would we find all of the students enrolled in a particular course?
* What opportunities for error/corrupted information would exist?
* How does normalization help resolve these potential issues?

---

# Practice

* See lesson plan.

---

# How are tables and indexes actually stored in PostgreSQL

* See lesson plan.

---

# What are "btree" indexes?

A b-tree is like the "prefix" tree that you may have used in the [Complete Me](http://backend.turing.edu/module1/projects/complete_me) project in Mod 1, where each node in the tree can have multiple children. We won't dive into the theory of it, but this is the most-used index type within PostgreSQL.

