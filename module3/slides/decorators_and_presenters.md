# Helpers, Decorators, and Presenters

---

# Warmup

* Read [Sandi Metz' Rules for Developers](https://robots.thoughtbot.com/sandi-metz-rules-for-developers)
* Which of these would be the hardest to implement?
* Why?

---

# A Note on Opinions

* Everyone has them.

---

# Investigate (Groups of 4)

* Pull down [Guaranty Records](https://github.com/s-espinosa/guaranty_records/)
* Check out a different branch from the others in your group
* Compare and Contrast
* Each person write down advantages and disadvantages of their branch

---

# Investigation (Focus)

    * `/app/views/dashboards/index.html.erb`
    * `/app/controllers/dashboards_controller.rb`
    * `/app/models/employee.rb`
    * `/app/models/employee_presenter.rb`
    * `/app/models/employee_decorator.rb`
    * `/app/helpers/application_helper.rb`

---

# Share

---

# Additional Note

* Simple Delegator allows us to apply more than one decorator on a class.
* Can decorate a decorator.
* Can only inherit from one class.
* Including modules moves the module code into your class.

---

# Albums

* Pick one of the strategies and create a show page for albums.
* For an album display its title and artist: "Title, Artist"
* Also display its total revenue
