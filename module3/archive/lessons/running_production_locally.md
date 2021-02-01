---
layout: page
title: Running Rails in Local Production Environment
tags: rails, production environment
---

Below are instructions for how to get started running a Rails 5.2 application in a local production environment.

Start in the Rails application directory

* Make sure all necessary gems are installed
```bash
bundle install
```

* Set up the production database
```bash
RAILS_ENV=production rake db:{create,migrate,seed}
```

* Make some changes to the production configuration

```ruby
# within app/config/envrionments/production.rb

# change the below line to be commented out
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

# change to equal true
config.assets.compile = false
```

* Precompile the assets
```bash
RAILS_ENV=production rails assets:precompile
```

* Start the server for the production environment
```bash
RAILS_ENV=production rails s
```

* Navigate to your app in the browser to see how it looks



__Important to Remember__

* If you are making changes to your assets and want to see those updates you will need to do the following:
  - Stop the server
  - Run `rails assets:clobber` This will remove the assets in the public folder
  - Run `rails assets:precompile` This will create new assets with the changes
  - Start the server


* Once you are finished running you application in your local production environment
  - Run `rails assets:clobber`
  - Undo the changes made in the `app/config/envrionments/production.rb`
  - This will help to ensure that there isn't any issues with your assets when you deploy to Heroku.
