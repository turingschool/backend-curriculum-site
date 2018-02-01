---
title: Blogger
subheading: Guided Tutorial
---

In this project you'll create a simple blog system and learn the basics of Ruby on Rails including:

* Models, Views, and Controllers (MVC)
* Data Structures & Relationships
* Routing
* Migrations
* Views with forms, partials, and helpers
* RESTful design
* Adding gems for extra features

This tutorial is open source. If you notice errors, typos, or have questions/suggestions, please [submit them to the project on GitHub](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/misc/blogger.md). You can find a completed (through Iter3) version [here](https://github.com/AliSchlereth/blogger). 

## I0: Up and Running

Part of the reason Ruby on Rails became popular quickly is that it takes a lot of the hard work off your hands, and that's especially true in starting up a project. Rails practices the idea of "sensible defaults" and will, with one command, create a working application ready for your customization.

### Setting the Stage

First we need to make sure everything is set up and installed. See the [Environment Setup](http://tutorials.jumpstartlab.com/topics/environment/environment.html) page for instructions on setting up and verifying your Ruby and Rails environment.

From the command line, switch to the folder that will store your projects. For instance, `/Users/jcasimir/module2/projects/`. Within that folder, run the following command:

```
$ rails new blogger -T -d="postgresql" --skip-turbolinks --skip-spring
```

- `-T` - rails has minitest by default, when this flag is used, `gem 'minitest'` will not be in the Gemfile
- `-d="postgresql"` - by default, Rails uses `sqlite3`. We want to tell it to use `postgres` instead because sites that we use for deploying, expect a postgres database.
- `--skip-spring` - Spring is a Rails application preloader. It speeds up development by keeping your application running in the background so you don't need to boot it every time you run a test, rake task or migration but it benefits more advanced developers the most. We are going to not include it in our Gemfile.
- `--skip-turbolinks` - Enables faster page loading by using AJAX call behind the scenes but has some subtle edge cases where it will not work as expected. For those reasons, we don't enable it by default.

Use `cd blogger` to change into the directory, then open it in your text editor.

With Rails 5, your project comes with a `.git` repository out of the box. If you type `git status`, you should see something like this:

```
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore
	Gemfile
	Gemfile.lock
	README.md
	Rakefile
	app/
	bin/
	config.ru
	config/
	db/
	lib/
	log/
	package.json
	public/
	tmp/
	vendor/

nothing added to commit but untracked files present (use "git add" to track)
```

Let's start our project off right with some diligent git workflow.

```
git add .
git commit -m "Initial commit"
```

If you check your git status again, you should find a clean working tree.

Run `git remote -v`. You should get nothing back, because we only have a local `.git` repository. Let's connect this to a repo on GitHub. Go to your account, add a new repository, and follow the instructions that look something like this:

```
git remote add origin git@github.com:<USERNAME>/<REPO_NAME>.git
git push -u origin master
```

The `-u` flag remembers the origin/branch connection, and allows you to simply type `git push` from now on.

Refresh your GitHub repo, and checkout your shiny new Rails app.

### Project Tour

By running `rails new`, the generator has created a Rails application for you. Let's figure out what's in there. Looking at the project root, we have these folders:

* `app` - This is where 98% of your effort will go. It contains subfolders which will hold most of the code you write including Models, Controllers, Views, Helpers, JavaScript, etc.
* `bin` - This is where your app's executables are stored: `bundle`, `rails`, `rake`, `spring`, and, something a lot of people are excited about for Rails 5, `yarn`.
* `config` - Control the environment settings for your application. It also includes the `initializers` subfolder which holds items to be run on startup.
* `db` - Will eventually have a `migrations` subfolder where your migrations, used to structure the database, will be stored. When using SQLite3, as is the Rails default, the database file will also be stored in this folder.
* `lib` - This folder is to store code you control that is reusable outside the project.
* `log` - Log files, one for each environment (development, test, production)
* `public` - Static files can be stored and accessed from here, but all the interesting things (JavaScript, Images, CSS) have been moved up to `app` since Rails 3.1
* `spec` - When you install RSpec, it creates this directory as well as a `rails_helper.rb` and a `spec_helper.rb` file. Your tests will live here. You probably don't see this folder right now, but we'll circle back around to installing RSpec.
* `tmp` - Temporary cached files
* `vendor` - Infrequently used, this folder is to store code you *do not* control. With Bundler and Rubygems, we generally don't need anything in here during development.

### Configuring the Database

- We can set up our database by giving the command `rake db:create` from the command line. Do that now.

### Starting the Server

Let's start up the server. From your project directory:

```bash
rails server
```

And you should see:

```bash
=> Booting Puma
=> Rails 5.1.0 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.8.2 (ruby 2.2.6-p396), codename: Sassy Salamander
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```

You're ready to go!

### Viewing the App

Open any web browser and enter the address `http://0.0.0.0:3000`. You can also use `http://localhost:3000` or `http://127.0.0.1:3000` -- they are all "loopback" addresses that point to your machine.

You'll see the Rails' "Welcome Aboard" page. As long as there's no big ugly error message, you're good to go.

#### Getting an Error?

If you see an error here, it's most likely related to the database. You are probably running Windows and don't have either the SQLite3 application installed or the gem isn't installed properly. Go back to [Environment Setup](http://tutorials.jumpstartlab.com/topics/environment/environment.html) and use the Rails Installer package. Make sure you check the box during setup to configure the environment variables. Restart your machine after the installation and give it another try.

### Setting Up for Testing 

We're going to work with a few different tools while testing, [RSpec](https://relishapp.com/rspec), [Capybara](https://github.com/teamcapybara/capybara), [Launchy](https://github.com/copiousfreetime/launchy), and [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers). RSpec is a test driver comparable to MiniTest. RSpec allows you to rung unit, integration and feature tests. Capybara is a DSL(Domain Specific Language) that helps you build tests in a user friendly format, naviating the page and performing user actions. Launchy is a helper class that allows you to add the line `save_and_open_page` within a test. When you run your test suite a browser window will be opened with the current state of the web page where the `save_and_open_page` is located. It is a helpful debugging tool. Shoulda Matchers provides us simple one liners helpful in testing validations and relationships on models.

#### Adding Gems 

In your Gemfile, you should already have a group :development, :test section that looks like this: 

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end
```

In this section add `gem rspec-rails` `gem capybara`, `gem launchy`, `gem shoulda-matchers` and `gem pry`. Then run `bundle` from your command line. You should see a long print out of gems being bundled for use in your project. The end result of your bundle should look something like this:

```ruby
Bundle complete! 14 Gemfile dependencies, 71 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

Your Gemfile group :development, :test should now look like this:

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'pry'
end
```

#### Further RSpec setup

Notice we still don't have that `spec` directory we talked about earlier. We need to futher install RSpec. From your command line, enter the command `rails g rspec:install`. I'd expect to see the following output:

```ruby
   create  .rspec
   create  spec
   create  spec/spec_helper.rb
   create  spec/rails_helper.rb
```

If you check your project directory now, you should see a `spec` folder with two new files, `spec_helper.rb` and `rails_helper.rb`. If you click into these files you'll see that spec_helper is more about configuring RSpec while rails_helper is more about tying RSpec and Rails together. You'll need to require `rails_helper` from the beginning of each test you write in your project. At the root of your project you'll also see a `.rspec` file. This file requires in your `spec_helper.rb`.

#### Further Shoulda Matchers Setup  

In `rails_helper.rb` add the following configuration for Shoulda Matchers.

```ruby
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end
```


#### Don't forget to commit as you go
Let's commit these updates with git. 

```
git add Gemfile
git add Gemfile.lock
git add spec
git add .rspec	
git status (Everything should be green now)
git commit -m "Add setup for testing with RSpec and Shoulda Matchers"
```

#### Directory Setup 

You'll want all your tests to be organized so that Rails finds them and also so developers working on your project have an easy time navigating your test files. We want to make sub directories for our model tests and feature tests. And then add a .keep file to each so git tracks the emtpy directories. 

```bash
mkdir spec/models spec/features
touch spec/models/.keep spec/features/.keep
```  

If you run a `git status` you should see `spec/features` and `spec/models` in red.  Add and commit these changes before moving on.

### Creating the Article Model

Our blog will be centered around `articles`, each with a `title` and `body`, so we'll need a table in the database to store all the articles and a model to allow our Rails app to work with that data.

Whenever you find yourself ready to add functionality or features to your app,you should automatically think: *Time for a new working branch!*. Don't worry if that's not automatic yet, it soon will be. We are moving into the M(odel) part of MVC, so let's "checkout" a branch for implementing our Article model:

```
git checkout -b article-model
```

With `checkout` we create a new branch (`-b` for branch) off of the `master` branch called `article-model` and move directly into it. Let's get our Model on now.


#### Model Tests
Before we dive into the deep and start changing things, let's great a test to help drive our development and keep up focused. Within `spec/models` touch `article_spec.rb`

```bash
touch spec/models/article_spec.rb
```

In your article_spec add the following test:

```ruby
require "rails_helper"

describe Article, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:body)}
  end
end
```

And commit it. 

```bash
git add spec/models/article_spec.rb
git commit -m "Add article spec with validations"
```
You can run your test suite from your CLI(command line interface) with the command `rspec`. Go ahead and do that now. I get the following print out:

```bash
/Users/aleneschlereth/turing/1711/practice/blogger/db/schema.rb doesn't exist yet. Run `rails db:migrate` to create it, then try again. If you do not intend to use a database, you should instead alter /Users/aleneschlereth/turing/1711/practice/blogger/config/application.rb to limit the frameworks that will be loaded.

An error occurred while loading ./spec/models/article_spec.rb.
Failure/Error:
  describe Article, type: model do
    describe "validations" do
      it {should validate_presence_of(:title)}
      it {should validate_presence_of(:body)}
    end
  end

NameError:
  uninitialized constant Article
# ./spec/models/article_spec.rb:3:in `<top (required)>'
No examples found.

Finished in 0.00076 seconds (files took 3.69 seconds to load)
0 examples, 0 failures, 1 error occurred outside of examples
```

There's a lot going on here. Let's focus our attention to the NameError section:

```
NameError:
  uninitialized constant Article
# ./spec/models/article_spec.rb:3:in `<top (required)>
```

We know from working with Ruby and MiniTest that this error is telling us it can't find the class `Article`. In this past this has meant that maybe the files aren't required appropriately or the class just doesn't exist. Now that we'll be working with a database we also have to think about whether this resource exists in the database or not. 

We haven't done anything with our database yet other than create an empty one. It definitely doesn't have Articles in there yet. Let's go solve that problem first. 

#### Creating a Resource in the Database

We'll use one of Rails' generators to create the required files. Switch to your terminal and enter the following:

```
$ rails generate migration CreateArticles title:string body:text
```

We're running the `generate` script, telling it to create a `migration`, and naming that migration `CreateArticle`.

Since we know the attributes that our `article` has, we can assign those right in the terminal migration command. We have an attribute of `title` that we want to be a `string` and an attribute `body` that we want to be a `text` type.

Rails uses migration files to perform modifications to the database. Almost any modification you can make to a DB can be done through a migration.

The killer feature about Rails migrations is that they're generally database agnostic. When developing applications developers might use PostgreSQL as we are in this tutorial, but we might use another database. Many others choose MySQL. It doesn't matter -- the same migrations will work on all of them!  This is an example of how Rails takes some of the painful work off your hands. You write your migrations once, then run them against almost any database.

#### Migration?

**Important!**

What is a migration?  Let's open `db/migrate/(some_time_stamp)_create_articles.rb` and take a look. First you'll notice that the filename begins with a mish-mash of numbers which is a timestamp of when the migration was created. Migrations need to be ordered, so the timestamp serves to keep them in chronological order. Inside the file, you'll see the method `change`.

Migrations used to have two methods, `up` and `down`. The `up` was used to make your change, and the `down` was there as a safety valve to undo the change. But this usually meant a bunch of extra typing, so with Rails 3.1 those two were replaced with `change`.

We write `change` migrations just like we used to write `up`, but Rails will figure out the undo operations for us automatically.

You may often find yourself thinking *"Thank you, Rails. Thank you."* This is totally normal.

#### Modifying `change`

Inside the `change` method you'll see the generator has placed a call to the `create_table` method, passed the symbol `:articles` as a parameter, and created a block with the variable `t` referencing the table that's created.

We call methods on `t` to create columns in the `articles` table. Since we used the command line to define our attributes, our migration should already be all set up the way we want it.

That's it! You might be wondering, what is a "text" type?  This is an example of relying on the Rails database adapters to make the right call. For some DBs, large text fields are stored as `varchar`, while others like Postgres use a `text` type. The database adapter will figure out the best choice for us depending on the configured database -- we don't have to worry about it. The "string" type is similar, just shorter. You can generally think of the former as multi-line and the latter as single-line/in-line.

Your migration should look like this:

```ruby
def change
  create_table :articles do |t|
    t.string :title # create a column in the table with a string datatype and a column name of title ie. articles.title
    t.text :body # create a column in the table with a text datatype and a column name of body ie articles.body

    t.timestamps
  end
end
```

You may need to add the `t.timestamps` line.

#### Timestamps

What is that `t.timestamps` doing there? It will create two columns inside our table named `created_at` and `updated_at`. Rails will manage these columns for us. When an article is created its `created_at` and `updated_at` are automatically set. Each time we make a change to the article, the `updated_at` will automatically be updated.

#### Running the Migration

**Important!**

Save that migration file, switch over to your terminal, and run this command:

```
$ rake db:migrate
```

This command starts the `rake` program which is a ruby utility for running maintenance-like functions on your application (working with the DB, executing unit tests, deploying to a server, etc).

We tell `rake` to `db:migrate` which means "look in your set of functions for the database (`db`) and run the `migrate` function."  The `migrate` action finds all migrations in the `db/migrate/` folder, looks at a special table in the DB to determine which migrations have and have not been run yet, then runs any migration that hasn't been run.

In this case we had just one migration to run and it should print some output like this to your terminal:

```
$ bin/rake db:migrate
==  CreateArticles: migrating =================================================
-- create_table(:articles)
   -> 0.0012s
==  CreateArticles: migrated (0.0013s) ========================================
```

It tells you that it is running the migration named `CreateArticles`. And the "migrated" line means that it completed without errors. When the migrations are run, data is added to the database to keep track of which migrations have *already* been run. Try running `rake db:migrate` again now, and see what happens.

We've now created the `articles` table in the database and can start working on our `Article` model.

Before we move on, don't forget to commit.

```bash
git add db/migrate
git add db/schema.rb
git commit -m "Add Article migration"
```

### Working with a Model 

Let's run `rspec` from our command line again. The output should look something like this:

```
An error occurred while loading ./spec/models/article_spec.rb.
Failure/Error:
  describe Article, type: model do
    describe "validations" do
      it {should validate_presence_of(:title)}
      it {should validate_presence_of(:body)}
    end
  end

NameError:
  uninitialized constant Article
# ./spec/models/article_spec.rb:3:in `<top (required)>'
No examples found

Finished in 0.00044 seconds (files took 4.63 seconds to load)
0 examples, 0 failures, 1 error occurred outside of examples
```

The top looks slightly different, but the meat of what we're focusing hasn't yet. RSpec still can't find an Article. 

Let's add the model so that RSpec doesn't complain:

```bash
  touch app/models/article.rb
```

And inside of that file:

```ruby
#models/article.rb
class Article < ApplicationRecord

