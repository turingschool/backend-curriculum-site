---
title: Scaling Apps & Picking the Right Tool
layout: page
---

Today we're going to talk about the basics of scaling an application. Up to this point, you've mostly been exposed to using Rails as your primary tool for building full stack applications. While Ruby and Ruby on Rails are considerably powerful, they may not always be the best tool for every job that you'll ever encounter. This lesson will look at various ideas that surround the idea of scaling an application and picking the right tool to do so.  

### Discussion: What are some ways we can make our Rails application more performant?

1. Leveraging the asset pipeline
2. Background workers
3. Benchmarking our applications

These are a few options in our toolbox that we can use right off the bat.   

#### Heroku Instances
Deploying on Heroku has been commonplace for you over the last few modules. The creation of your Rails application on Heroku can be found in an instance that is created after being deployed. The instance is a lightweight and isolated environment that allow your application to run, just like on your own local machine. By default, you’ll share space with other applications that have been deployed on Heroku. This is why your application goes to sleep when you’re not using it. 


### Discussion: If our application needs more computational power, what would be a good strategy to help it scale more easily?

1. Add more machines?
2. Add more CPUs? 
3. Add more RAM? 

#### Defining RAM vs. CPU
1. More RAM: you can run more apps concurrently
  1. RAM let us write the directions of our program and allocates some memory for it. 
  2. RAM is like the top of a desk. More space means we can do more things at once, even if we aren’t doing anything 
	2. More CPU: you can run more complex calculations/operations. 
  1. A CPU will take our written instructions and execute them. If everything goes well, we’ll get the result we were expecting. 
  2. CPU is similar to a person sitting at the desk. That person is able to do things with the stuff sitting on the desk in front of them. The more people (the more CPUs), the more that can be done with the items on the desk. 
#### Vertical scaling vs. Horizontal scaling
1. Vertical scaling is where we add more machines to help scale our problem. This help us distribute load across multiple machines and will help us avoid having a single source of truth if something goes wrong in our system.  
2. Horizontal scale is where we add more additional RAM or CPUs into our system. This allows us to take on more requests from our users.
3. We can use a combination of the two in a variety of ways that fit our particular problem. 
#### Autoscaling 
Think of this as machines being on standby. When you need a machine to fire up, you can automatically do this when load becomes too heavy for your current system. If you are expecting a spike in traffic, this may be a good solution for the short term. 
#### Load balancing
Distributing the load of requests across all machines, ideally in an even way. This distribution of traffic can be done randomly across machines, or by using a round robin approach. 

### Under the hood:

#### Defining a process vs. thread
1. A process is an instance of a computer program that is being executed by a thread (or many).  
2. A thread is a program’s execution context. It usually executes the instructions of your program in a sequential manner. Threads may also share memory with other threads in your system. You can think of a thread as a tiny process within the process of your application. 
3. As threads use up your system’s memory and it begins to run out, the system may begin to slow down.
4. You can think of memory as a chest of tiny drawers. Each drawer has an address associated to it and can hold some items inside. As more of the drawers get filled up, the system won’t have as many options to execute more requests from your users. 
5. As a program’s function finishes up, a thing called garage collection will take that memory and reallocate it back into your system. If your system gets bogged down, then GC will be running in overtime in an attempt to reallocate memory to that additional users can use your application.  
6. Ruby is single threaded by nature
  1. You can add more threads in a variety of ways, but there will be an upper limit to its use (as with any programming language). 

#### Defining concurrency vs. parallelism
1. Concurrency is when two or more tasks can start, run, and complete over the course of a predefined time period. This is useful if many people are attempting to upload large CSVs at the same time. Not one file upload will slow the system down. If the system were purely synchronous, each person in life to upload their file would have to wait. 
2. Parallelism is when multiple tasks start to run at the same time. This could be useful if you are attempting to upload a big CSV. 

### Picking the right tool for the job

As our system begins to grow, we should be thinking about how we can successfully scale our applications. This could potentially mean that we only use Rails for our frontend while our backend uses something a bit more performant (such as Go or Scala). Picking the right tool is all dependent on what you’re attempting to achieve. If you know that your application will only need basic CRUD functionality, you may be good to use Rails for an extended period of time (or perhaps forever). If your application is need of something that requires heavy computational power, then perhaps you should look into other options. 

### Another perspective: The Majestic Monolith

Breaking your application out into separates services or smaller applications may not always be the best way to go about it. Here is an article from DHH, the creator of Rails, talking about why they think their monolith application at their company is perfect for the job. 

[The Majestic Monolith - Signal v. Noise](https://m.signalvnoise.com/the-majestic-monolith/)

As you can see, there are many perspectives on how to go about this. There isn’t a perfect way to build out our applications.  
