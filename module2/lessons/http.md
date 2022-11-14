---
layout: page
title: HTTP
---

## Agenda

* Background
* Starting a Server
* Reading the Request
* Generating the Response
* Playing the game (query params)
* Refactor (into methods)
* Form Data
* Refactor (into responsibilities)

## Background

The internet, which for most people is the web...how does that work?

* The **Internet** is the network between devices that allows them to exchange information
* Devices fall in to two categories: **Clients** and **Servers**.
* Clients send **Requests** to Servers asking for some kind of information
* Upon receiving a Request, Servers send **Responses** back to the Client

**HTTP** is a set of rules for how this exchange of information happens. Clients and Servers adhere to these rules to ensure that they understand each other's Requests and Responses.

Imagine you're writing to a penpal. The process would look something like this:

1. Write a letter
1. Specify your penpal's address
1. Drop the letter in your mailbox
1. The letter goes through the postal system and arrives at your penpal's mailbox

Your penpal then goes through a very similar set of steps:

1. Read your letter and write a response
1. Specify your address
1. Drop their letter in their mailbox
1. The letter goes through the postal system and arrives at your mailbox

In this metaphor:

* You are the **Client**
* Your penpal is the **Server**
* Your letter is the **Request**
* Your penpal's letter is the **Response**
* The postal system, the thing responsible for ensuring your letters are delivered, is **The Internet**

**HTTP** is the language you write in so that your penpal can understand you. You may write in English because you know you both understand English. If you wrote a letter in Spanish and your penpal only spoke English, they might write you a letter back saying "Please write to me in English".

Metaphor aside, let's run through the protocol as executed by computers:

1. You open your browser, the Client, and type in a web address like `http://turing.edu` and hit enter.
1. The browser takes this address and builds an **HTTP Request**. It addresses it to the Server located at `http://turing.edu`.
1. The Request is handed off to your Internet Service Provider (ISP) (like CenturyLink or Comcast) and they send it through the Internet, mostly a series of wires and fiber optic cables, to the Server
1. The Server reads the Request. It knows how to read it because it is formatted as an **HTTP Request**.
1. The Server generates an **HTTP Response** to that Request.
1. The server hands the Response off to their ISP and it goes through the internet to arrive at your computer.
1. Your browser reads the Response. It knows how to read it because it is formatted as an **HTTP Response**.
1. Your browser displays the data on your machine.

That's HTTP. At its core, it is a bunch of formatting rules that Clients and Servers use to talk to each other. You can read more on the [wikipedia page](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) or the [IETF specification](https://tools.ietf.org/html/rfc2616).

### The Request

When you enter `localhost:9292` into your address bar, your browser will build an HTTP Request. Here is what an actual request looks like. Note that it's just a single highly-formatted string:

```
GET / HTTP/1.1
Host: 127.0.0.1:9292
Connection: keep-alive
Cache-Control: max-age=0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8
```

The parts we're most interested in are:

* The first line, `GET / HTTP/1.1`, which specifies the *verb*, *path*, and *protocol* which we'll pick apart later
* `Host` which is where the request is sent to
* `Accept` which specifies what format of data the client wants back in the response

With those pieces of information a typical server can generate a response.

### The Response

The Server generates and transmits a response that looks like this:

```
http/1.1 200 ok
date: Sun,  1 Nov 2015 17:25:48 -0700
server: ruby
content-type: text/html; charset=iso-8859-1
content-length: 27

The response body goes here
```

The parts we're most interested in are:

* The first line, `HTTP/1.1 200 ok`, which has the *protocol* and the *response code*
* The unmarked lines at the end which make up the *body* of the response
* `content-length` which tells the client when to stop listening

## Starting a Server

In this tutorial, we will play the part of both the Server and Client. We will write the server in Ruby, and we will use a web browser, like Chrome or Safari, as the Client.

Add the following lines of code to a Ruby file:

