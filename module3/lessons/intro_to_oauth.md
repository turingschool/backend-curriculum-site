---
layout: page
title: Getting Started with OAuth
length: 180
tags: rails, security, authentication, OAuth
---

## Historical Context for this lesson plan

We have taught this class many different ways -- hand rolling the handshake and using a gem. While hand rolling the handshake provides the most in-depth learning for the OAuth flow, it is a level of detail that is often not as applicable on the job. However, it's important to understand the OAuth handshake at a high level in order to better troublshoot the gem. This lesson includes a section showing how to hand roll the OAuth process if students are interested. However, performing the handshake manually is not a learning goal for this lesson. The expectation is for students to use a gem on their projects. The big reason for using a gem is it’s much easier to test and most struggle with testing external APIs.

## Learning Goals

* Explain the tradeoffs of using OAuth vs. building authentication from scratch.
* Implement the OAuth handshake using an HTTP library.
* Understand the value of using Omniauth to handle this handshake.
* Understand where to store and how to use a user's access token

## Slides

Available [here](../slides/oauth)

## Prework

Start by watching this [video](https://www.youtube.com/watch?v=tFYrq3d54Dc). Which explains the oauth process at a high level.

OPTIONAL: Watch this [video](https://vimeo.com/173947281) which actually demonstrates the process live with Github.

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

Think about the steps it takes to obtain a [passport](https://travel.state.gov/content/travel/en/passports/need-passport/apply-in-person.html).
You can't just sign a form and be on your way.
You have to fill out a form, provide proof of citizenship, provide a form of identification,
AND provide a photo.

OAuth is very similar in that it also asks you to provide multiple forms of identification.
Simply signing into the app isn't enough.

__Talk through the steps__

You can also visit the GitHub docs [here](https://docs.github.com/en/developers/apps/authorizing-oauth-apps) to see the steps you need to take.

1. User needs to go to the github authentication site and ask for what they want.
We do this by redirecting our user to:
`https://github.com/login/oauth/authorize` and including in the params the
following:
   * `client_id`: given to us when we registered our app on GitHub
   * `redirect_uri`: we used `https://localhost:3000/auth/github/callback` when we
   registered our app
   * `scope`: list of scopes are found [here](https://docs.github.com/en/developers/apps/scopes-for-oauth-apps)
2. User needs to get authorized by signing into Github and confirming they are
who they say they are
3. Once the user is signed in, they need to authorize the application to use the Github data.
4. Github sends a request to our `redirect_uri` we provided, and includes a code
in the params
5. We now take the code and send a POST request to
`https://github.com/login/oauth/access_token` and include the code in the params
6. Github gives us an `access_token` associated with that user and we can use it to get information
from the API about the user.


## Hand Rolling the Handshake: Workshop -- Implementing OAuth with GitHub

This workshop was last tested to work with Rails 5.2.6 and Ruby 2.5.3

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
2. Once logged in, click here to access your [Developer settings](https://github.com/settings/developers), check to see that you're in the `OAuth Apps` section.
3. Click on `New OAuth App`.
4. Fill in `Application name` with any name you want.
5. Fill in `Homepage URL` with: `http://localhost:3000`.
6. Fill in `Application Description` with whatever you like.
7. Fill in `Authorization callback URL` with
`http://localhost:3000/auth/github/callback` **(Make sure you use `http` and not
`https`)**
8. Click on `Register application`
9. The page should refresh and show you your application information. Save this
page so we can reference the `client_id` and `client_secret`.

### Step 2 - Setup the repo for this workshop locally

Set up [this repo](https://github.com/turingschool-examples/oauth_practice).

Once you have the `oauth_practice` repo pulled down, familiarize yourself with the code:
1. open `routes.rb` to see the path that is already created for you.
2. run `rails s`, navigate to `http://localhost:3000`. You should see a message that says "Welcome to your OAuth Practice Repo!!"

### Step 3 - Authenticating user on Github

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
<h1>Welcome to your OAuth Practice Repo!!</h1>

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

We can see that GitHub is giving us the code (Your code should be different).

Let's use this code and send a POST request to Github. Remember that according to [the GitHub docs](https://docs.github.com/en/developers/apps/authorizing-oauth-apps#redirect-urls) we need to also include our `client_id` and the `client_secret`.


Let's also add a `binding.pry` to the end of our method so we can see what we are getting back

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code = params[:code]

  conn = Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})

  response = conn.post('/login/oauth/access_token') do |req|
    req.params['code'] = code
    req.params['client_id'] = client_id
    req.params['client_secret'] = client_secret
  end

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
  # everything we had above, plus the following:

  data = JSON.parse(response.body, symbolize_names: true)
  access_token = data[:access_token]

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
  # everything we had above, plus the following:

  # note we're hitting a different domain, api.github.com
  # so we're going to rebuild 'conn'
  conn = Faraday.new(
    url: 'https://api.github.com',
    headers: {
        'Authorization': "token #{access_token}"
    }
  )
  response = conn.get('/user')
  data = JSON.parse(response.body, symbolize_names: true)

  binding.pry
end
```

Let's take a look at the response we are getting!

```sh
[3] pry(#<SessionsController>)> data
```

You should now see something like this:

```sh
data=> {
  :login=>"iandouglas",
  :id=>168030,
  :node_id=>"MDQ6VXNlcjE2ODAzMA==",
  :avatar_url=>"https://avatars0.githubusercontent.com/u/168030?v=4",
  :gravatar_id=>"",
  :url=>"https://api.github.com/users/iandouglas",
  :html_url=>"https://github.com/iandouglas",
  :followers_url=>"https://api.github.com/users/iandouglas/followers",
  :following_url=>"https://api.github.com/users/iandouglas/following{/other_user}",
  :gists_url=>"https://api.github.com/users/iandouglas/gists{/gist_id}",
  :starred_url=>"https://api.github.com/users/iandouglas/starred{/owner}{/repo}",
  :subscriptions_url=>"https://api.github.com/users/iandouglas/subscriptions",
  :organizations_url=>"https://api.github.com/users/iandouglas/orgs",
  :repos_url=>"https://api.github.com/users/iandouglas/repos",
  :events_url=>"https://api.github.com/users/iandouglas/events{/privacy}",
  :received_events_url=>"https://api.github.com/users/iandouglas/received_events",
  :type=>"User",
  :site_admin=>false,
  :name=>"ian douglas",
  :company=>"iandouglas.com",
  :blog=>"http://iandouglas.com",
  :location=>"Denver, CO",
  :email=>nil,
  :hireable=>nil,
  :bio=>"Sr Instructor @turingschool, open-source advocate, maker/teacher/trainer/learner", :twitter_username=>nil,
  :public_repos=>118,
  :public_gists=>21,
  :followers=>139,
  :following=>5,
  :created_at=>"2009-12-15T18:48:12Z",
  :updated_at=>"2020-08-19T05:51:56Z"
}
[2] pry(#<SessionsController>)>
```

Update the code:

**app/controllers/sessions_controller.rb**

```rb
def create
  client_id = YOUR_CLIENT_ID
  client_secret = YOUR_CLIENT_SECRET
  code = params[:code]

  conn = Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})

  response = conn.post('/login/oauth/access_token') do |req|
    req.params['code'] = code
    req.params['client_id'] = client_id
    req.params['client_secret'] = client_secret
  end

  data = JSON.parse(response.body, symbolize_names: true)
  access_token = data[:access_token]

  # note we're hitting a different domain, api.github.com
  # so we're going to rebuild 'conn'
  conn = Faraday.new(
    url: 'https://api.github.com',
    headers: {
        'Authorization': "token #{access_token}"
    }
  )
  response = conn.get('/user')
  data = JSON.parse(response.body, symbolize_names: true)
end
```

Now we have a hash of the user's data, and we can now create a user in our
database so we can use their information every time they log in. We want to think about
the data that we are always going to need when they login. We are going to want to keep
THREE pieces of data.

1. The `id` that is given to us in the response. This way we have something
unique (from GitHub) we can check against to confirm we are getting the correct user.
2. The `access token` we received. We will need this in order to hit the api
endpoints for the user.
3. The `login` username we get in the response. We can save this as the username in our own database.


### Step 5 - Save user to database

In order to create a user, we need to create a migration.

```sh
$ rails g model User uid username token
$ rake db:migrate
```

##### wait -- what's "uid"

We may want to track our own user ID value from our database PLUS the unique ID value from our OAuth provider. Our ID value in the Rails model will be an integer, but the unique ID we get from our OAuth provider may NOT be an integer. (it's a coincidence that GitHub's ID is also an integer)

##### Next:

Now that we have a `User` model, we want to find or create our user. Let's find the user
by their id that comes through in the auth hash. If we don't find the user in the db,
we can create the user. We can do this with the ActiveRecord method `find_or_create_by`.
Once we find the user, we save their data into the db.

**app/controllers/sessions_controller.rb**

```rb
def create
  # everything we had above, plus the following:

  user          = User.find_or_create_by(uid: data[:id])
  user.username = data[:login]
  user.uid      = data[:id]
  user.token    = access_token
  user.save
  binding.pry
end
```

Let's login again so we can hit our pry. Type in `user`. We saved our first user! Huzzah! Now let's implement a current user in our application controller so
that we have access to this user in our views. First, let's save the user's `id` to a session variable.

**app/controllers/sessions_controller.rb**

```rb
def create
  # everything we had above, plus the following:

  session[:user_id] = user.id
end
```

Great! We have a User, we've stored that user's id in our session, and we're just about ready to show them the next page. Let's redirect our now logged in user to their dashboard.

```rb
def create
  # everything we had above, plus the following:

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
<h1>Welcome, <%= current_user.username %> to your OAuth Practice Repo!!</h1>
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

### STEP 6 (OPTIONAL) - Hitting the API to access user data

Let's add another `binding.pry` in our sessions#create and see how we can use the token to access
the user's repos.

```rb
def create
  # everything we had up until we saved the session

  session[:user_id] = user.id

  # add a binding pry BEFORE our redirect:
  binding.pry

  redirect_to dashboard_path
end
```

Log back in to your app so we can hit the pry. Let's start by sending a GET request to the endpoint `/user/repos`

```
[1] pry(#<SessionsController>)> response = Faraday.get("https://api.github.com/user/repos")
```

If you look at the `response.body`, you can see that we get a message telling us that we require authentication. We need to
send the access_token with our request. So it's a good thing we saved that token to our user. Let's try sending the request again
but this time let's include the `access_token`.

```sh
[2] pry(#<SessionsController>)> response = Faraday.get("https://api.github.com/user/repos", {}, {"Authorization": "token #{user.token}" })
[2] pry(#<SessionsController>)> JSON.parse(response.body, symbolize_names: true)
```

Now you should be able to see an array of hashes of your repo data.


## WORKSHOP - Implement Twitter OAuth with the Twitter gem

Now that you understand how oauth works behind the scenes, implementing oauth with a gem should seem a lot easier.
See if you can implement oauth in a rails app with the going through this [tutorial](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/archive/getting_started_with_oauth.md#user-content-workshop----implementing-oauth-with-twitter).

[Twitter gem](https://github.com/arunagw/omniauth-twitter)

## Resources for Further Study

* [OAuth](http://en.wikipedia.org/wiki/OAuth) on Wikipedia
* [Understanding OAuth](http://lifehacker.com/5918086/understanding-oauth-what-happens-when-you-log-into-a-site-with-google-twitter-or-facebook) on LifeHacker
* [OmniAuth](https://github.com/intridea/omniauth) for integration in Ruby web apps
* [Oauth 1.0 Diagram (from MashApe's oauth bible)](http://puu.sh/2pJ4y)
* [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) -- Oauth provider gem
* OmniAuth core API documentation: https://github.com/intridea/omniauth
* OmniAuth wiki: https://github.com/intridea/omniauth/wiki
* A Devise and OmniAuth powered Single-Sign-On implementation: https://github.com/joshsoftware/sso-devise-omniauth-provider
* [RailsCast on combining Devise and OmniAuth](http://railscasts.com/episodes/235-devise-and-omniauth-revised)
