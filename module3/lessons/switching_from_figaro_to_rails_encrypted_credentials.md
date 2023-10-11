---
title: Switching from Figaro to Rails Encrypted Credentials
length: 30
tags: 
---

As of Ruby 3.2+, Figaro no longer works as expected, and though there is at least one [fix sitting in a PR](https://github.com/laserlemon/figaro/pulls), I don’t think that we can expect this to go away.

So, this is a great opportunity to start using Rails Encrypted Credentials. 

First, with VS Code, you have to be able to launch it from the command line, instructions on how to do so available here:  [https://code.visualstudio.com/docs/setup/mac](https://code.visualstudio.com/docs/setup/mac)

Rails will encrypt our credentials for us. It encrypts with a master key that is generated. This key allows us to check the encrypted credentials we may be using to a VCS such as GitHub without the fear of having them compromised. Without the key, it is useless. 

The first step is to generate our master key. We can do this by adding credentials we want encrypted.

```bash
$ EDITOR="code --wait" rails credentials:edit
```

When we run this command, a new key is created in `config/master.key` and it creates a credentials temp file thats opened in your browser.

We need to do the wait to make sure that the encryption happens after the edits have been saved and the editor closed. 

This just a YAML file like we have used with Figaro.

Lets replace the scaffold with our key like so:

```yaml
propublica:
  key: asdsa3498serghjirteg978ertertwhter

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: ugsdfeadsfg98a7sd987asjkas98asd87asdkdwfdg876fgd
```

Generally good idea to nest things to keep ourselves organized.

And now we save and close the yaml file.

When you do this, you should see in your terminal that your file was encrypted and saved. 

Now, we need to change our controller to use the key. 

Previously you had something like this:

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["PROPUBLICA_API_KEY"]
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results]
  end
end
```

And now if we follow the format above:

```ruby
class SearchController < ApplicationController
  def index
    state = params[:state]

    conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = Rails.application.credentials.propublica[:key]
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names: true)
    @members = json[:results]
  end
end
```

Now to work with this with a team - its the contents of the `config/master.key` file you need to share with your teammates securely, and they need to go and create this file with that key as the contents.


## Checking Credentials

After encrypting your credentials, you will not be able to read the encrypted text at all - and that's the whole point. But to check on those values, Rails will need to decrypt the strings for us so that we can read them. To do this, within a terminal in the project, enter the following: 

```bash
rails c

Rails.application.credentials
```

You should then see a list of encrypted strings; yours will likely be at the bottom of that list. Compare it to the value you encrypted originally - it should be the same. 

Watch for empty spaces before or at the end of the strings, or any funny characters you're not expecting. Rails will take *literally* whatever you give it and encrypt that entire string, so an eye for detail is essential! 