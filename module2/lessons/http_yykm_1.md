---
layout: page
title: How the Web Works III
subheading: HTTP Yeah You Know Me, Part I
---

## Learning Goals

* Write a web server in raw Ruby (as opposed to using a web framework like Rails)
* Parse Requests in raw Ruby
* Generate Responses in raw Ruby

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

# HTTP Tutorial

In this tutorial, we will play the part of both the Server and Client. We will write the server in Ruby, and we will use a web browser, like Chrome or Safari, as the Client.

## Starting a Server

Add the following lines of code to a Ruby file:

```ruby
# Library that contains TCPServer
require 'socket'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)
```

Run the file with `ruby <filename>` and you should see that nothing happens. So what do these lines of code do?

TCPServer is the Class we will use to create a new Server.

9292 is the **Port** that the Server runs on. The Port uniquely identifies a program running on a computer. Back to our penpal analogy, imagine your penpal lives in a large apartment building. You have to specify both the street address and the apartment number. Like an apartment building with many units, a computer has many programs running at once. In HTTP, we have to specify both the Server and the program within the Server we want to send our Request to.

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

The last line is telling the server to wait for a Request. When our server gets a Request, we are saving the connection to a variable called `connection`. This connection object is an open door between our Server and Client that the Server will use to read the Request and send back the Response. If you run the file now, you should see `Waiting for Request...` printed to your terminal which then hangs. Success! Your Server is now running. Use `ctrl + c` to stop the Server.

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

Go back to your terminal and you should see a print out of the request.

What we just did was start a Server and tell it to wait for a Request. Then we sent a Request using a web browser. When our Server got the Request, it read it and printed it out to the screen line by line.

**Answer the following questions in your notebook:**

1. Look at the request that was printed out. What is the verb?
1. What is the path?
1. What is the protocol?
1. What is the first header?
1. What is the last header?
1. What is the body?

### Generating the Response

If you look back at your web browser, it should say something like `localhost refused to connect`. Remember, the HTTP cycle includes both a request and a response. Right now, our program is quitting as soon as it gets a response.

Update your file with the following:

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

Run this file and send a Request to `localhost:9292` from the browser just like before. You should see the text `Hello from the Server side` in your browser. We now have a successful Client/Server interaction! Notice that when we are done writing the Response, we need to close the connection.

**Answer the following questions in your notebook:**

1. For the response we generated, identify each part of the status line.
1. Identify the headers we sent in the response.
1. Identify the response body.

After your Server sends a response, the program ends. If you try to refresh the page, you won't get a connection. Let's update our code so that the Server will continually accept Requests:

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

**Note:** If you are using Google Chrome, it may send two requests. The first one is the one we are concerned with. Ignore the second one requesting the "favicon".

## Checks for Understanding

1. Compare and contrast the code you wrote in this tutorial with the Rails apps you've written
1. Can you identify any code snippets from this tutorial that have a similar Rails component?
1. Can you identify any Rails components that are missing from the code?
1. Can you identify anything in this tutorial that we don't have to do in Rails? If so, does Rails just do it for us? Or does it not do it at all?

## Extensions

### Paths

Right now, our app only generates one response. If you send a request to `localhost:9292/users`, `localhost:9292/unicorns`, or `locahost:9292/hello`, you will get the same response every time. Refactor your code so that your server can respond to different paths. You can pick whatever paths you want, but if you need some ideas:

* Make you server respond to `/hello` with a greeting message
* Make your server to respond to `/bio` with a short biography for yourself
* Make your server respond to `/random` with a random number
* Make your server respond to any other path with a 404

### Verbs

Once you have made your server respond to a couple of different paths, try to make it respond to different verbs for the same path. For example, generate different responses for `GET /hello` and `POST /hello`.