```ruby
# Library that contains TCPServer
require 'socket'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)
```

Run the file with `Ruby <filename>` and you should see that nothing happens. So what do these lines of code do?

TCPServer is the Class we will use to create a new Server.

9292 is the **Port** that the Server runs on. The Port uniquely identifies a program running on a computer. Back to our penpal analogy, imagine your penpal lives in a large apartment building. You have to specify both the street address and the apartment number. In HTTP, we have to specify both the Server and the program within the Server we want to send our Request to.

Nothing is special about the Port we specified, 9292. It is just a number. You could just as easily change this number to 8181.

Update the file like so:

```ruby
# Library that contains TCPServer
require 'socket'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)

# Wait for a Request
# When a request comes in, save the connection to a variable
puts 'Waiting for Request...'
connection = server.accept
```

The last line is telling the server to wait for a Request. When our server gets a Request, we are saving the connection to a variable called `connection`. This connection is an open door between our Server and Client that the Server will use to read the Request and send back the Response. If you run the file now, you should see `Waiting for Request...` printed to your terminal which then hangs. Success! Your Server is now running. Use `ctrl + c` to stop the Server.

## Address In Use Errors

`ctrl + c` gracefully ends our program, but sometimes things happen that make our program exit not so gracefully. One of these things is using `ctrl + z`. **DO NOT** use `ctrl + z`! This could result in the Port not being released, and you may at some point see an error like this:

`Address already in use - bind(2) for nil port 9292 (Errno::EADDRINUSE)`

If you get that error enter this command into your terminal:

```
lsof -i:9292
```

and you should get output that looks like this:

```
COMMAND   PID  USER       FD   TYPE            DEVICE SIZE/OFF NODE NAME
ruby    63015 username    8u  IPv6  0xc5b438446726a53      0t0  TCP *:armtechdaemon (LISTEN)
```

Take that number under `PID`, in this case 63015, and enter:

```
kill -9 63015
```

Run your server file again and everything should be okay.

## Reading the Request

Update your file to look like this:

```ruby
# Library that contains TCPServer
require 'socket'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)

# Wait for a Request
# When a request comes in, save the connection to a variable
puts 'Waiting for Request...'
connection = server.accept

# Read the request line by line until we have read every line
puts "Got this Request:"
request_lines = []
line = connection.gets.chomp
while !line.empty?
  request_lines << line
  line = connection.gets.chomp
end

# Print out the Request
puts request_lines
```

Run your file again and you should see your terminal hanging. Open up a web browser, like Google Chrome, and enter the following into the address bar:

`localhost:9292`

Your terminal should print out the Request text similar to the following:

```
GET / HTTP/1.1
Host: localhost:9292
Connection: keep-alive
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.9
```

**Note:** If you are using Google Chrome, it may send two requests. The first one is the one we are concerned with. Ignore the second one requesting the "favicon".

What we just did was start a Server and tell it to wait for a Request. Then we sent a Request using a web browser. When our Server got the Request, it read it and printed it out to the screen line by line.

What got printed to the screen is the **HTTP Request**. It is just a highly formatted string. Let's break down this Request:

The first line is called the **Request Line**. It contains:

* The **Verb**, in this case `GET`. The Verb indicates what type of Request are you sending. `GET` is the most basic HTTP Verb. A Get Request is just asking for information.
* The **Path**, in this case `/`. The Path specifies where the request should go. Together, the first two words are saying "Get me the information located at `/`".
* The Protocol, in this case `HTTP/1.1`. It specifies which version of the HTTP protocol we are using.

All of the following lines are **Headers**. The first word is the name of the Header, and everything after is the value of the Header. The first Header is the `host` header that has a value of `localhost:9292`. Notice that this is very similar to a Hash.

### Generating the Response

Now that our Server has gotten a Request, we need to send back a Response. Update your file with the following:

