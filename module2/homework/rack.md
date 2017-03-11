---
layout: page
title: Rack
subheading: The Basics
---

## Spin up a Rack server and see the basics of a server response

* `gem install rack`
* get into a repl session with `pry`:

  ```terminal
    require 'rack'

    app = Proc.new do |env|
        ['200', {'Content-Type' => 'text/html'}, ['Now You Have A barebones rack app.']]
    end

    Rack::Handler::WEBrick.run app
  ```
* In your browser, navigate to the port your terminal output is directing you. See your response rendered by the server.
* Now go back into the repl session:

  ```terminal
    require 'rack'

    app = Proc.new do |env|
      ['200', {'Content-Type' => 'text/html'}, ["<h1>Meow You Have A barebones rack app.</h1><img src='http://i.telegraph.co.uk/multimedia/archive/02830/cat_2830677b.jpg'>"]]
    end

    Rack::Handler::WEBrick.run app
  ```
