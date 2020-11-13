---
layout: page
title: Sending Email in Production
tags: rails, email, sendgrid, smtp, action mailer
---
<!-- Included as link in Sending Emails in Rails lesson  -->
#### Sending Email in Production Checklist

- [ ] Create repo on GitHub & push up changes
- [ ] Create/Deploy app on Heroku

##### Heroku & Sendgrid

- [ ] Go to [SendGrid](https://app.sendgrid.com/settings/api_keys) to create an API Key for your project. You may also need to create an account if you do not have one.
- [ ] In Heroku, go to `Settings` for the project and in the `Config Vars` section click
  `Reveal Config Vars`
- [ ] Add the api key to the `Config Vars`
    - Key: `SENDGRID_API_KEY`
    - Value: `sendgrid-generated-api-key`

##### Configuration in Project

- [ ] Open `config/envrionments/production.rb` to add ActionMailer Configuration
- [ ] Add the following code inside of `Rails.application.configure do ... end` block
```ruby   config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.smtp_settings = {
    domain: 'YOUR_HEROKU_DOMAIN.COM',
    address:        "smtp.sendgrid.net",
    port:            587,
    authentication: :plain,
    user_name:      'apikey',
    password:       ENV['SENDGRID_API_KEY']
  }
  ```
  _Note: If you want more info on `action_mailer.smtp_settings` look at [these docs](https://guides.rubyonrails.org/configuring.html#configuring-action-mailer)_

- [ ] Save changes
- [ ] Push to GitHub
- [ ] Deploy changes to Heroku
