---
layout: page
title: Getting Started with OAuth
length: 180
tags: rails, security, authentication, OAuth
---

This lesson plan was last tested to work with Rails 5.2.1 and Ruby 2.4.1


## Historical Context for this lesson plan

We used to teach this class using a gem since that’s how most of us do it on the job. We saw a big difference in understanding for students who were able to hand roll the handshake and those that used a gem. The other interesting thing we uncovered was many students struggled troubleshooting the gem if they didn’t understand the process. This lesson is built showing how to hand roll the OAuth process. The expectation students should try to use a gem on their projects. The big reason for using a gem is it’s much easier to test and most struggle with testing external APIs.

## Learning Goals

* Can explain the tradeoffs of using OAuth vs. building authentication from scratch.
* Can implement the OAuth handshake using an HTTP library.
* Understands the value of using Omniauth to handle this handshake.
* Understands where to store and how to use a user's access token

## Slides

Available [here](../slides/oauth)

## Prework

Start by watching this [video](https://www.youtube.com/watch?v=tFYrq3d54Dc). Which explains the oauth process at a high level.

Then watch this [video](https://vimeo.com/173947281) which actually demonstrates the process live with Github.

Then draw a diagram of the OAuth handshaking process that takes place between your app and and an external API (Twitter, Facebook, Github etc)

## Discussion -- All about OAuth

### Benefits of OAuth

There are a lot of potential advantages to outsourcing our Authentication
via Oauth.

__Removing Security Complexities__

Authentication is a tricky problem with a high cost of failure. It can often be tedious
to re-implement on one application after another, but any small mistake
can still have dire consequences.

With OAuth, the user never has to provide sensitive credentials to our application.
Instead, they send these details to the OAuth provider (e.g. Google), who sends
us an authentication token and some basic details on the user's behalf.

Since the provider stores the user's actual credentials, we no longer have to worry about the
security considerations of storing and encrypting user passwords.

__Service Authorization / Authentication__

Another benefit of having users authenticate with OAuth is that it gives us
authenticated access (on their behalf) to any APIs available from the OAuth
provider. API Providers frequently limit your access to their platform, and
having a user authenticate with the provider can get you access to more
resources or to an additional volume of requests.

This can be a big help with API rate limiting, for example, since each authenticated user will usually
be allowed their own supply of requests.

### Disadvantages of OAuth

Like everything in technology, using OAuth isn't without tradeoffs. Often the benefits
outweigh the costs, but let's look at a few things to be aware of.

__Loss of Control__

With OAuth, we're no longer entirely in control of the user's login process. We
might like to collect additional information in the signup process that the
3rd party doesn't provide to us, or design our own onboarding flow, but with OAuth
we'll be locked into whatever our provider makes available.

__Account Requirement__

This one may seem obvious, but if we're using OAuth with twitter, then our users
will be required to have a twitter account in order to use the app. Many services
are so ubiquitous these days that this may not be a large disadvantage, but it is
something to be aware of.

Particularly, we may want to consider our target userbase when determining which
OAuth provider to rely on. If your app is a hip social network for tweens, requiring
users to log in with LinkedIn may not be the best choice.

__Data Duplication__

One challenge OAuth imposes on our application design is deciding how much data
to copy from the external service and where to store it. Do we duplicate the user's
basic profile info into a table in our own DB? Or just read it from the API whenever
we need it? These types of dilemmas are very common when dealing with remote data, and
OAuth data is no exception.

### Real World Example

__Applying for a Passport__

Think about the steps it takes to obtain a [passport](https://travel.state.gov/content/passports/en/passports/applyinperson.html).
You can't just sign a form and be on your way.
You have to fill out a form, provide proof of citizenship, provide a form of identification,
AND provide a photo.

OAuth is very similar in that it also asks you to provide multiple forms of identification.
Simply signing into the app isn't enough.

__Talk through the steps__

You can also visit the Github docs [here](https://developer.github.com/v3/oauth/) to see the steps you need to take.

1. User needs to go to the github authentication site and ask for what they want.
We do this by redirecting our user to:
`https://github.com/login/oauth/authorize` and including in the params the
following:
   * `client_id`: given to us when we registered our app on github
   * `redirect_uri`: we used `https://localhost:3000/auth/github/callback` when we
   registered
   * `scope`: list of scopes are found [here](https://developer.github.com/v3/oauth/#scopes)
2. User needs to get authorized by signing into Github and confirming they are
who they say they are
3. Once the user is signed in, they need to authorize the application to use the Github data.
4. Github sends a request to our `redirect_uri` we provided, and includes a code
in the params
5. We now take the code and send a POST request to
`https://github.com/login/oauth/access_token` and include the code in the params
6. Github gives us an `access_token` associated with that user and we can use it to get information
from the API about the user.

## Workshop -- Implementing OAuth with Github

Let's get some practice with handrolling OAuth by implementing it in a simple
Rails project. While there are gems we can use for OAuth, handrolling will
allow us to understand what is going on behind the scenes.

Note: We are going to be implementing all of the code in the Sessions Controller #create method.
We do this in the tutorial so it is easier to understand what is happening. It is
greatly recommended that you refactor the code out once you have your code working.

### Step 1 - Registering with the Provider

For this exercise, we'll be authenticating with Github. As a first step,
we need to register an application with Github, which will allow us
to obtain the credentials we'll need in order for Github to authenticate
users on our behalf.

To register a new application, follow these steps:

1. Go to [www.github.com](https://www.github.com) and login.
2. Go to your settings.
3. Under `Developer settings`, check to see that you're in the `OAuth Apps` section.
4. Click on `New OAuth App`.
5. Fill in `Application name` with any name you want.
6. Fill in `Homepage URL` with: `http://localhost:3000`.
7. Fill in `Application Description` with whatever you like.
8. Fill in `Authorization callback URL` with
`http://localhost:3000/auth/github/callback` **(Make sure you use `http` and not
`https`)**
9. Click on `Register application`
10. The page should refresh and show you your application information. Save this
page so we can reference the `client_id` and `client_secret`.

### Step 2 - Creating a new Rails app

```ruby
$ rails new oauth_workshop -T -d postgresql --skip-spring --skip-turbolinks
$ cd oauth_workshop
$ bundle
$ bundle exec rake db:create
```

Let's add the gems we will need. We want to use Faraday for sending our HTTP
requests to Github, and we also want to use Pry for debugging.


**Gemfile**

```rb
gem 'faraday'

group :development, :test do
  gem 'pry'
end
```

Bundle!

```sh
$ bundle install
```

### Step 3 - Authenticating user on Github

Our users will start this entire process by visiting our page. The first thing that we need for them is a landing page of some sort that will give them the opportunity to log in with GitHub.

Let's start by creating a route for our users to visit.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  root "home#index"
end
```

Note that assumes that we have a `HomeController` with an `index` action on it. Let's create that now.

```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
  end
end
```

With that controller action in place we now need a view to display. Start by creating the directory structure/file.

```sh
$ mkdir app/views/home
$ touch app/views/home/index.html.erb
```

In your newly created view, let's start off with the following.

```html
<h1>Welcome!</h1>
```

Great! Let's visit that page to see if what we have so far is linking up correctly. Fire up your server with `rails s` and visit `http://localhost:3000`. You should see a page that just says `Welcome!`

Now, the very first step in getting our user authenticated with GitHub is to have them visit GitHub! We can do this by adding a link to GitHub from our homepage.

But how will GitHub know what to do with our user once they get there? We don't want to send them to just the GitHub homepage. We want to send them to a portal that GitHub has created for the specific purpose of authenticating users for other applications. Additionally, when we send them to GitHub we need to tell them who sent our user there in the first place.

It's almost as though we are sending our users over to a friend's house and telling them 'Tell them Jessica sent you,' except in this case we're going to replace `Jessica` with our `client_id`. More information about this handshake process is available in the [GitHub documentation](https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/).

GitHub specifies that the link we use to start this process is `https://github.com/login/oauth/authorize`. We'll provide our `client_id` as a query parameter in the URL. For GitHub specifically, also need to give some additional information about the kind of information we want to have access to. GitHub calls these [scopes](https://developer.github.com/v3/oauth/#scope).

Altogether our link will look something like this:

```
https://github.com/login/oauth/authorize?client_id=YOUR_CLIENT_ID&scope=repo
```

Adding that to our `index.html.erb` gives us the following:

**app/views/home/index.html.erb**

```rb
<h1>Welcome!</h1>

<%= link_to "Login",
"https://github.com/login/oauth/authorize?client_id=YOUR_CLIENT_ID&scope=repo" %>
```

Spin up that server, visit localhost in an incognito window (this prevents us from having to constantly clear our cookies throughout the tutorial), and let's visit click on `Login` (Make sure you are signed out of Github)

You should see that you have been redirected to the Github site, and have been
asked to login. Enter your credentials, and now you should see that Github is
asking you to authorize the application (the application name is whatever you
set it as in your Github settings).

Click on `Authorize application`

You should now see an error `No route matches [GET] "/auth/github/callback"`
If you look at the url, you can see that it
matches the callback url we specified in our app settings on Github. You can
also see that there is a code in the params. We don't have this route in our
app, so let's set that up.

**config/routes.rb**

```rb
Rails.application.routes.draw do
  root "home#index"

  get '/auth/github/callback', to: 'sessions#create'
end
```

Now that we have a route, let's also get our controller and action setup.

```sh
$ touch app/controllers/sessions_controller.rb
```

**app/controllers/sessions_controller.rb**

```rb
class SessionsController < ApplicationController
  def create
  end
end
```

### Step 4 - Get our authentication token

So far we have mostly proved that we are who we said we are
by logging into Github. But Github wants one more check, and to do this we need
to send back the code they gave us when we logged in by sending a POST request
to `https://github.com/oauth/access_token`. Let's take a look at the info we are
getting back in our sessions#create method.

Add a `binding.pry` within our sessions#create method.

**app/controllers/sessions_controller.rb**

```rb
def create
  binding.pry
end
```

Let's try that callback again. Refresh our page with the routing error and we should be stopped by our debugger.

In your pry session, type in `params` and you should see something like this:

```sh
[1] pry(#<SessionsController>)> params
=> <ActionController::Parameters {"code"=>"430c3d0bd82c664b9652", "controller"=>"sessions", "action"=>"create"} permitted: false>
```

We can see that Github is giving us the code (Your code should be different).

Let's use this code and send a POST request to Github. Remember that according to Github [docs](https://developer.github.com/v3/oauth/#2-github-redirects-back-to-your-site) we need to also include our `client_id` and the `client_secret`.


Let's also add a `binding.pry` to the end of our method so we can see what we are getting back

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
   binding.pry
end
```

Let's now run through the logging in process again, and then look at pry to see
what kind of response we are getting back. Again, logout of GitHub and clear
your cookies if you aren't using an incognito window.

Within pry, type in `response` and we should see the whole response.
What we actually want is the response body, so let's type in `response.body` and
we get the access token we need in order to hit the API and get back user data.
Notice that we do need to parse out that token. Let's take a trip to Rubyville.

While we only really want the token, let's go ahead and parse this response to look like the hash it feels like it should be. We'll also go ahead and pull that token out at the end.

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

  pairs = response.body.split("&")
  response_hash = {}
  pairs.each do |pair|
    key, value = pair.split("=")
    response_hash[key] = value
  end

  token = response_hash["access_token"]

  binding.pry
end
```

Now that we have the token, we can use this token to get user data from github
and create a user in our database. If we look at the docs again, we can see that
we can send a GET request to `https://api.github.com/user?access_token` with
`access_token` as a param.

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

  pairs = response.body.split("&")
  response_hash = {}
  pairs.each do |pair|
    key, value = pair.split("=")
    response_hash[key] = value
  end

  token = response_hash["access_token"]

  oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")
  binding.pry
end
```

Let's take a look at the response we are getting. You know the drill: Logout of
Github, login to your app. We should hit the pry. Type in `oauth_response.body`
and we should see a JSON response returned. Let's parse it so that we can get a
hash that we can work with.

```sh
[3] pry(#<SessionsController>)> JSON.parse(oauth_response.body)
```

You should now see something like this:

```sh
[3] pry(#<SessionsController>)> JSON.parse(oauth_response.body)
=> {"login"=>"janedoe",
 "id"=>11111111,
  "avatar_url"=>"https://avatars.githubusercontent.com/u/11111111?v=3",
  "gravatar_id"=>"",
  "url"=>"https://api.github.com/users/janedoe",
  "html_url"=>"https://github.com/janedoe",
  "followers_url"=>"https://api.github.com/users/janedoe/followers",
  "following_url"=>"https://api.github.com/users/janedoe/following{/other_user}",
  "gists_url"=>"https://api.github.com/users/janedoe/gists{/gist_id}",
  "starred_url"=>"https://api.github.com/users/janedoe/starred{/owner}{/repo}",
  "subscriptions_url"=>"https://api.github.com/users/janedoe/subscriptions",
  "organizations_url"=>"https://api.github.com/users/janedoe/orgs",
  "repos_url"=>"https://api.github.com/users/janedoe/repos",
  "events_url"=>"https://api.github.com/users/janedoe/events{/privacy}",
  "received_events_url"=>"https://api.github.com/users/janedoe/received_events",
  "type"=>"User",
  "site_admin"=>false,
  "name"=>"Jane Doe",
  "company"=>nil,
  "blog"=>nil,
  "location"=>nil,
  "email"=>nil,
  "hireable"=>true,
  "bio"=>nil,
  "public_repos"=>54,
  "public_gists"=>5,
  "followers"=>7,
  "following"=>0,
  "created_at"=>"2014-12-31T21:08:13Z",
  "updated_at"=>"2016-10-10T00:09:00Z"}
[4] pry(#<SessionsController>)>
```

Update the code:

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

  pairs = response.body.split("&")
  response_hash = {}
  pairs.each do |pair|
    key, value = pair.split("=")
    response_hash[key] = value
  end

  token = response_hash["access_token"]

  oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

  auth = JSON.parse(oauth_response.body)
end
```

Now we have a hash of the user's data, and we can now create a user in our
database so we can use their information every time they log in. We want to think about
the data that we are always going to need when they login. We are going to want to keep
three pieces of data.
1. The `id` that is given to us in the response. This way we have something
unique we can check against to confirm we are getting the correct user.
2. The `access token` we received. We will need this in order to hit the api
endpoints for the user.
3. The `login` we get in the response. We can save this as the username.


### Step 5 - Save user to database

In order to create a user, we need to create a migration.

```sh
$ rails g model User uid username token
$ rake db:migrate
```

Now that we have a `User` model, we want to find or create our user. Let's find the user
by their id that comes through in the auth hash. If we don't find the user in the db,
we can create the user. We can do this with the ActiveRecord method `find_or_create_by`.
Once we find the user, we save their data into the db.

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

  pairs = response.body.split("&")
  response_hash = {}
  pairs.each do |pair|
    key, value = pair.split("=")
    response_hash[key] = value
  end

  token = response_hash["access_token"]

  oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

  auth = JSON.parse(oauth_response.body)

  user          = User.find_or_create_by(uid: auth["id"])
  user.username = auth["login"]
  user.uid      = auth["id"]
  user.token    = token
  user.save
  binding.pry
end
```

Let's login again so we can hit our pry. Type in `user`. We saved our first user! Huzzah! Now let's implement a current user in our application controller so
that we have access to this user in our views. First, let's save the user's `id` to a session variable.

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

  pairs = response.body.split("&")
  response_hash = {}
  pairs.each do |pair|
    key, value = pair.split("=")
    response_hash[key] = value
  end

  token = response_hash["access_token"]

  oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

  auth = JSON.parse(oauth_response.body)

  user          = User.find_or_create_by(uid: auth["id"])
  user.username = auth["login"]
  user.uid      = auth["id"]
  user.token    = token
  user.save

  session[:user_id] = user.id
end
```

Great! We have a User, we've stored that user's id in our session, and we're just about ready to show them the next page. Let's redirect our now logged in user to their dashboard.

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

  pairs = response.body.split("&")
  response_hash = {}
  pairs.each do |pair|
    key, value = pair.split("=")
    response_hash[key] = value
  end

  token = response_hash["access_token"]

  oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

  auth = JSON.parse(oauth_response.body)

  user          = User.find_or_create_by(uid: auth["id"])
  user.username = auth["login"]
  user.uid      = auth["id"]
  user.token    = token
  user.save

  session[:user_id] = user.id

  redirect_to dashboard_path
end
```

That will give us an error that our dashboard path doesn't exist. Let's add it to our routes file.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  root 'home#index'

  get '/auth/github/callback', to: 'sessions#create'
  get '/dashboard', to: 'dashboard#show'
end
```

New error: we need a DashboardController to handle that. Let's make one of those.

```ruby
# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def show
  end
end
```

New error: missing a template. Let's make one!

**app/views/dashboard/show.html.erb**

```html
<h1>Welcome, <%= current_user.username %></h1>
```

Notice that I'm using `current_user` here. We don't actually have a `current_user` method set up coming from our DashboardController or our ApplicationController. That doesn't bother me. I'm writing this view the way that I *want* it to work, in a way that's familiar to me. I have enough faith in myself as a dev that I can go back and make it work. We'll do that next.

This is something that we might want to have access to at different places in our app. Let's go ahead and create the method in our ApplicationController.

**app/controllers/application_controller.rb**

```rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
```

Let's log back in to our app. We should now see that we have landed on the dashboard page. HOORAY!

### STEP 6 (OPTIONAL) - Hitting the API to access uesr data

For kicks and giggles, let's add another `binding.pry` in our sessions#create and see how we can use the token to access
the users repos.

```rb
def create
  client_id     = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code          = params[:code]
  response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

  pairs = response.body.split("&")
  response_hash = {}
  pairs.each do |pair|
    key, value = pair.split("=")
    response_hash[key] = value
  end

  token = response_hash["access_token"]

  oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

  auth = JSON.parse(oauth_response.body)

  user          = User.find_or_create_by(uid: auth["id"])
  user.username = auth["login"]
  user.uid      = auth["id"]
  user.token    = token
  user.save

  session[:user_id] = user.id

> binding.pry
  redirect_to dashboard_path
end
```

Log back in to your app so we can hit the pry. Let's start by sending a GET request to the endpoint `/user/repos`

```
[1] pry(#<SessionsController>)> response = Faraday.get("https://api.github.com/user/repos")
```

If you look at the `response.body`, you can see that we get a message `Require authentication`. We need to
send the access_token with our request. So it's a good thing we saved that token to our user. Let's try sending the request again
but this time let's include the `access_token`.

```sh
[2] pry(#<SessionsController>)> response = Faraday.get("https://api.github.com/user/repos?access_token=#{user.token}")
[2] pry(#<SessionsController>)> JSON.parse(response.body)
```

Now you should be able to see hash that contains all of your repos.


## WORKSHOP - Implement Twitter oauth with the Twitter gem

Now that you understand how oauth works behind the scenes, implementing oauth with a gem should seem a lot easier.
See if you can implement oauth in a rails app with the going through this [tutorial](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/archive/getting_started_with_oauth.md#user-content-workshop----implementing-oauth-with-twitter).

[Twitter gem](https://github.com/arunagw/omniauth-twitter)

## Resources for Further Study

* [OAuth](http://en.wikipedia.org/wiki/OAuth) on Wikipedia
* [Understanding OAuth](http://lifehacker.com/5918086/understanding-oauth-what-happens-when-you-log-into-a-site-with-google-twitter-or-facebook) on LifeHacker
* [OmniAuth](https://github.com/intridea/omniauth) for integration in Ruby web apps
* [Oauth 1.0 Diagram (from MashApe's oauth bible)](http://puu.sh/2pJ4y)
* [Oauth Bible](http://oauthbible.com/) - lots of in-depth info about different oauth versions and components
* [Edge Cases Podcast #36](http://edgecasesshow.com/036-zenos-paradox-of-authentication.html) - Good in-depth discussion of the evolution of Oauth and the pros and cons of using it.
* [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) -- Oauth provider gem
* OmniAuth core API documentation: https://github.com/intridea/omniauth
* OmniAuth wiki: https://github.com/intridea/omniauth/wiki
* A Devise and OmniAuth powered Single-Sign-On implementation: https://github.com/joshsoftware/sso-devise-omniauth-provider
* [RailsCast on combining Devise and OmniAuth](http://railscasts.com/episodes/235-devise-and-omniauth-revised)
