---
layout: page
title: Sending Email in Rails
length: 60
tags: rails, email, smtp, actionmailer, rspec
---

Updated to work with Ruby 2.5.3 and Rails 5.2.4.3

## Learning Goals

We'll explore sending email in Rails by building a project that requires this functionality. By the end you should understand:

* How to use ActionMailer
* Send email locally using Mailcatcher
* How to test that a mailer is working

---

## Warm Up

* Why are emails important?

---

## Friendly Advice Exercise

We are going to build an application that allows us to send our friend some friendly advice via email.

What we'd like our app to do:

1. Allow us to sign up / log in
2. Allow us to enter a friend's email address
3. Send that friend some advice.  


## Researching with the Docs  
* [What is SMTP?](http://whatismyipaddress.com/smtp)
* [Action Mailer](http://guides.rubyonrails.org/action_mailer_basics.html)  

---

## Sending Email locally with Mailcatcher

### Getting Started

For this tutorial, we are going to setup our emails to "send" through Mailcatcher locally. And in production, you'll want to set up your Rails environment to send all emails through a third-party service like SendGrid.

First things first, go ahead and clone down [this repo](https://github.com/turingschool-examples/friendly-advice)

```shell
$ git clone https://github.com/turingschool-examples/friendly-advice.git friendly-advice
$ cd friendly-advice
$ bundle
$ rake db:{drop,create,migrate,seed}
```
You should have one failure when you run `rspec`.

### Rails Setup  
Run your server and navigate to port 3000 to see what we've already got in our repo
```
rails s
```  
⭐ Register as a new user\
⭐ Click on "Send Advice" in the nav bar (you should be redirected there upon registration), and inspect(CMD + OPT + i) the Form/Input field, where does this route to?

Make sure the route is in the routes file:

```ruby
post '/advice', to: 'advice#create'
```

Let's follow that route to the Advice Controller's create action. Before updating this action, let's keep familiarizing ourselves with the code. Take a look at what's happening: 

⭐ What is `@advice = AdviceGenerator.new`? Explore the AdviceGenerator class. What's going on in there? Take some time to dissect what's happening.\
⭐ Put a `binding.pry` in under `@advice = AdviceGenerator.new` and run your tests. Try some things out-- what methods do you have available to call on `@advice`? What happens when you call `@advice.message`? What happens when you run `@advice.message` again?

Alright, let's get back to updating the create action to call our mailer! 💌

```ruby
class AdviceController < ApplicationController

  def show
   redirect_to root_path unless logged_in?
  end

  def create
    @advice = AdviceGenerator.new
    # `recipient` is the email address that should be receiving the message
    recipient = params[:friends_email]

    # `email_info` is the information that we want to include in the email message.
    email_info = {
      user: current_user,
      friend: params[:friends_name],
      message: @advice.message
    }

    FriendNotifierMailer.inform(email_info, recipient).deliver_now
    flash[:notice] = 'Thank you for sending some friendly advice.'
    redirect_to advice_url
  end
end
```
Run your tests again, and you'll see we now have a different failure. We're dream driving a bit, and have not yet created that mailer. 

### Exploring the Mailer 

⭐ In your text editor, search the application for files containing the word 'mailer'. (CMD + t in atom, CMD + p in VScode)\
⭐ You should see 3 files pop up -- `mailer.html.erb`, `mailer.text.erb`, `application_mailer.rb`. These files come with Rails. Open up the files, and start to speculate what they're used for. Does `mailer.html.erb` remind you of any other files you've interacted with in the past? 

### Creating the Mailer

First, we set up our ApplicationMailer to set an automatic "From" address for every outgoing email. There's no easy way to change this in the default setup of Rails; you can do this with a third-party email service like SendGrid.

The 'layout' option tells Rails where in `/app/views/layouts/` to look for layout files, similar to how `/app/views/layouts/application.html.erb` affects all HTML view pages with a `yield` command. In this case, we're configuring our setup to look for `/app/views/layouts/mailer.html.erb` and `/app/views/layouts/mailer.text.erb` for HTML-based emails and plaintext-based emails, respectively.

⭐ Any thoughts on why there's a html AND a text file for our mailer layouts? 

```rb
# app/mailers/application_mailer.rb

class ApplicationMailer < ActionMailer::Base
  default from: 'friendly@advice.io'
  layout 'mailer'
end
```

Our next step will be to create the FriendNotifer mailer to send our friends advice. We'll use a generator for this, but the generator will ignore the `-T` we used to create the Rails app and generate some scaffolding for tests under a `/test/` folder, which we can delete afterward.

```shell
rails g mailer FriendNotifier
rm -rf test/
```

This creates our `friend_notifer_mailer` inside `app/mailers` and a `friend_notifer_mailer` folder in `app/views`. 

Run your test to see the next failure. Looks like our application is now able to find the FriendNotifierMailer class, but it is still looking for the inform method. 

⭐ If you need to, open up your Advice Controller to help jog your memory on why we need an inform method in our `friend_notifier_mailer`. Where are we calling the method `inform`? On what class are we calling `inform`? What *should* this method do for us?

Let's open the `friend_notifer_mailer` in mailers and add our inform method.

```rb
# mailers/friend_notifier_mailer.rb

class FriendNotifierMailer < ApplicationMailer
  def inform(info, recipient)
    @user = info[:user]
    @message = info[:message]
    @friend = info[:friend]

    mail(
      reply_to: @user.email,
      to: recipient,
      subject: "#{@user.name} is sending you some advice"
    )
  end
end
```
⭐ We have `inform` taking two arguments - `info` and `recipient`. Open your `Advice Controller` to remind yourself what you're passing in.\  
⭐ Hmmmm... `mail`? Where did that come from? It came from our `ActionMailer::Base` that `ApplicationMailer` inherits from. Take some time to look at the [ActionMailer::Base#mail](https://apidock.com/rails/ActionMailer/Base/mail) method. Heck, if you have the time, take a look at some other [ActionMailer::Base methods](https://apidock.com/rails/ActionMailer/Base) that ActionMailer provides for our mailers.

Notice that in our call to [ActionMailer::Base#mail](https://apidock.com/rails/ActionMailer/Base/mail) that we're setting a reply-to email address of our user. This allows the recipient to hit 'reply' on an email and their response will go back to our user, not to our "default" email address of "friendly@advice.io"

Next we'll make the views that will have the body of the email that is sent. Similar to controllers, any instance variables you create in your mailer method will be available in your mailer view. The reason why we passed these values from our `Advice Controller` to our `inform` method was so that we'd be able to render their values in the `friend_notifier_mailer` templates.

In `app/views/friend_notifier_mailer` create two files, `inform.html.erb` and `inform.text.erb`

Depending on the person's email client you're sending the email to, it will render either the plain text or the HTML view. We don't have control over that, so we want to accomodate both and make them have the same content.

```
# inform.html.erb and inform.text.erb

Hello <%=@friend%>!

<%= @user.name %> has sent you some advice: <%= @message %>
```

You can add VERY VERY simple HTML within the `.html.erb` file, but you cannot use the typical CSS layouts nor rely on class/id attributes of CSS. If you really want to style your email, you must look into "inline" styling like this:

```html
<p style="background:yellow;">This background is yellow</p>
```


### Configuring Mailcatcher

⭐Take about 5 minutes to see what you can figure out from the [MailCatcher](https://mailcatcher.me/) docs. 

Mailcatcher allows you to test sending email. It is a simple SMTP server that intercepts (catches) outgoing emails, and it gives you a web interface that allows you to inspect them. Mailcatcher does not allow the emails to actually go out, and so you are able to test that emails send, without having to worry about that email being flooded with emails.

Let's get it set up.

You want to install the Mailcatcher gem, **but you do not want to add it to your gemfile** in order to prevent conflicts with your applications gems.

```sh
$ gem install mailcatcher
```
If you get an error, suggesting an issue with the `thin_parcer` gem, take a look at [this](https://meta.discourse.org/t/mailcatcher-gem-installation-issue-on-macos-catalina-and-its-solution/168606) possible solution. 

Now let's setup our development config to send the emails to the mailcatcher port. Add the following code to your `config/environments/development.rb` file, within the `Rails.application.configure` block of code where you see other `config.` settings.

```rb
# config/environments/development.rb

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
```

The mail is sent through port 1025, but in order to view the Mailcatcher interface we want to visit port 1080. To start up Mailcatcher:

```sh
$ mailcatcher
```

Now open up http://localhost:1080 and you should see the interface for where emails are sent. Now let's test to see emails come through.

If you open up the app in a browser locally, and run through the steps to send an email, you should see the email come through on mailcatcher.

## Testing

I know, I know, TDD all the things, and we didn't do that here. At this point, all of your tests should be passing, but they're not really testing the action and the content of your mailer. Using the tips and guidance below, write one more **robust** test to ensure your mailer is working as expected. 

#### In your test files

```ruby
expect(ActionMailer::Base.deliveries.count).to eq(1)
email = ActionMailer::Base.deliveries.last
```
This will catch an email object of the last thing sent to ActionMailer

Next, we can test that the subject line and Reply-To email address were set correctly
```ruby
expect(email.subject).to eq('Nancy Drew is sending you some advice')

# note: the reply_to address will come through as an array, not a single string
expect(email.reply_to).to eq(['nancydrew@detective.com'])
```

Finally, since we sent a multi-part email message with both plaintext and HTML parts, can test that the content came through correctly:

```ruby
# we can test that the plaintext portion of the email worked as intended
expect(email.text_part.body.to_s).to include('Hello Leroy Brown')
expect(email.text_part.body.to_s).to include('Nancy Drew has sent you some advice:')

# we can test that the HTML portion of the email worked as intended
expect(email.html_part.body.to_s).to include('Hello Leroy Brown')
expect(email.html_part.body.to_s).to include('Nancy Drew has sent you some advice:')
```

#### Should that really be in a controller feature test though?

Let's do this as a mailer spec test, within `spec/mailers/friendnotifier_mailer_spec.rb`

This will feel more like a proper "unit test" of our mailer setup.

```ruby
require 'rails_helper'

RSpec.describe FriendNotifierMailer, type: :mailer do
  describe 'inform' do
    sending_user = User.create(
      first_name: 'Rey',
      last_name: 'Palpatine',
      email: 'rey@dropofgoldensun.com',
      password: 'thebestjedi'
    )

    email_info = {
      user: sending_user,
      friend: 'Kylo Ren',
      message: 'Work through your anger with exercise, and wear a mask'
    }

    let(:mail) { FriendNotifierMailer.inform(email_info, 'kyloren@besties.com') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Rey Palpatine is sending you some advice')
      expect(mail.to).to eq(['kyloren@besties.com'])
      expect(mail.from).to eq(['friendly@advice.io'])
      expect(mail.reply_to).to eq(['rey@dropofgoldensun.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include('Hello Kylo Ren')
      expect(mail.text_part.body.to_s).to include('Rey Palpatine has sent you some advice: Work through your anger with exercise, and wear a mask')

      expect(mail.html_part.body.to_s).to include('Hello Kylo Ren')
      expect(mail.html_part.body.to_s).to include('Rey Palpatine has sent you some advice: Work through your anger with exercise, and wear a mask')

      expect(mail.body.encoded).to include('Hello Kylo Ren')
      expect(mail.body.encoded).to include('Rey Palpatine has sent you some advice: Work through your anger with exercise, and wear a mask')
    end
  end
end

```
⭐️ If you have extra time, try running through the mailcatcher implementation one more time on your own. And if you've done that and are feeling comfortable, feel free to check out some of the additional resources below. 

### Additional Resources

* [ Slides ](../slides/emails)
* [Production Email Checklist using SendGrid](../lessons/production_email_checklist)
* [Additional Rails docs on Testing Emails](https://guides.rubyonrails.org/testing.html#testing-your-mailers)
