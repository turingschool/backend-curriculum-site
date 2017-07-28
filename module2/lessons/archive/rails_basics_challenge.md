#### Practice with Migrations: One-to-Many Relationship at the Database Level

Imagine that you have Students and Addresses. A student can have many addresses (ie - current address, permanent address, etc.), and an address belongs to one student. We're going to set up a Rails app to build this out.

1) Create a new rails project from your command line! It's your choice whether to use PG or sqlite. 

2) Create migrations (`rails g migration ...`) for both students and addresses. Make sure to give each object some applicable attributes (for example: first_name for students, street for addresses, etc.). 

3) Create a migration to add a boolean column `is_alumnus` to the students table. Give this a default value of false. Migrate this and watch how `schema.rb` changed. [Unsure how to add a column?](http://lmgtfy.com/?q=rails+migration+add+column). 

4) Rollback one previous migration. What file changed? Can you re-migrate so that `is_alumnus` is in your table again? 

#### Practice with Models: One-to-Many Relationship at the Model Level

1) Create a Student model that inherits from ApplicationRecord (practice doing this by hand -- don't use a generator).

2) Create an Address model that inherits from ApplicationRecord (practice doing this by hand -- don't use a generator).

3) Start `rails console` (or `rails c`) from the command line. Check how many class methods are available on the Student class with `Student.methods.count`. 

4) Create a new instance of a Student (`student = Student.new`). Check how many methods are available using `student.methods.count`.

5) Stay in the console and create a plain, empty Ruby class. (`class Thing; end`). Check how many methods are availble both for the class and an instance of the class. (`Thing.methods.count` and `t = Thing.new; t.methods.count`). Why do the Student class and instance have more methods than the Thing class and instance? Where do those methods come from? 

6) Still in the console, use the instance methods `new_record?`, `update`, and `save` on your `student` object from step 3. What do they do? Is SQL executed for any of them? Reference the docs if you're not sure how to use these methods.

7) Use the class methods `all` to see all Students, `find` to locate a student by an id, and `find_by` to locate a student by an attribute other than id. 

8) Go to your model files and add a line of code to both model files that would represent a one-to-many relationship between the Address and Student.

9) In the `rails console`, create a new Student (`student = Student.new(...)`), save that student (`student.save`), and create a new address for that student (`student.addresses.create(...)`).

10) Check the ActiveRecord relationship with `student.addresses`. What line of code did we write that allowed us to be able to call the `.addresses` method on an instance of student? 

11) Save the first address in the database to a variable: `a = Address.first`. What method you call on `a` to get the student associated with that address? Before you try it in the console, predict what SQL will be generated and executed for the query. 

#### Connecting Routes and Controllers

Use our routes and controllers lesson (and/or example application) from Friday to add functionality so that:

* when visiting `'/students'`, render a view (follow Rails naming conventions) with the names of all of the students
* when visiting `'/students/:id'`, render a view showing the student's name and a list of that student's addresses.

**Don't worry about building out beautiful views -- just get the data on the page in whatever way you can.**

Start up your server (`rails s`) and try navigating to `/students` and `/students/:id` to make sure these routes work the way you expect. 

#### Practice with Migrations: Many-to-Many Relationship

Imagine that you have Students, Courses, and Enrollments. A student has many courses, and a course has many students. The many-to-many relationship will be created through the join table `enrollments`. You should already have a table and model for students. 

1) Create two more migrations and models: courses and enrollments. This time, use the generator `rails g model...` instead of `rails g migration`. Review your notes from Friday's lesson if you've forgotten the difference between these two generators. Again, choose appropriate attributes for these models.

#### Practice with Many-to-Many associations

1) Set up a many-to-many relationship with Students, Courses, and Enrollments at the model level. Which part of this was already done for you by the model generators? 

2) In the console (`rails c`), create a new Student (`student = Student.create(...`). Create a new course (`course = Course.create(...)`). Now, type `student.enrollments.create(`course_id: course.id`). What new object was created, in which table, and with which attributes? Can you interpret the SQL that was executed? 

3) What happens if you create a new course and associate it with a student at the same time - for example: `student.courses.create(name: "Chemistry")`? What object(s) are created? Can you interpret the SQL that was executed in your terminal? 

4) Look at the ActiveRecord relationships with `student.enrollments` and `student.courses`. What table(s) are queried with each of these calls? Can you interpret the SQL? 

#### Connecting Routes and Controllers

Use our routes and controllers lesson (and/or example application) from Friday to add functionality so that:

* when visiting `'/courses'`, a view is rendered showing all of the course names
* when visiting `'/courses/:id'`, a view is rendered to show the course name *and a list of all enrolled students for that course* 
* add additional functionality to your existing route `'/students/:id'` so that in addition to name and addresses, all of that student's course names are also displayed
