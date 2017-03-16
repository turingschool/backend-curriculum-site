We are going to start this conversation about scope and variables first by talking about methods.

Let's start by taking ten minutes minutes to write some thoughts and feelings down in our notebooks.

* What is a method?
* How do we use methods?
* When do we think we should use methods?
* What are some of the other uses or benefits of methods?

Now, find the person next to you, the taller person will share the first two questions with their new best friend, and the shorter person will explain their thoughts about the last two.

If you are the same height, rock paper scissors will suffice. (Evens and Odds are also acceptable.)

A Ruby method is used to bundle one oe more repeatable statements into a single unit. You might want to think about it as a sort of variable.

Let's start off by writing a method.

```
def hello
	puts "HELLO THERE"
end
```

And this is the basic format of what a method looks like. `def` tells us that this is a method, then we have the name of the method, the contents of the method, and we use end to signal that we have reached the end of the method.

A side note that I want to make here is that rules and conventions concerning method names are just like that involving variables. Example, you don't do

```
def Hello
	puts "HELLO THERE"
end
```

And you don't do something like this:

```
def hello_method
	puts "HELLO THERE"
end
```

We then use this method that we have defined by simply calling its name.

```
hello
```

What we can also do with methods is pass it information. When we do so, we have to set up our method so that it can accept the information and use it. So we have above a method that simply says hello. What if we want to be a little more personal?

```
def hello(name)
	puts "Hello, #{name}."
end

hello("Alice")
```



