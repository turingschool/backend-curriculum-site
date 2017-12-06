# Debugging Techniques

---

# Warmup

* What do you do when you don't know what's going wrong with your application?
* What do you know about `pry`?
* What questions do you still have about `pry`?

---

# Things to Try

* Read your stack trace (find the error).
* Verify your assumptions.
* Try things.

You might add `research` to that list, but generally research is something that you do so that you can try things.

---

# Reading Your Stack Trace

From Erroneous Creatures

```
Error:
HippogriffTest#test_when_moonrock_is_magical_when_collected:
NoMethodError: undefined method `push' for nil:NilClass
    /Users/sespinos/Desktop/erroneous_creatures/hippogriff.rb:14:in `fly'
    /Users/sespinos/Desktop/erroneous_creatures/hippogriff_test.rb:51:in `test_when_moonrock_is_magical_when_collected'`
```

---

# Info in the Stack Trace

* A specific error that was generated (in this case a no method error)
* The file where the error occurred
* The line in that file where the error occurred
* The file/line where the call that caused that error originated (here it's our test file)

---

# Reading a Stack Trace

* Start at the top
* Read carefully (maybe even twice)
* Ignore references to code that you didn't write

---

# Verifying Your Assumptions

* Can be costly not to verify assumptions
* Use pry

```
Error:
HippogriffTest#test_when_it_files_it_collects_a_unique_moonrock:
NoMethodError: undefined method `push' for nil:NilClass
    /Users/sespinos/Desktop/erroneous_creatures/hippogriff.rb:14:in `fly'
    /Users/sespinos/Desktop/erroneous_creatures/hippogriff_test.rb:37:in `test_when_it_files_it_collects_a_unique_moonrock'
```

---

# With a Partner

Review lesson

---

# Trying Things

* Don't just stare at your computer!
* Try things!
* Use pry

```
Failure:
HydraTest#test_it_dies_if_it_loses_all_heads [/Users/sespinos/Desktop/erroneous_creatures/hydra_test.rb:36]:
Expected: true
  Actual: 0
```

---

# With a Partner

* Read the stack trace to determine where the error is occurring.
* Use pry in the test file to verify any assumptions you may have about what's happening.
* Use pry in the Hydra class to see if you can determine how to implement this method before you enter any code into the Hydra class. Ask yourself: how can I get the return value that I want?

---

# Exercise - Erroneous Creatures

