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
class AddPaperclipFieldsToArticle < ActiveRecord::Migration[5.1]
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

[Continue to Iteration 5](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/misc/blogger_iteration_5.md)