end
```

We want this model to inherit from ActiveRecord so why ApplicationRecord? If we take a look around, we see a base file in the model directory called `application_record.rb`. Open that and peek around:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

That file inherits from ActiveRecord so we want to inherit from ApplicationRecord. This allows us to have a master model that could contain some shared methods.


#### Rails Console

Another awesome feature of working with Rails is the `console`. The `console` is a command-line interface to your application. It allows you to access and work with just about any part of your application directly instead of going through the web interface. This will accelerate your development process. Once an app is in production the console makes it very easy to do bulk modifications, searches, and other data operations. So let's open the console now by going to your terminal and entering this:

```
$ rails console
```

You'll then just get back a prompt of `>>`. You're now inside an `irb` interpreter with full access to your application. Let's try some experiments. Enter each of these commands one at a time and observe the results:

```
$ Time.now
$ Article.all
$ Article.new
```

**Important!**

The first line was just to demonstrate that you can run normal Ruby, just like `irb`, within your `console`. The second line referenced the `Article` model and called the `all` class method which returns an ActiveRecord::Relation, which acts and looks just like an array, of all articles in the database -- so far an empty one. The third line created a new article object. You can see that this new object had attributes `id`, `title`, `body`, `created_at`, and `updated_at`.

Type `exit` to quit the Rails console.

### Looking at the Model

**Important!**

All the code for the `Article` model is in the file `app/models/article.rb`, so let's open that again.

Not very impressive, right?  There are no attributes defined inside the model, so how does Rails know that an Article should have a `title`, a `body`, etc?  The answer is a technique called reflection. Rails queries the database, looks at the articles table, and assumes that whatever columns that table has should be the attributes for the model.

You'll recognize most of them from your migration file, but what about `id`?  Every table you create with a migration will automatically have an `id` column which serves as the table's primary key. When you want to find a specific article, you'll look it up in the articles table by its unique ID number. Rails and the database work together to make sure that these IDs are unique, usually using a special column type in the DB called "serial".

In your console (BONUS: you can run `rails c`, `c` being short for `console`), try entering `Article.all` again. Do you see the blank article that we created with the `Article.new` command?  No?  The console doesn't change values in the database until we explicitly call the `.save` method on an object. Let's create a sample article and you'll see how it works. Enter each of the following lines one at a time:

```
$ article = Article.new
$ article.title = "Sample Article Title"
$ article.body = "This is the text for my article, woo hoo!"
$ article.save
$ Article.all
```

Now you'll see that the `Article.all` command gave you back an array holding the one article we created and saved. Go ahead and **create 3 more sample articles**. When you're finished type `exit` to leave the console.

#### Validations

Back to our test suite again, when we run `rspec` our error has changed. 

```bash
Article
  validations
    should validate that :title cannot be empty/falsy (FAILED - 1)
    should validate that :body cannot be empty/falsy (FAILED - 2)

Failures:

  1) Article validations should validate that :title cannot be empty/falsy
     Failure/Error: it {should validate_presence_of(:title)}

       Article did not properly validate that :title cannot be empty/falsy.
         After setting :title to ‹nil›, the matcher expected the Article to be
         invalid, but it was valid instead.
     # ./spec/models/article_spec.rb:5:in `block (3 levels) in <top (required)>'

  2) Article validations should validate that :body cannot be empty/falsy
     Failure/Error: it {should validate_presence_of(:body)}

       Article did not properly validate that :body cannot be empty/falsy.
         After setting :body to ‹nil›, the matcher expected the Article to be
         invalid, but it was valid instead.
     # ./spec/models/article_spec.rb:6:in `block (3 levels) in <top (required)>'

Finished in 0.06108 seconds (files took 2.23 seconds to load)
2 examples, 2 failures

Failed examples:

rspec ./spec/models/article_spec.rb:5 # Article validations should validate that :title cannot be empty/falsy
rspec ./spec/models/article_spec.rb:6 # Article validations should validate that :body cannot be empty/falsy
```

You should expect your error messages to be a bit longer than you've experienced in the past. The parts I want to focus on with this error are here:

```bash
Article did not properly validate that :body cannot be empty/falsy.
         After setting :body to ‹nil›, the matcher expected the Article to be
         invalid, but it was valid instead.
```

Basically RSpec is no longer concerned about finding the Article but now our assertion is failing. We told it we wanted every Article to have a title and body present, but our code doesn't demand that. In order to fix this, let's add some validations to our Article model.

```ruby
#app/models/article.rb
class Article < ApplicationRecord

  validates_presence_of :title, :body

end
```

When we run `rspec` again you should see green. A passing test!

This is a great start for our Article model, let's conclude our working branch
and merge to master:

Part 1 - Commit:

```
git add app/models/article.rb
git commit -m "Add article model"
```

Part 2 - Merge:

```
git pull origin master
git push origin article-model
```
On GitHub put in a PR to merge the branch article-model into master. My PR message looks like this:

```
Add Article Model 
* Add Spec with validations for title and body
* Add migration to create articles table in DB
* Add Article model
* Add validations for title and body to Article model
* Test is passing 
```

Even though we are working on a solo project, we still want to keep strong git habits, which includes PRs and not merging to master. Since we're working solo, we will need to merge our own PRs though. Do that before moving on.

To keep things nice and tidy, from the CLI(command line interface):

```
git checkout master
git pull origin master
git branch -d article-model
```

### Setting up the Router

We've created a few articles through the console, but we really don't have a web application until we have a web interface. Let's get that started. We said that Rails uses an "MVC" architecture and we've worked with the Model, now we need a Controller and View.

Let's start off with a controller branch:

```
git checkout -b articles-controller
```

#### Feature Tests 

As with anything we do, let's create a feature test before we go crazy building things we may or may not need. First, touch a new test file.

```bash
touch spec/features/user_sees_all_articles_spec.rb
```

Add the following test structure:

```ruby
require "rails_helper"

describe "user sees all articles" do
  desribe "they visit /articles" do
    it "displays all articles" do
      
    end
  end
end
```

We need to first do the test setup, usually requiring data prep. In this test our user is going to visit the URI `/articles` and expect to see multiple articles' information displayed. For this test we will need more than one article. Add the following within the it block of your test.

```ruby
      article_1 = Article.create!(title: "Title 1", body: "Body 1")
      article_2 = Article.create!(title: "Title 2", body: "Body 2")
``` 

We also will use Capybara methods to tell our test to navigate to the right page. Add the following below your data prep but still within the it block.

```ruby
     visit '/articles'
```

Lastly we need to assert or expect something. I want my user to see the title and body of each article on the page. Add the following expectations below your visit line.

```ruby
     expect(page).to have_content(article_1.title)
     expect(page).to have_content(article_1.body)
     expect(page).to have_content(article_2.title)
     expect(page).to have_content(article_2.body)
```

The test should look like this altogether:

```ruby
require "rails_helper"

describe "user sees all articles" do
  describe "they visit /articles" do
    it "displays all articles" do
      article_1 = Article.new(title: "Title 1", body: "Body 1")
      article_2 = Article.new(title: "Title 2", body: "Body 2")

      visit '/articles'

      expect(page).to have_content(article_1.title)
      expect(page).to have_content(article_2.title)
    end
  end
end
```

Now that we have a test, let's commit it.

```bash
git add spec/features/user_sees_all_articles_spec.rb
git commit -m 'Add all articles feature spec'
```

Let's run it!

See what I mean about longer error messages?

```ruby
user sees all articles
  they visit /articles
    displays all articles (FAILED - 1)

Article
  validations
    should validate that :title cannot be empty/falsy
    should validate that :body cannot be empty/falsy

Failures:

  1) user sees all articles they visit /articles displays all articles
     Failure/Error: visit '/articles'

     ActionController::RoutingError:
       No route matches [GET] "/articles"
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/railties-5.1.4/lib/rails/rack/logger.rb:36:in `call_app'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/railties-5.1.4/lib/rails/rack/logger.rb:24:in `block in call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/railties-5.1.4/lib/rails/rack/logger.rb:24:in `call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/method_override.rb:22:in `call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/runtime.rb:22:in `call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/sendfile.rb:111:in `call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/railties-5.1.4/lib/rails/engine.rb:522:in `call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/urlmap.rb:68:in `block in call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/urlmap.rb:53:in `each'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/urlmap.rb:53:in `call'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-test-0.8.2/lib/rack/mock_session.rb:29:in `request'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-test-0.8.2/lib/rack/test.rb:251:in `process_request'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-test-0.8.2/lib/rack/test.rb:129:in `custom_request'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-test-0.8.2/lib/rack/test.rb:58:in `get'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/capybara-2.17.0/lib/capybara/rack_test/browser.rb:69:in `process'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/capybara-2.17.0/lib/capybara/rack_test/browser.rb:41:in `process_and_follow_redirects'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/capybara-2.17.0/lib/capybara/rack_test/browser.rb:22:in `visit'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/capybara-2.17.0/lib/capybara/rack_test/driver.rb:44:in `visit'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/capybara-2.17.0/lib/capybara/session.rb:274:in `visit'
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/capybara-2.17.0/lib/capybara/dsl.rb:50:in `block (2 levels) in <module:DSL>'
     # ./spec/features/user_sees_all_articles_spec.rb:9:in `block (3 levels) in <top (required)>'

Finished in 0.03617 seconds (files took 1.67 seconds to load)
3 examples, 1 failure

Failed examples:

rspec ./spec/features/user_sees_all_articles_spec.rb:5 # user sees all articles they visit /articles displays all articles
```

Hopefully yours is coming through with some different colors. The long blue section is the strack trace. It can be helpful to use in debugging but is certainly not the first place I look. Instead I'm going to focus on the content of my failure:

```ruby
Failures:

  1) user sees all articles they visit /articles displays all articles
     Failure/Error: visit '/articles'

     ActionController::RoutingError:
       No route matches [GET] "/articles"
```
`No route matches [GET] "/articles"` Huh? Let's talk about routes.  

#### Rails Routing

When a Rails server gets a request from a web browser it first goes to the _router_. The router decides what the request is trying to do, what resources it is trying to interact with. The router dissects a request based on the address it is requesting and other HTTP parameters (like the request type of GET or PUT). Let's open the router's configuration file, `config/routes.rb`.

Rails used to fill this file with TONS of comments, but they take it easier on us now with just one. Let's still get rid of it and make our whole file look like this:

```ruby
Rails::Application.routes.draw do
  resources :articles
end
```

This line tells Rails that we have a resource named `articles` and the router should expect requests to follow the *RESTful* model of web interaction (REpresentational State Transfer). The details don't matter right now, but when you make a request like `http://localhost:3000/articles/`, the router will understand you're looking for a listing of the articles, and `http://localhost:3000/articles/new` means you're trying to create a new article.

#### Looking at the Routing Table

**Important!**

Dealing with routes is commonly very challenging for new Rails programmers. There's a great tool that can make it easier on you. To get a list of the routes in your application, go to a command prompt and run `rake routes`. You'll get a listing like this:

```bash
$ rake routes
```
And your outcome should be:

```bash
      Prefix Verb   URI Pattern                  Controller#Action
    articles GET    /articles(.:format)          articles#index
             POST   /articles(.:format)          articles#create
 new_article GET    /articles/new(.:format)      articles#new
edit_article GET    /articles/:id/edit(.:format) articles#edit
     article GET    /articles/:id(.:format)      articles#show
             PATCH  /articles/:id(.:format)      articles#update
             PUT    /articles/:id(.:format)      articles#update
             DELETE /articles/:id(.:format)      articles#destroy
```

Experiment with commenting out the `resources :articles` in `routes.rb` and running the command again. Un-comment the line after you see the results.

These are the seven core actions of Rails' REST implementation. To understand the table, let's look at the first row as an example:

```
      Prefix Verb   URI Pattern                  Controller#Action
    articles GET    /articles(.:format)          articles#index
```

The left most column says `articles`. This is the *prefix* of the path. The router will provide two methods to us using that name, `articles_path` and `articles_url`. The `_path` version uses a relative path while the `_url` version uses the full URL with protocol, server, and path. The `_path` version is always preferred.

The second column, here `GET`, is the HTTP verb for the route. Web browsers typically submit requests with the verbs `GET` or `POST`. In this column, you'll see other HTTP verbs including `PUT` and `DELETE` which browsers don't actually use. We'll talk more about those later.

The third column is similar to a regular expression which is matched against the requested URL. Elements in parentheses are optional. Markers starting with a `:` will be made available to the controller with that name. In our example line, `/articles(.:format)` will match the URLs `/articles/`, `/articles.json`, `/articles` and other similar forms.

The fourth column is where the route maps to in the application. Our example has `articles#index`, so requests will be sent to the `index` method of the `ArticlesController` class.

Now that the router knows how to handle requests about articles, it needs a place to actually send those requests, the *Controller*.

If we re-run `rspec` we get an error telling us likewise. Note you're error message will likely be just as large as last time, but we only really need to focus on the failure message printed above the stack trace. My error reads:

```ruby
Failures:

  1) user sees all articles they visit /articles displays all articles
     Failure/Error: visit '/articles'

     ActionController::RoutingError:
       uninitialized constant ArticlesController
```

RSpec can't find a class called ArticlesController. Let's go make one!

### Creating the Articles Controller

Let's open one more terminal or command prompt and move to your project directory which we'll use for command-line scripts. I generally like to keep one terminal tab for my console, one for running tests/command prompts, and one for my server. In that a terminal window, enter this command:

```
$ touch app/controllers/articles_controller.rb
```

Remember, models are singular (e.g., Article), and controllers are plural (e.g.,
articles).

Let's open up the controller file, `app/controllers/articles_controller.rb` and add the code we want:

```ruby
#app/controllers/articles_controller.rb
class ArticlesContoller < ApplicationController

end
```

What is ApplicationController? Look at the controllers folder and you should see an `application_controller.rb` file. This file defines the `ApplicationController` class, which (generally) all of your other controllers will inherit from.

Let's run our tests again with `rspec`. Looking above the blue stack trace I see the following message:

```ruby
Failures:

  1) user sees all articles they visit /articles displays all articles
     Failure/Error: visit '/articles'

     AbstractController::ActionNotFound:
       The action 'index' could not be found for ArticlesController
```

Woo new errors! This means we're making progress. What is this action 'index' all about? 


### Defining the Index Action

The first feature we want to add is an "index" page. This is what the app will send back when a user requests `http://localhost:3000/articles/` -- following the RESTful conventions, this should be a list of the articles. So when the router sees this request come in, it tries to call the `index` action inside `articles_controller`.

Let's first try it out by entering `http://localhost:3000/articles/` into your web browser. If you no longer have a server running, remember you can spin one up with the `rails s` command. You should get an error message that looks like this:

```
Unknown action

The action 'index' could not be found for ArticlesController
```

Same error message our test gave us! 

The router tried to call the `index` action, but the articles controller doesn't have a method with that name. It then lists available actions, but there aren't any. This is because our controller is still blank. Let's add the following method inside the controller:

```ruby
def index
  @articles = Article.all
end
```

#### Instance Variables

What is that "at" sign doing on the front of `@articles`?  That marks this variable as an "instance level variable". We want the list of all articles in the database to be accessible from both the controller and the view that we're about to create. In order for it to be visible in both places it has to be an instance variable. If we had just named it `articles`, that local variable would only be available within the `index` method of the controller.

A normal Ruby instance variable is available to all methods within an instance.

There are ways to accomplish the same goals without instance variables, but they're not widely used. Check out the [Decent Exposure](https://github.com/voxdolo/decent_exposure) gem to learn more.

If we run our tests again, we should get a different error now in the failure section, above the stack trace. 

```ruby
 1) user sees all articles they visit /articles displays all articles
     Failure/Error: visit '/articles'

     ActionController::UnknownFormat:
       ArticlesController#index is missing a template for this request format and variant.

       request.formats: ["text/html"]
       request.variant: []

       NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

GAH! What does all that mean? The part I focus on is this:

```ruby
ArticlesController#index is missing a template for this request format and variant.
```

It's telling us we don't have a view template for this index action method.

### Creating the Template

Now refresh your browser. The error message changed, but you've still got an error just like our new test error, right?

```
ActionController::UnknownFormat in ArticlesController#index

ArticlesController#index is missing a template for this request format and variant. request.formats: ["text/html"]...
```

The error message is pretty helpful here. It tells us that the app is looking for a (view) template in `app/views/articles/` but it can't find one named `index.erb`. Rails has *assumed* that our `index` action in the controller should have a corresponding `index.erb` view template in the views folder. We didn't have to put any code in the controller to tell it what view we wanted, Rails just figures it out.

Let's commit our changes.

```
git add config/routes
git add app/controllers/articles_controller.rb
git commit -m "Set up /articles route and action"
```

Let's create our view template.

```bash
mkdir app/views/articles
touch app/views/articles/index.html.erb
```

#### Naming Templates

Why did we choose `index.html.erb` instead of the `index.erb` that the error message said it was looking for?  Putting the HTML in the name makes it clear that this view is for generating HTML. In later versions of our blog we might create an RSS feed which would just mean creating an XML view template like `index.xml.erb`. Rails is smart enough to pick the right one based on the browser's request, so when we just ask for `http://localhost:3000/articles/` it will find the `index.html.erb` and render that file.

