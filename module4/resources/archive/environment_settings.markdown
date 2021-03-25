---
layout: page
title: Environment Settings
length: 90
tags: rails, heroku, environment, configuration
---

## Learning & Completion Goals

### Environment Variables

* Student can explain the role and usage of a shell profile like `.bash_profile`
* Student can define environment variables in a shell profile
* Student can access environment variables from a running Ruby process
* Student can define environment variables in a Heroku application
* Student can access environment variables on a running Heroku application

### Environments in Rails

* Student can use the environment configuration files to define per-environment settings
* Student can use command-line flags to set the application environment
* Student can explain how the database.yml works with the application environment to allow for per-environment settings

## Session Plan

### Schedule

Recapping what goes into a local dev environment, staging, production.

### Part 1: Shell Profile

What are environment variables? Environment (`ENV` or `env`) variables are name=value pairs set to dynamically describe the environment a machine and or program is going to run in. These values can dictate the way a program will run. Let's look at a common environment variable, `PATH` or `$PATH`. You often see `env` variable mentioned with a `$` because the dollar sign is the SHELL syntax to refer to a variable. `PATH` and `$PATH` are referring to the same variable.

#### Investigating Variables

Let's explore a few commands to help us investigate the environment variables.

You can see the values of your variables by running the command ,`env` in your terminal. The command `printenv` will show you the same output. Another command you can use to investigate the environment is `set`. The `set` command will return to you all env functions and their values too and this can be a little verbose. You can run `set | less` to see the output without all the functions. All three of these commands generally give you the same output.

Spend a minute or two investigating these commands:

* `env`
* `printenv`
* `set`
* `set | less`


These command allow us to see all the environment variables. If you want to investigate a single variable you can use the `echo` command referring to the shell variable (ex: $SHELL). Try this: `echo $SHELL` and or `echo $PATH`. You will also most likely have variables for $TERM and $USER if you want to look at these.

#### Setting and Unsetting Temporary Variables

Now that we know how to investigate current environment variables, we can look at declaring new, or overriding existing variables temporarily. The `HOME` variable is a common env variable we should all have. It declares what is the root of your machine. Mine for example is `/Users/Carmer`. If I navigate to my machines home or root ( `cd` or `cd ~`), I will be taken to `/User/Carmer`. You can temporarily override this, and any variable in the command line.

Setting variables is done with the `export` command. If we want to override the `HOME` variable, we can do that with the command `export HOME=/Path/I/Want/To/NavigateTo`. I'll temporarily change mine to the desktop `/Users/Carmer/Desktop`.

* `export HOME=/Users/$USER/Desktop`

You could change this to any directory you'd like. Keep in mind we are currently setting *TEMPORARY VARIABLES* for the current shell only. That means that a different window in your terminal will not have these values. Also, once you close your terminal or shell session you will lose these variables. You can see this in action:

In one window run:

* `echo $HOME`
* `export HOME=/Users/$USER/Desktop`
* `echo $HOME`

You should see the output of the echo command change to `/Users/Carmer/Desktop`. Now open a new terminal window with `command t` or up in the menu bar with Shell -> New Window.

If you run `echo $HOME` now, you will see the $HOME variable is back to it's original value. You can even flip back to the old window and see the temporary value is still what you changed it too.

Alternatively we can set completely new variables too. Let's play around with this a little.

Use the export command to set some random variables. Then use the commands that we learned to investigate the values that we set:

example: `export RANDOMVARIABLENAME="HellowWOWOWOWVariable"`

To unset or remove a temporary environment variable you can use the `unset` command followed by the Shell variable name you want to unset. `unset $RANDOMVARIABLENAME`.

We can manipulate these variables in Ruby too. In any ruby program we can access the environment variables with `ENV`. `ENV` is an Object in ruby and you can interact with it just like a hash with strings as keys. `ENV["key"] = "Value"`.

Let's play in IRB for a minute. Open an IRB session in your terminal with the command `irb`.

```ruby
irb(main):001:0>
`loop{ sleep 3; puts "The variable HOME is #{ENV['HOME']}" }`
```

In this example we are looking at the environment variable HOME. We can see that this is the same variable that we looked at through our terminal without ruby.

Now let's try an experiment. Open `irb` and run the following:

```ruby
irb(main):001:0> ENV["MARKER"]
=> nil
```

