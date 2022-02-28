---
layout: page
title: Introduction to Background Workers
---

## Learning Goals

- Describe a background worker and when we would want to use one
- Be able to implement a basic background worker with Sidekiq

### Intro

When building websites, it’s important to keep response times down. Long-running requests will tie up server resources, degrade user perception of your site, and make it hard to manage failures.

There’s a solution to this: return a successful response, and then schedule some computation to happen later, outside the original request/response cycle.

We do this with background workers. A background worker allows you to run process on a separate dedicated thread. We can move tasks that don't have to happen in real time to their own process so that the app can move on, rather than causing a backlog of requests which slows everything down.

#### Do you need a job queue?

How do you identify areas of the application that can benefit from a background job? Some common areas for asynchronous work:

* Data Processing - e.g. generating thumbnails or resizing images
* 3rd Party APIs - interacting with a service outside of your site
* Maintenance - expiring old sessions, sweeping caches
* Email - a request that causes an email to be sent

Applications with good Object Oriented design make it easy to send jobs to workers, while poor OO makes it hard to extract jobs since responsibilities tend to overlap.

### App Setup

Let's look at an example of making a background task using Sidekiq. We'll use the `main` branch of the ["Daily Mood" application](https://github.com/turingschool-examples/daily-mood-mailer)

```
git clone git@github.com:turingschool-examples/daily-mood-mailer.git
cd daily-mood-mailer
bundle
rails db:{create, migrate}
rails s
```

This application's homepage has a form that takes an email and a string to generate an email. Start the server rails s and you should be able to view the app at `http://localhost:3000` which has form inputs for an email address and a mood. When you submit that form you should feel the pain of a slow page load.

Why?

Check out our `UserNotifierMailer` mailer. A 5 second delay has been hard-coded in to simulate a real-life delay.

Notice that this process takes a very long time. What we have here is a perfect candidate for a background process:

Operation is slow
User's interaction with the process is already asynchronous (submit the form then go check their email)
Operation is well-encapsulated behind the UserNotifier interface
Operation requires relatively little data as inputs (email address and mood).
Sidekiq and Resque are the 2 most popular queuing libraries for Ruby. For this application, we'll use Sidekiq.

### Dependency -- Redis

Sidekiq uses Redis as a memory store for enqueued jobs. Make sure you have Redis installed and running:

```
brew update && brew install redis
```

Then, run `redis-server`.

This command starts the Redis server on port 6379. Once the Redis server is running it is ready to queue jobs that still need to be done.

You can check if your Redis process is running by executing the command `redis-cli`:

```
$ redis-cli
127.0.0.1:6379>
```

The need for running our Redis server now is similar to how Postgres must be running in order for ActiveRecord to interact with our database.

### Sidekiq Setup

Sidekiq is the tool we will use to manage our background workers.

We can add the sidekiq gem to our Gemfile:

```
gem 'sidekiq', '<= 6.0.2''
```

Note: this gem should live **outside** of the `:development, :test` group.

bundle the app and you should now be able to run a sidekiq process by executing the command:

```
bundle exec sidekiq
```

You should get the fancy Sidekiq ASCII logo in your terminal:

```
s
 ss
sss  sss         ss
s  sss s   ssss sss   ____  _     _      _    _
s     sssss ssss     / ___|(_) __| | ___| | _(_) __ _
s         sss         \___ \| |/ _` |/ _ \ |/ / |/ _` |
s sssss  s             ___) | | (_| |  __/   <| | (_| |
ss    s  s            |____/|_|\__,_|\___|_|\_\_|\__, |
s     s s                                           |_|
 s s
sss
sss
```

Next we need to add a Sidekiq initializer. Add `sidekiq.rb` to your initializers folder:
`config/initializers/sidekiq.rb`

Add this configuration to that new file:
```
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end
```

If your server is running, you must restart it after adding an initializer for it to take effect.

Sidekiq also comes with a handy dashboard UI so we can see what our jobs are doing. We can set this up by adding the following to our routes file:

```
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
end
```

We do not need to do this step for the Daily Mood app, however, if you are running an API only application (like your consultancy backend apps) you must enable some sessions middleware that is excluded in API only apps by default:

In config/application.rb add the following to the application class:
```
config.session_store :cookie_store, key: '_interslice_session'
config.middleware.use ActionDispatch::Cookies
config.middleware.use config.session_store, config.session_options
```

### Creating the Worker

Now we have Sidekiq running with our application, but so far it doesn't do anything for us. Let's create a worker to handle our email.

In the terminal:

`rails generate sidekiq:worker mood_sender`

This will generate your worker class within a directory called `workers`:

```
class MoodSenderWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
  end
end
```

It is Sidekiq convention to use the suffix of `_Worker` for your worker classes.

In newer versions of Sidekiq, you may need to use `rails generate sidekiq:job <job_name>`.

### Defining Worker Operations

Within a Sidekiq job, the instance method `#perform` is what gets called whenever a job appears for our worker to do. Other methods can live within the job class, but `#perform` is what will be invoked when running the worker.

Let's think about what needs to go in here and about what inputs are required for the worker to do its job:

Needs to take in the email address and thought (since these are the parameters needed to send the email)
Needs to send an email using the UserNotifier
Given these constraints, it might look something like:

```
class GifSenderWorker
  include Sidekiq::Worker
  def perform(email, thought)
    UserNotifierMailer.send_randomness_email(email, thought).deliver_now
  end
end
```

### Queueing Jobs -- Sidekiq::Worker.perform_async

The Sidekiq worker defines what actual work will be done whenever our background process is invoked. Now we just need to actually invoke it.

With Sidekiq, we dispatch a job for a worker to do later by calling `.perform_async` on our worker and providing it whatever arguments are needed for the job.

Under the hood, the .perform_async method writes data into Redis indicating the type of job which needs to be done and the data associated with it. The workers (in a separate process) are monitoring the queue so that whenever new jobs appear, they can spring into action and do them!

Also commonly used is `.perform_at` which can be reviewed in the Sidekiq docs. This method allows you to specify the date/time a job should execute.

Let's see what it looks like to actually queue the job. Recall that we were previously sending the email directly from our `MailersController`. Let's replace the line that was sending the email with this line to queue our job instead:


```
MoodSenderWorker.perform_async(params[:mailers][:email], params[:mailers][:mood])
```

Remember -- the arguments passed to the `.perform_async` method here will eventually be handed to your worker's `#perform` method, so make sure they match up.

Let's try this out now - hopefully hat painful delay is no more!

### Sidekiq Dashboard

Sidekiq provides a dashboard for us to monitor our local job queues.

In our routes file, we'll need to mount the Sidekiq dashboard:

```
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
```

Now you can navigate to `http://localhost:3000/sidekiq/`. This dashboard is very useful for testing out jobs and receiving confirmation that everything is queued according to plan.

## Checks for Understanding

- What is a background worker?
- Why would you use a background worker?
- Describe Sidekiq and Redis, and draw a diagram of how they interact with Rails.
