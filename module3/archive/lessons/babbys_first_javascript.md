---
layout: page
title: babby's first javascript
---

## You Got Your JavaScript In My Rails!

### Warm Up

Take ten minutes and on pen and paper, write fizz buzz. Loop through the numbers 1 though 100 and print out each number. If the number is divisible by 3, print out `Fizz` to the console instead of the number. If the number is divisible by 5, output `Buzz` to the console instead of the number. If the number is divisible by both 3 AND 5, print out`FizzBuzz` to the console.

At the end of ten minutes, spend 90 seconds apiece showing what you did to your new best friend. The person who loves dogs more goes first.


### History of JavaScript

"Every programming language has its creation myth." -Steve Kinney

#### Ruby

The word that Matz uses when talking about the creation of Ruby is joy. "For me, the purpose of life is partly to have joy. Programmers often feel joy when they can concentrate on the creative side of programming, so Ruby is designed to make programmers happy."

#### JavaScript

"JavaScript May Have Been Written in Ten Days, But Wait Till You Hear How Much Time We've Spent Fixing It."  -@BuzzfeedJS

JavaScript was created by Brendan Eich, a Netscape employee in 1995. It was known then as Mocha, and essentially Eich was given ten days to write a whole new programming language, and it had to look like Java, which was the hotness at the time. (The two are actually unrelated).

And so, let us return and think on the lessons about empathy that we have learned during BattleShift.

You had a bit over ten days to do that project. Can you imagine writing an entire programming language in the same amount of time? What sins did you commit in BattleShift? What sins do you think Eich committed in ten days?

Example. What number do we associate with the month January? 1? Not in JavaScript - it's zero. And knowing what we know about programming, one could say that it kind of makes sense that January would be zero. Buuuuu that's not how the real world works.

"Working with JavaScript has traditionally involved memorizing a bunch of weird tricks and hacks."

An example of this is the dunder prototype. This was something added to let people know what prototype a thing came from, never expecting it to be a _thing_ and it was added. They then planned on taking out later as it got replaced with a better implementation, but when they went to do so, people freaked out because they were used to doing it in the old stopgap measure. So, right now, if you check the documentation for the dunder prototype, it says you shouldn't use it because it may get deprecated and removed at any point. No firm date or anything, just sometime soon. Maybe tomorrow. Maybe next year. [Further Reading](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/proto)

#### The Swing Between the Client and The Server

Throughout history, there's been some swings between things running on the server, things running on clients, and theres been ideas of thin clients and thick clients and dummy terminals, and all sorts of things. We're going to take a look at this.

In the early days of computing there was just big giant computers. Essentially, if you wanted to run software on the computers, you had to write your code on these punch cards, hand in the cards to the computer technician, and later at some point, you'd get the results of your program. Note: This would really suck if you had a bug in your code. Computers were so slow back then and you had to make an appointment for time for your computer to run. So if you did something wrong in your code, you had to fix it, get it on punch cards, and then make an appointment to run it at some later date. We are truly spoiled by the fact that we can just run our code all day every day and its fine.

As computers got faster, and technology advanced, we got to the point to where we no longer had to make appointments for computer time, computers could essentially time share, so it could be set up so that many people could use a computer at what appeared to them to be at the same time. The first iteration of this were dummy terminals, which were essentially a keyboard and screen connected via a VERY long cable to the server, also known then as possibly a mainframe. The computer wasnt doing multiple things at a time, it was essentially multitasking, but moving so fast that it felt like things were happening simultaneously. And of course, the more people using terminals at the time, the more things would slow down, as a finite number of computing resources are now allocated to more and more users.

We took this approach out to its logical conclusion, as the terminals were able to go further and further away from the mainframe, to the point where terminals were able to connect to the mainframe via phone lines. But then there started a shift with the advent of the personal computer.  Home computers were now more and more prevalent as the cost of computers came down and the machines people had in their homes got more powerful, we see this shift. Instead of running programs on a remote server somewhere, we install software on our computers at home and that does the heavy lifting, freeing up computing power on the mainframe. Who here has installed some kind of software on their computer using floppy disks or CD-ROMs back in the day? This was kind of a consequence of the fact that network speeds were so slow back then. It made time-sense and money sense to offload more things to the desktop as it could handle them.

This was the status quo until the internet became a thing. Not just the internet, but the internet and fast connection speeds and always on internet connections. I recall getting a copy of Microsoft Office, and it was something like six CDs. What do you do now if you want to run a copy of Microsoft Office? You sign up for an account for Office 365, and you log in using your Web Browser. Google Docs, whatever. But the model has changed a bit. We’re not connecting to a single server, we’re connecting to _the cloud_. In OOP terms, what do you think we would call _the cloud_?

#### TIPS
So that’s a brief history of how the architecture and paradigms of doing things on the internet has changed over the years.

Let’s imagine the best web app. You visit `catsarelame.com`.  There’s some text, it reads, “CATS RULE” You click a button on the screen. Now the webpage says, “NO CATS ARE LAME DOGS RULE”.

With the context of the HTTP response cycle, and what you know about rails, take five minutes and write down what happens in this scenario.

Take three minutes and in your pair, the person who has the cooler shoes shares first.

#### I want to go fast
![i want to go fast]

Why do we want our websites to go fast?

In the example you discussed, how long do you think that would take to complete? Is that best case scenario? Worst case scenario?

How long do you wait for a web page to load before you give up?

How much do you think Amazon spends on making their website fast. This is literally a situation where each millisecond can cost millions of dollars.

How can we speed up this situation? This is what JavaScript was made for. It ads interactivity and allows you to make changes to the displayed web site all on the browser without having to reach out to the server.