We can see MARKER is currently `nil`. Now go ahead and export a value for the variable `MARKER`. Whatever value you want. Now, go back into an `irb` session and look at what the variable's value is. You can see that this variable now exists. Open irb again and look up the environment variable MARKER. It should have the val.

As we mentioned earlier, these variables are local to the terminal session, so they are temporary. We can see this by opening a second terminal window. If you get into `irb` in this session and query the `MARKER` variable then you will see it is once again nil. When you flip back to the original session it is not


#### Setting Permanent Variables

If you want these environment variables to persist you can declare them in various places. These could include `.bash_profile`, `.bashrc`, `.profile`. Let's look into them.

When I open my `.bash_profile` I see among other things, `export PATH=/my/specific/path`. Anything I declare in these file will be available in any session and will persist until changed either temporarily or permanently.

Go ahead and set a variable in your profile. `export EXAMPLE_VAR="hello1234567"`. Now if you open up a new terminal session and investigate the environment variables you will see $EXAMPLE_VAR in every new terminal session, not just the local session.

#### Pragmatically, Why?

What might we use this for? Let's get into the mindset of a Rails Developer. If I want to run a bunch of commands in a different environment, say `staging` or `production`, we can set a temporary env variable in the current Shell session so we don't have to manually declare the name of the environment every time we run a rails command.

You may want to store sensitive data, api keys, and

### Part 2: Rails

#### Boot Cycle for a Rails App

I think it's important to first dig into how a Rails app boots up. [Here is the Rails Guide](http://guides.rubyonrails.org/initialization.html) for the initialization process. I suggest you read that whole doc, but since time is limited let's investigate a simplified version of how Rails starts to boot up the application when we run `rails s` or `rails c`.

The thing I want to point out, and focus on is that through the chain of firing up the application Rails eventually calls a method `set_environment`. This is done very early on in the boot process and is important. Let's look at the `set_environment` method:

```ruby
def set_environment
  ENV["RAILS_ENV"] ||= options[:environment]
end
```

this doesn't look like much, but when we start to dig into `options` the picture of what's happening begins to come into focus.

```ruby
def options
  @options ||= parse_options(ARGV)
end
```
then we look at `parse_options(ARGV)`

```ruby
def parse_options(args)
  options = default_options

  # Don't evaluate CGI ISINDEX parameters.
  # http://www.meb.uni-bonn.de/docs/cgi/cl.html
  args.clear if ENV.include?("REQUEST_METHOD")

  options.merge! opt_parser.parse!(args)
  options[:config] = ::File.expand_path(options[:config])
  ENV["RACK_ENV"] = options[:environment]
  options
end
```

We can see here that the last two lines set our `ENV["RACK_ENV"]` and return `options`. Also, `options` is initially set to `default_options`. `ENV["RACK_ENV"]` is important, but let's come back to it and look at `default_options` so we know what options really are.

```ruby
def default_options
  environment  = ENV['RACK_ENV'] || 'development'
  default_host = environment == 'development' ? 'localhost' : '0.0.0.0'

  {
    :environment => environment,
    :pid         => nil,
    :Port        => 9292,
    :Host        => default_host,
    :AccessLog   => [],
    :config      => "config.ru"
  }
end
```

So, essentially `default_options` is a hash that we see on the last lines of the method. The most important thing to notice here right now is the default `environment` local variable that is set up on the first line of the method. If there is no setting of `ENV['RACK_ENV']` then the value of `environment` becomes "development". This is why whenever we just fire up `rails s` or `rails c` be are by default in the `development` environment. If we look back at the `parse_options` method above, we notice that we take in the args which is the `ARGV` from running the initial boot command.

What does this mean for us? We can pass an optional argument like `RACK_ENV=production` when we fire up `rails s` (ie: `rails s RACK_ENV=production`) and it will set the `options[:environment]` to be whatever value we pass to `RACK_ENV`.

This is important because in the boot process Rails will execute the initializers and any middlewear corresponding to the defined environment. This includes the file in the `/config/environments` directory that corresponds to the defined environment. We already stated that the default environment is `development` in which case we would execute the `development.rb` file within `/config/environments`. But if we fire up our application with `rails s RACK_ENV=production` we will execute `/config/environments/production.rb`.

With all of this in mind, realizing that this connection to the environment is simply a string that is either set by default or manually when we fire up the app, we can make our own environments.

