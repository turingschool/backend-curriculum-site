---
layout: page
title: Basics of Web Application Security
---

Learning Goals
---------------

-   Students are familiar with common security practices, vulnerabilities and resources

Intro
--------------

We've shown you best practices for security in Rails (authorization, authentication, strong params, etc), but Rails is not the only game in town. Let's talk about some of these concepts in general, and how they may apply in the various applications you build, and enable you to speak about these concepts from an educated perspective.

Review of concepts
-------------------

These are the the concepts [covered in mod 3](../../module3/lessons/fundamental_rails_security). Let's talk about them briefly.

* Privilege Escalation
* Mass Assignment Vulnerabilities
* XSS

You've seen security concepts applied in Rails, but let's talk about security more generally. These are concepts and terms you'll see in all types of web applications, regardless of the language.

Best Practices
----------------

### SSL

You may not have thought about it, but interaction you have between your browser and a webserver has to go through a network of computers, and it's all exposed to anyone else on that network. Secure Socket Layer sits on top of HTTP, encrypting all traffic between a browser and server.

- What are the advantages of SSL?
- What are some disadvantages?
- What are some misconceptions?

#### Resources

[Let's Encrypt](https://letsencrypt.org/getting-started/) is trying to make adding SSL to your application much simpler

How do two computers that have never met each other have an encrypted conversation? [You Tube explanation of SSL handshake](https://www.youtube.com/watch?v=3p_e00tEZM8)

### Hashing and sensitive data

- What is a hash (in the cryptographic sense)?
- What kinds of things should be hashed?
- What kinds of things can't be hashed?
- What do you do with data that is private but can't be hashed?

## Security Terms and Concepts

### Public/Private key pairs

I've heard several drawn out explanations and metaphors of public/private keys. If you google around, it shouldn't be too hard to find them. Here's what you need to know.

- These keys are both used to encrypt messages
- Messages encrypted with one key can only be decrypted with the other key
  - Messages encrypted with your public key can only be decrypted with your private key
  - Messages encrypted with your private key can only be decrypted with your public key
- If someone encrypts something with your public key (anyone can, it's public), they know only you can decrypt it, because you hold the companion private key
- If you encrypt something with your private key, and then encrypt that with someone else's public key, then they can decrypt the message with their private key, and then use your public key to confirm that the message really came from you, and hasn't been tampered with.

Rarely have I ever manually used these keys. I've only ever used them with other software that does the necessary encrypting and decrypting for me. I just think the idea is really cool.

#### Some uses of key pairs

- SSL (Secure Socket Layer)
- SSH (Secure Shell)
- PGP (Pretty Good Privacy)

### UUIDs

There's really two concepts I want to cover here:

1. Sequential ID numbers (the types of IDs you've been using this whole time) can be a security risk
2. UUIDs are a common replacement for sequential IDs

### Secrets

There's not much to define here. Secrets are usually random strings, and they're not to be made public. On their own, secrets don't do much. But they're used to encrypt information, or to prove identity and data integrity.

Secrets like Rails' `SECRET_KEY_BASE` are used to encrypt session data so that clients can't read or tamper with it.

Secrets like API secrets are used to prove that the data really did come from you. This is commonly done using...

### Signatures

Signatures are made by hashing some data or message along with a secret to prove that the data hasn't been tampered with, and the data came from the right person.

This diagram pretty well illustrates signature creation and verification:

![https://www.tutorialspoint.com/cryptography/images/model_digital_signature.jpg](https://www.tutorialspoint.com/cryptography/images/model_digital_signature.jpg)

Signatures are used in API requests, authentication and...

### Tokens

Tokens are temporary strings that represent some other data, typically a combination of identity(s) and permissions. That's pretty broad, but there are many types of tokens, and they follow different rules.

- Some tokens are public. It's fine to pass them around to clients and in URLs
- Some tokens are private. They're like keys to unlock access to specific resources.
- Some tokens encode data. The string itself is "decryptable" to get information about what it represents
- Some tokens are arbitrary data. As long as you hold the string, you can use it to identify yourself.

#### Some examples

- JWT
- oAuth

Attack Types
---------

### Man in the middle and Replay

Man in the Middle attacks are any attacks that involve modifying the communication between a client and server. They involve a malicious actor listening to traffic between a client and server, and inserting their own data. Like when Xfinity puts their logo on your screen while you use their public wifi.

An easy way to prevent against these attacks are to encrypt the traffic. This is why you don't ever see the Xfinity logo on websites you visit using SSL. Replay attacks ignore this problem, and just store your traffic to play it again later. You encrypted a message to take some action (post a tweet, change settings, buy headphones), and if someone records that message, they can just replay it to cause the same action to happen again.

Prevention of replay attacks typically involve including timestamps in your requests, or Nonces (short for Number Only Used Once)


### Click Jacking

This is employed on malicious websites to make you do things on other websites. Since you're typically logged in to all of your sites all the time, they will bring other sites into their own website and get you to take actions you probably didn't want to take. Common examples are liking, favoriting or retweeting something you've never heard of.

Here's a video showing off an example of click jacking: <https://www.youtube.com/watch?v=ZkooSj-SvpE>

Since most click jacking takes advantage of iframes, a common prevention measure is to prevent the browser from allowing your site to be loaded in an iframe.

### Injection

Injection happens any time instructions are added to what is usually data. It causes your site to execute some instruction while trying to work with data.

The two most common types are SQL injection, and JavaScript injection. Prevention starts with never trusting user input. You can "sanitize" inputs by removing any characters or strings that shouldn't be there. If someone is using SQL in their input, strip it out before sending it to your database. If someone puts `<script>` tags in their post, strip them out.

Most frameworks do these things for you, as long as you don't subvert them. Injection problems typically come up when you're trying to solve some other problem, and you end up working around the protections in place. If you interpolate user input right into commands you send to your database, you're at risk. If you write user content directly to the page without stripping HTML tags, you're at risk.

## Next Steps

Security is best left to security experts. But you can't be leaving holes in your application. Learn the best practices, and try to understand new security risks as they become discovered.

If you'd like to continue learning about application security concepts, and learn about best practices for preventing them, check out the [Open Web Application Security Project](https://www.owasp.org/). It's just a wiki, so it can be kind of disorganized at times, but it's designed to be a place to learn only what you need to know as a developer, as opposed to learning to be a web security expert.
