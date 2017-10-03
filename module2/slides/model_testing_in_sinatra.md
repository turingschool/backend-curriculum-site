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

# Setup

* Add `gem 'rspec'` to your Gemfile.
* `bundle`

---

# Create RSpec Directories and Files

* Create a `.rspec` file
* Create a `spec` directory
* Create a `spec/spec_helper.rb` file
* Create a `spec/models` directory
* Create a `spec/models/horse_spec.rb` file

---

# RSpec Flags

Add to your `.rspec` file

* -–color
* -–format=documentation
* --order=random

---

# Set Up Your Spec Helper

```
require 'bundler'
bundler.require(:default, :test)
require File.expand_path('../../config/environment.rb', __FILE__)
```

---

# Set Up Your First Test

```
RSpec.describe Film do
  describe "Class Methods" do
    describe ".total_box_office_sales" do
      it "returns total box office sales for all films" do
        Film.create(title: "Fargo", year: 2017, box_office_sales: 3)
        Film.create(title: "Die Hard", year: 2016, box_office_sales: 4)

        expect(Film.total_box_office_sales).to eq(7)
      end
    end
  end
end
```

---

# Implement the Method

```ruby
# film.rb
def self.total_box_office_sales
  sum(:box_office_sales)
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
describe "Validations" do
  it "is invalid without a title" do
    film = Film.new(year: 2017, box_office_sales: 2)

    expect(film).to_not be_valid
  end
end
```

---

# In the `Film` model

```
validates :name, presence: true
```

---

# Practice

* a test for an `.average_box_office_sales` class method
* tests that a film cannot be created without a `year` or `box_office_sales`

---

# Takeaways

* RSpec organizes tests using `describe` and `it` blocks
* We run our tests in the `test` environment so that we don't have to worry about data in our development database
* DatabaseCleaner can be used to clean your test database
* RSpec and DatabaseCleaner have gems that we can use in our projects
* We can test methods that exist on models as well as validations
* Specific setup steps can be looked up