Let's run our tests again and see how our changes have affected our error message. You'll notice how this error message is much shorter. Where'd the stack trace go? Since we've successfully loaded the page, RSpec is is now only looking for text on the page. None of or our Rails methods are erroring out, thus no stack trace. Either way, we're still going to focus on what the message within the `Failures:` section says:

```ruby
Failures:

  1) user sees all articles they visit /articles displays all articles
     Failure/Error: expect(page).to have_content(article_1.title)
       expected to find text "Title 1" in ""
     # ./spec/features/user_sees_all_articles_spec.rb:11:in `block (3 levels) in <top (required)>'
```

#### Index Template Content

Now you're looking at a blank file. Enter in this view template code which is a mix of HTML and what are called ERB tags:

```html
<h1>All Articles</h1>

<ul id="articles">
  <% @articles.each do |article| %>
    <li>
      <%= article.title %>
    </li>
  <% end %>
</ul>
```

ERB is a templating language that allows us to mix Ruby into our HTML. There are only a few things to know about ERB:

* An ERB clause starts with `<%` or `<%=` and ends with `%>`
* If the clause started with `<%`, the result of the ruby code will be hidden
* If the clause started with `<%=`, the result of the ruby code will be output in place of the clause

When we run our tests, what do we get?

```ruby
user sees all articles
  they visit /articles
    displays all articles

Article
  validations
    should validate that :title cannot be empty/falsy
    should validate that :body cannot be empty/falsy

Finished in 0.21042 seconds (files took 2.32 seconds to load)
3 examples, 0 failures
```

Woo, green passing tests!!

Refresh your web browser. You should see a listing of the articles you created in the console. We've got the start of a web application!

Let's commit our changes and head back into our controller and merge our new index view.

```
git add app/views/articles/
git commit -m "Add articles index template"
```

Let's double check our `/articles` path one more time in the browser to make sure our merge links the controller and the view correctly. Once that's squared away, let's merge `articles-controller` to `master`:

```
git pull origin master
git push origin articles-controller
```
On GitHub put in a PR to merge your changes into master (Yes put in a PR even though you're working solo.

My PR message looks like this:

```
Add Articles Index Functionality
* Add a feature spec for all articles
* Add all routes for articles 
* Add an ArticlesController
* Add an index action within ArticlesController
* Add a view for articles/index
* All tests passing
```

Merge your PR. Then come back to your CLI to pull down the current master.

```
git checkout master
git pull origin master
git branch -d articles-controller
```

Nice job! With our basic MVC structure in place, let's polish our application.

### Adding Navigation to the Index

Right now our article list is very plain, let's add some links.

No code snippet this time. Checkout a new branch from master. The name should describe the feature you're working on. In this case, something like `index-navigation-links` gets the job done.

#### Looking at the Routing Table

Remember when we looked at the Routing Table using `rake routes` from the command line? Look at the left-most column and you'll see the route names. These are useful when creating links.

When we create a link, we'll typically use a "route helper" to specify where the link should point. We want our link to display the single article which happens in the `show` action. Looking at the table, the name for that route is `article` and it requires a parameter `id` in the URL. The route helper we'll use looks like this:

```ruby
article_path(id)
```

For example, `article_path(1)` would generate the string `"/articles/1"`. Give the method a different parameter and you'll change the ID on the end.

#### Completing the Article Links

Let's update our assertions in our feature test. Change `dexpect(page).to have_content(article_1.title)` to `expect(page).to have_link(article_1.title)` and make the same update for the second article.

When you run your test your error should looke something like this:

```ruby
Failures:

  1) user sees all articles they visit /articles displays all articles
     Failure/Error: expect(page).to have_link(article_1.title)
       expected to find visible link "Title 1" but there were no matches
     # ./spec/features/user_sees_all_articles_spec.rb:11:in `block (3 levels) in <top (required)>'
```

Our test is now broken because while we have the text for the article's title, it's not a link yet. Back in `app/views/articles/index.html.erb`, find where we have this line:

```erb
<%= article.title %>
```

Instead, let's use a `link_to` helper:

```erb
<%= link_to article.title, article_path(article) %>
```

The first part of this helper after the `link_to`, in this case `article.title`, is the text you want the link to say. The next part is our route helper. Note that when you pass an entire object as an argument, Rails takes the id from the object and builds the route from there.

But wait, there's one more thing. Our stylesheet for this project is going to look for a certain class on the link to make it look fancy. To add HTML attributes to a link, we include them in a Ruby hash style on the end like this:

```erb
<%= link_to article.title, article_path(article), class: 'article-title' %>
```

Or, if you wanted to also have a CSS ID attribute:

```erb
<%= link_to article.title, article_path(article),
    class: 'article-title', id: "article-#{article.id}" %>
```

When the template is rendered, it will output HTML like this:

```html
<a class="article-title" id="article-1" href="/articles/1">First Sample Article</a>
```
Run your test suite again you should have all green, passing tests. Let's commit this change before we move on. 

#### New Article Link

At the very bottom of the template, let's add a link to the "Create a New Article" page. First, let's add an assertion to our feature test.
Referencing the new assertion we just used to check that each article title is a link, write another assertion that there is a  "Create a New Article" link on the page.  

When we run our test suite, we get the following error:

```ruby
Failures:

  1) user sees all articles they visit /articles displays all articles
     Failure/Error: expect(page).to have_link("Create a New Article")
       expected to find visible link "Create a New Article" but there were no matches
     # ./spec/features/user_sees_all_articles_spec.rb:16:in `block (3 levels) in <top (required)>'
```

We'll use the `link_to` helper, we want it to display the text `"Create a New Article"`, and where should it point? Look in the routing table for the `new` action, that's where the form to create a new article will live. You'll find the name `new_article`, so the helper is `new_article_path`. Assemble those three parts and write the link in your template.

Use the technique mentioned above to add the CSS class `new-article` to your "Create a New Article" link.

```erb
<h1>All Articles</h1>

<ul id="articles">
  <% @articles.each do |article| %>
    <li>
      <%= link_to article.title, article_path(article) %>
    </li>
  <% end %>
</ul>

<%= link_to "Create a New Article", new_article_path, class: "new-article" %>
```

Run your tests again and they should be passing.

#### Review the Results

Refresh your browser and each sample article title should be a link. If you click the link, you'll get an error as we haven't implemented the `show` method yet. Similarly, the new article link will lead you to a dead end. Let's tackle the `show` next.

Based on our branch name, we have completed the intended functionality. Let's:  

* Commit these changes
* Push our code to GitHub
* Put in a PR with comments to merge our work to master on GitHub
* Merge your PR
* Checkout master locally
* Pull the current version of master into your local master
* Delete `index-navigation-links`
* Checkout a new branch for adding functionality for the SHOW action

### Creating the SHOW Action

We'll need to write a new test for this since we're building out functionality on a new action/view. Create a new feature test file for the functionality where a user sees one article. Within this test structure, you're going to start with a describe block similar to the name of the file, then give any more specific scenario information, and then say what you expect to find there. Git it a try yourself before looking at my sample below.

```ruby
require "rails_helper"

describe "user sees one article" do
	describe "they link from the articles index" do
		it "displays information for one article" do
		
		end 
	end 
end 
```

We need our test to do the following:

* Create an article
* Visit the articles index
* Click the article's link
* Expect the page to display the article's title
* Expect the page to display the article's body

Give it a try before looking at my test below:

```ruby
require "rails_helper"

describe "user sees one article" do
  describe "they link from the article index" do
    it "displays information for one article" do
      article = Article.create!(title: "New Title", body: "New Body")

      visit articles_path

      click_link article.title

      expect(page).to have_content(article.title)
      expect(page).to have_content(article.body)
    end
  end
end
```

After you've put your test together, don't forget to commit it.

When we run our test suite, we have a new error. 

```bash
Failures:

  1) user sees one article they link from the article index displays information for one article
     Failure/Error: click_link article.title

     AbstractController::ActionNotFound:
       The action 'show' could not be found for ArticlesController
```

How did we move forward when we got a similar error for the index?

An "action" is just a method of the controller. Here we're talking about the `ArticlesController`, so our next step is to open `app/controllers/articles_controller.rb` and add a `show` method:

```ruby
def show

end
```

When we run our tests again we get this much longer failure message:

```bash
Failures:

  1) user sees one article they link from the article index displays information for one article
     Failure/Error: click_link article.title

     ActionController::UnknownFormat:
       ArticlesController#show is missing a template for this request format and variant.

       request.formats: ["text/html"]
       request.variant: []

       NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

Remember the important part of this message is:

```bash
ActionController::UnknownFormat:
       ArticlesController#show is missing a template for this request format and variant.
```

What did we do to solve this error last time? Go ahead and create the file for the show template. Think first about where this file should live. Rails is going to look in a very specific place for this file.

When you run your test suite again, I'd expect to have a different error:

```ruby
Failures:

  1) user sees one article they link from the article index displays information for one article
     Failure/Error: expect(page).to have_content(article.title)
       expected to find text "New Title" in ""
     # ./spec/features/user_sees_one_article_spec.rb:12:in `block (3 levels) in <top (required)>'
```
Add the following html & erb to your file:

```erb
<h1><%= @article.title %></h1>
<p><%= @article.body %></p>
<%= link_to "<< Back to Articles List", articles_path %>
```

What does your error tell you now?

```ruby
Failures:

  1) user sees one article they link from the article index displays information for one article
     Failure/Error: <h1><%= @article.title %></h1>

     ActionView::Template::Error:
       undefined method `title' for nil:NilClass
```

Here RSpec is telling us it tried to run the method `.title` on @article, but @article is `nil` so it doesn't have access to such a method. How do we make @article not be empty/nil?

#### A Bit on Parameters

Look at the URL: `http://localhost:3000/articles/1`. When we added the `link_to` in the index and pointed it to the `article_path` for this `article`, the router created this URL. Following the RESTful convention, this URL goes to a SHOW method which would display the Article with ID number `1`. Your URL might have a different number depending on which article title you clicked in the index.

So what do we want to do when the user clicks an article title?  Find the article, then display a page with its title and body. We'll use the number on the end of the URL to find the article in the database.

Within the controller, we have access to a method named `params` which returns us the request parameters. Often we'll refer to it as "the `params` hash", but technically it's "the `params` method which returns a hash-like object". Params is not a hash, but it acts just like one so we can treat it just like a hash.

Put a `binding.pry` or `buybug` in your show action and run your test suite again. When your test suite stops, enter `params` and see what is returned. 

```
<ActionController::Parameters {"controller"=>"articles", "action"=>"show", "id"=>"34"} permitted: false>
```

Play around a little bit. What happens when you type `params[:controller]` or `params["action"]` or `params[:id]`?

Exit `pry`, remove the `binding.pry` from your show action and run your test suite again to continue.

Within that hash we can find the `:id` from the URL by accessing the key `params[:id]`. Use this inside the `show` method of `ArticlesController` along with the class method `find` on the `Article` class to retrieve the record from the database and create a Ruby object whose state is the information pulled from the database.

```ruby
@article = Article.find(params[:id])
```

If you run your tests at this point, you should be all green, all tests passing. 

#### Back to the Web page

Refresh your browser and your article should show up along with a link back to the index. We can now navigate from the index to a show page and back.

Time to commit. Bite-sized commits like this are best-practice, and a great habit to start early. Commit, push your branch to GitHub, but in a PR with a message, merge your PR, checkout master, pull in the updates to master, and delete the old working branch.

### Styling

First, checkout a new branch for styling.

This is not a CSS project, so to make it a bit more fun we've prepared a CSS file you can drop in. It should match up with all the example HTML in the tutorial.

