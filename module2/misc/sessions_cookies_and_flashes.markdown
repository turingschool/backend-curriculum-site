---
title: Sessions, Cookies, and Flashes
length: 90
tags: rails, http, sessions, cart, dinner dash
---

## Learning Goals

* Understand how cookies are a part of the HTTP request/response cycle
* Understand how cookies and sessions tie together
* Understand how to store state in both cookies and sessions
* Practice the syntax for setting and fetching session data
* Practice setting flash messages based on conditionals

## Exercise

### Background

1. Download [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg).
1. Watch [this](https://youtu.be/64veb6tKTm0) video about sessions and cookies.
1. Watch [this](https://youtu.be/xdH9zsW1CK0) video covering the same topic with a slightly different focus.
1. [This one](https://youtu.be/IPQhME1UYQU) as well.
1. Read [Sections 5.1, 5.2, and 6](http://guides.rubyonrails.org/action_controller_overview.html) of the Action Controller Overview in the Rails docs.
1. Visit a big name site (Wikipedia, Facebook, Amazon, Google, etc.), or another site that you visit frequently and click on EditThisCookie in your nav bar (you should see a cookie logo). Explore the different cookies that are being stored for each site. Many will likely be encrypted or at the very least seem cryptic, but some may have information that is more easily parsed by us mere mortals.

### Practice

#### Cookies

Per section 6 of the docs linked above: Rails gives us a `cookies` method that acts like a hash that will allow us to set data in our controller and send it to our user as a cookie. Let's try this out.

Open SetList and in the `show` method on the `ArtistsController` change the `show` to match the method below:

```ruby
# app/controllers/artists_controller.rb

def show
  @artist = Artist.find(params[:id])
  cookies[:secret] = "It's a secret to everybody"
end
```

Run `rails s` in a terminal, open your browser, and visit the show page for one of the artists in your database. Use EditThisCookie to view the cookie that you have created (it should have a title of `secret`).

Now, delete the line `cookie[:secret] = "It's a secret to everybody"` from your controller. Visit the page again and check to see if the cookie is still there. Click refresh a few times. What changed?

Use EditThisCookie to change the value in the cookie to "It's a secret to nobody" (edit the value that you see and click the green checkbox). Hit refresh a few times and check to see what the value is. Remember: cookies are stored **client side** and can be edited by users.

#### Sessions

The session method that Rails gives us in our controller offers similar behavior for sessions.

Go back to the `show` method of your ArtistsController and adjust it to the following:

```ruby
# app/controllers/artists_controller.rb

def show
  @artist = Artist.find(params[:id])
  session[:secret] = "This time for real, though."
end
```

Reload your artist show page again, and use EditThisCookie to see what cookies you have now. What is different about the sesssion? Can you change it?

Update the `show` method in your ArtistsController one more time:

```ruby
# app/controllers/artists_controller
def show
  binding.pry
  @artist = Artist.find(params[:id])
  session[:secret] = "This time for real, though."
end
```

Visit the artist show page once more and check to see that you hit the Pry in the terminal where your server is running.

From there, check to see what is stored in our session by entering `session[:secret]` in your Pry session.

Rails translates the encrypted cookie that lives on the client's machine into something that you can read and use in your controller.

Note that the `flash` that you have been using is a special type of session that Rails automatically expires after one request. Generally we use it in our views to give users feedback about actions they have performed.

## Questions to Hand-in:

Answer the following questions in the Google Form provided to you.

1. What is a cookie?
1. What's the difference between a cookie and a session?
1. What would it mean to store a user id in a cookie?
1. When would we want to use a session over a cookie?


## If you finish early...

* experiment with [`flash.now`](http://guides.rubyonrails.org/action_controller_overview.html#flash-now)
* read this blog post about [hacking Rails](http://robertheaton.com/2013/07/22/how-to-hack-a-rails-app-using-its-secret-token/) from 2013. Some of the content in this article is out of date but the concepts still apply.

