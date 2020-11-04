# Automating repeated things {#functional_programming}

> Anything that can be automated should be automated. Do as little as possible by hand. Do as much as possible with functions. 
- Hadley Wickham

## Flow control 

* Control structures = putting logic in code to control flow (e.g., `if`, `else`, `for`, `while`, `repeat`, `break`, `next`)

* Almost all the conditional operators used in Python also work in R. The basic loop set up is also very similar, with some small syntax adjustments. 

* ```if()``` is a function whose arguments must be specified inside parentheses.

* ```else```, however, is a reserved operator that takes no arguments. Note that there is no ```elif``` option --- one simply writes ```else if()```.  

* Whereas operations to be executed after conditional evaluations in Python come after a ```:```, R operations must only be enclosed in curly brackets: ```{}```.  Furthermore, there is no requirement for indentation. 


```r
x <- 5

if(x < 0){ # Condition 
  print("x is negative") # Do something 
} 

x <- -5

if(x < 0){
  print("x is negative")
}
```

```
## [1] "x is negative"
```

```r
x <- 5

if(x < 0){
  print("x is negative")
} else{
  print("x is positive")
}
```

```
## [1] "x is positive"
```

```r
x <- 0

if(x < 0){ # Condition 
  print("x is negative") # Do something 
} else if(x == 0){ 
  print("x is zero") # Do something else 
} else { print("x is positive") # Do something else 
}
```

```
## [1] "x is zero"
```
R also does some class coercion that makes Boolean evaluations harder to break than in Python.  But be careful --- R has a set of special coercion used for fast logical evaluation and subsetting.  Specifically, ```TRUE``` is considered equal to ```1```, while ```FALSE``` is equal to ```0```. The Boolean logicals can also be specified as a full word in all caps, or simply as ```T``` or ```F```.


```r
1 < 2
```

```
## [1] TRUE
```

```r
"1" < 2
```

```
## [1] TRUE
```

```r
"a" < 2
```

```
## [1] FALSE
```

```r
TRUE < 2
```

```
## [1] TRUE
```

```r
TRUE == "TRUE"
```

```
## [1] TRUE
```

```r
T == "TRUE"
```

```
## [1] TRUE
```

```r
TRUE == "T"
```

```
## [1] FALSE
```

```r
TRUE == "FALSE"
```

```
## [1] FALSE
```

```r
TRUE == 0
```

```
## [1] FALSE
```

```r
TRUE == 1
```

```
## [1] TRUE
```

```r
FALSE == 0
```

```
## [1] TRUE
```

```r
FALSE <= 1
```

```
## [1] TRUE
```

### Functions 

While functions are defined in Python using the ```def``` reserved operator, R sees functions as just another type of named object.  Thus, they require explicit assignment to an object.  This is done using the function ```function()```, which creates a function taking the arguments specified in parentheses.  

function = input + computation (begin -> end) + output 


```r
simple.function <- function(x){
  print(x + 1)
}

simple.function(x = 2)
```

```
## [1] 3
```

```r
less.simple.function <- function(x, y){
  print(x - y + 1)
}

less.simple.function(x = 2, y = 10)
```

```
## [1] -7
```

With respect to returning function output, most of the same rules apply as with Python. Be sure to remember that ```return()``` will only process a single object, so multiple items must usually be returned as a list. Note that your ordering of the functions matters, too. 


```r
dumbfun <- function(x){
  return(x)
  print("This will never print :(")
}

dumbfun(x = "something")
```

```
## [1] "something"
```

```r
dumbfun <- function(x){
  print("Why did I print?")
  return(x)
}

dumbfun(x = "something")
```

```
## [1] "Why did I print?"
```

```
## [1] "something"
```

```r
dumbfun <- function(x,y){
  thing1 <- x
  thing2 <- y
  return(list(thing1, thing2))
}

dumbfun(x = "some text", y = "some data")
```

```
## [[1]]
## [1] "some text"
## 
## [[2]]
## [1] "some data"
```

```r
dumbfun(x = c(5,10,15), y = "some data")
```

```
## [[1]]
## [1]  5 10 15
## 
## [[2]]
## [1] "some data"
```

R functions also allow you to set default argument values:


```r
less.simple.function <- function(x, y = 0){
  print(x - y + 1)
}

less.simple.function(x = 2)
```

```
## [1] 3
```

```r
less.simple.function(x = 2, y = 10)
```

```
## [1] -7
```

With respect to specifying arguments, one can either use argument **position** specifications (i.e., the order) or argument **name** specifications.  The latter is strongly preferred, as it is very easy to accidentally specify incorrect argument values.


```r
send <- function(message, recipient, cc=NULL, bcc=NULL){
  print(paste(message, recipient, sep = ", "))
  print(paste("CC:", cc, sep = " "))
  print(paste("BCC:", bcc, sep = " "))
}

send(message = "Hello", recipient = "World", cc = "Sun", bcc = "Jane")
```

```
## [1] "Hello, World"
## [1] "CC: Sun"
## [1] "BCC: Jane"
```

```r
send("Hello", "World", "Sun", "Jane")
```

```
## [1] "Hello, World"
## [1] "CC: Sun"
## [1] "BCC: Jane"
```

```r
send("Hello", "Sun", "Jane", "World")
```

```
## [1] "Hello, Sun"
## [1] "CC: Jane"
## [1] "BCC: World"
```

```r
send(message = "Hello", cc = "Sun", bcc = c("Jane", "Rochelle"), recipient = "World")
```

```
## [1] "Hello, World"
## [1] "CC: Sun"
## [1] "BCC: Jane"     "BCC: Rochelle"
```

Also, note that functions don't have what CS people called side-effects. Functions only define local variables = They don't change objects stored in the global environment. (Consider the difference between `<-` and `=` for assignments.) That's why you can use functions for reusable tasks since it does not interrupt other important things in your system.

See [the following example](https://darrenjw.wordpress.com/2011/11/23/lexical-scope-and-function-closures-in-r/) from Wilkinson.


```r
a = 1 
b = 2

f <- function(x)
{
  a*x + b
}

f(2)
```

```
## [1] 4
```

```r
g <- function(x)
{
  a = 2
  b = 1
  f(x)
}

g(2) # a equals still 1 
```

```
## [1] 4
```
**Additional tips**

* Nonstandard evaluation 

Nonstandard evaluation is an advanced subject. If you feel overwhelmed, you are more than welcome to skip this. But if you are serious in R programming, this is something you want to check out. For deeper understanding of this issue, I recommend reading [Ren Kun's very informative blog post](https://renkun.me/2014/12/03/tips-on-non-standard-evaluation-in-r/) carefully. 

This part draws on one of the [the dplyr package articles](https://dplyr.tidyverse.org/articles/programming.html.

In tidyverse, calling a variable with or without quotation mark (string or not) does make little difference because tidyeval is a type of non-standard evaluation. This flexibility runs into the following problem when it comes to programming. 






























































































































