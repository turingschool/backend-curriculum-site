# Mocks & Stubs

---

# Warmup

* Why do we write tests?
* In Black Thursday, how many of your tests are loading CSV data?
* Have you attempted to adjust those tests/your code to not rely on CSV data? Had any luck?

---

# Mocks

* Objects that stand in for other objects.

```ruby
my_mock = mock("paint")
```

---

# Stubs

* Fake method added to or overriding an existing method.

```ruby
my_stub = stub(color: "Alizarin Crimson")
my_mock = mock("paint")
my_mock.stubs(:color).returns("Van Dyke Brown")
paint = Paint.new("Orange")
paint.stubs(:color).returns("Orange")
```

---

# Mock Expectations

* Mocks can also verify that they have been used.

```ruby
my_mock = mock("paint")
my_mock.expects(:color).returns("Van Dyke Brown")
```

---

# Paired Exercise

---

# Check for Understanding

With your partners, teach back the difference between stubs and mocks. Check the [mocha docs](https://github.com/freerange/mocha) for more details.

---

# The Ultimate CFU

* Can you think of a Black Thursday test you've already written that could use mocks and stubs instead?
* When would you use a stub over a mock with expectations and returns?
