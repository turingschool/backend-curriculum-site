---
layout: page
title: A Quick Class Exploration
---

Generally, when we create a string, we do so with a string literal (we literally type the string as we want it to exist).  This is sufficient to create an object that is an instance of the class [**String**](https://ruby-doc.org/core-2.7.2/String.html), which will respond to any of the build in string methods. We can see this in the pry snippet below:

```ruby
[1] pry(main)> greeting = 'hello world'
=> "hello world"
[2] pry(main)> greeting.class
=> String
[3] pry(main)> greeting.upcase
=> "HELLO WORLD"
```

This is not the only way to create a string object.  You can also create a string object by calling the method `new` on the string class itself:

```ruby
[1] pry(main)> some_text = String.new
=> ""
[2] pry(main)> some_text.class
=> String
[3] pry(main)> some_text.upcase
=> ""
[4] pry(main)> greeting = String.new('hello world')
=> "hello world"
[5] pry(main)> greeting.class
=> String
[6] pry(main)> greeting.upcase
=> "HELLO WORLD"
```

String objects, as a ruby datatype, have this cool ability to be created both literally, and through the method `new`.  When we create our own classes, we will create those class objects through the `new` method - our classes will not have the literal creation superpower :)

Now, back to [defining our own methods...](./methods_and_return_values#define-method)
