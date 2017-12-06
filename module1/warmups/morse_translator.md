## Morse Translator  
Using this [repo](https://github.com/turingschool-examples/morse_translator), build a well tested Ruby program that translates a message from English to Morse Code.  
** Hint **   
Use a hash as your dictionary   

## Submission instructions

1. Fork the repo above
2. Clone your fork
3. Push your solution to your fork
4. Use Github's interface to create a pull request

### Iteration 0 
Translate English to Morse Code    
* lowercase letters

```ruby 
  $ translator = Translate.new 
  => #<Translate:0x007fa1ab98cac0>
  $ translator.eng_to_morse("hello world") 
  => "......-...-..--- .-----.-..-..-.."
```

### Iteration 1  
Translate English to Morse Code  
* case insensitive, with numbers  

```ruby 
  $ translator = Translate.new 
  => #<Translate:0x007fa1ab98cac0>
  $ translator.eng_to_morse("Hello World") 
  => "......-...-..--- .-----.-..-..-.."
  $ translator.eng_to_morse("There are 3 ships") 
  => "-......-.. .-.-.. ...-- ..........--...."
```

### Iteration 2  
Translate English to Morse Code  
* from a file  

```
# in input.txt
I am in a file
```

```ruby 
  $ translator = Translate.new 
  => #<Translate:0x007fa1ab98cac0>
  $translator.from_file("input.txt")
  => ".. .--- ..-. .- ..-....-..."
```

### Iteration 3 
Translate Morse Code to English  

```ruby 
  $ translator = Translate.new 
  => #<Translate:0x007fa1ab98cac0>
  $ translator.morse_to_eng(".... . .-.. .-.. ---  .-- --- .-. .-.. -..") 
  => "hello world"
```

