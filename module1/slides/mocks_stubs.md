# Mocks & Stubs

---
# Speed (94) Wins

![inline](https://i.pinimg.com/originals/eb/c8/ec/ebc8eca795d22a94231f0091def4ab73.jpg)

^ Computers should be closed

---

# Warmup

- What do they have in common?
- What is different about their jobs?
- Why does the production company hire this double? How does it impact the actors job?
- When you watch a movie, it is usually obvious that a different human is acting a scene out? Does it change your movie-watching experience? Explain.

^ Should have already given into on stunt doubles and directions to google and find images of your favorite action actor.

---

# Learning Goals

* Understand what mocking and stubbing is and why we would use it.

* Have a framework for how/why to use mocks and stubs, but you are not expected to be an expert. You do NOT have to implement these in Cross Check; can if you want to play around with them. Megan and Ian will expect that you have the basics from this lesson down when you walk into Mod2.

^ Touch on what a lot of them are already using - FIXTURES to bring in small CSVs

---


# Step 1: Setup

* What is a gem?
* What does `mocha` do for us?
* How to install

^ Explain what a gem is, what mocha does for us and how to install

---

# Step 1: Setup

* Pick a driver
* Create a bob_ross directory
* Inside, lib and test directories
* Inside, `bob` and `bob_test` files

^ Quick run down of files structure they will be creating

---

# Step 1: Setup

* Make the first two tests pass

NOTE: You should not create a Paint class at any point during this lesson.

^ Slack out directions copy-pasted from lesson to students NOW.

---

# Step 1: Setup

Work with your partner to make the first tests pass.

---

# Step 2: Mocks

Work with your partner to make the first tests pass.

```ruby
def test_it_can_have_paint
  bob = Bob.new
  paint_1 = Paint.new("Alizarin Crimson")
  paint_2 = Paint.new("Van Dyke Brown")

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  assert_equal [paint_1, paint_2], bob.paints
end
```

^ Let's imagine we wanted to test `Bob`'s `paints` method to see that it returns a collection of `Paint` instances. We might write a test like the following. WHAT WOULD WE HAVE TO DO TO MAKE THIS TEST PASS???

---

# Step 2: Mocks

Mocks are objects that stand in for other objects.

^ The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation. You can think of a mock as fake or a dummy object.

---

# Step 2: Mocks

We would have to create a Paint class in order to make this test pass. Instead, we are going to use a Mock object to stand in for a Paint object.

```ruby
paint_1 = mock("paint")
```

---

# Step 2: Mocks

Update this test so that it uses Mocks instead of Paints. Make the test pass.

You can reference the lesson resource to copy and paste the original test!

---

# Step 3: Stubs

**A stub is a fake method.** It can be added to an object that doesn't have that method, or it can override an existing method. We can add a stub to a mock so our fake object will now have a fake method:

```ruby
paint_1 = mock
paint_1.stubs(:color).returns("Van Dyke Brown")
```

^ Now, whenever we call `paint_1.color` it will return `"Van Dyke Brown"`.

---

# Step 3: Stubs

There is another test under Step 3 in the lesson resource. Copy and paste, then modify so that this test so that it stubs out the color method for the Mock objects.

Make the test pass.

---

# Step 4: Expectations

Work with your partner through the expectations section.

You goal is to be able to answer:
- What is the difference between `stubs` and `expects`?
- Why would we want to use `expects`?

---

# Interview Question

What are mocks and stubs? When have you used them?

---


```ruby

logged_in == true

while logged_in
  "Welcome to your account"
end

```
