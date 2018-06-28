# Deploying with Amazon Web Services (AWS)

## Learning Goals

* Setup Amazon Web Services (AWS) account
* Use the correct gem or package to deploy application to AWS

## Warm Up

* What has been your experience in deploying applications?
* In your experience, is it relatively difficult or easy to deploy an application?
* Do you use a particular type of service that helps you deploy?
* How often are you deploying while building out your application?

## Getting started

We're going to introduce you to AWS while using Elastic Beanstalk! So, what is it in the first place? The official documentation says that Elastic Beanstalk to be, "...an easy-to-use service for deploying and scaling web applications and services..."

Simply put, you can think of it as another service that closely resembles Heroku. Once you upload the code from your application, you'll have access to features such as load balancing, auto-scaling, and health monitoring.

Before we continue, what do the follow terms mean? Turn to your neighbor, do some Googling, and discuss each.  

* Load balancing
* Auto-scaling
* Health monitoring

Without further adieu, let's get started with Elastic Beanstalk. Let's checkout their main page [here](https://aws.amazon.com/elasticbeanstalk/)

## Check list of things to do before we start coding:

* Checkout the page for basic information
* Understand the main benefits for using Elastic Beanstalk
* Understand that AWS is being used by some pretty big companies


## Step 1 - Get started with your Elastic Beanstalk account

1. Press the, "Get started with AWS Elastic Beanstalk"
2. If you haven't set up an amazon account, do so now. It's free!
3. Once you have created an account and logged in, take a look around at all of the services that AWS offers.

You will see a variety of "solutions" that AWS offers. This includes launching a virtual machine, building a web application, connecting to an Internet of Things(IoT) device, and deploying micro-services. There are definitely a lot of great things you can do. For today, we're only going to attempt to deploy a basic Rails application.

## Step 2 - Prepare the Elastic Beanstalk CLI

1. Get the CLI from brew

```bash
brew install aws-elasticbeanstalk
```

Once this is done, you can run the following to see if it loaded correctly:
```bash
eb --version
```

## Step 3 - Create a standard Rails application

1. Start off with creating a new application

```bash
rails new aws_rails --database=postgresql  
```

2. Add a simple welcome page

```bash
rails generate controller WelcomePage welcome
```

3. Change the root to point to our new controller and action

In your routes.rb file, add this line:

```ruby
root 'welcome_page#welcome'  
```

4. Add some simple HTML for our landing page

In your welcome.html.erb file, add something unique in the markup:

```html
<h1>Welcome page deployed with AWS</h1>
```

5. Add the following to your database.yml file:

```yaml
production:
  <<: *default
  adapter: postgresql
  encoding: unicode
  database: <%= ENV['RDS_DB_NAME'] %>
  username: <%= ENV['RDS_USERNAME'] %>
  password: <%= ENV['RDS_PASSWORD'] %>
  host: <%= ENV['RDS_HOSTNAME'] %>
  port: <%= ENV['RDS_PORT'] %>
```

6. Now fire up your application to make sure that everything is working correctly!

```bash
rails server
```

## Step 4 - Push to Github
1. Initialize a new git repo
2. Add your new changes and link up a remote from your new Github repo
3. Push up changes like you always do

## Step 5 - Create your first Elastic Beanstalk instance

Now we get to use the Elastic Beanstalk package that we installed earlier. If there were no errors when you were downloading everything, then you should be good to go.

In the root of your application's directory, run this command:

```bash
  eb init
```

This will run you through a variety of questions that will set up and configure your AWS EB instance.

**Warning:** You may need to enter secret keys and your Amazon credentials during this process. Please take a look at the bottom of this lesson to see some additional links on how to do this. Once you have done this once, you will more than likely be okay for the time being. If you destroy any of your secret keys on Amazon, you may need to re-do this process of adding them back in again. For more information, check out this documentation [here.](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-configuration.html)

To find your secret keys easily, do the following:

1. Head to your AWS dashboard. Click on your name and then "My Security Credentials."
2. Click on Access Keys
3. Click “Create New Access Key” button.

**Another warning:** You'll only get one chance to see your secret keys when you create a new access key. Save it somewhere safe if you are afraid of forgetting it.

Now go into your rails application and checkout the .elasticbeanstalk config file. You'll see that a lot of the questions that we answered in our CLI will be found here. This directory will also be added to your .gitignore file as well. You'll need to commit and push those changes up.

## Step 6 - Deploy to AWS

1. Grab your secret key found in secrets.yml file

```bash
rake secret
```

2. Insert the secret and run the following command to deploy to AWS
```bash
eb create -d -db.engine postgres -db.size 5 --envvars SECRET_KEY_BASE=PUT_SECRET_HERE
```

**What does the following line of code do above?**

## Step 7 - Wait and hope that you have no errors

You may encounter some errors along the way. Errors are always a good thing because it tells us what we need to do to fix something. If you encounter an error, take a moment to read into it and figure out what the problem is. You could also check out the current logs from our AWS server.

If you don't see any errors, head over to your AWS dashboard and find the Elastic Beanstalk instance that you created. You can then head over to your application's new URL and home.

## Step 8 - Keep deploying

When you make new changes to your projects, you'll need to do the following:
1. Write a great commit message and push up to Github
2. Run the following code to deploy your changes:

```bash
  eb deploy
```

## Wrapping up

Now you've successfully deployed your application using a service that isn't Heroku!

### Reflection

* Compared to Heroku, what were the differences and similarities of deploying with each service?
* Would you prefer to deploy with Heroku or with AWS? Why?


## Additional Resources

[Main AWS Free Tier Signup Page](https://aws.amazon.com/free/).
[Main AWS documentation](https://aws.amazon.com/elasticbeanstalk/).
[Configure your AWS CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-configuration.html)
[Add DB to your AWS instance](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.managing.db.html)
