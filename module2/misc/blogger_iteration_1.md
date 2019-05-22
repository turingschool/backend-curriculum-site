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

We accessed the `new` action to load the form, but Rails' interpretation of REST uses a second action named `create` to process the data from that form. Inside your `articles_controller.rb` add this method (again, _inside_ the `ArticlesController` class, but _outside_ the other methods):

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
  @article.body = params[:article][:body]
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
<%= link_to "Delete", article_path(@article) %>
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
<%= link_to "Delete", article_path(@article), method: :delete %>
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
before_action :set_article, only: [:show, :destroy, :edit, :update]
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

[Continue to Iteration 2](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/misc/blogger_iteration_2.md)
