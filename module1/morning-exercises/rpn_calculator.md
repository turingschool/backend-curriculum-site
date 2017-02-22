RPN, or Reverse Polish Notation, is a convention for writing arithemetic expressions. Typically, most arithemetic expressions are written as 1 + 2: the operation is in the middle, with arguments (in this case, 1 and 2) on either side. In Polish Notation, this order is changed so that the operation comes before all of the arguments, i.e. `+ 1 2`.

Reverse Polish Notation is almost the same, as Polish Notation, except that the operation comes after all of the arguments, i.e. `1 2 +`

*Your challenge will be to create a simplified calculator for evaluating expressions written in RPN.*

For example:

```
RPN.new.calc("1 2 +")
```

Bonus: If you complete the above, tweak your calculator to be able to handle expressions with more than one operation, i.e. `1 2 3 + -`