Download this [file](http://tutorials.jumpstartlab.com/assets/blogger/screen.css) and place it in your `app/assets/stylesheets/` folder. It will be automatically picked up by your project.

Here is a fun snippet that will do all that from the command line:

```
curl http://tutorials.jumpstartlab.com/assets/blogger/screen.css -o app/assets/stylesheets/screen.css
```

`curl` is a command line tool used to access server data. We get the data from
`http://tutorials.jumpstartlab.com/assets/blogger/screen.css` and output it (`-o`) to `app/assets/stylesheets`.

Commit, push, put in a PR, merge, checkout master, pull in updated master, delete.

## I1: Form-based Workflow

We've created sample articles from the console, but that isn't a viable long-term solution. The users of our app will expect to add content through a web interface. In this iteration we'll create an HTML form to submit the article, then all the backend processing to get it into the database.

Check out a branch for adding create functionality to our app.

### Creating the NEW Action and View

Previously, we set up the `resources :articles` route in `routes.rb`, and that told Rails that we were going to follow the RESTful conventions for this model named Article. Following this convention, the URL for creating a new article would be `http://localhost:3000/articles/new`. From the articles index, your "Create a New Article" link should go to this path.

### But first, tests

Create a new feature test file for a user creating a new article. Think about how they need to visit a new article form first. Set up your test structure to describe the scenario and what you want to happen. Will you need to create an article in the data prep section? How will you tell Capybara to fill in the form? Try to write out the whole test before looking at my sample.

```ruby
require "rails_helper"

describe "user creates a new article" do
  describe "they link from the articles index" do
    describe "they fill in a title and body" do
      it "creates a new article" do
        visit articles_path
        click_link "Create a New Article"

        expect(current_path).to eq(new_article_path)

        fill_in "article[title]", with: "New Title!"
        fill_in "article[body]",  with: "New Body!"
        click_on "Create Article"

        expect(page).to have_content("New Title!")
        expect(page).to have_content("New Body!")
      end
    end
  end
end
```

When we run this test, we get the following error message. 

```ruby
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: click_link "Create a New Article"

     AbstractController::ActionNotFound:
       The action 'new' could not be found for ArticlesController
```

Good thing we've done this twice and know how to handle this error. 

Now, let's create that action. Open `app/controllers/articles_controller.rb` and add this method, making sure it's _inside_ the `ArticlesController` class, but _outside_ the existing `index` and `show` methods:

```ruby
def new

end
```

#### Starting the Template

Our next error we get from our tests is the long `no template` error. 

Create a new file `app/views/articles/new.html.erb` with these contents:

```erb
<h1>Create a New Article</h1>
```

### Writing a Form

It's not very impressive so far -- we need to add a form to the `new.html.erb` so the user can enter in the article title and body. Because we're following the RESTful conventions, Rails can take care of many of the details. Inside that `erb` file, enter this code below your header:

```erb
<%= form_for(@article) do |f| %>
  <ul>
  <% @article.errors.full_messages.each do |error| %>
    <li><%= error %></li>
  <% end %>
  </ul>
  <p>
    <%= f.label :title %><br />
    <%= f.text_field :title %>
  </p>
  <p>
    <%= f.label :body %><br />
    <%= f.text_area :body %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>
```

What is all that?  Let's look at it piece by piece:

* `form_for` is a Rails helper method which takes one parameter, in this case `@article` and a block with the form fields. The first line basically says "Create a form for the object named `@article`, refer to the form by the name `f` and add the following elements to the form..."
* The `f.label` helper creates an HTML label for a field. This is good usability practice and will have some other benefits for us later
* The `f.text_field` helper creates a single-line text box named `title`
* The `f.text_area` helper creates a multi-line text box named `body`
* The `f.submit` helper creates a button labeled "Create"

#### Does it Work?

Re-run your test suite and you certainly have a new error. 

```
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: <%= form_for(@article) do |f| %>

     ActionView::Template::Error:
       First argument in form cannot contain nil or be empty
```

What's happening here is that we're passing `@article` to `form_for`. Since we haven't created an `@article` in this action, the variable just holds `nil`. The `form_for` method calls `model_name` on `nil`, generating the error above.

#### Setting up for Reflection

Rails uses some of the _reflection_ techniques that we talked about earlier in order to set up the form. Remember in the console when we called `Article.new` to see what fields an `Article` has? Rails wants to do the same thing, but we need to create the blank Ruby object for it. Go into your `articles_controller.rb`, and _inside_ the `new` method, add this line:

```ruby
@article = Article.new
```

When you run your test suite, your error should be the following: 

```ruby
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: click_on "Create Article"

     AbstractController::ActionNotFound:
       The action 'create' could not be found for ArticlesController
```

Go back and look at the test you created.  Since my error is concerning the click_on "Create Article" that tells me Capybara made it through all those fill_in steps without a problem. 

### The `create` Action

Your old friend pops up again...

```
AbstractController::ActionNotFound:
  The action 'create' could not be found for ArticlesController
```

We accessed the `new` action to load the form, but Rails' interpretation of REST uses a second action named `create` to process the data from that form. Inside your `articles_controller.rb` add this method (again, _inside_ the `ArticlesContoller` class, but _outside_ the other methods):

```ruby
def create

end
```

When we run our tests again, we get this rather unhelpful error:

```ruby
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: expect(page).to have_content("New Title!")

     Capybara::ElementNotFound:
       Unable to find visible xpath "/html"
```

This is a great opportunity to use Launchy. Put a `save_and_open_page` after the click_on "Create Article" but before the expectation lines. You should see absolutely nothing on the page. If you go to your server tab you should see:

```
Started POST "/articles" for 127.0.0.1 at 2018-01-18 09:55:52 -0700
Processing by ArticlesController#create as HTML
  Parameters: {"utf8"=>"✓", "authenticity_token"=>"T/n64kWdb4FRAQ8CCiHA27k4141L+70dDCBxAYXOmjJCzeNRmGiKV3dICHTg9fHShY1H5B2Wsbq2sarKoxBwsQ==", "article"=>{"title"=>"something", "body"=>"other things"}, "commit"=>"Create Article"}
No template found for ArticlesController#create, rendering head :no_content
Completed 204 No Content in 46ms (ActiveRecord: 0.0ms)
```

That last line says `Completed 204 No Content`. This is a fancy way to say your POST request did absolutely nothing, which matches the amount of code in our `#create` action: absolutely nothing.

#### We Don't Always Need Templates

When you click the "Create" button, what would you expect to happen? Most web applications would process the data submitted then show you the object. In this case, display the article.

We already have an action and template for displaying an article, the `show`, so there's no sense in creating another template to do the same thing.

#### Processing the Data

Before we can send the client to the `show`, let's process the data. The data from the form will be accessible through the `params` method.

To check out the structure and content of `params`, put a pry in your create action:

```ruby
def create
  binding.pry
end
```

The `binding.pry` method will halt the request allowing you to play with the code inside of your console.

Re-run your tests to hit the pry.

#### Understanding Form Parameters

Type `params` into your pry session to see the output.

Here is the request information. We are interested in the parameters (I've inserted line breaks for readability):

```
{"utf8"=>"✔", "authenticity_token"=>"UDbJdVIJjK+qim3m3N9qtZZKgSI0053S7N8OkoCmDjA=",
 "article"=>{"title"=>"Fourth Sample", "body"=>"This is my fourth sample article."},
 "commit"=>"Create", "action"=>"create", "controller"=>"articles"}
```

What are all those? We see the `{` and `}` on the outside, similar to a `Hash`. Within the hash we see keys:

* `utf8` : This meaningless checkmark is a hack to force Internet Explorer to submit the form using UTF-8. [Read more on StackOverflow](http://stackoverflow.com/questions/3222013/what-is-the-snowman-param-in-rails-3-forms-for)
* `authenticity_token` : Rails has some built-in security mechanisms to resist "cross-site request forgery". Basically, this value proves that the client fetched the form from your site before submitting the data.
* `article` : Points to a nested hash with the data from the form itself
  * `title` : The title from the form
  * `body` : The body from the form
* `commit` : This key holds the text of the button they clicked. From the server side, clicking a "Save" or "Cancel" button looks exactly the same except for this parameter.
* `action` : Which controller action is being activated for this request
* `controller` : Which controller class is being activated for this request

#### Pulling Out Form Data

Now that we've seen the structure, we can access the form data to mimic the way we created sample objects in the console. In the `create` action, take the `binding.pry` out and try this:

```ruby
def create
  @article = Article.new
  @article.title = params[:article][:title]
  @article.title = params[:article][:body]
  @article.save
end
```

Heading back to our tests, remove the save_and_open_page and then run your test suite again. We still get that xpath error. If you refresh your browser and enter the form again, when you look at your server you should still see this error:

```
No template found for ArticlesController#create, rendering head :no_content
Completed 204 No Content in 70ms (ActiveRecord: 13.2ms)
```

We still don't have a template. Why is this error different from the other no template error? Remember we used a POST to get to our create action, all our other ones have been GET requests so far. We don't usually have a view for a POST request. Instead we need to send a message to the browser that we've successully created and that it needs to make a second call to our show path.

Add one more line to the action, the redirect:

```ruby
redirect_to article_path(@article)
```

When you run your test suite, you should see all passing tests. !!
Let's commit this before refactoring.

#### Fragile Controllers

Controllers are middlemen in the MVC framework. They should know as little as necessary about the other components to get the job done. This controller action knows too much about our model.

To clean it up, let me first show you a second way to create an instance of `Article`. You can call `new` and pass it a hash of attributes, like this:

```ruby
def create
  @article = Article.new(
    title: params[:article][:title],
    body: params[:article][:body])
  @article.save
  redirect_to article_path(@article)
end
```

Try that in your app, if you like, and it'll work just fine.

But look at what we're doing. `params` gives us back a hash, `params[:article]` gives us back the nested hash, and `params[:article][:title]` gives us the string from the form. We're hopping into `params[:article]` to pull its data out and stick it right back into a hash with the same keys/structure.

There's no point in that! Instead, just pass the whole hash:

```ruby
def create
  @article = Article.new(params[:article])
  @article.save
  redirect_to article_path(@article)
end
```

Test and you'll find that it... blows up! What gives?

For security reasons, it's not a good idea to blindly save parameters sent to us via the params hash. Luckily, Rails gives us a feature to deal with this situation: Strong Parameters.

It works like this: You use two new methods, `require` and `permit`.  They help you declare which attributes you'd like to accept. Add the below code to the bottom of your `articles_controller.rb`.

```ruby
private

  def article_params
    params.require(:article).permit(:title, :body)
  end
```

Now, you'll then use this method instead of the `params` hash directly:

```ruby
@article = Article.new(article_params)
```

Go ahead and add this helper method to your code, and change the arguments to `new`. It should look like this, in your articles_controller.rb file, when you're done:

```ruby
class ArticlesController < ApplicationController

  #...

  def create
    @article = Article.new(article_params)
    @article.save

    redirect_to article_path(@article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

end
```

We can then re-use this method any other time we want to make an `Article`.

Commit, push, PR, merge, checkout master, pull, delete. Look at the header directly below, make a new branch based on that header.

### Deleting Articles

We can create articles and we can display them, but when we eventually deliver this to less perfect people than us, they're going to make mistakes. There's no way to remove an article, let's add that next.

We could put delete links on the index page, but instead let's add them to the `show.html.erb` template. 

#### But first, a test

We want a brand new test file where our user is going to delete an article. 

* We've already decided that we will be linking from the show page. 
* How would we build an assertion that proves that it is gone from the complete list of articles?

Build out your own test first before checking out my example below. 

```ruby
require "rails_helper"

describe "user deletes an article" do
  describe "they link from the show page" do
    it "displays all articles without the deleted entry" do
      article_1 = Article.create!(title: "Title 1", body: "Body 1")
      article_2 = Article.create!(title: "Title 2", body: "Body 2")

      visit article_path(article_1)
      click_link "Delete"

      expect(current_path).to eq(articles_path)
      expect(page).to have_content(article_2.title)
      expect(page).to_not have_content(article_1.title)
    end
  end
end

``` 
With our test all put together let's commit that first before moving on. When we run the test suite, we get the following error. Remember the important part to read in the error message is above the long stack trace where it lists the `Failures` message. 

```ruby
Failures:

  1) user deletes an article they link from the show page displays all articles without the deleted entry
     Failure/Error: click_link "Delete"

     Capybara::ElementNotFound:
       Unable to find visible link "Delete"
```

Let's figure out how to create the link.

We'll start with the `link_to` helper, and we want it to say the word "delete" on the link. So that'd be:

```erb
<%= link_to "Delete", some_path %>
```

But what should `some_path` be? Look at the routes table with `rake routes`. The `destroy` action will be the last row, but it has no name in the left column. In this table the names "trickle down," so look up two lines and you'll see the name `article`.

The helper method for the destroy-triggering route is `article_path`. It needs to know which article to delete since there's an `:id` in the path, so our link will look like this:

```erb
<%= link_to "delete", article_path(@article) %>
```

Add that to `app/views/articles/show.html.erb`.

When we run our test suite again, we get the following error:

```ruby
Failures:

  1) user deletes an article they link from the show page displays all articles without the deleted entry
     Failure/Error: expect(current_path).to eq(articles_path)

       expected: "/articles"
            got: "/articles/3"

       (compared using ==)
     # ./spec/features/user_deletes_an_article_spec.rb:12:in `block (3 levels) in <top (required)>'
```

Huh? If you look closely, this error is coming from line 12 of our test file where we told our application that we expect to be on the index (articles_path aka "/articles") but instead we're on "/articles/85" (aka article_path(article aka a show).

#### REST is about Path and Verb

Why isn't the article being deleted? If you look at the server window, this is the response to our link clicking:

```
Started GET "/articles/3" for 127.0.0.1 at 2012-01-08 13:05:39 -0500
  Processing by ArticlesController#show as HTML
  Parameters: {"id"=>"3"}
  Article Load (0.1ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = ? LIMIT 1  [["id", "3"]]
Rendered articles/show.html.erb within layouts/application (5.2ms)
Completed 200 OK in 13ms (Views: 11.2ms | ActiveRecord: 0.3ms)
```

Compare that to what we see in the routes table:

```
             DELETE /articles/:id(.:format)      articles#destroy
```

The path `"articles/3"` matches the route pattern `articles/:id`, but look at the verb. The server is seeing a `GET` request, but the route needs a `DELETE` verb. How do we make our link trigger a `DELETE`?

You can't, exactly. While most browsers support all four verbs, `GET`, `PUT`, `POST`, and `DELETE`, HTML links are always `GET`, and HTML forms only support `GET` and `POST`. So what are we to do?

Rails' solution to this problem is to *fake* a `DELETE` verb. In your view template, you can add another attribute to the link like this:

```erb
<%= link_to "delete", article_path(@article), method: :delete %>
```

Through some JavaScript tricks, Rails can now pretend that clicking this link triggers a `DELETE`. Try your tests again, and say hello to your old friend, "ActionNotFound" error.

#### The `destroy` Action

Now that the router is recognizing our click as a delete, we need the action. The HTTP verb is `DELETE`, but the Rails method is `destroy`, which is a bit confusing.

Let's define the `destroy` method in our `ArticlesController` so it:

1. Uses `params[:id]` to find the article in the database
2. Calls `.destroy` on that object
3. Redirects to the articles index page

Do that now on your own and run your tests.

Didn't quite get there? See the code below:

```ruby
  def destroy
    Article.destroy(params[:id])
    redirect_to articles_path
  end
```

Passing tests means time to commit! 

#### Confirming Deletion

There's one more parameter you might want to add to your `link_to` call in your `show.html.erb`:

```ruby
data: {confirm: "Really delete the article?"}
```

This will pop up a JavaScript dialog when the link is clicked. The Cancel button will stop the request, while the OK button will submit it for deletion. Run your tests again to make sure this change didn't break anything. Your tests should still be passing, which means...

Delete functionality is implemented! Now go be a Git boss and wrap up this branch.

### Creating an Edit Action & View

If you haven't already, checkout a new branch for edit functionality.

Sometimes we don't want to destroy an entire object, we just want to make some changes. We need an edit workflow.

In the same way that we used `new` to display the form and `create` to process that form's data, we'll use `edit` to display the edit form and `update` to save the changes.

#### First, we write a test  

We want to create a new test file for the purpose of checking if a user can edit an article. Try to come up with your own list of what you want your test to do, thinking through each phase of a test (setup, action, assertion). Think about the user flow. We want to link from a show to an edit (which only displays the form), fill in a form, and see the results of our change to this single article. Put together your test on your own. I'm not going to give you a sample test, but you might reference the new/create test if you need some support.

Commit your new test.
Run your test and you should get a similar error:

```ruby
Failures:

  1) user edits an article they link from a show page they fill in an edit field and submit displays the updated information on a show
     Failure/Error: click_link "Edit"

     Capybara::ElementNotFound:
       Unable to find visible link "Edit"
```

#### Adding the Edit Link

Again in `show.html.erb`, let's add this:

```erb
<%= link_to "edit", edit_article_path(@article) %>
```

Trigger the `edit_article` route and pass in the `@article` object. When you run your tests you should get an `ActionNotFound` message or edit.

#### Implementing the `edit` Action

The router is expecting to find an action in `ArticlesController` named `edit`, so let's add this:

```ruby
def edit
  @article = Article.find(params[:id])
end
```

The router is expecting to find an action in `ArticlesController` named `edit`, so let's add this:

```ruby
def edit

end
```
When you run your test suite you'll see the `ArticlesController#edit is missing a template for this request format and variant.` error message. Let't go create that file.

#### An Edit Form

Create a file `app/views/articles/edit.html.erb`. Below is what the edit form would look like:

```erb
<h1>Edit an Article</h1>

<%= form_for(@article) do |f| %>
  <ul>
  <% @article.errors.full_messages.each do |error| %>
    <li><%= error %></li>
  <% end %>
  </ul>
  <p>
    <%= f.label :title %><br />
    <%= f.text_field :title %>
  </p>
  <p>
    <%= f.label :body %><br />
    <%= f.text_area :body %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>
```

Run your test and you should get an error similar to this:

```ruby
Failures:

  1) user edits an article they link from a show page they fill in an edit field and submit displays the updated information on a show
     Failure/Error: <%= form_for(@article) do |f| %>

     ActionView::Template::Error:
       First argument in form cannot contain nil or be empty
```

We've seen this error before. When you build your form_for you pass it an argument of your object (@article). Where do we get @article from? The controller. Take a look at your edit action in your controller. 

Add `@article = Article.find(params[:id])` to your edit method. Rerun your test, and we have a new error! 

But wait, that code in edit looks an awful lot like how we set `@article` in our 'show' and `delete` action. Let's first DRY up this with a `before_action`:

```ruby
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :edit]

  ...

  private

  ...

  def set_article
    @article = Article.find(params[:id])  
  end
end
```

This runs the `set_article` method before `show`, `destroy` and `edit`, as specified by the `only:` key. With this, `@article` is available within the scopes of the `show`, `destroy` and `edit` actions. We can now remove the lines in `show`, `destroy` and `edit` that set `@article`, leaving something like this:

```ruby
def show
end

def destroy
  @article.destroy

  redirect_to articles_path
end

def edit
end
```

All the `edit` action does is find the object and display the form. Run your tests again to make sure you're still getting the following error:

```ruby
Failures:

  1) user edits an article they link from a show page they fill in an edit field and submit displays the updated information on a show
     Failure/Error: click_on "Update Article"

     AbstractController::ActionNotFound:
       The action 'update' could not be found for ArticlesController
```

#### Implementing Update

The router is looking for an action named `update`. Just like the `new` action sends its form data to the `create` action, the `edit` action sends its form data to the `update` action. In fact, within our `articles_controller.rb`, the `update` method will look very similar to `create`.

First, since we'll need to find an article by `id`, let's add `update` to our `before_action`:

```ruby
before_action :set_article, only: [:destroy, :edit, :update]
```

With `@article` set:

```ruby
def update
  @article.update(article_params)

  redirect_to article_path(@article)
end
```

The only new bit here is the `update` method. It's very similar to `Article.new` where you can pass in the hash of form data. It changes the values in the object to match the values submitted with the form. One difference from `new` is that `update` automatically saves the changes.

We use the same `article_params` method as before so that we only update the attributes we're allowed to.

Run your test suite again, and passing tests!! Passing tests means time to commit our progress.

#### Some Refactoring

In the Ruby community there is a mantra of "Don't Repeat Yourself" -- but that's exactly what I've done with our edit view. This view is basically the same as the `new.html.erb` -- the only change is the H1. We can abstract this form into a single file called a _partial_, then reference this partial from both `new.html.erb` and `edit.html.erb`.

#### Creating a Form Partial

Partials are a way of packaging reusable view template code. We'll pull the common parts out from the form into the partial, then render that partial from both the new template and the edit template.

Create a file `app/views/articles/_form.html.erb` and, yes, it has to have the underscore at the beginning of the filename. Partials always start with an underscore.

Open your `app/views/articles/new.html.erb` and CUT all the text from and including the `form_for` line all the way to its `end`. The only thing left will be your H1 line.

Add the following code to the new view:

```erb
<%= render partial: 'form' %>
```

Now go back to the `_form.html.erb` and paste the code from your clipboard.

Run your tests to make sure they're still passing and you haven't broken anything. 

#### Writing the Edit Template

Then look at your `edit.html.erb` file. Remove the entirty of the form_for and add the line which renders the partial.

```html
  <h1>Edit <%= @article.title %></h1>
  <%= render partial: 'form' %>
```

Run your tests again and make sure they're all green. Then, commit your changes.

### Adding a flash message

Our operations are working, but it would be nice if we gave the user some kind of status message about what took place. When we create an article the message might say "Article 'the-article-title' was created", or "Article 'the-article-title' was removed" for the remove action. We can accomplish this with the `flash` object.

The controller provides you with accessor methods to interact with the `flash` object. Calling `flash.notice` will fetch a value, and `flash.notice = "Your Message"` will store the string into it.

#### But first, let's add to our test 

In your user_edits_an_article_spec add the following expectation:

```ruby
expect(page).to have_content("Article Your Updated Title was updated.")
```

Run your tests an you should see a similar error:

```ruby
Failures:

  1) user edits an article they link from a show page they fill in an edit field and submit displays the updated information on a show
     Failure/Error: expect(page).to have_content("Article #{article.title} was updated.")
       expected to find text "Article Title 1 was updated." in "Different Title Different Body Edit Delete << Back to Articles List"
     # ./spec/features/user_edits_an_article_spec.rb:22:in `block (4 levels) in <top (required)>'
```

The `expected to find text "Article Title 1 Updated!" in "Different Title Different Body Edit Delete << Back to Articles List"` part tells us RSpec couldn't find this new text on the page. Which makes sense because we haven't implemented it yet.

#### Flash for Update

Let's look first at the `update` method we just worked on. It currently looks like this:

```ruby
def update
  @article.update(article_params)

  redirect_to article_path(@article)
end
```

We can add a flash message by inserting one line:

```ruby
def update
  @article.update(article_params)

  flash.notice = "Article '#{@article.title}' Updated!"

  redirect_to article_path(@article)
end
```

#### Testing the flash messages

Run your test suite. What error do you get? The same one?!

We need to add the flash messages to our view templates. We stored our message in the flash objct, but we didn't print it to the page. The `update` method redirects to the `show`, so we _could_ just add the display to our show template.

However, we will use the flash object in many actions of the application. Most of the time, it's preferred to add it to our layout.

#### Flash messages in the Layout

If you look in `app/views/layouts/application.html.erb` you'll find what is called the "application layout". A layout is used to wrap multiple view templates in your application. You can create layouts specific to each controller, but most often we'll just use one layout that wraps every view template in the application.

Looking at the default layout, you'll see this:

```erb
<!DOCTYPE html>
<html>
<head>
  <title>Blogger</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>

```

The `yield` is where the view template content will be injected. Just *above* that yield, let's display the flash message by adding this:

```erb
<p class="flash"><%= flash.notice %></p>
```

This outputs the value stored in the `flash` object in the attribute `:notice`.

Run your test suite again and you should have all passing tests. Which means, time to commit! 

#### Adding More Messages

Typical controllers will set flash messages in the `update`, `create`, and `destroy` actions. Add assertions into each test, insert messages into the `create` and `destroy` actions now.

If you have passing tests, then you're done with I1. Commit!

### An Aside on the Site Root

It's annoying me that we keep going to `http://localhost:3000/` and seeing the Rails starter page. Let's make the root show our articles index page.

Open `config/routes.rb` and right above the other routes (in this example, right above `resources :articles`) add in this one:

```ruby
root to: 'articles#index'
```

Now visit `http://localhost:3000` and you should see your article list.

With flash message, partials, and a root default, we got a little beyond the scope of our branch, and I'm okay with that. We didn't really add anything new of substance, just made things nicer.

**Commit, push, PR, merge, checkout, pull, delete.**

If you are not happy with the code changes you have implemented in this iteration, you don't have to throw the whole project away and restart it.  You can use Git's reset command to roll back to your first commit, and retry this iteration from there.  To do so, in your terminal, type in:

```
$ git log
commit <SOME BIG SHA KEY>
Author: your_name your_email
Date:   Thu Apr 11 11:02:57 2013 -0600
    first blogger commit
$ git reset --hard <SOME BIG SHA KEY>
```

## I2: Adding Comments

Most blogs allow the reader to interact with the content by posting comments. Let's add some simple comment functionality. Don't forget to checkout a new branch.

### Designing the Comment Model

First, we need to brainstorm what a comment _is_...what kinds of data does it have...

* It's attached to an article
* It has an author name
* It has a body

With that understanding, let's create a `Comment` model and a test. 

### Testing a Model's Relationships

Create a new file `touch spec/models/comment_spec.rb`

Set up your test similar to how we formatted the article model test, except this time we want to check that it has the right relationship to an article rather than validating presence of attributes. Your assertion might look like this: 

```ruby
  it {should belong_to(:article)}
```

Commit your test, then run the test suite. You should see an error similar to this:

```ruby
An error occurred while loading ./spec/models/comment_spec.rb.
Failure/Error:
  describe Comment, type: :model do
    it {should belong_to(:article)}
  end

NameError:
  uninitialized constant Comment
```
Remember this means RSpec cannot find a Comment. Which makes sense because we haven't made one yet in neither our database nor our models.

Let's make a Comment! Switch over to your terminal and enter this line:

```bash
$ rails generate migration CreateComments author_name:string body:text article:references
```

We'll be most interested in the migration file and adding the `comment.rb` file.

### Setting up the Migration

Open the migration file that the generator created,
`db/migrate/some-timestamp_create_comments.rb`. Let's see the fields that were
added:

```ruby
t.string :author_name
t.text :body
t.references :article, index: true, foreign_key: true

t.timestamps
```

You might see some Rails projects pre-5.0.0 that have `t.timestamps null: false`. This is now the default option, which prevents null values from being saved for either `created_at` or `updated_at`. You might need to add t.timestamps **Before** you migrate.

Once you've taken a look at your generated migration task, go to your terminal and run the migration:

```bash
$ rake db:migrate
```

We've made a pretty major change in alterign our database so let's commit that change. 

```bash
git add db/migrate
git add db/schema
git commit -m "Add comments table to db"
```

### Add Comments Model

If we run our test again, we get that same `uninitialized constant Comment` error. We need to create the Comment class as well.  

```ruby
#app/models/comment.rb

class Comment < ApplicationRecord
end
```

### Relationships

The power of SQL databases is the ability to express relationships between elements of data. We can join together the information about an order with the information about a customer. Or in our case here, join together an article in the `articles` table with its comments in the `comments` table. We do this by using foreign keys.

Foreign keys are a way of marking one-to-one and one-to-many relationships. An article might have zero, five, or one hundred comments. But a comment only belongs to one article. These objects have a one-to-many relationship -- one article connects to many comments.

Part of the big deal with Rails is that it makes working with these relationships very easy. When we created the migration for comments we started with a `references` field named `article`. The Rails convention for a one-to-many relationship:

* the objects on the "many" end should have a foreign key referencing the "one" object.
* that foreign key should be titled with the name of the "one" object, then an underscore, then "id".
* We would say that objects on the "many" end "belong_to" the object on the "one" end

In this case one article has many comments, so each comment has a field named `article_id`. We would say an article `has_many` comments and a comment `belongs_to` an article.

Following this convention will get us a lot of functionality "for free."  

If we run our tests, we find a new error:

```ruby
Failures:

  1) Comment should belong to article
     Failure/Error: it {should belong_to(:article)}
       Expected Comment to have a belongs_to association called article (no association called article)
```

Open your `app/models/comment.rb` and add:

```ruby
class Comment < ActiveRecord::Base
  belongs_to :article
end
```
The reason this `belongs_to` field already exists is because when we generated the Comment model, we included this line: `article:references`. What that does is tell Rails that we want this model to _reference_ the Article model, thus creating a one-way relationship from Comment to Article. You can see this in action in our migration on the line `t.references :article`.

A comment relates to a single article, it "belongs to" an article. We then want to declare the other side of the relationship inside `app/models/article.rb`.  

#### But first, the test

Let's add a section to our `spec/models/article_spec.rb`. Inside the first describe block, but outside of the validations describe block add another block for relationships with an assertion that article should have_many comments. Give it a try before looking at my example below.

```ruby 
describe "relationshps" do
  it {should have_many(:comments)}
end
```

Our error should look like this: 

```ruby
Failures:

  1) Article relationshps should have many comments
     Failure/Error: it {should have_many(:comments)}
       Expected Article to have a has_many association called comments (no association called comments)
```
To satisy this error we can add the following method to `article.rb`. 

```ruby
class Article < ActiveRecord::Base
  has_many :comments
end
```

Unlike how `belongs_to :article` was implemented for us on the creation of the Comment model because of the references, the `has_many :comments` relationship must be entered in manually.

Now an article "has many" comments, and a comment "belongs to" an article. We have explained to Rails that these objects have a one-to-many relationship.

Run your tests again and they should be all green. Which means, time to commit! 

### Testing in the Console

Let's use the console to play with how this relationship works in code. If you don't have a console open, go to your terminal and enter `rails console` from your project directory. If you have a console open already, enter the command `reload!` to refresh any code changes.

Run the following commands one at a time and observe the output:

```
$ article = Article.first
$ article.comments
$ Comment.new
$ article.comments.new
$ article.comments
```
When you called the `comments` method on object `article`, it gave you back a blank array because that article doesn't have any comments. When you executed `Comment.new` it gave you back a blank Comment object with those fields we defined in the migration.

But, if you look closely, when you did `article.comments.new` the comment object you got back wasn't quite blank -- it has the `article_id` field already filled in with the ID number of article `article`. Additionally, the following (last) call to `article.comments` shows that the new comment object has already been added to the in-memory collection for the `article`, Article object.

Try creating a few comments for that article like this:

```
$ comment = article.comments.new
$ comment.author_name = "Daffy Duck"
$ comment.body = "I think this article is thhh-thhh-thupendous!"
$ comment.save
$ new_comment = article.comments.create(author_name: "Chewbacca", body: "RAWR!")
```
For the first Comment, `comment`, I used a series of commands like we've done before. For the second comment, `new_comment`, I used the `create` method. `new` doesn't send the data to the database until you call `save`. With `create` you build and save to the database all in one step.

Now that you've created a few comments, try executing `article.comments` again. Did your comments all show up?  When I did it, only one comment came back. The console tries to minimize the number of times it talks to the database, so sometimes if you ask it to do something it's already done, it'll get the information from the cache instead of really asking the database -- giving you the same answer it gave the first time. That can be annoying. To force it to clear the cache and lookup the accurate information, try this:

```
$ article.reload
$ article.comments
```
You'll see that the article has associated comments. Now we need to integrate them into the article display.

### Displaying Comments for an Article

We want to display any comments underneath their parent article. 

Go back to `user_sees_one_article_spec.rb`. We're going to need to add some comments associated with the article and also add some assertions that those comments are showing up on the page. My test now looks like this:

```ruby
require "rails_helper"

describe "user sees one article" do
  describe "they link from the article index" do
    it "displays information for one article" do
      article = Article.create!(title: "New Title", body: "New Body")
      comment_1 = article.comments.create(author_name: "Me", body: "Commenty comments")
      comment_2 = article.comments.create(author_name: "You", body: "So much to say")
      
      visit articles_path

      click_link article.title

      expect(page).to have_content(article.title)
      expect(page).to have_content(article.body)
      expect(page).to have_content(comment_1.author_name)
      expect(page).to have_content(comment_1.body)
      expect(page).to have_content(comment_2.author_name)
      expect(page).to have_content(comment_2.body)
    end
  end
end

```
First commit, then let's run our test and see what kind of error we get.

```ruby
Failures:

  1) user sees one article they link from the article index displays information for one article
     Failure/Error: expect(page).to have_content(comment_1.author_name)
       expected to find text "Me" in "New Title New Body Edit Delete << Back to Articles List"
```

This tells me two things. First, RSpec didn't have any problem creating comments associated with an article. Excellent. Second, the information for an article's comments is not showing up on the page.

Open `app/views/articles/show.html.erb` and add the following lines right before the link to the articles list:

```erb
<h3>Comments</h3>
<%= render partial: 'articles/comment', collection: @article.comments.reverse %>
```

This renders a partial named `"comment"` and sets that we want to do it once for each element in the collection `@article.comments`. We saw in the console that when we call the `.comments` method on an article we'll get back an array of its associated comment objects. This render line will pass each element of that array one at a time into the partial named `"comment"`. Now we need to create the file `app/views/articles/_comment.html.erb` and add this code:

```erb
<div>
  <h4>Comment by <%= comment.author_name %></h4>
  <p class="comment"><%= comment.body %></p>
</div>
```

When you run your test suite again you should see all green. Time to commit!

### Web-Based Comment Creation

Good start, but our users can't get into the console to create their comments. We'll need to create a web interface.

#### Building a Comment Form Partial

The lazy option would be to add a "New Comment" link to the article `show` page. A user would read the article, click the link, go to the new comment form, enter their comment, click save, and return to the article.

But, in reality, we expect to enter the comment directly on the article page. This means we need to further update our `user_sees_one_article_spec.rb`. For this I'm going to add another whole describe block, nested within the outermost describe block.

```ruby
  describe "they fill in a comment form" do
    it "displays the comment on the article show" do
      article = Article.create!(title: "New Title", body: "New Body")

      visit article_path(article)

      fill_in "comment[author_name]", with: "ME!"
      fill_in "comment[body]", with: "So many thoughts on this article."
      click_on "Submit"

      expect(current_path).to eq(article_path(article))
      expect(page).to have_content("Post a Comment")
      expect(page).to have_content("ME!")
      expect(page).to have_content("So many thoughts on this article.")
    end
  end

```
Commit your test change!
Then, my error looks like this:

```ruby
Failures:

  1) user sees one article they fill in a comment form displays the comment on the article show
     Failure/Error: fill_in "comment[author_name]", with: "ME!"

     Capybara::ElementNotFound:
       Unable to find visible field "comment[author_name]" that is not disabled
```

From this I know that RSpec can't find my form on the page.

Let's look at how to embed the new comment form onto the article `show`.

Just above the "Back to Articles List" in the articles `show.html.erb`:

```erb
<%= render partial: 'comments/form' %>
```

This is expecting a file `app/views/comments/_form.html.erb`, so create the `app/views/comments/` directory with the `_form.html.erb` file, and add this form:

```erb
<h3>Post a Comment</h3>

<%= form_for [ @article, @comment ] do |f| %>
  <p>
    <%= f.label :author_name %><br/>
    <%= f.text_field :author_name %>
  </p>
  <p>
    <%= f.label :body %><br/>
    <%= f.text_area :body %>
  </p>
  <p>
    <%= f.submit 'Submit' %>
  </p>
<% end %>
```

Whoa, major test breakage.  Don't panic. A lot of our assertions hit the article show, so each time the test suite tries to load that view we get this same error:

```ruby
Failures:

  1) **this line is likely different for you**
     Failure/Error: <%= form_for [ @article, @comment ] do |f| %>

     ActionView::Template::Error:
       First argument in form cannot contain nil or be empty
```

We know this error. We've seen it twice already. We are passing our form_for an argument of which type of object we're working with. In this form we pass **both** @article - the article the comment will belong to - and @comment. When this happened before it meant we hadn't created the emtpy Ruby object for the form to build off of. Let's go look in our ArticlesController. Remember we got to this partial on the show route, so we need to check out the show action. 

#### In the `ArticlesController`

First look in your `articles_controller.rb` for the `new` method.

Remember how we created a blank `Article` object so Rails could figure out which fields an article has?  We need to do the same thing for our comment form.

But when we view the article and display the comment form we're not running the article's `new` method, we're running the `show` method. So we'll need to create a blank `Comment` object inside that `show` method like this:

```ruby
@comment = Comment.new
@comment.article_id = @article.id
```

Due to the Rails' mass-assignment protection, the `article_id` attribute of the new `Comment` object needs to be manually assigned with the `id` of the `Article`. Why do you think we use `Comment.new` instead of `@article.comments.new`?



#### Trying the Comment Form

Run your tests again you'll get an error like this:

```
 Failure/Error: <%= form_for [ @article, @comment ] do |f| %>

     ActionView::Template::Error:
       undefined method `article_comments_path' for #<#<Class:0x007faca3c81228>:0x007faca40fd310>
       Did you mean?  article_path
```

The `form_for` helper is trying to build the form so that it submits to `article_comments_path`. That's a helper which we expect to be created by the router, but we haven't told the router anything about `Comments` yet. Open `config/routes.rb` and update your article to specify comments as a sub-resource.

```ruby
resources :articles do
  resources :comments
end
```

Run your tests again. Hallelujah, we got most of our green back. We still have one test failing with an `uninitialized constant CommentsController` error.

Before we move on, getting all those green tests back, I think deserves a commit.

<div class="note">
  <p>Did you figure out why we aren't using <code>@article.comments.new</code>? If you want, edit the <code>show</code> action and replace <code>@comment = Comment.new</code> with <code>@comment = @article.comments.new</code>. Refresh the browser. What do you see?</p>
  <p>For me, there is an extra empty comment at the end of the list of comments. That is due to the fact that <code>@article.comments.new</code> has added the new <code>Comment</code> to the in-memory collection for the <code>Article</code>. Don't forget to change this back.</p>
</div>

#### Creating a Comments Controller

Just like we needed an `articles_controller.rb` to manipulate our `Article` objects, we'll need a `comments_controller.rb`.

Switch over to your terminal to generate it:

```bash
$ touch app/controllers/comments_controller.rb
```

And set up that file:

```ruby
# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
end
```

**BEFORE** you run your tests, predict which error message you'll see. Okay run your test, did you get what you expected? I got this:

```
Failures:

  1) user sees one article they fill in a comment form displays the comment on the article show
     Failure/Error: click_on "Submit"

     AbstractController::ActionNotFound:
       The action 'create' could not be found for CommentsController
```

We need a create action in our CommentsController.

#### Writing `CommentsController.create`

The comment form is attempting to create a new `Comment` object which triggers the `create` action. How do we write a `create`?

You can cheat by looking at the `create` method in your `articles_controller.rb`. For your `comments_controller.rb`, the instructions should be the same just replace `Article` with `Comment`.

There is one tricky bit, though! We need to assign the article id to our comment like this:

```ruby
def create
  @comment = Comment.new(comment_params)
  @comment.article_id = params[:article_id]

  @comment.save

  redirect_to article_path(@comment.article)
end

private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
```
Go ahead and run your tests again. ALL GREEN TESTS! Commit!

#### After Creation

As a user, imagine you write a witty comment, click save, then what would you expect? Probably to see the article page, maybe automatically scrolling down to your comment.

At the end of our `create` action in `CommentsController`, how do we handle the redirect? Instead of showing them the single comment, let's go back to the article page:

```ruby
redirect_to article_path(@comment.article)
```

Recall that `article_path` needs to know *which* article we want to see. We might not have an `@article` object in this controller action, but we can find the `Article` associated with this `Comment` by calling `@comment.article`.

### Cleaning Up

We've got some decent comment functionality, but there are a few things we should add and tweak.

#### Comments Count

Let's make it so where the view template has the "Comments" header, it displays how many comments there are, like "Comments (3)". First add an assertion to your `user_sees_one_article_spec`. Open up your article's `show.html.erb` and change the comments header so it looks like this:

```erb
<h3>Comments (<%= @article.comments.size %>)</h3>
```

Run your tests to make sure you didn't break anything.

#### Form Labels

The comments form looks a little silly with "Author Name". It should probably say "Your Name", right?  To change the text that the label helper prints out, you pass in the desired text as a second parameter, like this:

```erb
<%= f.label :author_name, "Your Name"  %>
```

Change your `comments/_form.html.erb` so it has labels "Your Name" and "Your Comment". Run your tests again to make sure you didn't break anything.

#### Add a Timestamp to the Comment Display

We should add something about when the comment was posted. Rails has a really neat helper named `distance_of_time_in_words` which takes two dates and creates a text description of their difference like "32 minutes later", "3 months later", and so on.

You can use it in your `_comment.html.erb` partial like this:

```erb
<p>Posted <%= distance_of_time_in_words(comment.article.created_at, comment.created_at) %> later</p>
```

With that, you're done with I2!  Now that the comments feature has been added, git your gitflow going.

## PAUSE

How did you feel about those first three iterations? If you feel shaky at all, spike this project and do it all over again. That's right, head to your terminal and:

```
cd ..
rm -rf blogger
rails new blogger
```

If you feel awesome about and comfortable with what we've done so far, feel free to move on.

Note: Iterations 0-2 were updated to reflect Rails 5.1.0, if you run into inconsistencies between the tutorial and your development (e.g., different error messages or behavior), it could be due to version differences.

## I3: Tagging

In this iteration we'll add the ability to tag articles for organization and navigation.

First we need to think about what a tag is and how it'll relate to the Article model. If you're not familiar with tags, they're commonly used in blogs to assign the article to one or more categories.

For instance, if I write an article about a feature in Ruby on Rails, I might want it tagged with all of these categories: "ruby", "rails" and "programming". That way if one of my readers is looking for more articles about one of those topics they can click on the tag and see a list of my articles with that tag.

### Understanding the Relationship

What is a tag?  We need to figure that out before we can create the model. First, a tag must have a relationship to an article so they can be connected. A single tag, like "ruby" for instance, should be able to relate to *many* articles. On the other side of the relationship, the article might have multiple tags (like "ruby", "rails", and "programming" as above) - so it's also a *many* relationship. Articles and tags have a *many-to-many* relationship.

Many-to-many relationships are tricky because we're using an SQL database. If an Article "has many" tags, then we would put the foreign key `article_id` inside the `tags` table - so then a Tag would "belong to" an Article. But a tag can connect to *many* articles, not just one. We can't model this relationship with just the `articles` and `tags` tables.

When we start thinking about the database modeling, there are a few ways to achieve this setup. One way is to create a "join table" that just tracks which tags are connected to which articles. Traditionally this table would be named `article_tags` and Rails would express the relationships by saying that the Article model `has_and_belongs_to_many` Tags, while the Tag model `has_and_belongs_to_many` Articles.

Most of the time this isn't the best way to really model the relationship. The connection between the two models usually has value of its own, so we should promote it to a real model. For our purposes, we'll introduce a model named "Tagging" which is the connection between Articles and Tags. The relationships will setup like this:

* An Article `has_many` Taggings
* A Tag `has_many` Taggings
* A Tagging `belongs_to` an Article and `belongs_to` a Tag

### Making Models

With those relationships in mind, let's design the new models:

* Tag
  * `name`: A string
* Tagging
  * `tag_id`: Integer holding the foreign key of the referenced Tag
  * `article_id`: Integer holding the foreign key of the referenced Article

Note that there are no changes necessary to Article because the foreign key is stored in the Tagging model. 

#### But first, we test

Let's make two tests. One for Tagging and one for Tag. We want each to test it's relationship with both other pieces (i.e. a Tagging belongs_to Tag AND Tagging belongs_to Article)

* Create a model test for Tag, checking its relationships
* Create a model test for Taggin, checking its relationships
* Add expectations to an Articles relationships section for Tag and Tagging

One hint, you've used the have_many shoulda-matchers method. Now tag `.through(:resource_name)` to the end to test this has_may through scenario.

Commit your test and then run it.
When I run my test suite, I see these two errors:

```ruby
An error occurred while loading ./spec/models/tag_spec.rb.
Failure/Error:
  describe Tag, type: :model do
    describe "relationships" do
      it {should have_many(:tagings)}
      it {should have_many(:articles).through(:taggings)}
    end
  end

NameError:
  uninitialized constant Tag
  
  
An error occurred while loading ./spec/models/tagging_spec.rb.
Failure/Error:
  describe Tagging, type: :model do
    describe "relationships" do
      it {should belong_to(:tag)}
      it {should belong_to(:article)}
    end
  end

NameError:
  uninitialized constant Tagging
```

So now lets generate these tables in your terminal:

```bash
$ rails generate migration CreateTags name:string
$ rails generate migration CreateTaggings tag:references article:references
$ rake db:migrate
```

Note, the order is important here. Your second migration you generate relies on the first one to have been created first. Otherwise when you try to create Taggings it will complain about not knowing what a tag is.

We just made a pretty significant DB change so let's commit that progress.

### Expressing Relationships

We won't be rid of those errors though until we persist this change to models. Lets add models for both of the above tables that we just generated:

```ruby
# app/models/tag.rb
class Tag < ApplicationRecord

end

# app/models/tagging.rb
class Tagging < ApplicationRecord
end
```

When I run my test, I have a new error... or errors actually. I have 6 failing assertions right now. Thank goodness they're all about these relationships I just added. 

Now that our model files are generated we need to tell Rails about the relationships between them. For each of the files below, add these lines:

In `app/models/article.rb`:

```ruby
has_many :taggings
```

In `app/models/tag.rb`:

```ruby
has_many :taggings
```

In `app/models/tagging.rb`:

```ruby
belongs_to :tag
belongs_to :article
```

After Rails had been around for awhile, developers were finding this kind of relationship very common. In practical usage, if I had an object named `article` and I wanted to find its Tags, I'd have to run code like this:

```ruby
tags = article.taggings.collect{|tagging| tagging.tag}
```

That's a pain for something that we need commonly.

An article has a list of tags through the relationship of taggings. In Rails we can express this "has many" relationship through an existing "has many" relationship. We will update our article model and tag model to express that relationship.

In `app/models/article.rb`:

```ruby
has_many :taggings
has_many :tags, through: :taggings
```

In `app/models/tag.rb`:

```ruby
has_many :taggings
has_many :articles, through: :taggings
```

Now if we have an object like `article` we can just ask for `article.tags` or, conversely, if we have an object named `tag` we can ask for `tag.articles`.

Run your tests again and you should be all passing. Which means, time to commit!

To see this in action, start the `bin/rails console` and try the following:

```
$ article = Article.first
$ article.tags.create name: "tag1"
$ article.tags.create name: "tag2"
$ article.tags
=> [#<Tag id: 1, name: "tag1", created_at: "2012-11-28 20:17:55", updated_at: "2012-11-28 20:17:55">, #<Tag id: 2, name: "tag2", created_at: "2012-11-28 20:31:49", updated_at: "2012-11-28 20:31:49">]
```
### An Interface for Tagging Articles

The first interface we're interested in is within the article itself. When I write an article, I want to have a text box where I can enter a list of zero or more tags separated by commas. When I save the article, my app should associate my article with the tags with those names, creating them if necessary.

Let's go to the `user_creates_a_new_article_spec`. Add `fill_in "article[tag_list]", with: "ruby, technology"` to the fill_in list already present. Also add an expectation that those tags are listed on the page.

Run your test and what do you get?

```ruby
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: fill_in "article[tag_list]", with: "ruby, technology"

     Capybara::ElementNotFound:
       Unable to find visible field "article[tag_list]" that is not disabled
```

Add the following to our existing form in `app/views/articles/_form.html.erb`:

```erb
<p>
  <%= f.label :tag_list %><br />
  <%= f.text_field :tag_list %>
</p>
```

With that added, run your test again you should see this error:

```
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: <%= f.text_field :tag_list %>

     ActionView::Template::Error:
       undefined method `tag_list' for #<Article:0x007ff89851de50>
       Did you mean?  tag_ids
```

An Article doesn't have an attribute or method named `tag_list`. We made it up in order for the form to display related tags, but we need to add a method to the `article.rb` file. 

Let's hop back over to our `article_spec` really quickly to add a test for this new model method.

```ruby
describe "instance methods" do
    describe "#tag_list" do
      it "turns associated tags into a string" do
        article = Article.create(title: "Tall Tables", body: "They are tough for the short legged")
        article.tags.create(name: "furniture")
        article.tags.create(name: "opinions")

        expect(article.tag_list).to eq("furniture, opinions")
      end
    end
  end
```

You can run just one part of your test suite, so let's just run the model tests with `rspec spec/models`. You should get a similar undefined method error.

Let's build the method like this:

```ruby
def tag_list
  tags.join(", ")
end
```
Run your test... and we still have an error.

```
Failures:

  1) Article instance methods #tag_list turns associated tags into a string
     Failure/Error: expect(article.tag_list).to eq("furniture, opinions")

       expected: "furniture, opinions"
            got: "#<Tag:0x007fbedc11ca18>, #<Tag:0x007fbedfa416e0>"
```

That is not quite right. What happened?

Our array of tags is an array of Tag instances. When we joined the array Ruby called the default `#to_s` method on every one of these Tag instances. The default `#to_s` method for an object produces some really ugly output.

We could fix the `tag_list` method by:

* Converting all our tag objects to an array of tag names
* Joining the array of tag names together

```ruby
def tag_list
  self.tags.collect do |tag|
    tag.name
  end.join(", ")
end
```

Another alternative is to define a new `Tag#to_s` method which overrides the default:

```ruby
class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :articles, through: :taggings

  def to_s
    name
  end
end
```

Now, when we try to join our `tags`, it'll delegate properly to our name attribute. This is because `#join` calls `#to_s` on every element of the array.

You probably have passing tests right now. But we just created a new model method. We're not done here.  Hop over to the `tag_spec` and add a section for instance methods and an assertion the to_s method. Once you have your model tests passing go ahead and commit your changes to your model spec and your models. 

Run your tests again. I got this error:

```ruby
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: expect(page).to have_content("ruby, technology")
       expected to find text "ruby, technology" in "Article New Title! Created! New Title! New Body! Edit Delete Comments (0) Post a Comment Your Name Your Comment << Back to Articles List"
```

It's not showing up on the page. 

### Adding Tags to our Display

According to our work in the console, articles can now have tags, but we haven't done anything to display them in the article pages.

Let's start with `app/views/articles/show.html.erb`. Right below the line that displays the `article.title`, add these lines:

```erb
<p>
  Tags:
  <% @article.tags.each do |tag| %>
    <%= tag.name %>
  <% end %>
</p>
```

When I run my test again, I get an (only slightly) new error.

```ruby
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: expect(page).to have_content("ruby, technology")
       expected to find text "ruby, technology" in "Article New Title! Created! New Title! Tags: New Body! Edit Delete Comments (0) Post a Comment Your Name Your Comment << Back to Articles List"
```

When I look at the string of what IS on the page, I see that header of Tags: but my tags are listed there. Why aren't they saving? Put a `binding.pry` in your articles#create action. I'd probably put it after we call Article.new. 

Let's run our test and poke around. First I want to check out `params` then maybe `params[:tag_list]`. Is my information coming through from the form? Yes. I see "ruby, technology" nested under `:tag_list` in params. Second I want to check the state of my new Article. What is `@article`? Do we have anything under `@article.tags`? Hmm nothing there. Why aren't our tags being saved? Check our strong params `article_params`. Oooo here I only see :title and :body.  Why not :tag_list?

Strong Parameters has done its job, saving us from parameters we don't want. But in this case, we _do_ want that parameter. Fix the `article_params` method:

```ruby
  def article_params
    params.require(:article).permit(:title, :body, :tag_list)
  end
```

Take out your pry, and run your test again, you'll get this new error:

```
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: @article = Article.new(article_params)

     ActiveModel::UnknownAttributeError:
       unknown attribute 'tag_list' for Article.
```

What is this all about?  Let's start by looking at the form data that was posted when we clicked SAVE. Put a pry back in and look at your params. The field that's interesting there is the `"tag_list"=>"technology, ruby"`. Those are the tags as I typed them into the form. The error came up in the `create` method, so let's peek at `app/controllers/articles_controller.rb` in the `create` method. See the first line that calls `Article.new(article_params)`?  This is the line that's causing the error as you could see in the middle of the stack trace.

Since the `create` method passes all the parameters from the form into the `Article.new` method, the tags are sent in as the string `"technology, ruby"`. The `new` method will try to set the new Article's `tag_list` equal to `"technology, ruby"` but that method doesn't exist because there is no attribute named `tag_list`.

There are several ways to solve this problem, but the simplest is to pretend like we have an attribute named `tag_list`.

We can define the `tag_list=` method inside `article.rb` like this: (***do not delete your original tag_list method***)

```ruby
def tag_list=(tags_string)

end
```

Just leave it blank for now and re-run your tests. We're back to the error telling us it's not listed on the page.

### Not So Fast

Did it really work?  It's hard to tell. Let's jump into the console and have a look.

```
$ article = Article.last
$ article.tags
```
I bet the console reported that `article` had `[]` tags -- an empty list. (It also probably said something about an `ActiveRecord::Associations::CollectionProxy` 😉 ) So we didn't generate an error, but we didn't create any tags either.

We need to return to the `Article#tag_list=` method in `article.rb` and do some more work.

The `Article#tag_list=` method accepts a parameter, a string like **"tag1, tag2, tag3"** and we need to associate the article with tags that have those names. The pseudo-code would look like this:

* Split the *tags_string* into an array of strings with leading and trailing whitespace removed (so `"tag1, tag2, tag3"` would become `["tag1","tag2","tag3"]`
* For each of those strings...
  * Ensure each one of these strings are unique
  * Look for a Tag object with that name. If there isn't one, create it.
  * Add the tag object to a list of tags for the article
* Set the article's tags to the list of tags that we have found and/or created.

The first step is something that Ruby does very easily using the `String#split` method. Go into your console and try **"tag1, tag2, tag3".split**. By default it split on the space character, but that's not what we want. You can force split to work on any character by passing it in as a parameter, like this: `"tag1, tag2, tag3".split(",")`.

Look closely at the output and you'll see that the second element is `" tag2"` instead of `"tag2"` -- it has a leading space. We don't want our tag system to end up with different tags because of some extra (non-meaningful) spaces, so we need to get rid of that. The `String#strip` method removes leading or trailing whitespace -- try it with `" my sample ".strip`. You'll see that the space in the center is preserved.

So first we split the string, and then trim each and every element and collect those updated items:

```
$ "programming, Ruby, rails".split(",").collect{|s| s.strip.downcase}
```
The `String#split(",")` will create the array with elements that have the extra spaces as before, then the `Array#collect` will take each element of that array and send it into the following block where the string is named `s` and the `String#strip` and `String#downcase` methods are called on it. The `downcase` method is to make sure that "ruby" and "Ruby" don't end up as different tags. This line should give you back `["programming", "ruby", "rails"]`.

Lastly, we want to make sure that each and every tag in the list is unique. `Array#uniq` allows us to remove duplicate items from an array.

```
$ "programming, Ruby, rails, rails".split(",").collect{|s| s.strip.downcase}.uniq
```
Now, back inside our `tag_list=` method, let's add this line:

```ruby
tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
```

So looking at our pseudo-code, the next step is to go through each of those `tag_names` and find or create a tag with that name. Rails has a built in method to do just that, like this:

```ruby
tag = Tag.find_or_create_by(name: tag_name)
```

And finally we need to collect up these new or found new tags and then assign them to our article.

```ruby
def tag_list=(tags_string)
  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  self.tags = new_or_found_tags
end
```
When I run my test suite again, I have all passing tests. Phew. Let's commit these changes. There was quite a bit in there.

### Testing in the Console

Go back to your console and try these commands:

```
$ reload!
$ article = Article.create title: "A Sample Article for Tagging!", body: "Great article goes here", tag_list: "ruby, technology"
$ article.tags
```
You should get back a list of the two tags. If you'd like to check the other side of the Article-Tagging-Tag relationship, try this:

```
$ tag = article.tags.first
$ tag.articles
```
And you'll see that this Tag is associated with just one Article.


### Adding Tag Links to our Display

We want to be able to link from our article show to a tag show. 

#### First, let's write a test.

We want a new test file for a user seeing a single tag. I'm going to want to click from an article show to a tag show and have it display the tag's name. 

You're going to need to do a some data prep that is slightly more fancy that you've done before. We are trying to set up this many-to-many relationship in our test.  Below are a few different strategies to choose from:

```ruby
      article = Article.create!(title: "New Title", body: "New Body")
      tag = article.tags.create!(name: "Name")
```

```ruby
     article = Article.create!(title: "New Title", body: "New Body")
     tag = Tag.create!(name: "Name")
     article.tags << tag 
```

```ruby
      article = Article.create!(title: "New Title", body: "New Body")
      tag = Tag.create!(name: "Name")
      tagging = Tagging.create!(article_id: article.id, tag_id: tag.id)
```

Once you've put your test together don't forget to commit.  

When I run my tests, my error looks like this:

```ruby
Failures:

  1) user creates a new article they link from the articles index they fill in a title and body creates a new article
     Failure/Error: <%= link_to tag.name, tag_path(tag) %>

     ActionView::Template::Error:
       undefined method `tag_path' for #<#<Class:0x007f9bc61b13b8>:0x007f9bc8d31c40>
       Did you mean?  image_path
```

The `link_to` helper is trying to use `tag_path` from the router, but the router doesn't know anything about our Tag object. We created a model, but we never created a controller or route. There's nothing to link to.

We need to add tags as a resource to our `config/routes.rb`, it should look like this:

```ruby
Rails.Application.routes.draw do

  root to: 'articles#index'
  resources :articles do
    resources :comments
  end
  resources :tags

end
```

Now we get a new error:

```ruby
Failures:

  1) user sees one tag they link from an article show displays a tag's information
     Failure/Error: click_link "Name"

     ActionController::RoutingError:
       uninitialized constant TagsController
```


So let's generate that controller from your terminal:

```bash
$ touch app/controller/tags_controller.rb
```

And create controller:

```ruby
# app/controllers/tags_controller.rb
class TagsController < ApplicationController
end
```

Then 

```ruby
Failures:

  1) user sees one tag they link from an article show displays a tag's information
     Failure/Error: click_link "Name"

     AbstractController::ActionNotFound:
       The action 'show' could not be found for TagsController
```

### Listing Articles by Tag

The links for our tags are showing up, but if you click on them you'll see our old friend "No action responded to show." error.

Open `app/controllers/tags_controller.rb` and define a show action:

```ruby
def show
  @tag = Tag.find(params[:id])
end
```

Then we get a `TagsController#show is missing a template for this request format and variant.` error.

Let's create the show template `app/views/tags/show.html.erb`:

```erb
<h1>Articles Tagged with <%= @tag.name %></h1>

<ul>
  <% @tag.articles.each do |article| %>
    <li><%= link_to article.title, article_path(article) %></li>
  <% end %>
</ul>
```

Re-run your tests and we're all green. Time to commit!

### Listing All Tags

We've built the `show` action, but the reader should also be able to browse the tags available at `http://localhost:3000/tags`. I think you can do this on your own. 

Create a test for a user seeing all tags. Follow the errors to get your test passing.

Look at your `articles_controller.rb` and Article `index.html.erb` if you need some clues along the way.

Now that we can see all of our tags, we also want the capability to delete them.
I think you can do this one on your own too. Create a test for a user deleting a tag. Follow the errors to implement the functionality. Look
at your `articles_controller.rb` and Article `show.html.erb` if you need some clues.

With that, a long Iteration 3 is complete! Wrap up your branch with a commit, push, PR, merge, checkout master, pull, and delete.


## I4: STOP HERE OR IF YOU WANT MORE: A Few Gems

In this iteration we'll learn how to take advantage of the many plugins and libraries available to quickly add features to your application. First we'll work with `paperclip`, a library that manages file attachments and uploading.

### Using the *Gemfile* to Set up a RubyGem

In the past Rails plugins were distributed in zip or tar files that got stored into your application's file structure. One advantage of this method is that the plugin could be easily checked into your source control system along with everything you wrote in the app. The disadvantage is that it made upgrading to newer versions of the plugin, and dealing with the versions at all, complicated.

These days, all Rails plugins are now 'gems.' RubyGems is a package management system for Ruby, similar to how Linux distributions use Apt or RPM. There are central servers that host libraries, and we can install those libraries on our machine with a single command. RubyGems takes care of any dependencies, allows us to pick any options if necessary, and installs the library.

Let's see it in action. Go to your terminal where you have the rails server running, and type `Ctrl-C`. If you have a console session open, type `exit` to exit. Then open up `Gemfile` and look for the lines like this:

```ruby
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'
```

These lines are commented out because they start with the `#` character. By specifying a RubyGem with the `gem` command, we'll tell the Rails application "Make sure this gem is loaded when you start up. If it isn't available, freak out!"  Here's how we'll require the paperclip gem, add this near those commented lines:

```ruby
gem "paperclip"
```
Paperclip is dependent on ImageMagick so you will also need to add that program.

```
$ brew install imagemagick
```

When you're writing a production application, you might specify additional parameters that require a specific version or a custom source for the library. With that config line declared, go back to your terminal and run `rails server` to start the application again. You should get an error like this:

```
$ rails server
Could not find gem 'paperclip (>= 0, runtime)' in any of the gem sources listed in your Gemfile.
Try running `bundle install`.
```

The last line is key -- since our config file is specifying which gems it needs, the `bundle` command can help us install those gems. Go to your terminal and:

```
$ bundle
```

It should then install the paperclip RubyGem with a version like 3.5.2. In some projects I work on, the config file specifies upwards of 18 gems. With that one `bundle` command the app will check that all required gems are installed with the right version, and if not, install them.

Note: You may need to reload your rails server for the paperclip methods to work.

Now we can start using the library in our application!

### Setting up the Database for Paperclip

We want to add images to our articles. To keep it simple, we'll say that a single article could have zero or one images. In later versions of the app maybe we'd add the ability to upload multiple images and appear at different places in the article, but for now the one will show us how to work with paperclip.

First we need to add some fields to the Article model that will hold the information about the uploaded image. Any time we want to make a change to the database we'll need a migration. Go to your terminal and execute this:

```
$ bin/rails generate migration add_paperclip_fields_to_article
```

That will create a file in your `db/migrate/` folder that ends in `_add_paperclip_fields_to_article.rb`. Open that file now.

Remember that the code inside the `change` method is to migrate the database forward, and Rails should automatically figure out how to undo those changes. We'll use the `add_column` and `remove_column` methods to setup the fields paperclip is expecting:

```ruby
class AddPaperclipFieldsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :image_file_name,    :string
    add_column :articles, :image_content_type, :string
    add_column :articles, :image_file_size,    :integer
    add_column :articles, :image_updated_at,   :datetime
  end
end
```

Then go to your terminal and run `rake db:migrate`. The rake command should show you that the migration ran and added columns to the database.

### Adding to the Model

The gem is loaded, the database is ready, but we need to tell our Rails application about the image attachment we want to add. Open `app/models/article.rb` and just below the existing `has_many` lines, add these lines:

```ruby
has_attached_file :image
validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
```

This `has_attached_file` method is part of the paperclip library. With that declaration, paperclip will understand that this model should accept a file attachment and that there are fields to store information about that file which start with `image_` in this model's database table.

As of version 4.0, all attachments are required to include a content\_type validation, a file\_name validation, or to explicitly state that they're not going to have either. Paperclip raises MissingRequiredValidatorError error if you do not do this. So, we add the validates\_attachment\_content_type line so that our model will validate that it is receiving a proper filetype.

We also have to deal with mass assignment! Modify your `app/controllers/articles_controller.rb` and update the `article_params` method to permit an `:image` as:

```ruby
  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :image)
  end
```

### Modifying the Form Template

First we'll add the ability to upload the file when editing the article, then we'll add the image display to the article show template. Open your `app/views/articles/_form.html.erb` view template. We need to make two changes...

In the very first line, we need to specify that this form needs to accept "multipart" data. This is an instruction to the browser about how to submit the form. Change your top line so it looks like this:

```erb
<%= form_for(@article, html: {multipart: true}) do |f| %>
```

Then further down the form, right before the paragraph with the save button, let's add a label and field for the file uploading:

```erb
<p>
  <%= f.label :image, "Attach an Image" %><br />
  <%= f.file_field :image %>
</p>
```

### Trying it Out

If your server isn't running, start it up (`rails server` in your terminal). Then go to `http://localhost:3000/articles/` and click EDIT for your first article. The file field should show up towards the bottom. Click the `Choose a File` and select a small image file (a suitable sample image can be found at http://hungryacademy.com/images/beast.png). Click SAVE and you'll return to the article index. Click the title of the article you just modified. What do you see?  Did the image attach to the article?

When I first did this, I wasn't sure it worked. Here's how I checked:

1. Open a console session (`rails console` from terminal)
2. Find the ID number of the article by looking at the URL. In my case, the url was `http://localhost:3000/articles/1` so the ID number is just `1`
3. In console, enter `article = Article.find(1)`
3. Right away I see that the article has data in the `image_file_name` and other fields, so I think it worked.
4. Enter `article.image` to see even more data about the file

Ok, it's in there, but we need it to actually show up in the article. Open the `app/views/articles/show.html.erb` view template. Before the line that displays the body, let's add this line:

```erb
<p><%= image_tag @article.image.url %></p>
```

Then refresh the article in your browser. Tada!

### Improving the Form

When first working with the edit form I wasn't sure the upload was working because I expected the `file_field` to display the name of the file that I had already uploaded. Go back to the edit screen in your browser for the article you've been working with. See how it just says "Choose File, no file selected" -- nothing tells the user that a file already exists for this article. Let's add that information in now.

So open that `app/views/articles/_form.html.erb` and look at the paragraph where we added the image upload field. We'll add in some new logic that works like this:

* If the article has an image filename
  *Display the image
* Then display the `file_field` button with the label "Attach a New Image"

So, turning that into code...

```erb
<p>
  <% if @article.image.exists? %>
      <%= image_tag @article.image.url %><br/>
  <% end %>
  <%= f.label :image, "Attach a New Image" %><br />
  <%= f.file_field :image %>
</p>
```

Test how that looks both for articles that already have an image and ones that don't.

When you "show" an article that doesn't have an image attached it'll have an ugly broken link. Go into your `app/views/articles/show.html.erb` and add a condition like we did in the form so the image is only displayed if it actually exists.

Now our articles can have an image and all the hard work was handled by paperclip!

### Further Notes about Paperclip

Yes, a model (in our case an article) could have many attachments instead of just one. To accomplish this you'd create a new model, let's call it "Attachment", where each instance of the model can have one file using the same fields we put into Article above as well as an `article_id` field. The Attachment would then `belong_to` an article, and an article would `have_many` attachments.

Paperclip supports automatic image resizing and it's easy. In your model, you'd add an option like this:

```ruby
has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
```

This would automatically create a "medium" size where the largest dimension is 300 pixels and a "thumb" size where the largest dimension is 100 pixels. Then in your view, to display a specific version, you just pass in an extra parameter like this:

```erb
<%= image_tag @article.image.url(:medium) %>
```

If it's so easy, why don't we do it right now?  The catch is that paperclip doesn't do the image manipulation itself, it relies on a package called *imagemagick*. Image processing libraries like this are notoriously difficult to install. If you're on Linux, it might be as simple as `sudo apt-get install imagemagick`. On OS X, if you have Homebrew installed, it'd be `brew install imagemagick`. On windows you need to download and copy some EXEs and DLLs. It can be a hassle, which is why we won't do it during this class.

If you do manage to get imagemagick installed, be advised that the custom sizes will only take affect on those images uploaded *after* the imagemagick installation. In otherwords, when the image is uploaded - Paperclip will use Imagemagick to create the customized sizes specified on the `has_attached_file` line. However, there is a fix for this! Whenever you change your `has_attached_file` styles - whether adding, editing, or deleting - you can easily reprocess all existing images with `rake paperclip:refresh CLASS=Article`. Just replace 'Article' with the model name containing your Paperclip images in your other projects.  For more information, see this helpful post in the [Paperclip documentation](https://github.com/thoughtbot/paperclip/wiki/Thumbnail-Generation).

### A Few Sass Examples

All the details about Sass can be found here: http://sass-lang.com/

We're not focusing on CSS development, so here are a few styles that you can copy & paste and modify to your heart's content.
Place the following styles in a new file and save it as styles.css.scss in `app/assets/stylesheets/`.

```sass
$primary_color: #AAA;

body {
  background-color: $primary_color;
  font: {
    family: Verdana, Helvetica, Arial;
    size: 14px;
  }
}

a {
  color: #0000FF;
  img {
    border: none;
  }
}

.clear {
  clear: both;
  height: 0;
  overflow: hidden;
}

#container {
  width: 75%;
  margin: 0 auto;
  background: #fff;
  padding: 20px 40px;
  border: solid 1px black;
  margin-top: 20px;
}

#content {
  clear: both;
  padding-top: 20px;
}
```

If you refresh the page, it should look slightly different! But we didn't add a reference to this stylesheet in our HTML; how did Rails know how to use it? The answer lies in Rails' default layout.

### Working with Layouts

We've created about a dozen view templates between our different models. Imagine that Rails _didn't_ just figure it out. How would we add this new stylesheet to all of our pages? We _could_ go into each of those templates and add a line like this at the top:

```erb
<%= stylesheet_link_tag 'styles' %>
```

Which would find the Sass file we just wrote. That's a lame job, imagine if we had 100 view templates. What if we want to change the name of the stylesheet later?  Ugh.

Rails and Ruby both emphasize the idea of "D.R.Y." -- Don't Repeat Yourself. In the area of view templates, we can achieve this by creating a *layout*. A layout is a special view template that wraps other views. Rails has given us one already: `app/views/layouts/application.html.erb`.

Check out your `app/views/layouts/application.html.erb`:

```html+erb
<!DOCTYPE html>
<html>
<head>
  <title>Blogger</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<p class="flash">
  <%= flash.notice %>
</p>
<%= yield %>

</body>
</html>
```

Whatever code is in the individual view template gets inserted into the layout where you see the `yield`. Using layouts makes it easy to add site-wide elements like navigation, sidebars, and so forth.

See the `stylesheet_link_tag` line? It mentions 'application.' That means it should load up `app/assets/stylesheets/application.css`... Check out what's in that file:

```
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the top of the
 * compiled file, but it's generally better to create a new file per style scope.
 *
 *= require_self
 *= require_tree .
*/
```

There's that huge comment there that explains it: the `require_tree .` line automatically loads all of the stylesheets in the current directory, and includes them in `application.css`. Fun! This feature is called the `asset pipeline`, and it's pretty new to Rails. It's quite powerful.

Now that you've tried out a plugin library (Paperclip), Iteration 4 is complete!


####Saving to GitHub.


```
$git add .
$git commit -m "added a few gems"
$git push
```


## I5: Authentication

Authentication is an important part of almost any web application and there are several approaches to take. Thankfully some of these have been put together in plugins so we don't have to reinvent the wheel.

There are two popular gems for authentication: One is named [AuthLogic](https://github.com/binarylogic/authlogic/) and I wrote up an iteration using it for the [Merchant](http://tutorials.jumpstartlab.com/projects/merchant.html) tutorial, but I think it is a little complicated for a Rails novice. You have to create several different models, controllers, and views manually. The documentation is kind of confusing, and I don't think my tutorial is that much better. The second is called [Devise](https://github.com/plataformatec/devise), and while it's the gold standard for Rails 3 applications, it is also really complicated.

[Sorcery](https://github.com/NoamB/sorcery) is a lightweight and straightforward authentication service gem. It strikes a good balance of functionality and complexity.

### Installing Sorcery

Sorcery is just a gem like any other useful package of Ruby code, so to use it in our Blogger application we'll need to add the following line to our Gemfile:

```ruby
gem 'sorcery'
```

<div class='note'>
  <p>When specifying and installing a new gem you will need to restart your Rails Server</p>
</div>

Then at your terminal, instruct Bundler to install any newly-required gems:

```
$ bundle
```

Once you've installed the gem via Bundler, you can test that it's available with this command at your terminal:

```
$ rails generate
```


<div class="note">
  <p>If you receive a LoadError like `cannot load such file -- bcrypt`, add this to your Gemfile: `gem 'bcrypt-ruby'`, and then run `bundle` again.</p>
</div>

Somewhere in the middle of the output you should see the following:

```
$ rails generate
...
Sorcery:
  sorcery:install
...
```

If it's there, you're ready to go!

### Running the Generator

This plugin makes it easy to get up and running by providing a generator that creates a model representing our user and the required data migrations to support authentication. Although Sorcery provides options to support nice features like session-based "remember me", automatic password-reset through email, and authentication against external services such as Twitter, we'll just run the default generator to allow simple login with an email and password.

One small bit of customization we will do is to rename the default model created by Sorcery from "User" to "Author", which gives us a more domain-relevant name to work with. Run this from your terminal:

```
$ bin/rails generate sorcery:install --model=Author
```


Take a look at the output and you'll see roughly the following:

```
  create  config/initializers/sorcery.rb
generate  model Author --skip-migration
  invoke  active_record
  create    app/models/author.rb
  invoke    rspec
  create      spec/models/author_spec.rb
  insert  app/models/author.rb
  create  db/migrate/20120210184116_sorcery_core.rb
```

Let's look at the SorceryCore migration that the generator created before we migrate the database. If you wanted your User models to have any additional information (like "department\_name" or "favorite\_color") you could add columns for that, or you could create an additional migration at this point to add those fields.

For this tutorial, you will need to add the username column to the Author model. To do that, open the migration file `*_sorcery_core.rb` file under `db/migrate` and make sure your file looks like this:

```ruby
class SorceryCore < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :username,         :null => false
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false

      t.timestamps
    end

    add_index :authors, :email, unique: true
  end
end
```

So go to your terminal and enter:

```
$ bin/rake db:migrate
```

Let's see what Sorcery created inside of the file `app/models/author.rb`:

```ruby
class Author < ActiveRecord::Base
  authenticates_with_sorcery!
end
```

We can see it added a declaration of some kind indicating our Author class authenticates via the sorcery gem. We'll come back to this later.

### Creating a First Account

First, stop then restart your server to make sure it's picked up the newly generated code.

Though we could certainly drop into the Rails console to create our first user, it will be better to create and test our form-based workflow by creating a user through it.

We don't have any create, read, update, and destroy (CRUD) support for our
Author model. We could define them again manually as we did with Article.
Instead we are going to rely on the Rails code controller scaffold generator.

```
$ bin/rails generate scaffold_controller Author username:string email:string password:password password_confirmation:password
```

Rails has two scaffold generators: **scaffold** and **scaffold_controller**.
The **scaffold** generator generates the model, controller and views. The
**scaffold_controller** will generate the controller and views. We are
generating a **scaffold_controller** instead of **scaffold** because Sorcery
has already defined for us an Author model.

As usual, the command will have printed all generated files.

The generator did a good job generating most of our fields correctly, however,
it did not know that we want our password field and password confirmation field
to use a password text entry. So we need to update the `authors/_form.html.erb`:

```html+erb
<div class="field">
  <%= f.label :password %><br />
  <%= f.password_field :password %>
</div>
<div class="field">
  <%= f.label :password_confirmation %><br />
  <%= f.password_field :password_confirmation %>
</div>
```

When we created the controller and the views we provided a `password` field and
a `password_confirmation` field. When an author is creating their account we
want to ensure that they do not make a mistake when entering their password, so
we are requiring that they repeat their password. If the two do not match, we
know our record should be invalid, otherwise the user could have mistakenly set
their password to something other than what they expected.

To provide this validation when an author submits the form we need to define this
relationship within the model.

```ruby
class Author < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "should match confirmation", if: :password
end
```

The `password` and `password_confirmation` fields are sometimes referred to as
"virtual attributes" because they are not actually being stored in the
database. Instead, Sorcery uses the given password along with the automatically
generated `salt` value to create and store the `crypted_password` value.

Visiting [http://localhost:3000/authors](http://localhost:3000/authors) at this
moment we will find a routing error. The generator did not add a resource for
our Authors. We need to update our `routes.rb` file:

```ruby
Rails.Application.routes.draw do
  # ... other resources we have defined ...
  resources :authors
end
```

With this in place, we can now go to
[http://localhost:3000/authors/new](http://localhost:3000/authors/new) and we
should see the new user form. Let's enter in "admin@example.com" for email, and "password" for the password and password_confirmation fields, then click "Create Author". We should be taken to
the show page for our new Author user.

Now it's displaying the password and password_confirmation text here, lets delete that! Edit your `app/views/authors/show.html.erb` page to remove those from the display.

If you click _Back_, you'll see that the `app/views/authors/index.html.erb` page also shows the password and password_confirmation. Edit the file to remove these as well.

We can see that we've created a user record in the system, but we can't really tell if we're logged in. Sorcery provides a couple of methods for our views that can help us out: `current_user` and `logged_in?`. The `current_user` method will return the currently logged-in user if one exists and `nil` otherwise, and `logged_in?` returns `true` if a user is logged in and `false` if not.

Let's open `app/views/layouts/application.html.erb` and add a little footer so the whole `<body>` chunk looks like this:

```html+erb
<body>
  <p class="flash">
    <%= flash.notice %>
  </p>
  <div id="container">
    <div id="content">
      <%= yield %>
      <hr>
      <h6>
        <% if logged_in? %>
          <%= "Logged in as #{current_user.email}" %>
        <% else %>
          Logged out
        <% end %>
      </h6>
    </div>
  </div>
</body>
```

The go to `http://localhost:3000/articles/` and you should see "Logged out" on the bottom of the page.

### Logging In

How do we log in to our Blogger app? We can't yet! We need to build the actual endpoints for logging in and out, which means we need controller actions for them. We'll create an AuthorSessions controller and add in the necessary actions: new, create, and destroy.

First, let's generate the AuthorSessions controller:

```
$ bin/rails generate controller AuthorSessions
```

Now we'll add `new`, `create`, and `destroy` methods to `app/controllers/author_sessions_controller.rb`:

```ruby
class AuthorSessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(articles_path, notice: 'Logged in successfully.')
    else
      flash.now.alert = "Login failed."
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to(:authors, notice: 'Logged out!')
  end
end
```

As is common for Rails apps, the `new` action is responsible for rendering the related form, the `create` action accepts the submission of that form, and the `destroy` action removes a record of the appropriate type. In this case, our records are the Author objects that represent a logged-in user.

Let's create the template for the `new` action that contains the login form, in `app/views/author_sessions/new.html.erb`: (you may have to make the directory)

```html+erb
<h1>Login</h1>

<%= form_tag author_sessions_path, method: :post do %>
  <div class="field">
    <%= label_tag :email %>
    <%= text_field_tag :email %>
    <br/>
  </div>
  <div class="field">
    <%= label_tag :password %>
    <%= password_field_tag :password %>
    <br/>
  </div>
  <div class="actions">
    <%= submit_tag "Login" %>
  </div>
<% end %>

<%= link_to 'Back', articles_path %>
```

The `create` action handles the logic for logging in, based on the parameters passed from the rendered form: email and password. If the login is successful, the user is redirected to the articles index, or if the user had been trying to access a restricted page, back to that page. If the login fails, we'll re-render the login form. The `destroy` action calls the `logout` method provided by Sorcery and then redirects.

Next we need some routes so we can access those actions from our browser. Open up `config/routes.rb` and make sure it includes the following:

```ruby
resources :author_sessions, only: [ :new, :create, :destroy ]

get 'login'  => 'author_sessions#new'
get 'logout' => 'author_sessions#destroy'
```

```
$ bin/rake routes
   # ... other routes for Articles and Comments ...
   author_sessions POST   /author_sessions(.:format)     author_sessions#create
new_author_session GET    /author_sessions/new(.:format) author_sessions#new
    author_session DELETE /author_sessions/:id(.:format) author_sessions#destroy
             login        /login(.:format)               author_sessions#new
            logout        /logout(.:format)              author_sessions#destroy

```

Our Author Sessions are similar to other resources in our system. However, we
only want to open a smaller set of actions. An author is able to be presented
with a login page (:new), login (:create), and logout (:destroy). It does not
make sense for it to provide an index, or edit and update session data.

The last two entries create aliases to our author sessions actions.

Externally we want our authors to visit pages that make the most sense to them:

* http://localhost:3000/login
* http://localhost:3000/logout

Internally we also want to use path and url helpers that make the most sense:

* login\_path, login\_url
* logout\_path, logout\_url

Now we can go back to our footer in `app/views/layouts/application.html.erb`
and update it to include some links:

```erb
<body>
  <p class="flash">
    <%= flash.notice %>
  </p>
  <div id="container">
    <div id="content">
      <%= yield %>
      <hr>
      <h6>
        <% if logged_in? %>
          <%= "Logged in as #{current_user.email}" %>
          <%= link_to "(logout)", logout_path %>
        <% else %>
          <%= link_to "(login)", login_path %>
        <% end %>
      </h6>
    </div>
  </div>
</body>
```

Now we should be able to log in and log out, and see our status reflected in the footer. Let's try this a couple of times to confirm we've made it to this point successfully.
(You may need to restart the rails server to successfully log in.)

### Securing New Users

It looks like we can create a new user and log in as that user, but I still want to make some more changes. We're just going to use one layer of security for the app -- a user who is logged in has access to all the commands and pages, while a user who isn't logged in can only post comments and try to login. But that scheme will breakdown if just anyone can go to this URL and create an account, right?

Let's add in a protection scheme like this to the new users form:

* If there are zero users in the system, let anyone access the form
* If there are more than zero users registered, only users already logged in can access this form

That way when the app is first setup we can create an account, then new users can only be created by a logged in user.

We can create a `before_filter` which will run _before_ the `new` and `create` actions of our `authors_controller.rb`. Open that controller and put all this code in:

```ruby
before_filter :zero_authors_or_authenticated, only: [:new, :create]

def zero_authors_or_authenticated
  unless Author.count == 0 || current_user
    redirect_to root_path
    return false
  end
end
```

The first line declares that we want to run a before filter named `zero_authors_or_authenticated` when either the `new` or `create` methods are accessed. Then we define that filter, checking if there are either zero registered users OR if there is a user already logged in. If neither of those is true, we redirect to the root path (our articles list) and return false. If either one of them is true this filter won't do anything, allowing the requested user registration form to be rendered.

With that in place, try accessing `authors/new` when you're logged in and when you're logged out. If you want to test that it works when no users exist, try this at your console:

```
$ Author.destroy_all
```

Then try to reach the registration form and it should work!  Create yourself an account if you've destroyed it.

### Securing the Rest of the Application

The first thing we need to do is sprinkle `before_filters` on most of our controllers:

* In `authors_controller`, add a before filter to protect the actions besides `new` and `create` like this:<br/>`before_filter :require_login, except: [:new, :create]`
* In `author_sessions_controller` all the methods need to be accessible to allow login and logout
* In `tags_controller`, we need to prevent unauthenticated users from deleting the tags, so we protect just `destroy`. Since this is only a single action we can use `:only` like this:<br/>`before_filter :require_login, only: [:destroy]`
* In `comments_controller`, we never implemented `index` and `destroy`, but just in case we do let's allow unauthenticated users to only access `create`:<br/>`before_filter :require_login, except: [:create]`
* In `articles_controller` authentication should be required for `new`, `create`, `edit`, `update` and `destroy`. Figure out how to write the before filter using either `:only` or `:except`

Now our app is pretty secure, but we should hide all those edit, destroy, and new article links from unauthenticated users.

Open `app/views/articles/show.html.erb` and find the section where we output the "Actions". Wrap that whole section in an `if` clause like this:

```erb
<% if logged_in? %>

<% end %>
```

Look at the article listing in your browser when you're logged out and make sure those links disappear. Then use the same technique to hide the "Create a New Article" link. Similarly, hide the 'delete' link for the tags index.

Your basic authentication is done, and Iteration 5 is complete!

### Extra Credit

We now have the concept of authenticated users, represented by our `Author` class, in our blogging application, and it's authors who are allowed to create and edit articles. What could be done to make the ownership of articles more explicit and secure, and how could we restrict articles to being edited only by their original owner?

#### Saving to GitHub.

```
$ git add .
$ git commit -m "Sorcery authentication complete"
$ git push
```

That is the last commit for this project!  If you would like to review your previous commits, you can do so with the git log command in terminal:

```
$ git log
commit 0be8c0f7dc92322dd31f579d9a91ebc8e0fac443
Author: your_name your_email
Date:   Thu Apr 11 17:31:37 2013 -0600
    Sorcery authentication complete
and so on...
```

## I6: Extras

Here are some ideas for extension exercises:

* Add a site-wide sidebar that holds navigation links
* Create date-based navigation links. For instance, there would be a list of links with the names of the months and when you click on the month it shows you all the articles published in that month.
* Track the number of times an article has been viewed. Add a `view_count` column to the article, then in the `show` method of `articles_controller.rb` just increment that counter. Or, better yet, add a method in the `article.rb` model that increments the counter and call that method from the controller.
* Once you are tracking views, create a list of the three "most popular" articles
* Create a simple RSS feed for articles using the `respond_to` method and XML view templates
