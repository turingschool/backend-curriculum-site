---
layout: page
title: Cookies and Sessions in Rails
---

# Cookies and Sessions in Rails

Through your exploration into [Cookies, Sessions and Flashes](http://backend.turing.edu/module2/misc/sessions_cookies_and_flashes), you have started to familiarize yourself with the basics of Cookies and Sessions as they pertain to the HTTP request/response cycle.  Now, we are going to dive into more detail around how Rails implements Cookies and Sessions.

## Learning Goals
* practice implementing cookies and sessions in Rails
* Understand where cookie and session information is stored

## Vocab
* Session  
* Cookie

## Warm Up

Let's act out the basics of a rails session as it passes through the HTTP cycle.

Break into small groups.  Each group should be given envelopes and index cards.

In your small group, choose one person who will be the Server, and the other people will be Clients.  As you act out this cycle, your envelopes will represent the Headers being passed around in the HTTP request and response.

Each client will make a request to the server by handing them an envelope with the client's name on it.  When the server receives a request, they will open the envelope and write a message to the client on the index card inside, then pass the envelope back to the client. The client will then open their envelope, read the message and respond by writing their own message and sending it back to the server. Client and Server will continue to pass messages until their index card is full, or time has expired.

The rules of this exchange are simple.  Only the server is able to open envelopes from clients (clients can not open each others envelopes) and only the client to whom the envelope is addressed can open and read messages from the server.  If a client passes an envelope to a server outside of their group, that server can not open the envelope.

In your groups, discuss how this exercise matches up to what you learned in the Cookies Sessions and Flashes Exploration.

## Cookies

As you saw in your exploration, Cookies are always stored on the client and are visible to users. Cookies are limited in size and are susceptible to user interaction (users can see, edit and clear cookies).

Rails gives us a cookies method that acts like a hash that will allow us to set data in our controller and send it to our user as a cookie. Let’s try this out.

Open your lesson-based Rails app and in the show method on the ArtistsController change the show to match the method below:

```ruby
# app/controllers/artists_controller.rb

def show
  @artist = Artist.find(params[:id])
  cookies[:secret] = "It's a secret to everybody"
end
```

Run rails s in a terminal, open your browser, and visit the show page for one of the artists in your database. Use [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg) to view the cookie that you have created (it should have a title of secret).

Now, delete the line cookie[:secret] = "It's a secret to everybody" from your controller. Visit the page again and check to see if the cookie is still there. Click refresh a few times. What changed?

Use EditThisCookie to change the value in the cookie to `“It’s a secret to nobody”` (edit the value that you see and click the green checkbox). Hit refresh a few times and check to see what the value is. Remember: cookies are stored client side and can be edited by users.


## Sessions

As you learned during your exploration, sessions can be stored either on the server or client side.  Rails will default to storing session information on the client side, similar to cookies.  Think about what we know about cookies - what are some advantages and disadvanteges to client-side storage?

One major advantage of client-side session storage is speed.  Rather than having to make database calls to get session information for a particular user, storing that information on the cookie means it is much quicker to access.

But, what about security?  As we saw in our cookie example above, the information sent in a cookie (stored client-side) is visible to the user. This is ok for some data, but much of the information that we use to give HTTP state is sensitive (think usernames and passwords).  So, we don't want to be passing this information in a cookie; we need a better tool.

Rails treats sessions as a special type of cookie.  A rails session is a secure and tamper-proof cookie that contains all of the session information in a key-value format where the key is the session identifier and the value is all of the information needed for that session; the value is often a series of additional key-value pairs.  In this way, a Rails session can look a bit like a nested hash.  The Rails session uses encryption to protect sensitive data and it expires when the browser is closed.

Go back to the show method of your ArtistsController and adjust it to the following:

```ruby
# app/controllers/artists_controller.rb

def show
  @artist = Artist.find(params[:id])
  session[:secret] = "This time for real, though."
end
```

Reload your artist show page again, and use EditThisCookie to see what cookies you have now. What is different about the sesssion? Can you change it?

Update the show method in your ArtistsController one more time:


```ruby
# app/controllers/artists_controller
def show
  binding.pry
  @artist = Artist.find(params[:id])
  session[:secret] = "This time for real, though."
end
```

Visit the artist show page once more and check to see that you hit the Pry in the terminal where your server is running.

From there, check to see what is stored in our session by entering session[:secret] in your Pry session.

Rails translates the encrypted cookie that lives on the client’s machine into something that you can read and use in your controller.

Note that the `flash` that you have been using is a special type of session that Rails automatically expires after one request. Generally we use it in our views to give users feedback about actions they have performed.


### CFU

1. From a user's perspective, what are the differences between a cookie and a Rails session?
2. What are some pros and cons to client-side session storage?
3. What data type do sessions and cookies mimic?