If we want a staging environment we would need to be setup a file `/config/environments/staging.rb`. We would need to set up some configurations, but since staging needs to be relatively the same as `production`, a good first step would be to paste the production configurations into the staging environment. We would most likely want some configurations to be different such as `config.consider_all_requests_local = true` for example, but I'll let you dig into that more.

These files within `/config/environments` are where we specify the per environment configurations for our Rails applications. If we want a configuration for our `test` environment we would put that in the `/config/environments/test.rb` file etc.

Another place to take notice of environments is with out GEMFILE. We define `groups` for the gems we include and these groups correspond to the specific environment we're running the application in.

Let's do an experiment here to prove this.


Open a rails application. Open up the `/config/environments` directories. Inside of the `development.rb` file set an env variable. Something like `ENV["PROOF"] = ====DEVELOPMENT====` and then open the `production.rb` file and set the same variable to something different, `ENV["PROOF"] = ====PRODUCTION====`. Now open the `environment.rb`  file and print the environment variable.

Now we can see what we've been talking about in action. First, start the server with `rails s`. Remmeber the default setting is for this to be the development environment. You should see the varaible value you set in the `developmnet.rb` file print in the terminal. Now, if you start the server in the production environment you should see the other value for that variable printed in the server.

#### Database.yml

Other than the environment configuration file, it's important to look into the `database.yml` file when we talk about environments.

If you open up a `database.yml` you will see something similar to this:


```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see rails configuration guide
  # http://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: exploration_development

test:
  <<: *default
  database: exploration_test

production:
  <<: *default
  database: exploration_production
  username: exploration
  password: <%= ENV['EXPLORATION_DATABASE_PASSWORD'] %>

```

You should take note that the far left of this file are the keys `development`, `test`, `production` and underneath these are some other key values.


```yaml
development:
  <<: *default
  database: exploration_development
```
What is happening here is that this file is deciding which set of configurations to use based on the environment we're running the application in. In the above example, the `development` environment is set up to use a database called `exploration_development` and the line `<<: #default` is including the default settings in the `development` database configuration. The postgresql databases name that we see in these configurations as `database:` has a naming convention in Rails as the name of the app followed by the name of the environment. The name of this app is `exploration`.

```yaml
production:
  <<: *default
  database: exploration_production
  username: exploration
  password: <%= ENV['EXPLORATION_DATABASE_PASSWORD'] %>
```

The `production` configurations have a little more going on. We see in addition to the default configs we also have the database name configured to be `exploration_production`, and there is also a `username` and `password` configuration.

There are other [database configurations](http://edgeguides.rubyonrails.org/configuring.html#configuring-a-database) you can set to customize your database in Rails.


### Part 3: Heroku

Heroku provides us a server to host our application. A server is a machine much like our laptops that runs an operating system. The server has environment variables just like our machines.

You can access a bash session on a heroku server, just like our terminal sessions. To open this simply run `heroku run bash` on any app you have hosted on heroku.

Once the bash session is open you can then look at the environment variables just like you would on your machine. `env`, `printenv`, `echo $VARIABLE`,.

```
$ heroku run bash
~$ env
# you will see all your env variables here
```

Heroku provides us an easy way to access, set, and unset all our environment variables. The command to do this is `config`.

Running `heroku config` will give you a list of all the environment variables that you have set. Heroku calls these Config Vars. You can add one with the command `heroku config:set key=valueofkey123`. Using the `config:set` command will also overwrite a key that was already there by the same name. And you can remove one with the unset `heroku config:unset key`.

A hypothetical example of something we could use environment variables for in production, besides for API keys, could be this:

  Say we have a homepage with many many dynamic assets (images, products, descriptions, maybe even videos). This works great for clients that have enough bandwidth to handle loading all these assets. However some users may not be able to handle loading all this making for an unpleasant UX. One way we could potentially solve this UX problem would be to store information about the users bandwidth in an environment variable and look at that variable to decide whether or not to load the asset heavy homepage or a different version of the homepage that is static and does not have all the assets to load.

  Our view could, hypothetically look something like this:

```erb
if(ENV["BANDWIDTH_THRESHOLD?"])
  <%= render partial :dynamic_asset_heavy_home %>
else
  <%= render partial :static_low_asset_home %>
end
```
