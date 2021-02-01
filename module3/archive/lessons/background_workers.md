---
layout: page
title: Intro to Background Workers
length: 180
tags: Background Workers, sidekiq, queue, async
---

This lesson plan was last updated to work with Rails 5.2.0 and Ruby 2.4.1

[slides](../slides/background_workers)

### Learning Goals

By the end of this lesson, you will know/be able to:

* Explain when you would want to use a background worker
* Be able to implement a basic background process
* What ActiveJob is and how it is similar to ActiveRecord

#### Intro

When building websites, it’s important to keep your response times down. Long-running requests tie up server resources, degrade user perception of your site, and make it hard to manage failures.

There’s a solution to this: return a successful response, and then schedule some computation to happen later, outside the original request/response cycle.

##### Do you need a job queue?

How do you identify areas of the application that can benefit from a background job? Some common areas for asynchronous work:

* Data Processing - e.g. generating thumbnails or resizing images
* 3rd Party APIs - interacting with a service outside of your site
* Maintenance - expiring old sessions, sweeping caches
* Email - a request that causes an email to be sent

Applications with good OO design make it easy to send jobs to workers, poor OO makes it hard to extract jobs since responsibilities tend to overlap.

### 1: App Setup

Let's look at an example of backgrounding a task using Sidekiq.
We'll use the "Working-It" application for the following demo.
Clone and bundle it like so:

```
git clone git@github.com:turingschool-examples/work-it.git
cd work-it
bundle
rake db:{create,migrate}
rails s
```

Workin-it is a simple app that takes an email and a random thought to generate an email with a giphy about your thought. Start the server `rails s` and you should be able to view the app at `http://localhost:3000` which has form inputs for an email address and a thought. When you submit that form you should feel the pain of a slow page load.

Why?

Check out our `UserNotifierMailer` mailer. A 5 second delay has been hard-coded in to simulate a real-life delay.

### 2: Mailcatcher for Local Email Processing

Now test that the application is working by entering an email address
and any thought you may have right now. You should
see an email in the mailcatcher UI with the thought-giphy.

Notice that this process takes a very long time. What we have here is a perfect candidate for a background process:

* Operation is slow
* User's interaction with the process is already asynchronous (submit
  the form _then_ go check their email)
* Operation is well-encapsulated behind the UserNotifier interface
* Operation requires relatively little data as inputs (email address
  and random thought).

Sidekiq and Resque are the 2 most popular queuing libraries for Ruby.
For this application, we'll use Sidekiq.

### 3: Dependency -- Redis

Like Resque, Sidekiq uses Redis as a database to store queued jobs, so first make
sure you have redis installed and running.

Run `redis-server`

If you don't already have redis, install it with homebrew:

```
brew update && brew install redis
```

Then run `redis-server`.

This command starts the redis server on port 6379. Once the redis server is running it is ready to queue jobs that still need to be done.

You can check if your redis process is running by executing the command
`redis-cli`:

```
$ redis-cli
127.0.0.1:6379>
```

The need for running our Redis server now is similar to how Postgres must be running in order for ActiveRecord to interact with our database.

### 4: ActiveJob and Sidekiq Setup

Sidekiq is the adapter we'll be using with Rails' ActiveJob. ActiveJob was introduced in Rails 4.2 as a way of interacting with these background worker adapters more easily.

A worker class inheriting from `ActiveJob::Base` will have access to job enqueing methods, as well as many callbacks. Those can be seen [here](http://edgeguides.rubyonrails.org/active_job_basics.html).

We can add the sidekiq gem to our Gemfile:

```
gem 'sidekiq'
```

bundle the app and you should now be able to run a sidekiq
process by executing the command:

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

We also need to configure ActiveJob to use sidekiq as its adapter:

```ruby
# config/application.rb
class Application < Rails::Application
  #
  config.active_job.queue_adapter = :sidekiq
end
```

### 5: Making a Job

Now we have sidekiq running with our application, but so far it doesn't
do anything for us. Let's create a worker to handle our Workin-it email.

ActiveJob looks for jobs in the `app/jobs` directory. These job files will typically end in `_job` as to avoid namespace collisions.

Rails 4.2 introduced a generator for these jobs:

```ruby
rails generate job gif_sender
```

The above will create `GifSenderJob` saved to the `app/jobs` directory.

```ruby
class GifSenderJob < ActiveJob::Base
end
```

### 6: Defining Job Operations

Within a Sidekiq job, the instance method `#perform` is what gets
called whenever a job appears for our worker to do. Other methods can live within the job class, but `#perform` is what will be invoked when running the worker.

Let's think about what needs to go in here and about what inputs are required for
the worker to do its job:

* Needs to take in the email address and thought (since these
  are the parameters needed to send the email)
* Needs to send an email using the `UserNotifier`

Given these constraints, it might look something like:

```ruby
class GifSenderJob < ActiveJob::Base
  def perform(email, thought)
    UserNotifierMailer.send_randomness_email(email, thought).deliver_now
  end
end
```

If you went the generate route for creating `GifSenderJob`, you may see something that looks like:

```ruby
queue_as :default
```

This helper allows us to designate which workers queue our job should run on (should we have multiple workers).

By default, ActionMailer jobs run on the `mailers` queue. Changing `default` to something like `urgent` would redirect these jobs.


### 7: Queueing Jobs -- Sidekiq::Worker.perform_async

The Sidekiq worker defines what actual work will be done whenever
our background process is invoked. Now we just need to actually
invoke it.

With Sidekiq, we dispatch a job for a worker to do later by
calling ActiveJob's class method `.perform_later` on our worker and
providing it whatever arguments are needed for the job.

Under the hood, the `.perform_later` method writes data into
Redis indicating the type of job which needs to be done
and the data associated with it. The workers (in a separate
process) are monitoring the queue so that whenever new jobs
appear, they can spring into action and do them!

These workers can also perform jobs syncronously if needed. In that case, the method `.perform_now` would be used.

But enough chit-chat, let's see what it looks like to actually
queue the job. Recall that we were previously sending the
email directly from our `MailersController`. Let's replace
the line that was sending the email with this line to
queue our job instead:

```ruby
GifSenderJob.perform_later(params[:mailers][:email], params[:mailers][:thought])
```

Remember -- the arguments passed in to the `.perform_later` method here
will eventually be handed to your worker's `#perform` method, so make
sure they match up.

Let's try this out now - hopefully that painful delay is no more!

### 8: Sidekiq Dashboard

Sidekiq and Resque provide dashboards for us to monitor our local job queues.

They both run using Sinatra, so to enable them, we need to add Sinatra to our Gemfile:

```ruby
gem 'sinatra'
```

Then, in our routes file, we'll need to mount the Sidekiq dashboard:

```ruby
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
```

Now you can navigate to `http://localhost:3000/sidekiq/`. This dashboard is very useful for testing out jobs and recieving confirmation that everything is queued according to plan.

## Checks for Understanding

* What is a background worker? Why would you use a background worker?
* What is Sidekiq?
* What is Redis?
* How do Sidekiq, Redis, and Rails interact? Draw a diagram?

### Video

* [Link to optional video](https://vimeo.com/131505902)

### Repository

* [Work-it Repo](https://github.com/turingschool-examples/work-it/)

### Outside Resources / Further Reading

* [background workers revisited](https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/background_workers_revisited.markdown)
* [workers at scale](https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/workers_at_scale.markdown)