```ruby
# Library that contains TCPServer
require 'socket'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)

# Wait for a Request
# When a request comes in, save the connection to a variable
puts 'Waiting for Request...'
connection = server.accept

# Read the request line by line until we have read every line
puts "Got this Request:"
request_lines = []
line = connection.gets.chomp
while !line.empty?
  request_lines << line
  line = connection.gets.chomp
end

# Print out the Request
puts request_lines

# Generate the Response
puts "Sending response."
output = "<html>Hello from the Server side!</html>"
status = "http/1.1 200 ok"
response = status + "\r\n" + "\r\n" + output

# Send the Response
connection.puts response

# close the connection
connection.close
```

Run this file and send a Request to `localhost:9292` from the browser just like before. You should see the text `Hello from the Server side` in your browser. We now have a successful Client/Server interaction!

Let's break down our response:

The variable `output` is the information we want to send to the Client. In our case, it is some HTML with a short message.

The variable `status` is required by the HTTP protocol. It indicates what the result of the request was. `200 ok` is the most common status. It means everything is fine. Another common status you've probably seen is `404 not found`. There are many, many different HTTP status codes.

Together, the `status` and `output` make the request. Notice there needs to be two `\r\n`s joining the status and the output. These blank lines are an example of how the HTTP Request needs to be formatted properly so that our Client can read it. Try just putting one `\r\n` in between them and see what happens.

When we are done writing the Response, we need to close the connection.

After your Server sends a response, the program ends. If you try to send to refresh the page, you won't get a connection. Let's update our code so that the Server will continually accept Requests:

```ruby
# Library that contains TCPServer
require 'socket'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)

loop do
  # Wait for a Request
  # When a request comes in, save the connection to a variable
  puts 'Waiting for Request...'
  connection = server.accept

  # Read the request line by line until we have read every line
  puts "Got this Request:"
  request_lines = []
  line = connection.gets.chomp
  while !line.empty?
    request_lines << line
    line = connection.gets.chomp
  end

  # Print out the Request
  puts request_lines

  # Generate the Response
  puts "Sending response."
  output = "<html>Hello from the Server side!</html>"
  status = "http/1.1 200 ok"
  response = status + "\r\n" + "\r\n" + output

  # Send the Response
  connection.puts response

  # close the connection
  connection.close
end
```

You should now be able to refresh the page multiple times and get a Response every time.

## Playing the Guessing Game

Now we want to use our server to play a number guessing game. In order to make this work, we can't just request information from the Server. We have to also send it some information, in this case the guess. We do that with parameters. Parameters are extra information attached to the Path Header. They are specified using the `?`. We want to be able to send a guess like this:

```
localhost:9292?guess=50
```

When your server gets a Request like this, it will see the Path as `/?guess=50`. We need to extract the guess and report back whether the guess was correct, too low, or too high.

Update your code with the following:

```ruby
# Library that contains TCPServer
require 'socket'

answer = rand(0..100)
guess = nil
# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)

loop do
  # Wait for a Request
  # When a request comes in, save the connection to a variable
  puts 'Waiting for Request...'
  connection = server.accept

  # Read the request line by line until we have read every line
  puts "Got this Request:"
  request_lines = []
  line = connection.gets.chomp
  while !line.empty?
    request_lines << line
    line = connection.gets.chomp
  end

  # Print out the Request
  puts request_lines

  # Extract the guess parameter if the Request included a guess
  request_line = request_lines[0]
  if request_line.include? '?'
    path = request_line.split[1]
    params = path.split("guess=")
    guess = params[-1].to_i
  end

  # Generate the Response
  puts "Sending response."
  if guess < answer
    output = "<html>Your Guess of #{guess} was too low</html>"
  elsif guess > answer
    output = "<html>Your Guess of #{guess} was too high</html>"
  else
    output = "<html>Your Guess of #{guess} was Correct!</html>"
  end
  status = "http/1.1 200 ok"
  response = status + "\r\n" + "\r\n" + output

  # Send the Response
  connection.puts response

  # close the connection
  connection.close
end
```

