---
layout: page
title: Sending Email Tutorial
length: 30
tags: rails, email, sendgrid, smtp, action mailer
---

## Sending Email

We'll explore sending email in Rails by building a project that requires this functionality. By the end you should understand:

* How to use ActionMailer
* Send email locally using Mailcatcher
* How to setup a third party email service

### A Bit of Advice

We are going to build an application that allows us to send our friend's a bit of advice via email.

What we'd like our app to do:

1. Allow us to sign up / log in
2. Allow us to enter a friend's email address
3. Send that friend some advice.  

## Researching with the Docs  
* [What is SMTP?](http://whatismyipaddress.com/smtp)
* [Action Mailer](http://guides.rubyonrails.org/action_mailer_basics.html)  

## Sending Email locally with the mailcatcher

### Getting Started

For this tutorial, we are going to setup our emails to "send" through mailcatcher locally. And in production, the emails will actually send through Sendgrid. If you want to setup an account with Sendgrid in order to send emails both locally and in production, you can set up an account with them. Keep in mind that Sendgrid will provision your account at first so it might take some time to get the account set up. You should sign up for the free account.

First things first, go ahead and clone down the repo.

```shell
$ git clone https://github.com/turingschool-examples/a_bit_of_advice.git a_bit_of_advice
$ cd a_bit_of_advice
$ bundle
$ rake db:create
```
### Rails Setup  
Run your server to see what we've already got in our repo
```
rails s
```  
Inspect the Form/Input field, where does this route to?
Make sure the route is in the routes file:

```rb
post '/advice' => 'advice#create'
```

Next we'll make a new controller that will call our mailer. Create a controller called AdviceController. The form asks for a post route so we'll need to update our  create action where we will call our mailer.

```rb

# app/controllers/advice_controller.rb

class AdviceController < ApplicationController

  def create
    @advice = AdviceGenerator.new
    friend_email = email: params[:friends_email]
    email_info = {user: current_user,
                  friend: params[:friends_name],
                  message: @advice.message
                 }
    FriendNotifierMailer.inform(email_info, friend_email).deliver_now
    flash[:notice] = "Thank you for sending a bit of advice."
    redirect_to advice_url
  end
end
```

### Creating the Mailer

Our next step will be to create the Friend mailer to send our friends advice.

```shell
rails g mailer FriendNotifier
```

This creates a lot of files for you. Let's first start out with the FriendNotifier.

```rb
# mailers/friend_notifier_mailer.rb

class FriendNotifierMailer < ApplicationMailer
  def inform(info, friend_email)
    @user = info[:user]
    @message = info[:message]
    @friend = info[:friend]
    mail(to: friend_email, subject: "#{@user} is sending you some advice")
  end
end
```

Next we'll make the views that will determine the body of the email that is sent. Similar to controllers, any instance variables in your mailer method will be available in your mailer view.

When you generated your mailer, two layouts were added to app/views/layouts - mailer.html.erb and mailer.text.erb.  Take a look at these files, what are they doing? Why do we get both an HTML and txt layout?

In app/views/friend_notifier_mailer creates two files, inform.html.erb and inform.text.erb

Depending on the person's email client you're sending the email to, it will render either the plain text or the html view. We don't have control over that, so we'll make them have the same content.

```
# inform.html.erb and inform.text.erb

Hello <%=@friend%>!

<%= @user.first_name %> has sent you some advice: <%= @message %>
```

Let's also change the default address the email gets sent from:

```rb
# app/mailers/application_mailer.rb

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@advice.io"
  layout 'mailer'
end
```

### Configuring Mailcatcher

Take a moment to see what you can figure out from the [MailCatcher](https://mailcatcher.me/) docs.

Mailcatcher allows you to test sending email. It is a simple SMTP server that intercepts (catches) outgoing emails, and it gives you a web interface that allows you to inspect them. Mailcatcher does not allow the emails to actually go out, and so you are able to test that emails send, without having to worry about that email being flooded with emails.

Let's get it set up.

You want to install the Mailcatcher gem, but you do not want to add it to your gemfile in order to prevent conflicts with your applications gems.

```sh
$ gem install mailcatcher
```

Now let's setup our development config to send the emails to the mailcatcher port. Add the following code to your environments/development.rb file.

```rb
# environments/development.rb

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
```

The mail is sent through port 1025, but in order to view the mailcatcher interface we want to visit port 1080. To start up mailcatcher:

```sh
$ mailcatcher
```

Now open up http://localhost:1080 and you should see the interface for where emails are sent. Now let's test to see emails come through.

If you open up the app in a browser locally, and run through the steps to send an email, you should see the email come through on mailcatcher.

## Setting up Sendgrid email through a Heroku addon

Heroku makes it really easy to setup Sendgrid through an add on. In order to do this, you will first need to push your app to heroku.

```sh
$ heroku create
$ git push heroku master
$ heroku run rake db:migrate
```

Now we want to add the Sendgrid add on to our app:

```sh
$ heroku addons:create sendgrid:starter
```

We can confirm that it was setup properly by asking for our username and password, and we should see the details of each.

```sh
$ heroku config:get SENDGRID_USERNAME
appXYZ@heroku.com

$ heroku config:get SENDGRID_PASSWORD
password
```

## Sending the emails in production

In config/environments/production.rb:

```rb
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address:              'smtp.sendgrid.net',
    port:                 '587',
    domain:               'example.com',
    user_name:            ENV["SENDGRID_USERNAME"],
    password:             ENV["SENDGRID_PASSWORD"],
    authentication:       'plain',
    enable_starttls_auto: true
  }
  # Do not swallow errors in after_commit/after_rollback callbacks.
  config.active_record.raise_in_transactional_callbacks = true
```

Let's setup figaro so that we can add our username and password we got above in our command line to our application.yml file.

```rb
# Gemfile

gem 'figaro'
```

```sh
$ bundle
$ bundle exec figaro install
```

This creates an application.yml file and adds it to your .gitignore
For now, let's put our Sendgrid username and password into the newly created application.yml file.

```rb
# config/application.yml

SENDGRID_USERNAME: abcdefghijklmnop
SENDGRID_PASSWORD: 123456789
```

And remember, don't add the application.yml to your commits! We never push up our keys to Github.

Push up your changes to heroku:

```sh
$ git add .
$ git commit -m "email changes"
$ git push heroku master
```

Now that this is all setup, go out to your production app, send an email to yourself and watch it appear in your inbox (Be patient, it takes a couple minutes). Huzzah!

### Materials

* [ Repo ](https://github.com/turingschool-examples/a_bit_of_advice)
* [ Slides ](https://www.dropbox.com/s/ev7tya328sv9jyh/Turing%20-%20Sending%20Email.key?dl=0)
* [Heroku Docs for Sendgrid Addon](https://devcenter.heroku.com/articles/sendgrid#provisioning-the-add-on)
