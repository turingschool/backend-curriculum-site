---
layout: page
title: Basics of Web Application Security
---

## Learning Goals

-   Students are familiar with common security practices, vulnerabilities and resources

## Intro

We've shown you best practices for security in Rails (authorization, authentication, strong params, etc), but Rails is not the only game in town. Let's talk about some of these concepts in general, and how they may apply in the various applications you build, and enable you to speak about these concepts from an educated perspective.

## Review of Concepts

These are a few concepts [covered in Mod 3](../../module3/lessons/fundamental_rails_security).

* [Privilege Escalation](https://en.wikipedia.org/wiki/Privilege_escalation)
  * Privilege escalation is the act of exploiting a bug, design flaw or configuration oversight in an operating system or software application to gain elevated access to resources that are normally protected from an application or user. The result is that an application with more privileges than intended by the application developer or system administrator can perform unauthorized actions.
* [Mass Assignment Vulnerabilities](https://www.owasp.org/index.php/Mass_Assignment_Cheat_Sheet)
  * Software frameworks sometime allow developers to automatically bind HTTP request parameters into program code variables or objects to make using that framework easier on developers. This can sometimes cause harm. Attackers can sometimes use this methodology to create new parameters that the developer never intended which in turn creates or overwrites new variable or objects in program code that was not intended. This is called a mass assignment vulnerability.
* [Cross-Site Scriptin (XSS)](https://www.owasp.org/index.php/Cross-site_Scripting_(XSS))
  * Cross-Site Scripting (XSS) attacks are a type of injection, in which malicious scripts are injected into otherwise benign and trusted web sites. XSS attacks occur when an attacker uses a web application to send malicious code, generally in the form of a browser side script, to a different end user. Flaws that allow these attacks to succeed are quite widespread and occur anywhere a web application uses input from a user within the output it generates without validating or encoding it.

You've been exposed to security concepts applied in Rails, but let's talk about security more generally. The following are concepts and terms you'll see in all types of web applications, regardless of the language.

## Best Practices

### SSL

You may not have thought about it, but interaction you have between your browser and a webserver has to go through a network of computers, and it's all exposed to anyone else on that network. Secure Socket Layer sits on top of HTTP, encrypting all traffic between a browser and server.

#### Resources

[Let's Encrypt](https://letsencrypt.org/docs/) is trying to make adding SSL to your application much simpler. Check them out when wanting to add an SSL cert to your own server.

How do two computers that have never met each other have an encrypted conversation? [You Tube explanation of SSL handshake](https://www.youtube.com/watch?v=3p_e00tEZM8)

#### HTTPS

HTTPS is a combination of HTTP and SSL protocols. It makes clear to users they are on a secure site making secure network requests.

BONUS: Heroku and Github Pages already provide HTTPS security for sites you host through them!

### Hashing and Sensitive Data

- What is a hash (in the cryptographic sense)?
- What kinds of things should be hashed?
- What kinds of things can't be hashed?
- What do you do with data that is private but can't be hashed?

## Security Terms and Concepts

### Public/Private Key Pairs

I've heard several drawn out explanations and metaphors of public/private keys. If you google around, it shouldn't be too hard to find them. Here's what you need to know:

- These keys are both used to encrypt messages
- Messages encrypted with one key can only be decrypted with the other key
  - Messages encrypted with your public key can only be decrypted with your private key
  - Messages encrypted with your private key can only be decrypted with your public key
- If someone encrypts something with your public key (anyone can, it's public), they know only you can decrypt it, because you hold the companion private key
- If you encrypt something with your private key, and then encrypt that with someone else's public key, then they can decrypt the message with their private key, and then use your public key to confirm that the message really came from you, and hasn't been tampered with.

Rarely have I ever manually used these keys. I've only ever used them with other software that does the necessary encrypting and decrypting for me. The idea itself is fascinating, though.

#### Some Uses of Public/Private Key Pairs

- [SSL (Secure Socket Layer)](https://en.wikipedia.org/wiki/Transport_Layer_Security)
- [SSH (Secure Shell)](https://en.wikipedia.org/wiki/Secure_Shell)
- [PGP (Pretty Good Privacy)](https://en.wikipedia.org/wiki/Pretty_Good_Privacy)

### UUIDs

[UUIDs](https://en.wikipedia.org/wiki/Universally_unique_identifier) are Universally Unique Identifiers. The algorithm resposible for generating them creates almost 0 chance that the ID created has ever been created before - not perfect, but certainly good enough.

There are two concepts worth covering here:

1. Sequential ID numbers (the types of IDs you've been using this whole time) can be a security risk
2. UUIDs are a common replacement for sequential IDs

Interested in more? Read about [UUID as a Postgres data type](https://www.postgresql.org/docs/8.3/static/datatype-uuid.html).

### Secrets

There's not much to define here. Secrets are usually random strings, and they're not to be made public. On their own, secrets don't do much. But they're used to encrypt information, or to prove identity and data integrity.

Secrets like Rails' `SECRET_KEY_BASE` are used to encrypt session data so that clients can't read or tamper with it.

### Signatures

Signatures are made by hashing some data or message along with a secret to prove that the data hasn't been tampered with, and the data came from the right person.

This diagram pretty well illustrates signature creation and verification:

![https://www.tutorialspoint.com/cryptography/images/model_digital_signature.jpg](https://www.tutorialspoint.com/cryptography/images/model_digital_signature.jpg)

### Tokens

Tokens are temporary strings that represent some other data, typically a combination of identity(s) and permissions. That's pretty broad, but there are many types of tokens, and they follow different rules.

- Some tokens are public. It's fine to pass them around to clients and in URLs
- Some tokens are private. They're like keys to unlock access to specific resources.
- Some tokens encode data. The string itself is "decryptable" to get information about what it represents
- Some tokens are arbitrary data. As long as you hold the string, you can use it to identify yourself.

## Attack Types

### [Man-in-the-Middle](https://en.wikipedia.org/wiki/Man-in-the-middle_attack)

Man in the Middle attacks are any attacks that involve modifying the communication between a client and server. They involve a malicious actor listening to traffic between a client and server, and inserting their own data. Ever notice Xfinity putting their logo on your screen while you use their public wifi?

An easy way to prevent against these attacks are to encrypt the traffic. This is why you don't ever see the Xfinity logo on websites you visit using SSL.

### [Replay](https://en.wikipedia.org/wiki/Replay_attack)

Replay attacks store your traffic to play it again later. You encrypted a message to take some action (post a tweet, change settings, buy headphones), and if someone records that message, they can just replay it to cause the same action to happen again.

Prevention of replay attacks typically involve including timestamps in your requests, or [cryptographic nonces](https://en.wikipedia.org/wiki/Cryptographic_nonce) (short for Number Only Used Once)

### [Clickjacking](https://en.wikipedia.org/wiki/Clickjacking)

This is employed on malicious websites to make you do things on other websites. Since you're typically logged in to all of your sites all the time, they will bring other sites into their own website and get you to take actions you probably didn't want to take. Common examples are liking, favoriting or retweeting something you've never heard of.

Here's a video showing off an example of clickjacking: <https://www.youtube.com/watch?v=ZkooSj-SvpE>

Since most clickjacking takes advantage of iframes, a common prevention measure is to prevent the browser from allowing your site to be loaded in an iframe.

### Injection

Injection happens any time instructions are added to what is usually data. It causes your site to execute some instruction while trying to work with data.

The two most common types are SQL injection, and JavaScript injection. Prevention starts with never trusting user input. You can "sanitize" inputs by removing any characters or strings that shouldn't be there. If someone is using SQL in their input, strip it out before sending it to your database. If someone puts `<script>` tags in their post, strip them out.

Most frameworks do these things for you, as long as you don't subvert them. Injection problems typically come up when you're trying to solve some other problem, and you end up working around the protections in place. If you interpolate user input right into commands you send to your database, you're at risk. If you write user content directly to the page without stripping HTML tags, you're at risk.

Click through these to read more about [Rails security](http://guides.rubyonrails.org/security.html) and [Express security](https://expressjs.com/en/advanced/best-practice-security.html).

## Next Steps

Security is best left to security experts, but as a developer, you need to do your best to not leave holes in your application. Learn the best practices, and try to understand new security risks as they become discovered.

If you'd like to continue learning about application security concepts, and learn about best practices for preventing them, check out the [Open Web Application Security Project](https://www.owasp.org/). It's just a wiki, so it can be a little disorganized at times, but it's designed to be a place to learn only what you need to know as a developer, as opposed to learning to be a web security expert.

A great place to start is OWASP's [Top 10 Cheat Sheet](https://www.owasp.org/index.php/OWASP_Top_Ten_Cheat_Sheet).
