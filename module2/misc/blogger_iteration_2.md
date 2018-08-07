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

[Continue to Iteration 3](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/misc/blogger_iteration_3.md)
