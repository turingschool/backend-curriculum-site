# Boolean Logic

---

# Warmup

* With a partner in pry, use the method below to check the following values: 1.0, "hello", nil, 0, false, true, "false"

```ruby
def is_it_truthy(value)
  if value
    "#{value} is truthy!"
  else
    "#{value} is falsey!"
  end
end
```

* Research: What values are `falsey` in Ruby?

---

# Truth Tables

* Use a pry session to fill in the table below.

| `a` | `b` | `a AND b` | `a OR b` | `!a` |
| :---: | :---: | :---: | :---: | :---: |
| true | true | true | true | false |
| true | false |  |  |  |
| false | true |  |  |  |
| false | false |  |  |  |

---

# Check Answers

| `a` | `b` | `a AND b` | `a OR b` | `!a` |
| :---: | :---: | :---: | :---: | :---: |
| true | true | true | true | false |
| true | false | false | true | false |
| false | true | false | true | true |
| false | false | false | false | true |

---

# Precedence

[Precedence](https://ruby-doc.org/core-2.4.0/doc/syntax/precedence_rdoc.html) refers to the order of operations which Ruby follows.

```
!
>, >=, <, <=
><=>, ==, ===, !=, =~, !~
&&
||
=, +=, -=, etc.
```

---

# Example

```
false || true && false || false
         \          /
false ||     false     ||  false

             false
```

---

# Practice

What do you expect the following to return? Why?

```ruby
false && false || true
false && (false || true)
```

---

# Complex Practice

For three boolean values (`A`, `B`, `C`), determine the values of the following expressions:

* `(A || B) && (A || C)`
* `(A || !B) || (!A || C)`
* `((A && B) && C) || (B && !A)`
* `((A && B) && !C) || ((A && C) && !B)`

---

# Exercises

See lesson plan.

