## Big O Notation(40 - 55 minutes)
  - I had them discuss the pros and cons in small groups.  I tried to give them context of what would a small startup do, vs a big corporation.
  - Rate these in order of importance.  Tell me why they are important, and any possible pros and cons associated with implementing these items.(10 minutes)
  - Performance - Optimizing for performance  may not matter(Don't preoptimize), could be important if you need a ton of server space and rely on a fast UX
    * Ticket master rant 8 second 4g load time for a interactive map
    * Performance is about $$$$$$$$
  - Testing
    * Sacreligious but may not be important for an MVP app.  You start up is out of runway and you need features!
    * Obvious pros
  - Readable code(well refactored code)
    * May take "extra time" but you get technical debt in the end.
      * What is technical debt and why does it matter?
    * Similar to testing sometimes you just need to get the shit done.
  - Programming is about tradeoffs, if we could have all three above, yay!


- Show code example have them write down how many values get printed(3 minutes)
  * Have them rank 1-3 the fastest to slowest.
  * Big O is the language we use for articulating how long an algorithim takes
```  
## Which of these 3 is the fastest

## O(n2) = Quadratic Time
def print_all_possible_ordered_pairs(array_of_items)
  array_of_items.each do |first_item|
    array_of_items.each do |second_item|
      puts first_item, second_item
    end
  end
end

## O(1) = Contant Time
def print_first_item(array_of_items)
  puts array_of_items[0]
end


## O(n) = Linear Time
def print_all_items(array_of_items)
  array_of_items.each do |item|
    puts item
  end
end
```
- Constant time O(1)
- Linear time 0(n)
- Quadratic time 0(n^2)
- n can either be the size of the collection or a integer
- Maybe show a graph of constant, linear, vs quadractic time

- Should be judged on worse case scenario
- As "n" grows really really large.
- Needle in a haystack
  * Take a minute or two and figure out the worst case scenario and best case scenario.
  * Best case scenario is Constant time worst case is linear time
```
def needle_in_a_haystack(shuffled_array_of_integers, integer_were_looking_for)
  shuffled_array_of_integers.each do |integer|
    return integer if integer == integer_were_looking_for
  end
end
```

- Time complexity vs space complexity
  * All the examples we've been looking at so far have to do with time complexity.
  * When I say something that is stored in memory, what does that mean to you.
  * Space complexity has big o for space complexity as well
    * This does not include the original inputs
```
def say_hi_n_times(n)
  n.times { puts "hi" }
end

def array_of_hi_n_times(n)
  hi_array = []
  n.times { hi_array.push("hi") }
  hi_array
end
```
