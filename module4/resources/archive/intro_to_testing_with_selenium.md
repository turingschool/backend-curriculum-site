# Introduction to Integration Testing using Selenium

## Learning Goals
* Students use integration testing to verify JavaScript functionality
* Students integrate outside data sources in the browser (AJAX, local storage)

## Overview

Want to test your DOM but you have some JavaScript dynamically manipulating the DOM, or some AJAX calls? 

Enter Selenium.

## What is Selenium?

This lesson is designed to be an introduction to using Selenium WebDriver. WebDriver is a tool that will allow you to run tests on features that use JavaScript to make AJAX calls and dynamic content manipulation in the DOM.

Basically - testing with Selenium allows us to test complex user interactions. We are not limited to basic `fill_in` and `click` to follow the request to the next page and see what's there. Selenium allows us model not just traditional user actions, but more complex ones like interacting with dropdowns, changing windows in the browser, dealing with AJAX calls, navigation handling etc.  

The Selenium suite is a full scale testing suite that is composed of 4 basic components - Selenium IDE, Selenium RC, WebDriver, Selenium Grid. We will only focus on WebDriver - "a tool for automating web application testing, and in particular to verify that they work as expected. It aims to provide a friendly API that's easy to explore and understand..." [Here are the WebDriver docs](http://www.seleniumhq.org/docs/03_webdriver.jsp) if you want to read more about WebDriver.

Selenium WebDriver is fairly platform agnostic. You can use it with any of these languages:

* Java
* C#
* PHP
* Python
* Perl
* Ruby

We will be using Selenium WebDriver along with Capybara to fully test our Ruby on Rails applications.

## Getting Started With Selenium

### Selenium Setup

__Setup__

The only machine dependency for using Selenium is to have Firefox 46 installed.

If you don't have this, then go download it [here](https://www.softexia.com/windows/web-browsers/firefox-46). If you do have it, make sure it is on version 46. Selenium does not work with all versions of Firefox, so make sure that you are using Firefox 46 or else IT WILL NOT WORK. If you already have fFrefox and it's on a version more recent than 46, the easiest way to downgrade is to uninstall Firefox then install version 46.

__Important Note__

When in Firefox - make sure it does not automatically update.

- Firefox
  - preferences
  - Advanced
  - Update
  Then uncheck the automatic updates option.

## App Setup

For this section, we'll work through a brief demo using the Blogger example project. In this tutorial, we'll aim to:

* Get selenium set up with our app
* Write integration tests for a new feature using AJAX
* Implement the feature and verify the functionality using Selenium

### 1. Clone / Setup

Get started by cloning and setting up the blogger application:

```
git clone https://github.com/turingschool/blogger_advanced.git selenium-workshop
cd selenium-workshop
git checkout starting-selenium-webdriver-tutorial
bundle
rake db:setup
```

Additionally, go ahead and add the Selenium WebDriver gem to your Gemfile:

```
gem 'selenium-webdriver', '~> 2.53.4'
```

### 2. Using Selenium for a Test

The feature we'd like to add is an AJAX-based comment submission. Currently users can submit comments by submitting the form from an individual Article page so let's first check that out. Launch your server and check out the functionality of submitting a new comment on an individual article page.

Now let's see if we can make this work without a full page reload.

Fortunately, there is already a test written for the content we need -- it's in
`spec/features/article_comments_spec.rb`. However so far this is just using the default
(`Rack::Test`) capybara driver. Let's start by swapping it to use Selenium, by
setting the `js` flag on the test itself:

```ruby
# in spec/features/article_comments_spec.rb
require 'spec_helper'

## Add the :js => true option to the test group:
describe "Article Comments", :type => :feature, :js => true do
  let(:article){ Fabricate(:article) }

  it "posts a comment" do
    visit article_path(article)
    fill_in "comment_author_name", :with => "Cowboy"
    fill_in "comment_body", :with => "Testing is too hard."
    click_link_or_button "post_comment"
    within('#comments') do
      expect(page).to have_content("Cowboy said")
      expect(page).to have_content("Testing is too hard.")
    end
  end
end
```

Once this is in place, run your tests.

* A new Firefox browser window will open automatically and execute your test.
* __If you have issues with your test suit not finding the Article. You may be running into an issue with DB threading. You can solve this by using the feature to create a new article instead of a factory/fabricator__
  * If you do need to refactor to create the article with the feature - try to refactor the test using the features RSpec provides. Something like this:

```ruby
  before(:each) do
    visit new_article_path
    fill_in "article_title", with: "My Article"
    fill_in "article_body", with: "My Article Body"
    click_link_or_button "Save"
    click_link_or_button "My Article"
  end
```

Note that the last step of this is taking you to the specific articles show page, so you will not need the `visit article_path(article)` as the first line in your test.

### 4. Creating Comments using AJAX

Now that we have our test running with Selenium, we have a reasonable foundation
to add in our AJAX feature and remain confident that it will still be testing.

For starters, let's replace our existing `comments.js.coffee` file with a normal JS file.
Probably the easiest way to do this is to just remove one and create the other:

```
rm app/assets/javascripts/comments.js.coffee
touch app/assets/javascripts/comments.js
```

(don't skip this step, or the empty coffeescript file will overwrite your work in
the new JS file)

__New Comment with AJAX__

Now let's change the way we create a new comment for our articles. Let's use AJAX to submit/create the comment.

Take 5 minutes with a pair to try to implement this feature without looking at the code below.

Inside of the `comment.js` file, let's write a function to gather the information from the comment submission form and submit it via a post request.

```js
function postComment() {
      var commentData = {
          comment: {
              author_name: $("#comment_author_name").val(),
              body: $("#comment_body").val(),
              article_id: $("#comment_article_id").val()
           }
       }

       $.ajax({
              url: "/comments",
              method: "POST",
              data: commentData
              })
              .done(function(newCommentMarkup) {
                  $("#comments").append(newCommentMarkup);
                  $("#comment_author_name").val("");
                  $("#comment_body").val("");
              });
   }
```

For this post request we are expecting the return value of the comment post - `newCommentMarkup` in the `comments.js` file above - to be a template of the comment. If you look into the article show page file where all the comments are displayed you'll see the template for the comment:

```erb
<div class='comment'>
  <p>
    <em><%= comment.author_name %></em>
    said <%= distance_of_time_in_words(article.created_at, comment.created_at) %> later:
  </p>
  <p><%= comment.body %></p>
</div>
```

We are going to return the partial of this code from the post request so the AJAX call can just render that partial. You see it the `postComment` function above code as `newCommentMarkup`.

Note - a partial already exists. How can we update the current `articles/show` template to leverage this partial?

So, we'll change the comments controller create action to handle this for us:

```ruby
def create
    article = Article.find(params[:comment][:article_id])
    comment = article.comments.new(comment_params)

    if comment.save
      render partial: 'articles/comment', locals: {comment: comment, article: article}, layout: false
    else
      render :new
    end
end
```

What you may not be familiar with from the code above is the `layout: false`. What this is saying is that the partial will not be rendered in the context of the current layout. If you're interested into reading more about this checkout the [rails docs](http://guides.rubyonrails.org/layouts_and_rendering.html).

Now that you have the return value setup correctly from the create action - the last thing we need to do is prevent the button from submitting the HTTP request and call the function from the JS file so everything will work correctly.

```js

function bindSubmitListenerAndPostComment() {
   $("#new_comment").submit(function(event) {
       event.preventDefault();
       postComment();
   });
}

$(document).ready(function(){
  bindSubmitListenerAndPostComment();
})
```

What we're doing above is binding the `postComment` function to the #new_comment form submit action. With the line `event.preventDefault()` we're stopping the button from submitting the form and allowing the AJAX request to submit the post.

Run the tests again and everything should still pass.

#### Check for Understanding (Reflect or Turn/Talk)
* What's the purpose of using Selenium? 
* What setup is required to use Selenium?

### 5. Independent Practice

As you can see the feature test above is exactly the same as if you did not have JavaScript in place. So, now write tests and implement the following features in JavaScript:

* Write a test and implement the functionality to click a button and hide (not delete) a particular article from the articles index page.
* Write a test and implement the feature in JavaScript to delete an article from the articles index page.
* You can currently filter the articles by tag, but it makes a new request and reloads the page. Can you implement this feature in JavaScript? First write the test and make sure the test passes before you change the feature to JavaScript.

### Outside Resources / Further Reading

* [Intro to Selenium](http://www.guru99.com/introduction-to-selenium.html)
* [Quick into to Selenium WebDriver](http://www.softwaretestinghelp.com/selenium-webdriver-selenium-tutorial-8/)
* [Selenium Wiki - Ruby Bindings](https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings)
* [Using Selenium with Capybara](https://github.com/jnicklas/capybara#selenium)
* [Integration/Feature tests with RSpec, Capybara and Selenium](http://stefan.magnuson.co/articles/rails/robust-integration-testing-in-rails-4-with-rspec-capybara-and-selenium/)
