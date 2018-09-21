---
layout: page
title: Translation Station
subheading: AJAX and other things you already know
---
## Learning Goals

- Students recognize that AJAX is Yet Another T&T Cycle
- Students are able to apply HTTP request/response in multiple contexts
- Students are able to implement AJAX in their project
- Students are able to resolve CORS errors

## What are the parts of AJAX?

You've had one class on AJAX. Some of you have attempted implementing some AJAX in your personal project. Some of you have not. But I think you know AJAX better than you think you do.

### An Example psuedo-code AJAX interaction

```js
function handleResponse(data) {
  HTML = makeHTMLString(data)
  appendHTMLToDOM(HTML)
}

get('http://some.api/url')
  .then(handleResponse)
```

#### AKA

1. Make a request to some API
2. Do something with the response

You've done these two steps before. Where have you seen this pattern?

Here's those steps in Ruby:

```rb
require 'faraday'
require 'json'

def get_post(id)
  Faraday.get("http://birdeck.herokuapp.com/api/v1/posts/#{id}").body
end

def parse_json(json)
  JSON.parse(json, symbolize_names: true)
end

def render_post(post)
  puts "id: #{post[:id]}"
  puts "description: #{post[:description]}"
  puts "created_at: #{post[:created_at]}"
  puts "updated_at: #{post[:updated_at]}"
end

post_json = get_post(324)
post_data = parse_json(post_json)
render_post(post_data)
```

Let's say you wanted to do the same thing in JavaScript using AJAX. Just get some JSON from an API, and output it to the console.

- How would you break down what's happening above?
- What information would you need before you could do that?
- How might you get that information?

Take a minute to come up with a plan, and then we'll implement your plan. We'll write the above code using AJAX in JavaScript.

### AJAX goes both ways

Here's some more pseudo code

```js
function handleResponse(data) {
  HTML = makeHTMLString(data)
  appendHTMLToDOM(HTML)
}

data = somethingFromTheDOM()
someData = {some: data}
post('http://some.api/url', someData)
  .then(handleResponse)
```

#### AKA

1. Collect the data you need
1. Make a request to some API, and include some data
2. Do something with the response

And here's the Ruby:

```rb
require 'faraday'
require 'json'

def post_data
  { description: "I'll see you in court" }
end

def make_json(hash)
  JSON.generate(hash)
end

def parse_json(json)
  JSON.parse(json, symbolize_names: true)
end

def render_post(post)
  puts "id: #{post[:id]}"
  puts "description: #{post[:description]}"
  puts "created_at: #{post[:created_at]}"
  puts "updated_at: #{post[:updated_at]}"
end

def send_post(body)
  response = Faraday.post "http://birdeck.herokuapp.com/api/v1/posts.json" do |req|
    req.headers['Content-Type'] = 'application/json'
    req.body = body
  end
  response.body
end

new_post_json = make_json(post_data)
created_post_json = send_post(new_post_json)
created_post = parse_json(created_post_json)
render_post(created_post)
```

I realize that `post` means both the record we're creating, and the HTTP verb used to send data to the server, but stick with me.

Put your plan together for figuring this out in JS, and then we'll code it together.

### Checks for understanding

- How is AJAX the same as Faraday?
- How is it different?
- What are some things that AJAX would enable you to do on the front end?

## CORS: Oh this thing

### The problem

Browsers implement the "Same Origin Policy". Basically, the policy allows JavaScript to download data from servers into the current page you're on, but only if the data you download comes from the same "origin". I've dug into why this is a policy multiple times, and haven't ever really come up with a good reason that this is a thing. Sorry, it's just a thing.

What does this mean for us? It means that you're not allowed to download data if the domain doesn't match between the client and the server. If I'm visiting a page on `example.com` and I want to make an AJAX request to `api.com`, the browser won't let me.

### The solution

CORS stands for Cross Origin Resource Sharing. You can't change the rules of the browser. But the rules are slightly more complex. If you add some additional headers to your server, and you tell the browser that it's totally fine for clients at other domains to download from you, then the browser will allow it.

### How to CORS

Firstly, there's a good overview at <https://enable-cors.org>. CORS works by adding at least the `Access-Control-Allowed-Origin` header to the responses from your server. This is where you can put another domain that is allowed to connect via AJAX. If you're hosting your site at `neight-allen.github.io`, simply add `Access-Control-Allowed-Origin: neight-allen.github.io` to your headers.


There are several uses of this header, as well as some other headers you can use. I don't really care if you're CORS experts. Instead of going into the weeds with CORS options, let me just recommend a package and a gem that will allow you to easily configure these headers.

- [Express CORS Middleware package](https://github.com/expressjs/cors)
- [Rack CORS gem](https://github.com/cyu/rack-cors)

Let's spend a minute getting CORS set up in your Express API.

## Transport and Translate

The client to server (AJAX) and server to server (Faraday) communication we've discussed is just one form of what I call "Transport and Translate". In fact, an obnoxious amount of what we spend our time doing is moving data from one place to another, or changing the format or presentation of said data.

### Transport

Let's list out some of the ways we've moved our data around before:

- Getting data out of a database into memory
- Extracting data from an HTML form
- Storing data in session

What are some other sources and destinations for data?

### Translate

Let's list out some of the ways we've translated data from one form to another

- Parsing JSON into an object or hash
- Mapping an objects into a table row in HTML
- Converting an array of hashes to rows of a CSV

What other format translations have you done?

### Breaking it down

You're often performing multiple rounds transport and translate. Here's a few steps involved in serving data from an API.

1. Transport JSON from API via HTTP
2. Parse JSON into hash
3. Convert hash into class instance
4. Send instance to view
5. Render instance to HTML
6. Send HTML via HTTP

Can you think about the steps involved in Quantified self? Write out the steps to go from a food record in the database, to a rendered table row of HTML on the screen.

## Closing thoughts

I should have some of these. What do you think? What are your thoughts?
