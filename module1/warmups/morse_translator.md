## Morse Translator  

Build a Ruby program that translates a message from English to Morse.  
** Hint **   
Use a hash as your dictionary   

### Iteration 0 
Translate English to Morse  
lowercase letters

```ruby 
  $ translator = Translate.new 
  => #<Translate:0x007fa1ab98cac0>
  $ translator.eng_to_morse("hello world") 
  => "......-...-..--- .-----.-..-..-.."
```

### Iteration 1  
Translate case insensitive, with numbers and spaces  

```ruby 
  $ translator = Translate.new 
  => #<Translate:0x007fa1ab98cac0>
  $ translator.eng_to_morse("Hello World") 
  => "......-...-..--- .-----.-..-..-.."
```

### Iteration 2  
Translate from a file  
`input.txt`
```
I am in a file
```

```ruby 
$ translator = Translate.new 
=> #<Translate:0x007fa1ab98cac0>
$translator.from_file("input.txt")
=> ".. .--- ..-. .- ..-....-..."
```
