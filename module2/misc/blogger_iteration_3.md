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
     Failure/Error: expect(page).to have_content("ruby technology")
       expected to find text "ruby technology" in "Article New Title! Created! New Title! New Body! Edit Delete Comments (0) Post a Comment Your Name Your Comment << Back to Articles List"
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
     Failure/Error: expect(page).to have_content("ruby technology")
       expected to find text "ruby technology" in "Article New Title! Created! New Title! Tags: New Body! Edit Delete Comments (0) Post a Comment Your Name Your Comment << Back to Articles List"
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

[Continue to Iteration 4](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/misc/blogger_iteration_4.md)
