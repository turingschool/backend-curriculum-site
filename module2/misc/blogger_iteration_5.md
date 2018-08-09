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
class SorceryCore < ActiveRecord::Migration[5.1]
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

We can create a `before_action` which will run _before_ the `new` and `create` actions of our `authors_controller.rb`. Open that controller and put all this code in:

```ruby
before_action :zero_authors_or_authenticated, only: [:new, :create]

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

The first thing we need to do is sprinkle `before_actions` on most of our controllers:

* In `authors_controller`, add a before filter to protect the actions besides `new` and `create` like this:<br/>`before_action :require_login, except: [:new, :create]`
* In `author_sessions_controller` all the methods need to be accessible to allow login and logout
* In `tags_controller`, we need to prevent unauthenticated users from deleting the tags, so we protect just `destroy`. Since this is only a single action we can use `:only` like this:<br/>`before_action :require_login, only: [:destroy]`
* In `comments_controller`, we never implemented `index` and `destroy`, but just in case we do let's allow unauthenticated users to only access `create`:<br/>`before_action :require_login, except: [:create]`
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

[Continue to Iteration 6](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/misc/blogger_iteration_6.md)
