# Mixins

---

# Warmup

* What do you know about modules already? If little, what would you guess modules are all about?
* Football and soccer both use a ball, but each has its own attributes. What behaviors might they share?

---

# Introduction

* Mixins allow us to share behavior between classes
* Ruby implements mixins with Modules
* Modules only store behavior
* Modules *do not* store state

---

# GrubHubOrder

```ruby
class GrubhubOrder
  def confirmation(thing)
    puts "You got #{thing}."
  end

  def review
    puts "Please rate your order within 30 days."
  end

  def delivery
    puts "Your food will arrive in 45-60 minutes."
  end
end
```

---

# AmazonOrder

```ruby
class AmazonOrder
  def confirmation(thing)
    puts "You got #{thing}."
  end

  def review
    puts "Please rate your order within 30 days."
  end

  def delivery
    puts "Your order will arrive in 2 business days."
  end
end
```

---

# OnlineRunner

```ruby
require "./amazon_order.rb"
require "./grubhub_order.rb"

amazon = AmazonOrder.new
grub   = GrubHubOrder.new

amazon.delivery
grub.delivery

amazon.review
grub.review
```

---

# Discuss

How might we use a mixin to make this code better?

---

# OnlineOrder

```ruby
module OnlineOrder
  def confirmation(thing)
    puts "You got #{thing}."
  end

  def review
    puts "Please rate your order within 30 days."
  end
end
```

---

# GrubHubOrder

```ruby
require "./online_order"

class Grubhub
  include OnlineOrder

  def delivery
    puts "Your food will arrive in 45-60 minutes."
  end
end
```

---

# AmazonOrder

```ruby
require "./online_order"

class Amazon
  include OnlineOrder

  def delivery
    puts "Your order will arrive in 2 business days."
  end
end
```

---

# Discuss

What will happen when I run my runner file now?

---

# Exercise & Further Practice

See lesson plan.
