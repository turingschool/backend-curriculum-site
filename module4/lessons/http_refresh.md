---
title: HTTP Refresher
layout: page
---

[HTTP/HTTPS Refesher - Backend Students - Google Slides](https://docs.google.com/presentation/d/1FC3k0wS5GjSC6KwNdvA0JvlsGkC97e9kO6K2H3807QU/edit?usp=sharing)

## Important Basics:
* HTTP stands for hypertext transfer protocol
* Whenever you type “http” into your browser, you’re instructing your browser to open an HTTP connection
* The browser then sends data to a server via the Transmission Control Protocol (TCP)

### Discussion time (5 minutes)

Let’s answer two questions in relation to understanding HTTP
1. What is in an HTTP request and response?
2. What does it mean that HTTP is stateless?

## What is HTTPS?
HTTPS (also referred to as HTTP over SSL/TLS) is a protocol for secure communication(s) over a computer network. The main purpose of HTTPS is to authenticate the server and to protect  the privacy of the exchanged data that is being sent along in each request. 

### Discussion: What is HTTPS good for? (5 minutes)

## What are some other ways that we can use HTTP?

### Long Polling

Long Polling is a mechanism that allows your application to constantly check the server for a reply.

Example: You could have your application ping your server every [X] seconds to pull down new sets of data.

Upside:  You’d constantly have updated data for your application at all times

Downside: With HTTP long-polling, the client continually polls the server requesting for new information. With many users long polling your servers, the load of on your system will increase with more users. 

### HTTP/2 Server Push

HTTP/2 is a mechanism to push and pull data from a server  as a stream. What’s a stream? A stream is a bidirectional sequence of data flow between a client and a server. It requires an HTTP/2 connection.

Great example applications: Social media feeds and single page apps

### Web Sockets

Web sockets are very similar to HTTP/2 as it’s bidirectional in nature. It supports full duplex communication, which means that data can be sent either way during an open connection. Another advantage of using web sockets is that it has very low latency. There is limited HTTP overhead, which make the transfer speed substantially  faster. A typical request includes a simple web socket upgrade header, which lets the client know that a web socket connection is trying to be made. 

Real world applications for web sockets are endless. It can include online games, IoT decides, streaming live video, and simple chatting apps. You can do a lot if you have a continuous connection between a client and server! 
