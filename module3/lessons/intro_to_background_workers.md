---
layout: page
title: Introduction to Background Jobs
---

## Learning Goals

- Describe a background job and when we would want to use one
- Be able to implement a basic background job with Sidekiq

### Intro

When building websites, it’s important to keep response times down. Long-running requests will tie up server resources, degrade user perception of your site, and make it hard to manage failures.

There’s a solution to this: return a successful response, and then schedule some computation to happen later, outside the original request/response cycle.

We do this with background job. A background job allows you to run process on a separate dedicated thread. We can move tasks that don't have to happen in real time to their own process so that the app can move on, rather than causing a backlog of requests which slows everything down.

You may also hear 'background jobs' referred to as 'background workers.' These terms are interchangeable, but 'worker' is more common with older versions of Sidekiq.

#### Do you need a job queue?

How do you identify areas of the application that can benefit from a background job? Some common areas for asynchronous work:

* Data Processing - e.g. generating thumbnails or resizing images
* 3rd Party APIs - interacting with a service outside of your site
* Maintenance - expiring old sessions, sweeping caches
* Email - a request that causes an email to be sent

Applications with good Object Oriented design make it easy to queue background jobs, while poor OO makes it hard to extract jobs since responsibilities tend to overlap.

### App Setup

Let's look at an example of making a background task using Sidekiq. We'll use the `main` branch of the ["Daily Mood" application](https://github.com/turingschool-examples/daily-mood-mailer)

```
git clone git@github.com:turingschool-examples/daily-mood-mailer.git
cd daily-mood-mailer
bundle
rails db:{create,migrate}
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

Sidekiq is the tool we will use to manage our background jobs.

We can add the sidekiq gem to our Gemfile:

```
gem 'sidekiq'
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

We do not need to do this step for the Daily Mood app, however, if you are running an API only application (like your consultancy backend apps) you must enable some sessions middleware that is excluded in API only apps by default:

In config/application.rb add the following to the application class:
```
config.session_store :cookie_store, key: '_interslice_session'
config.middleware.use ActionDispatch::Cookies
config.middleware.use config.session_store, config.session_options
```

### Creating the Job

Now we have Sidekiq running with our application, but so far it doesn't do anything for us. Let's create a job to handle our email.

In the terminal:

`rails generate sidekiq:job mood_sender`

This will generate your job class within a directory called `sidekiq`:

```
class MoodSenderJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
  end
end
```

It is Sidekiq convention to use the suffix of `_Job` for your job classes.

### Defining Sidekiq Job Operations

Within a Sidekiq job, the instance method `#perform` is what gets called whenever a job appears for our job to do. Other methods can live within the job class, but `#perform` is what will be invoked when running the job.

Let's think about what needs to go in here and about what inputs are required for the job:

Needs to take in the email address and thought (since these are the parameters needed to send the email)
Needs to send an email using the UserNotifier
Given these constraints, it might look something like:

```
class MoodSenderJob
  include Sidekiq::Job
  def perform(email, thought)
    UserNotifierMailer.send_mood_email(email, thought).deliver_now
  end
end
```

### Queueing Jobs -- Sidekiq::Job.perform_async

The Sidekiq job defines what actual work will be done whenever our background process is invoked. Now we just need to actually invoke it.

With Sidekiq, we dispatch a job for a job to do later by calling `.perform_async` on our job and providing it whatever arguments are needed for the job.

Under the hood, the .perform_async method writes data into Redis indicating the type of job which needs to be done and the data associated with it. The queues are monitored in a separate process so that whenever new jobs appear, they'll be started!

Also commonly used is `.perform_at` which can be reviewed in the Sidekiq docs. This method allows you to specify the date/time a job should execute.

Let's see what it looks like to actually queue the job. Recall that we were previously sending the email directly from our `MailersController`. Let's replace the line that was sending the email with this line to queue our job instead:


```
MoodSenderJob.perform_async(params[:mailers][:email], params[:mailers][:mood])
```

Remember -- the arguments passed to the `.perform_async` method here will eventually be handed to your job's `#perform` method, so make sure they match up.

Let's try this out now - hopefully hat painful delay is no more!

### Sidekiq Dashboard

Sidekiq provides a dashboard for us to monitor our local job queues.

In our routes file, we'll need to mount the Sidekiq dashboard:

```
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
end
```

Now you can navigate to `http://localhost:3000/sidekiq/`. This dashboard is very useful for testing out jobs and receiving confirmation that everything is queued according to plan.

Note: if you are getting errors when trying to visit the Sidekiq dashboard, try clearing your browser cookies.

## Checks for Understanding

- What is a background job?
- Why would you use a background job?
- Describe Sidekiq and Redis, and draw a diagram of how they interact with Rails.

### Further practice
- Create your own Job class which creates an instance of a model asynchronously.
