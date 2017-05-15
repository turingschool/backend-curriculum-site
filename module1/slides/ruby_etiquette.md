# Ruby Project Etiquette

---

# Warmup

* How have you been organizing your projects so far?
* What are the advantages of following conventions in project organization?

---

# Overview

* File naming conventions
* Directory structure conventions
* `require`/`require_relative`
* Rakefile

---

# File Naming Conventions

* Snake-case (`my_file.rb`)
* End files in `.rb`
* Classes & filenames match (e.g. `RotationGenerator` in `rotation_generator.rb`)

---

# Directory Structure

1. `lib` for source code
2. `test` for test files
3. `data` for data-related files (.txt, .csv, etc)
4. `bin` for any "executable" files

Convention: test and source files match 1-to-1.

* `lib/rotation_generator.rb`
* `test/rotation_generator_test.rb`

---

# Exercise

* See lesson plan

---

# Require Statements

* `require`: relative to where code is being run.
* `require_relative`: relative to file where code is stored.

---

# Why `require`?

* Convention
* Allows you to move test files without changing require statements

---

# Check for Understanding

* See lesson plan

---

# Rakefile

* Want a standardized command to run across projects
* Task runner
* `Rakefile` is a special file that lives in the root of your project to define tasks

---

# Example

```ruby
task :pizza do
  puts "om nom nom"
end
```

---

# Docs

Installation and sample [test task](https://github.com/ruby/rake)

---

# More advanced version

```ruby
require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task default: :test # <---- if you want test to be your default task
```

---

# Exercise

* With a partner, see how much of the more advanced task you can understand

---

# Summary

* File naming conventions
* Directory structure conventions
* `require`/`require_relative`
* Rakefile

---

# Homework

1. Update your current project to follow these conventions
2. Update one previous project (Credit Check, Flashcards, Complete Me, Date Night) to also follow these conventions
