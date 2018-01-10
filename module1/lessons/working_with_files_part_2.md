---
title: working with files part 2
length: 60 min
tags: ruby, file I/O
---  


## Learning Goals  
* Compare Unix file commands to Ruby file commands  
* Use Ruby File I/O in a Ruby program 

## Structure  
5 min - Warm Up  
20 min - Review Unix & Ruby commands  
5 min - Break  
20 min - Apply Ruby Commands
5 min - Wrap Up

## Vocabulary  
* File Input/Output (I/O)
* Unix 

## Warm Up  
1. What Unix commands (command line commands) do you use for creating/reading/writing files? 
2. Name 3 kinds of files you've worked with in the past.
4. Why would you want to read files, especially text files, in a Ruby application?
5. What other kinds of files might you want to read from a program?

This lesson in intended as a follow up to this [video](https://vimeo.com/238294504)

## File Writing with Unix & Ruby 
#### Compare

Using a chart, compare commands in Unix & Ruby 


|  | Unix Commands | Ruby Commands |  
| :---: | :---: | :---: |   
|read | |  |  
|write | | |  



### Return values
In small groups walk through what the following Ruby tasks return:

* File.open
* File.read
* File.readlines
* File.write
* File.close
* CSV.foreach
  

** break **

## Ruby File I/O commands in Action
Work with a partner next to you to do the following:

Use `cat` to create a `quiet_quotes.txt` from the command line and paste the following into it:

```
Bob Ross Quotes
“We don't make mistakes, just happy little accidents.”
“Talent is a pursued interest. Anything that you're willing to practice, you can do.”
“There's nothing wrong with having a tree as a friend.”
“I guess I’m a little weird. I like to talk to trees and animals. That’s okay though; I have more fun than most people.”
“All you need to paint is a few tools, a little instruction, and a vision in your mind.”
“The secret to doing anything is believing that you can do it. Anything that you believe you can do strong enough, you can do. Anything. As long as you believe.”
“I started painting as a hobby when I was little. I didn't know I had any talent. I believe talent is just a pursued interest. Anybody can do what I do.”
“Mix up a little more shadow color here, then we can put us a little shadow right in there. See how you can move things around? You have unlimited power on this canvas -- can literally, literally move mountains”
“Let's build a happy little cloud. Let's build some happy little trees.”
```

Using `ARGV`, write a Ruby script that will take in the above file and write out an all caps version to `loud_quotes.txt`.

The program must be executed from the command line like so:

```
ruby <filename.rb> quiet_quotes.txt loud_quotes.txt
```

#### File I/O in a Project

* Apply these File methods in your current project. 


## Wrap Up  
* How do you create a file in Ruby? In Unix?
* How do you read a file in Ruby? In Unix?
* How do you write to a file in Ruby? In Unix? 


## Additional Resources 

### Additional Resources

[Reading/Writing to Files with Ruby Video](<https://vimeo.com/130322465>)  
[More on cat](https://slackbook.org/html/file-commands-output.html)  
[Resource on Unix Commands](http://mally.stanford.edu/~sr/computing/basic-unix.html)  
