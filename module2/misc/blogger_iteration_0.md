## I0: Up and Running

Part of the reason Ruby on Rails became popular quickly is that it takes a lot of the hard work off your hands, and that's especially true in starting up a project. Rails practices the idea of "sensible defaults" and will, with one command, create a working application ready for your customization.

### Setting the Stage
<!-- First we need to make sure everything is set up and installed. See the [Environment Setup](http://tutorials.jumpstartlab.com/topics/environment/environment.html) page for instructions on setting up and verifying your Ruby and Rails environment. -->

You will need Rails installed and verify that it is version 5.1 and **NOT** 5.2
 - To check your version run `rails -v` in the command line.
 - If you have not installed rails run `gem install rails -v 5.1` in the command line.

Now from the command line, switch to the folder that will store your projects. For instance, `/Users/jcasimir/module2/projects/`. Within that folder, run the following command:

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

We're going to work with a few different tools while testing, [RSpec](https://relishapp.com/rspec), [Capybara](https://github.com/teamcapybara/capybara), [Launchy](https://github.com/copiousfreetime/launchy), [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers), [Pry](https://github.com/pry/pry), and [Active Designer](https://github.com/thompickett/active_designer). RSpec is a test driver comparable to MiniTest. RSpec allows you to run unit, integration and feature tests. Capybara is a DSL(Domain Specific Language) that helps you build tests in a user friendly format, naviating the page and performing user actions. Launchy is a helper class that allows you to add the line `save_and_open_page` within a test. When you run your test suite a browser window will be opened with the current state of the web page where the `save_and_open_page` is located. It is a helpful debugging tool. Shoulda Matchers provides us simple one liners helpful in testing validations and relationships on models. Pry is debugging gem for Ruby environment. Active Designer will give you a visual of the current structure of your database.

#### Adding Gems

In your Gemfile, you should already have a group :development, :test section that looks like this:

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end
```

In this section add `gem rspec-rails` `gem capybara`, `gem launchy`, `gem shoulda-matchers`, `gem pry` and `gem active_designer`. Then run `bundle` from your command line. You should see a long print out of gems being bundled for use in your project. The end result of your bundle should look something like this:

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
  gem 'active_designer'
end
```

#### Further RSpec setup

Notice we still don't have that `spec` directory we talked about earlier. We need to futher install RSpec. From your command line, enter the command `rails g rspec:install`. I'd expect to see the following output:

```bash
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
    with.test_framework :rspec
    with.library :rails
  end
end
```


#### Don't forget to commit as you go
Let's commit these updates with git.

```bash
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

```bash
git checkout -b article-model
```

With `checkout` we create a new branch (`-b` for branch) off of the `master` branch called `article-model` and move directly into it. Let's get our Model on now.


#### Model Tests
Before we dive into the deep and start changing things, let's create a test to help drive our development and keep us focused. Within `spec/models` touch `article_spec.rb`

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

```bash
NameError:
  uninitialized constant Article
 ./spec/models/article_spec.rb:3:in `<top (required)>`
```

We know from working with Ruby and MiniTest that this error is telling us it can't find the class `Article`. In this past this has meant that maybe the files aren't required appropriately or the class just doesn't exist. Now that we'll be working with a database we also have to think about whether this resource exists in the database or not.

We haven't done anything with our database yet other than create an empty one. It definitely doesn't have Articles in there yet. Let's go solve that problem first.

#### Creating a Resource in the Database

We'll use one of Rails' generators to create the required files. Switch to your terminal and enter the following:

```bash
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

```bash
$ rake db:migrate
```

This command starts the `rake` program which is a ruby utility for running maintenance-like functions on your application (working with the DB, executing unit tests, deploying to a server, etc).

We tell `rake` to `db:migrate` which means "look in your set of functions for the database (`db`) and run the `migrate` function."  The `migrate` action finds all migrations in the `db/migrate/` folder, looks at a special table in the DB to determine which migrations have and have not been run yet, then runs any migration that hasn't been run.

In this case we had just one migration to run and it should print some output like this to your terminal:

```bash
$ bin/rake db:migrate
==  CreateArticles: migrating =================================================
-- create_table(:articles)
   -> 0.0012s
==  CreateArticles: migrated (0.0013s) ========================================
```

It tells you that it is running the migration named `CreateArticles`. And the "migrated" line means that it completed without errors. When the migrations are run, data is added to the database to keep track of which migrations have *already* been run. Try running `rake db:migrate` again now, and see what happens.

We've now created the `articles` table in the database and can start working on our `Article` model.

Every time you run a migration, you'll also want to checkout your schema. This can be found under `db/schema.rb`. This file displays the current structure of your database - which tables are in your database and which columns are present on each table. If you're more of a visual person, you may also want to use Active Designer.

Run `active_designer --create db/schema.rb` from the command line. You should see the following output:

```bash
Created active_designer/index.html
```

You'll notice that this has added an `active_designer` directory with an index.html in it. This has been built off your `schema.rb`. When you run the command `open active_designer/index.html` a web page will open up with a visual depiction of the current structure of your database. Cool!

I highly recommend checking both your `schema.rb` and running `active_designer --create db/schema.rb` after each migration you run.

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
 ./spec/models/article_spec.rb:3:in <top (required)>
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

```bash
$ rails console
```

You'll then just get back a prompt of `>>`. You're now inside an `irb` interpreter with full access to your application. Let's try some experiments. Enter each of these commands one at a time and observe the results:

```bash
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

```bash
git add app/models/article.rb
git commit -m "Add article model"
```

Part 2 - Merge:

```bash
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

```bash
git checkout master
git pull origin master
git branch -d article-model
```

### Setting up the Router

We've created a few articles through the console, but we really don't have a web application until we have a web interface. Let's get that started. We said that Rails uses an "MVC" architecture and we've worked with the Model, now we need a Controller and View.

Let's start off with a controller branch:

```bash
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
  describe "they visit /articles" do
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
     expect(page).to have_content(article_2.title)
```

The test should look like this altogether:

```ruby
require "rails_helper"

describe "user sees all articles" do
  describe "they visit /articles" do
    it "displays all articles" do
      article_1 = Article.create!(title: "Title 1", body: "Body 1")
      article_2 = Article.create!(title: "Title 2", body: "Body 2")

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
Rails.application.routes.draw do
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

```bash
      Prefix Verb   URI Pattern                  Controller#Action
    articles GET    /articles(.:format)          articles#index
```

The left most column says `articles`. This is the *prefix* of the path. The router will provide two methods to us using that name, `articles_path` and `articles_url`. The `_path` version uses a relative path while the `_url` version uses the full URL with protocol, server, and path. The `_path` version is always preferred.

The second column, here `GET`, is the HTTP verb for the route. Web browsers typically submit requests with the verbs `GET` or `POST`. In this column, you'll see other HTTP verbs including `PUT` and `DELETE` which browsers don't actually use. We'll talk more about those later.

The third column is similar to a regular expression which is matched against the requested URL. Elements in parentheses are optional. Markers starting with a `:` will be made available to the controller with that name. In our example line, `/articles(.:format)` will match the URLs `/articles/`, `/articles.json`, `/articles` and other similar forms.

The fourth column is where the route maps to in the application. Our example has `articles#index`, so requests will be sent to the `index` method of the `ArticlesController` class.

Now that the router knows how to handle requests about articles, it needs a place to actually send those requests, the *Controller*.

If we re-run `rspec` we get an error telling us likewise. Note your error message will likely be just as large as last time, but we only really need to focus on the failure message printed above the stack trace. My error reads:

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

```bash
$ touch app/controllers/articles_controller.rb
```

Remember, models are singular (e.g., Article), and controllers are plural (e.g.,
articles).

Let's open up the controller file, `app/controllers/articles_controller.rb` and add the code we want:

```ruby
#app/controllers/articles_controller.rb
class ArticlesController < ApplicationController

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

```bash
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

```bash
ArticlesController#index is missing a template for this request format and variant.
```

It's telling us we don't have a view template for this index action method.

### Creating the Template

Now refresh your browser. The error message changed, but you've still got an error just like our new test error, right?

```bash
ActionController::UnknownFormat in ArticlesController#index

ArticlesController#index is missing a template for this request format and variant. request.formats: ["text/html"]...
```

The error message is pretty helpful here. It tells us that the app is looking for a (view) template in `app/views/articles/` but it can't find one named `index.erb`. Rails has *assumed* that our `index` action in the controller should have a corresponding `index.erb` view template in the views folder. We didn't have to put any code in the controller to tell it what view we wanted, Rails just figures it out.

Let's commit our changes.

```bash
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

```bash
git add app/views/articles/
git commit -m "Add articles index template"
```

Let's double check our `/articles` path one more time in the browser to make sure our merge links the controller and the view correctly. Once that's squared away, let's merge `articles-controller` to `master`:

```bash
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

```bash
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

Let's update our assertions in our feature test. Change `expect(page).to have_content(article_1.title)` to `expect(page).to have_link(article_1.title)` and make the same update for the second article.

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

We'll need to write a new test for this since we're building out functionality on a new action/view. Create a new feature test file for the functionality where a user sees one article. Within this test structure, you're going to start with a describe block similar to the name of the file, then give any more specific scenario information, and then say what you expect to find there. Give it a try yourself before looking at my sample below.

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

```
Failures:

  1) user sees one article they link from the article index displays information for one article
     Failure/Error: <h1><%= @article.title %></h1>

     ActionView::Template::Error:
       undefined method `title' for nil:NilClass
```

Here RSpec is telling us it tried to run the method `.title` on @article, but @article is `nil` so it doesn't have access to such a method. How do we make `@article` not be empty/nil?

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

[Continue to Iteration 1](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/misc/blogger_iteration_1.md)
