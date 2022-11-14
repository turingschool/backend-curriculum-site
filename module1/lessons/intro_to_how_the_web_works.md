---
title: Intro to How the Web Works
length: 60
tags: http, servers
---

### Learning Goals

* Define the 'Vocabulary' of the web
* Describe the Request/Response Cycle at a high level
* Describe the parts of a URL

### Vocabulary

* Client
* Server
* URL
* URI
* User
* Request
* Response
* HTTP

## What is the Internet?

The internet, which for most people is the web...how does that work?

The basis of all web interactions is someone asking for information, and receiving information. In order to ask for and receive any information, we need two players - the asker and the producer. In basic web interactions, the 'asker' is a **client** and the 'producer' is a **server**. Clients send **Requests** to Servers asking for some kind of information. Upon receiving a Request, Servers send **Responses** back to the Client.

The **Internet** is the network between devices that allows clients and servers to exchange this information. **HTTP** is a set of rules for how this exchange of information happens. Clients and Servers adhere to these rules to ensure that they understand each other's Requests and Responses.

In the web development world, a client is a web browser, not an individual person.  The person using the browser is referred to as a **user**.  

## Penpal Analogy

Okay, that was a lot of information. Let's break all of this down with a metaphor:

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

In this analogy:

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

That's the HTTP Request/Response cycle. At its core, it is a bunch of formatting rules that Clients and Servers use to talk to each other. You can read more on the [wikipedia page](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) or the [IETF specification](https://tools.ietf.org/html/rfc2616).

## What is "URL"?

Users tell a client to ask for information by giving it a **URL**: a Universal Resource Locator.

A URL allows us to send data to, or retrieve, a "resource" on the Internet. A resource could be a page of HTML content, it could be an image or music file, or it could be part of a web application that will save data you send to it.

### URL vs URI

You may also hear the term "URI" when talking about things on the Internet. A "URI", or "Universal Resource Identifier" is not the same as a URL, but it's easy to confuse them.

A URI is part of a URL. See below:

#### Parts of a URL

A URL can be split into distinct parts:

* Protocol: `http://` - Tells us the application protocol we will be using to interact on the web.
* Domain: `task-manager.herokuapp.com` - Tells us where the resources we are trying to access are located (tied to an IP address using DNS).
* Path: `/task/new` - The specific path for the resources that we are trying to access at that location.
* Query String: `?title=New&task=Task` - Params that give our server additional information about what we would like to access.

### House Analogy
Because programmers love analogies...
Let's say you wanted to meet Kat's cat, Autumn and give her a cat treat. Kat lives far away so you'll need to drive there. You know Kat lives at `123 Main St` and Autumn always hangs out in the master bedroom on the cat tower in the corner.

1. You drive along the roads, following the speed limit and traffic lights and the rules of the road to arrive at Kat's house safely.
  - HTTP - your set of rules to navigate to your destination
  - The Internet - series of roads that connect you to the destination
2. Siri directed you to the address `123 Main St` where you know Kat and Autumn live.
  - Domain - location of the resource
3. Once inside, you follow Kat's instructions for getting from the front door, to the master bedroom, to the cat tower in the corner to find Autumn.
  - Path - the specific location of our resource at this server
4. Now you give Autumn her treat and a little pat on the head.
  - Query String - additional information about the information we want or the action we want to perform.



The "Domain", "Path", and "Query String" combined indicate a unique "identifier" for a resource, and all three of these pieces are a **URI**.

You will be covering more specifics around these parts of the URL later in Mod 2 - for now, it is important that you know that these parts exist.

## The Request and Response Cycle

As you start to build out web applications in Mod 2, it is important to be able to visualize the way information flows through the system; typically called the Request/Response Cycle.

First a user gives a client a URL, the client builds a **request** for information (or resources) to be generated by a server.  When the server receives that request, it uses the information included in the request to build a **response** that contains the requested information. Once built, that response is sent back to the client in the requested format, to be rendered to the user.

It is our job as web developers to build out and maintain servers that can successfully build responses based on standardized requests that will be received.  But, what does a standard request look like?  We need to know that before we can start building servers that will respond successfully.

The standard, or protocol we use is **HTTP**.

## HTTP Requests and Responses

The HyperText Transfer Protocol gives us rules about how messages should be sent around the Internet. The system that initiates a connection sends a "request", and the system the answers sends a "response".

### HTTP Request

When a "client" (like a web browser) retrieves information, it sends a payload of data to a server as a "request". This request has many parts, including a protocol, a path (URI), and any additional information that might be needed to perform the request. For example, if we were trying to add a new cat to our cat database, we'd need to send along the attributes of the specific cat we were creating.

### HTTP Response

Similar to a Request, the Response also has many parts, including information on if the request was successfully completed or not. If the resource was located and can be sent back, it will be sent in the response payload.


## Your Turn

Take turns with your group answering the questions below. Feel free to use/draw a diagram to assist you in your answer.

* Describe the HTTP request/response cycle. Use each of the following terms:
  * User
  * URL
  * Client
  * Server
  * Request
  * Response
  * HTTP
* What are the parts of a URL?

## Resources

* [How the Web Works - MDN](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/How_the_Web_works)
* [Anatomy of a URL](https://doepud.co.uk/blog/anatomy-of-a-url)
* [More How the Web Works](https://www.freecodecamp.org/news/how-the-web-works-a-primer-for-newcomers-to-web-development-or-anyone-really-b4584e63585c/)