Go to your browser and enter `localhost:9292?guess=50`. You should now be playing the guessing game. Have fun!

## Refactor

At this point, we have a functioning game, but it could use a refactor. We're going to take a second to refactor:

Start with this file and implement the empty method. If working, you should be able to run your server and play the guessing game just like before.

```ruby
# Library that contains TCPServer
require 'socket'
require 'pry'

def start
 answer = rand(0..100)
 guess = nil
 # Create a new instance of TCPServer on Port 9292

 server = TCPServer.new(9292)

 loop do
   # Wait for a Request
   # When a request comes in, save the connection to a variable
   puts 'Waiting for Request...'
   connection = server.accept
   request_lines = read_request(connection)

   # Read the request line by line until we have read every line
   puts "Got this Request:"

   # Print out the Request
   puts request_lines

   # Break apart the request
   parsed_request = parse_request(request_lines)
   verb = parsed_request["verb"]
   path = parsed_request["path"]
   query_params = parsed_request["query_params"]

   guess = extract_guess(query_params)

   # Generate the Response

   response = generate_response(guess, answer)

   # Send the Response
   puts "Sending response."
   connection.puts response

   # close the connection
   connection.close
 end
end



def parse_request(request_lines)
 # This method should take the lines of the request as input and return a hash with the request verb, path, query params, version, and headers. For example:
 # {
 #   "verb" => "GET",
 #   "path" => "/",
 #   "version" => "HTTP/1.1",
 #   "query_params" => "guess=50",
 #   "Host" => "localhost:9292",
 #   "Connection" => "keep-alive",
 #   "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36",
 #   "Accept" => "image/webp,image/apng,image/*,*/*;q=0.8",
 #   "Referer" => "http://localhost:9292/",
 #   "Accept-Encoding" => "gzip, deflate, br",
 #   "Accept-Language" => "en-US,en;q=0.9,la;q=0.8"
 # }
end

def read_request(connection)
 request_lines = []
 line = connection.gets.chomp
 while !line.empty?
   request_lines << line
   line = connection.gets.chomp
 end
 request_lines
end

def generate_response(guess, answer)
 if guess < answer
   output = "<html>Your Guess of #{guess} was too low</html>"
 elsif guess > answer
   output = "<html>Your Guess of #{guess} was too high</html>"
 else
   output = "<html>Your Guess of #{guess} was Correct!</html>"
 end
 status = "http/1.1 200 ok"
 status + "\r\n" + "\r\n" + output
end

def extract_guess(query_params)
 query_params.split("=").last.to_i if query_params
end

start
```

## Form Data

This is great! :) There's just one problem though... if we were going to deploy this game, we would not expect our end users to send guesses by manually typing a guess into the query params.  Think about how a user might want to play this game.  It makes sense at this point to give them a form that they can use to submit guesses - a much friendlier user experience.

What we'll do next is add some logic to our `generate_response`. If we don't get a guess, we'll send the user a form to input the guess in place of showing a welcome message.

```ruby
def generate_response(guess, answer)
 if guess.nil?
   output = "<html>
               <form action='/'>
                   Guess:<br>
                   <input type='text' name='guess' ><br>
                   <input type='submit' value='Guess!'>
               </form>
             </html>"
 elsif guess < answer
   output = "<html>Your Guess of #{guess} was too low</html>"
 elsif guess > answer
   output = "<html>Your Guess of #{guess} was too high</html>"
 else
   output = "<html>Your Guess of #{guess} was Correct!</html>"
 end
 status = "http/1.1 200 ok"
 status + "\r\n" + "\r\n" + output
end
```

In your browser, navigate to `localhost:9292` and you should see your form! Type in a guess, click the button, and what happens? Everything should be working just like before! If you look in the address bar, you should see your guess being generated as a query param. By default, an HTML form will take each input (except for the submit) and generate a corresponding query param in a GET request.

