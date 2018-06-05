---
layout: page
title: Intermediate Enumerables
length: 120
tags: enumerables, max, min, max_by, min_by, sort_by
---

## Learning Goals

* Understand how to use `max`, `max_by,` their opposites, and `sort_by` appropriately.

## Structure

5 min - Warm up/  Move to groups
5-10 min - Introduce topic
20 min - Recreate with `.each`
5 min - Break
25 min - Work on Presentation
5 min - Break
25 min - Presentations
5 min - Break
25 min - Instructor recap


### min / max

What would we do if we wanted to take the smallest thing out of an array?

Let's think about how we would do that with .each.

```ruby
  def max(array)
    result = array.first
    array.each do |num|
      result = num if num > result

    end

    result
  end

  max ([1,3,2,4,5])


[1,3,2,5,4].max
```

### max_by / min_by

```ruby
  def max_by(people)
    result = people.first
    people.each do |person|
      result = person if person.age > result.age
    end
  end


  people.max_by do |person|
    person.age
  end
```

### sort_by

```ruby
  [2,4,3,1].sort_by do |num|
    num
  end
```


### Other Enumerables

#all? #none? #one? #any?
