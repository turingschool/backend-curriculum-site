# Model Testing in Sinatra

---

# Warmup

* Read the Thoughtbot article linked in the lesson plan.

---

# Intro to RSpec

* `describe` blocks
* nested `describe` blocks
* `it` blocks
* `expect` instead of `assert`

---

# RSpec Flags

* –color
* –format=documentation
* Can save in a .rspec file in your home directory

---

# Setup

* Add `gem 'rspec'` to your Gemfile.
* `bundle`

---

# Create RSpec Directories and Files

* Create a `spec` directory
* Create a `spec/spec_helper.rb` file
* Create a `spec/models` directory
* Create a `spec/models/horse_spec.rb` file

---

# Set Up Your Spec Helper

```
require 'rspec'
require File.expand_path('../../config/environment.rb', __FILE__)
```

---

# Set Up Your First Test

```
require_relative '../spec_helper'

RSpec.describe Horse do
  describe ".total_winnings" do
    it "returns total winnings for all horses" do
      Horse.create(name: "Phil", age: 22, total_winnings: 3)
      Horse.create(name: "Penelope", age: 24, total_winnings: 4)

      expect(Horse.total_winnings).to eq(7)
    end
  end
end
```

---

# Update Spec Helper

On the first line:

```
ENV['RACK_ENV'] = 'test'
```

---

# Run Migrations on Your Test DB

```
$ rake db:test:prepare
```

---

# Add Database Cleaner

```
# Gemfile
gem 'database_cleaner'

# spec_helper.rb

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end
```

---

# Testing validations

```
it "is invalid without a name" do
  horse = Horse.new(age: 22, total_winnings: 14)

  expect(horse).to_not be_valid
end
```

---

# In the `Horse` model

```
validates :name, presence: true
```

---

# Takeaways

* RSpec organizes tests using `describe` and `it` blocks
* We run our tests in the `test` environment so that we don't have to worry about data in our development database
* DatabaseCleaner can be used to clean your test database
* RSpec and DatabaseCleaner have gems that we can use in our projects
* We can test methods that exist on models as well as validations
* Specific setup steps can be looked up
