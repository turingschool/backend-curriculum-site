# Ideabox on Cloud9

### Stuff to start with.

You're reading this if you're trying to complete Ideabox using the online IDE provided by Cloud 9. You will perform these instructions in place of I0: Getting Started in the standard tutorial.

## I0: Getting Started

### Environment Setup

When creating a new workspace in Cloud 9, make sure you are picking the blank workspace. Yes, there is a Ruby one, but that also installs rails. Where we're going, we won't need rails.

You will have to install the bundler gem on your own, though and you can do that by typing this into the terminal in the lower half of your browser.

```
gem install bundler
```
### File/Folder Structure

Let's start our project with the minimum and build up from there. We need:

* to create a project folder
* to add a file called `Gemfile` in that project folder
* to add a file called `app.rb` file in that project folder

### `Gemfile`

The `Gemfile` is used to express the dependencies of our application. We need the Sinatra library for our app to work, so we add it to the `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'sinatra', require: 'sinatra/base'
```

And save it.

#### Install the Dependency

Return to your terminal and, from your project directory, run `bundle` in the terminal.. The Bundler gem will read the `Gemfile`, decide if anything needs to be installed from RubyGems, and install it.

This will also generate a `Gemfile.lock` file which contains information about gem versions.

### Beginning `app.rb`

In the `app.rb` we'll start writing the body of our application.

```ruby
require 'bundler'
Bundler.require

class IdeaBoxApp < Sinatra::Base
  get '/' do
    "Hello, World!"
  end

  run! if app_file == $0
end
```

Save the file.


### Starting the server

Normally, this is where we would start the server and get things rolling, but we are working on Cloud9, so we have to jump through some hoops in order to get things working.

Let's talk about what we have in our files so far and what it's doing.

### What Just Happened?

#### Require dependencies

```ruby
require 'bundler'
Bundler.require
```

In the first two lines of `app.rb` we loaded Bundler and told it to require everything specified in the `Gemfile`.

### Create the Application Container

```ruby
class IdeaBoxApp < Sinatra::Base
end
```

Then we create a Ruby class which is going to be our application. It inherits from `Sinatra::Base`, which provides the application with all the Sinatra functionality.

### Define the URL to Match

```ruby
class IdeaBoxApp < Sinatra::Base
  get '/' do
  end
end
```

We call a method named `get`, giving it a parameter `/` and a block of code. The string parameter to `get` is the URL pattern to match against the incoming HTTP request.

Our Sinatra application knows that it is running on [http://localhost:4567](http://localhost:4567), so we only need to define the part of the url that comes after that.

In this case we passed `'/'`, which will match when someone visits the homepage, also known as the _root_ of the application.

### Defining the Response

```ruby
class IdeaBoxApp < Sinatra::Base
  get '/' do
    'Hello, world!'
  end
end
```

The block of code that we pass to the `get` method, the stuff between the `do` and the `end`, is the code that Sinatra is going to run when someone requests the matching page.

The response to the request is a string, in this case `'Hello, World!'`, which is sent to the browser.

#### Run the Application

```ruby
class IdeaBoxApp < Sinatra::Base
  # ...

  run! if app_file == $0
end
```

This functionality will be important later. Basically we only want to call `run!`, which actually starts the application, if this file was run directly like this:

```
$ ruby app.rb
```

In order to get our application working, we have to do some refactoring and use this tool called `rackup`

### Refactoring to use `rackup`

It's not a very good idea to have the app run itself. That line `run! if app_file == $0` isn't great. Let's separate the concerns of *defining* the application from *running* the application.

We want to refactor our code. Refactoring is the process of improving our code here to be more readable and simple, without changing the functionality of our code.

#### Rack, In Brief

There's a standard named Rack that's used by most Ruby web frameworks, including both Sinatra and Rails. It's a small interface that each framework follows.

This allows the community to share tools across frameworks. The Puma web server, for instance, supports Rack applications. So that means it can run either Sinatra or Rails apps without knowing anything more than the fact that they adhere to the Rack interface.

Let's take advantage of Rack to run our application.

#### Creating `config.ru`

Rack applications have a file in their project root named `config.ru`. When a Rack-compatible server is told to load the application, it'll try to run this file. Despite having the extension `.ru`, it's just another Ruby file.

Create an empty file called `config.ru`. Your `idea_box` project directory should now look like this:

```plain
idea_box/
├── Gemfile
├── Gemfile.lock
├── app.rb
└── config.ru
```

`config.ru` is called a _rack up_ file, hence the `ru` file extension. We're going to move the business of actually running the application into that file.

#### Filling In `config.ru`

Open up the file and add the following code to it:

```ruby
require 'bundler'
Bundler.require

run IdeaBoxApp
```

#### Starting the Application

Try starting your application with:

```
$ rackup
```

(Note: rack is installed when Sinatra is installed.)

It will give you the following error:

```
path/to/idea_box/config.ru:4:in `block in <main>': uninitialized constant IdeaBoxApp (NameError)
```

##### Reading the Error Message

Let's pick that error message apart. First, it tells us what the name of the file is where the error occurred:

```plain
path/to/idea_box/config.ru
```

So it's in the `config.ru` file.

Then it tells us which line the error occurred on:

```plain
path/to/idea_box/config.ru:4
```

So it happened on line 4. What's on line 4 of `config.ru`?

```ruby
run IdeaBoxApp
```

OK, so it has something to do with running the application we wrote. But what is it complaining about, really?

```plain
path/to/idea_box/config.ru:4:in `block in <main>': uninitialized constant IdeaBoxApp (NameError)
```

It doesn't know anything about any `IdeaBoxApp`. That's because we haven't told our `config.ru` file where to find it.

#### Adding the Requires

We need to tell the `config.ru` file to load the application we defined. Modify it like this:

```ruby
require 'bundler'
Bundler.require

require './app'

run IdeaBoxApp
```

Note that you don't have to type in the `.rb` extension - It is assuming that we have a `.rb` at the end of our ruby file.

#### Start It Again

Now, we need to start up our server using `rackup`

Type the following into your terminal:

```
rackup -p $PORT -o $IP
```

What this does is that it tells rackup that we want to use a Cloud9 defined IP address and port. If you were to do this using a computer and not Cloud9, you would just type in 

```
rackup -p 4567
```

In order to get your server running on port 4567.

After you've started your server, you can access it by going to, `workspace-username.c9users.io` in a web browser.

For example, if I named my workspace `ideabox` and my username is `mikedao`, the url to my Sinatra app would be `ideabox-mikedao.c9users.io`

Alternatively, you can click up at the top of your browser, `Preview` and then select `Preview Running Application`. That will open up a small browser in the bottom portion of your screen next to your terminal with your application. It should look something like this:

![Ideabox C9](c9_ideabox.png)

#### Remove the `run!` and Requires

We can now delete the redundant `run!` line inside of `app.rb` and we can delete the require in our `app.rb` as well because our `config.ru` has taken care of requiring the dependencies. So we can cut down our `app.rb` to just this:

```ruby
class IdeaBoxApp < Sinatra::Base
  get '/' do
    'Hello, world!'
  end
end
```

You can now return to I1: Recording Ideas. 

When you get to the portion where you start to use shotgun, you just need to start your server with the following instead:

```
shotgun -p $PORT -o $ip
```

