---
layout: page
title: CompleteMe
---

## Learning Goals

* Practice breaking a program into logical components
* Testing components in isolation and in combination
* Applying Enumerable techniques in a real context
* Reading text from and writing text to files

## CompleteMe

Everyone in today's smartphone-saturated world has had their
share of interactions with textual "autocomplete." You
may have sometimes even wondered if autocomplete is
worth the trouble, given the ridiculous completions it
sometimes attempts.

But how would you actually __make__ an autocomplete system?

In this project, __CompleteMe__ we'll be exploring this idea by
a simple textual autocomplete system. Perhaps in the process we will develop
some sympathy for the developers who built the seemingly
incompetent systems on our phones...

### Data Structure -- Introduction to Tries

A common way to solve this problem is using a data structure
called a __Trie__. The name comes from the idea of a Re-trie-val
tree, and it's useful for storing and then fetching paths through
arbitrary (often textual) data.

A Trie is somewhat similar to the binary trees you may have seen before,
but whereas each node in a binary tree points to up to 2 subtrees,
nodes within our retrieval tries will point to `N` subtrees, where `N`
is the size of the alphabet we want to complete within.

Thus for a simple latin-alphabet text trie, each node will potentially
have 26 children, one for each character that could potentially follow
the text entered thus far.
(In graph theory terms, we could classify this as a Directed, Acyclic
graph of order 26, but hey, who's counting?)

What we end up with is a broadly-branched tree where paths from the
root to the leaves represent "words" within the dictionary.

Take a moment and read more about Tries:

* [Tries writeup in the DSA Repo](https://github.com/turingschool/data_structures_and_algorithms/tree/master/tries)
* [Tries Wikipedia Article](https://en.wikipedia.org/wiki/Trie)

### Input File

Of course, our Trie won't be very useful without a good dataset
to populate it. Fortunately, our computers ship with a special
file containing a list of standard dictionary words.
It lives at `/usr/share/dict/words`

Using the unix utility `wc` (word count), we can see that the file
contains 235886 words:

```
$ cat /usr/share/dict/words | wc -l
235886
```

Should be enough for us!

### Required Features

To complete the project, you will need to build an autocomplete
system which provides the following features:

1. Insert a single word to the autocomplete dictionary
2. Count the number of words in the dictionary
3. Populate a newline-separated list of words into the dictionary
4. Suggest completions for a substring
5. Mark a selection for a substring
6. Weight subsequent suggestions based on previous selections

### Basic Interaction Model

We'll expect to interact with your completion project from an interactive
pry session, following a model something like this:

```ruby
# open pry from root project directory
require "./lib/complete_me"

completion = CompleteMe.new

completion.insert("pizza")

completion.count
=> 1

completion.suggest("piz")
=> ["pizza"]

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.count
=> 235886

completion.suggest("piz")
=> ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]
```

### Usage Weighting

The common gripe about autocomplete systems is that they give us
suggestions that are technically valid but not at all what we wanted.

A solution to this problem is to "train" the completion dictionary
over time based on the user's actual selections. So, if a user
consistently selects "pizza" in response to completions for "pizz",
it probably makes sense to recommend that as their first suggestion.

To facilitate this, your library should support a `select` method,
which takes a substring and the selected suggestion. You
will need to record this selection in your trie and use it
to influence future selections to make.

Here's what that interaction model should look like:


```ruby
require "./lib/complete_me"

completion = CompleteMe.new

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.suggest("piz")
=> ["pize", "pizza", "pizzeria", "pizzicato", "pizzle", ...]

completion.select("piz", "pizzeria")

completion.suggest("piz")
=> ["pizzeria", "pize", "pizza", "pizzicato", "pizzle", ...]

```

### Substring-Specific Selection Tracking

A simple approach to tracking selections would be to simply
"count" the number of times a given word is selected
(e.g. "pizza" - 4 times, etc). But a more sophisticated solution
would allow us to track selection information _per completion string_.

That is, we want to make sure that when `select`ing a given word,
that selection is only counted toward subsequent suggestions against
the same substring. Here's an example:

```
require "./lib/complete_me"

completion = CompleteMe.new

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.select("piz", "pizzeria")
completion.select("piz", "pizzeria")
completion.select("piz", "pizzeria")

completion.select("pi", "pizza")
completion.select("pi", "pizza")
completion.select("pi", "pizzicato")

completion.suggest("piz")
=> ["pizzeria", "pize", "pizza", "pizzicato", "pizzle", ...]

completion.suggest("pi")
=> ["pizza", "pizzicato", "pize", "pizzeria", "pizzle", ...]
```

In this example, against the substring "piz" we choose
"pizzeria" 3 times, making it the dominant choice for this
substring.

However for the substring "pi", we choose "pizza" twice and
"pizzicato" once. The previous selections of "pizzeria" against
"piz" don't count when suggesting against "pi", so now "pizza"
and "pizzicato" come up as the top choices.

### Word Deletion and Tree Pruning

Let's add a feature that let's us delete words from the tree.
When deleting a node, we'll need to consider a couple of cases.

First, make sure that we adjust our tree so that the node relating to
the removed word is no longer seen as a valid word. This means
that subsequent suggestions should no longer return it as a match for
any of its substrings.

For "intermediate" nodes (i.e. nodes that still have
children below them), this is all you need to do.

However, for **leaf nodes** (i.e. nodes at the end of the tree), we
will also want to **completely remove** those nodes from the tree.
Since the node in question no longer represents a word and there
are no remaining nodes below it, there's no point in keeping it in the
tree, so we should remove it.

**Additionally**, once we remove this node, we would also want to
remove any of its parents for which it was the only child. That is --
if, once we remove our word in question, the node above it is now
a path to nowhere, we should also remove that node. This process would
repeat up the chain until we finally reach "word" node that we want
to keep around.

The exact implementation of this process will depend on how your
tree is built, so we likely won't include it in the spec harness. You
will need to provide your own tests that demonstrate this functionality.


## Spec Harness

This is the first project where we'll use an automated spec harness
to evaluate the correctness of your projects.

For this reason, you'll want to make sure to follow the
top-level interface described in the previous sections
closely.

You can structure the internals of your program however you like,
but if the top level interface does not match, the
spec harness will be unable to evaluate your work.

Spec harness available [here](https://github.com/turingschool-examples/complete_me_spec_harness/blob/master/test/complete_me_test.rb).

## Support Tooling

Please make sure that, before your evaluation, your project has the following:

* [SimpleCov](https://github.com/colszowka/simplecov) reporting accurate test coverage statistics
* [HoundCI](https://houndci.com/) Pull Request based linter.

## Supporting Features

In addition to the base features included above, you must choose **two** of the following to implement:


### 1. Denver Addresses

Working with words was interesting, but what about a bigger dataset? Check out [this data file](http://data.denvergov.org/dataset/city-and-county-of-denver-addresses) (you'll want the CSV version) that contains all the known addresses in the city of Denver. Use the `full_address` field that's last in the row. Can you make your autocomplete work with that dataset?

### 2. Substrings

Could your word lookup possibly handle middle-of-the-word matches? So that `com` would list both the possibilities `complete` and `incomplete`? How does this change the memory requirements of your running program?

### 3. Visual Interface

Can you create a graphical user interface for your code? Something that a "normal person" might plausibly use? Consider a toolkit like [Shoes](http://shoesrb.com/) or [Ruby Processing](https://github.com/jashkenas/ruby-processing).



## Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

**Expectations:**

### 1. Ruby Syntax & Style

* Applies appropriate attribute encapsulation  
* Developer creates instance and local variables appropriately
* Naming follows convention (is idiomatic)
* Ruby methods used are logical and readable  
* Recursion is implemented logically
* Developer implements appropriate enumerable methods (#each is used sparingly)
* Code is indented properly
* Code does not exceed 80 characters per line 
* Each class has correctly-named files and corresponding test files in the proper directories

### 2. Breaking Logic into Components

* Code is effectively broken into methods & classes 
* Developer writes methods less than 8 lines 
* No more than 3 methods break the principle of SRP 

### 3. Test-Driven Development

* Each method is tested  
* Functionality is accurately covered
* Tests implement Ruby syntax & style   
* Balances unit and integration tests 
* Evidence of edge cases testing 
* Test Coverage metrics are present (SimpleCov)

### 4. Git Workflow

* Repository demonstrates that each member of team has contributed fairly equally.
* Developers commit at a rate of approximately one commit every 30 minutes.
* Repository shows the use of branches.
* Developers use a pull request workflow.
* Developers resolve HoundCI complaints in their pull requests.

### 5. Functionality

* Application meets all requirements (extension not req'd)