This behavior is different than what we see with forms in Rails apps. Rails forms, and most forms on the internet, will generate POST requests and send the data in the request **body** rather than query params. Let's change our form method to see that in action:

```ruby
<form action='/', method='post'>
```

Try to submit your form again. What happens?

Try to put a `binding.pry` after you read the request:

```ruby
parsed_request = parse_request(request_lines)
verb = parsed_request["verb"]
path = parsed_request["path"]
query_params = parsed_request["query_params"]

guess = extract_guess(query_params)

binding.pry
```

In HTTP requests, the post data appears in the **body** of the request after the headers. A blank line indicates the end of the headers and the beginning of the body. If you look at the `read_request` method, right now we stop reading the request once we hit that first blank line.

In your pry session, try to read some more data from the client:

```ruby
pry(main)> connection.read(1)
```

If you enter this command multiple times, you should see your post data being read from the request body character by character (this is what the `(1)` indicates). What happens if you continue to enter that command after all the data is read?

The problem with this approach is that we need to read the *exact* length of the data the client sends, otherwise we'll be trying to read data that isn't there, and our connection will hang.

To solve this problem, the client will send a header called `Content-Length` to indicate how much data they sent in the body. In your `pry` session, see if you can access this header.

Now that we have the information we need to read the body, we need to figure out how to determine if the guess was sent via a form or through query params. What information are we already capturing that can help us make this decision?

See if you can use this information to read the request body (if necessary) and pass the appropriate information to the `generate_response` method.

## Redirects

A [Redirect](https://en.wikipedia.org/wiki/URL_redirection) is a special kind of HTTP response. It indicates to an HTTP client that the resource they requested should be fetched from a different location. A redirect is HTTP's mechanism of telling a client (often a web browser) to "go over there." You've seen this on the web whenever you submit a web form and your browser automatically loads a new page. Redirects are often used in response to POST requests.

To respond with a redirect, you need to send 2 things:

1. A `3xx` status code -- in our case `301` will be the standard status code for redirecting
2. A special header called `Location` -- the `Location` header indicates the new URL the browser should visit. For example the header `Location: http://google.com` would tell a web browser to navigate to google's homepage.

Here's what the headers for an example redirect response would look like:

```
$ curl -I google.com
HTTP/1.1 301 Moved Permanently
Location: http://www.google.com/
Content-Type: text/html; charset=UTF-8
Date: Fri, 26 Feb 2016 01:55:24 GMT
Expires: Sun, 27 Mar 2016 01:55:24 GMT
Cache-Control: public, max-age=2592000
Server: gws
Content-Length: 219
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
```

Add functionality to your app to redirect the user to a special Congratulations page when they guess the correct answer. For example, your redirect can send them to `/congrats`.

## Cookies

Right now, every user who visits our app will have the same number they are guessing. For example, if you open up two browsers (like Chrome and Safari), and play the game, you'll notice you'll be playing the same game on both of them.

We can store information for each client in the client's cookies. See if you can update your app to give each client a different number they are guessing. See [this Stack Overflow post](https://stackoverflow.com/questions/3467114/how-are-cookies-passed-in-the-http-protocol) for some more info on setting cookies.

## Refactor

Now that we have multiple path/verb combinations implemented, let's refactor our app to be more generalized. We'll leave this up to you to decide what direction you take it, but here are some suggestions:

* Make a separate method for each type of response
* Make a method that takes a verb/path combo and routes it to the appropriate response method.
* Make request/response objects.


## Checks for Understanding

* What information is included in a request and in a response?  What is the format of this information?
* Thinking about the Rails apps that you have built - can you label the methods and code that we created today with the Rails tools that accomplishes the same goal?
* What are query params and how are they sent in a request?
* What type of requests typically contain a body? How do we access information in that body?
* When a redirect response is sent, what does that tell a client? Or, how does a client handle that response?
