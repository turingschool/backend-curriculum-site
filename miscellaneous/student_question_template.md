---
layout: page
title: Question Submission Template
---

### A clear, detailed explanation of the issue and a specific question for the instructor.
___

- Example: My CSS is not loading in production. When I spin up the server in a production environment and open the inspection tools, I see that the CSS file is there but the changes are not applied. How can I include my CSS changes in production?






### What **five** key terms/queries have you used in Google?
___

- Example of **one** of the queries: CSS not loading in Rails 5.2 production







### Provide the five links that you have read on the issue and 1-2 sentences of what you took from that link?
___

- Example of **one** link & summary:  https://github.com/thoughtbot/administrate/issues/725
This link talks about running a local production environment and ensuring that `config.public_file_server.enabled = true` inside `production.rb` is set. This is done in my application and did not solve my issue.






### Provide link to your GitHub PR that is highlighting the issue and a summary of the steps you've taken to try to resolve this issue on your own.
___

- Example: github.com/user_name/repo_name
I followed the instructions posted here to run my production environment: https://gist.github.com/rwarbelow/40bd72b2aee8888d6d91
```
Add gem 'rails_12factor' to your Gemfile. This will add error logging and the ability for your app to serve static assets.
bundle
Run RAILS_ENV=production rake db:create db:migrate db:seed
Run rake secret and copy the output
From the command line: export SECRET_KEY_BASE=output-of-rake-secret
To precompile your assets, run rake assets:precompile. This will create a folder public/assets that contains all of your assets.
Run RAILS_ENV=production rails s and you should see your app.
```
I have tried clobbering my assets and running the precompile command again.
