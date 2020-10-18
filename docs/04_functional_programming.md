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

### for loop 

Loops in R also work basically the same way as in Python, with just a few adjustments.  First, recall that index positions in R start at 1.  Second, ```while()``` and ```for()``` are functions rather than reserved operators, meaning they must take arguments in parentheses.  Third, just like ```else```, the ```in``` operator *is* reserved and takes no arguments in parentheses.  Fourth, the conditional execution must appear between curly brackets.  Finally, indentation is meaningless, but each new operation must appear on a new line.

- `while()`: when we have no idea how many times loop needs to be executed.
- `for()`: when we know how many times loop needs to be executed. This is likely to be the loop you are going to use most frequently. 


```r
fruits <- c("apples", "oranges", "pears", "bananas")

# a while loop
i <- 1
while(i <= length(fruits)){
  print(fruits[i])
  i <- i + 1
}
```

```
## [1] "apples"
## [1] "oranges"
## [1] "pears"
## [1] "bananas"
```

```r
# a for loop
for(i in 1:length(fruits)){
  print(fruits[i])
}
```

```
## [1] "apples"
## [1] "oranges"
## [1] "pears"
## [1] "bananas"
```

### apply family 

While and for loops in R can be very slow. For this reason, R has a number of built-in iteration methods to speed up execution times. In many cases, packages will have "behind-the-scenes" ways to avoid for loops, but what if you need to write your own function? 

A common method of getting around for loops is the **apply** family of functions. These take a data structure and a function, and applies a function over all the elements in the object.


```r
fruit <- c("apple", "orange", "pear", "banana")

# make function that takes in only one element
make.plural <- function(x){
   plural <- paste(x, 's', sep = '') # sep is for collapse, so collpase ''
   return(plural)
}

make.plural('apple')
```

```
## [1] "apples"
```

* `apply()` : loop over the margins (1 = row, 2 = column) of an array 
* `lapply()` : loop over a list then returns a list 
* `sapply()` : loop over a list then returns a named vector 
* `tapply()`: loop over subsets of a vector 
* `mapply()`: multivariate version of `lapply()`. Use this if you have a function that takes in 2 or more arguments.



```r
# apply that function to every element
lapply(fruit, make.plural) # returns a list
```

```
## [[1]]
## [1] "apples"
## 
## [[2]]
## [1] "oranges"
## 
## [[3]]
## [1] "pears"
## 
## [[4]]
## [1] "bananas"
```

```r
sapply(fruit, make.plural) # returns a named vector
```

```
##     apple    orange      pear    banana 
##  "apples" "oranges"   "pears" "bananas"
```

```r
library(purrr) # load package
map(fruit, make.plural) # type consistent
```

```
## [[1]]
## [1] "apples"
## 
## [[2]]
## [1] "oranges"
## 
## [[3]]
## [1] "pears"
## 
## [[4]]
## [1] "bananas"
```


```r
# Why sapply is bad 

sapply(1:100, paste) # return character 
```

```
##   [1] "1"   "2"   "3"   "4"   "5"   "6"   "7"   "8"   "9"   "10"  "11"  "12" 
##  [13] "13"  "14"  "15"  "16"  "17"  "18"  "19"  "20"  "21"  "22"  "23"  "24" 
##  [25] "25"  "26"  "27"  "28"  "29"  "30"  "31"  "32"  "33"  "34"  "35"  "36" 
##  [37] "37"  "38"  "39"  "40"  "41"  "42"  "43"  "44"  "45"  "46"  "47"  "48" 
##  [49] "49"  "50"  "51"  "52"  "53"  "54"  "55"  "56"  "57"  "58"  "59"  "60" 
##  [61] "61"  "62"  "63"  "64"  "65"  "66"  "67"  "68"  "69"  "70"  "71"  "72" 
##  [73] "73"  "74"  "75"  "76"  "77"  "78"  "79"  "80"  "81"  "82"  "83"  "84" 
##  [85] "85"  "86"  "87"  "88"  "89"  "90"  "91"  "92"  "93"  "94"  "95"  "96" 
##  [97] "97"  "98"  "99"  "100"
```

```r
sapply(integer(), paste) # return list!
```

```
## list()
```

```r
library(purrr)
map(1:100, paste) # return list
```

```
## [[1]]
## [1] "1"
## 
## [[2]]
## [1] "2"
## 
## [[3]]
## [1] "3"
## 
## [[4]]
## [1] "4"
## 
## [[5]]
## [1] "5"
## 
## [[6]]
## [1] "6"
## 
## [[7]]
## [1] "7"
## 
## [[8]]
## [1] "8"
## 
## [[9]]
## [1] "9"
## 
## [[10]]
## [1] "10"
## 
## [[11]]
## [1] "11"
## 
## [[12]]
## [1] "12"
## 
## [[13]]
## [1] "13"
## 
## [[14]]
## [1] "14"
## 
## [[15]]
## [1] "15"
## 
## [[16]]
## [1] "16"
## 
## [[17]]
## [1] "17"
## 
## [[18]]
## [1] "18"
## 
## [[19]]
## [1] "19"
## 
## [[20]]
## [1] "20"
## 
## [[21]]
## [1] "21"
## 
## [[22]]
## [1] "22"
## 
## [[23]]
## [1] "23"
## 
## [[24]]
## [1] "24"
## 
## [[25]]
## [1] "25"
## 
## [[26]]
## [1] "26"
## 
## [[27]]
## [1] "27"
## 
## [[28]]
## [1] "28"
## 
## [[29]]
## [1] "29"
## 
## [[30]]
## [1] "30"
## 
## [[31]]
## [1] "31"
## 
## [[32]]
## [1] "32"
## 
## [[33]]
## [1] "33"
## 
## [[34]]
## [1] "34"
## 
## [[35]]
## [1] "35"
## 
## [[36]]
## [1] "36"
## 
## [[37]]
## [1] "37"
## 
## [[38]]
## [1] "38"
## 
## [[39]]
## [1] "39"
## 
## [[40]]
## [1] "40"
## 
## [[41]]
## [1] "41"
## 
## [[42]]
## [1] "42"
## 
## [[43]]
## [1] "43"
## 
## [[44]]
## [1] "44"
## 
## [[45]]
## [1] "45"
## 
## [[46]]
## [1] "46"
## 
## [[47]]
## [1] "47"
## 
## [[48]]
## [1] "48"
## 
## [[49]]
## [1] "49"
## 
## [[50]]
## [1] "50"
## 
## [[51]]
## [1] "51"
## 
## [[52]]
## [1] "52"
## 
## [[53]]
## [1] "53"
## 
## [[54]]
## [1] "54"
## 
## [[55]]
## [1] "55"
## 
## [[56]]
## [1] "56"
## 
## [[57]]
## [1] "57"
## 
## [[58]]
## [1] "58"
## 
## [[59]]
## [1] "59"
## 
## [[60]]
## [1] "60"
## 
## [[61]]
## [1] "61"
## 
## [[62]]
## [1] "62"
## 
## [[63]]
## [1] "63"
## 
## [[64]]
## [1] "64"
## 
## [[65]]
## [1] "65"
## 
## [[66]]
## [1] "66"
## 
## [[67]]
## [1] "67"
## 
## [[68]]
## [1] "68"
## 
## [[69]]
## [1] "69"
## 
## [[70]]
## [1] "70"
## 
## [[71]]
## [1] "71"
## 
## [[72]]
## [1] "72"
## 
## [[73]]
## [1] "73"
## 
## [[74]]
## [1] "74"
## 
## [[75]]
## [1] "75"
## 
## [[76]]
## [1] "76"
## 
## [[77]]
## [1] "77"
## 
## [[78]]
## [1] "78"
## 
## [[79]]
## [1] "79"
## 
## [[80]]
## [1] "80"
## 
## [[81]]
## [1] "81"
## 
## [[82]]
## [1] "82"
## 
## [[83]]
## [1] "83"
## 
## [[84]]
## [1] "84"
## 
## [[85]]
## [1] "85"
## 
## [[86]]
## [1] "86"
## 
## [[87]]
## [1] "87"
## 
## [[88]]
## [1] "88"
## 
## [[89]]
## [1] "89"
## 
## [[90]]
## [1] "90"
## 
## [[91]]
## [1] "91"
## 
## [[92]]
## [1] "92"
## 
## [[93]]
## [1] "93"
## 
## [[94]]
## [1] "94"
## 
## [[95]]
## [1] "95"
## 
## [[96]]
## [1] "96"
## 
## [[97]]
## [1] "97"
## 
## [[98]]
## [1] "98"
## 
## [[99]]
## [1] "99"
## 
## [[100]]
## [1] "100"
```

```r
map(integer(), paste) # return list
```

```
## list()
```

## purrr

- Setup 


```r
# Install packages
if (!require("pacman")) {
  install.packages("pacman")
}
```

```
## Loading required package: pacman
```

```r
pacman::p_load(
  tidyverse, # tidyverse pkgs including purrr
  tictoc, # performance test
  broom, # tidy modeling
  glue, # paste string and objects
  furrr, # parallel processing
  rvest, # web scraping
  devtools, # dev tools 
  usethis, # workflow     
  roxygen2, # documentation 
            
  testthat) # testing 
```

### Why map? 

#### Objectives 

- How to use `purrr` to automate workflow in a cleaner, faster, and more extendable way

#### Copy-and-paste programming 

> Copy-and-paste programming, sometimes referred to as just pasting, is the production of highly repetitive computer programming code, as produced by copy and paste operations. It is primarily a pejorative term; those who use the term are often implying a lack of programming competence. It may also be the result of technology limitations (e.g., an insufficiently expressive development environment) as subroutines or libraries would normally be used instead. However, there are occasions when copy-and-paste programming is considered acceptable or necessary, such as for boilerplate, loop unrolling (when not supported automatically by the compiler), or certain programming idioms, and it is supported by some source code editors in the form of snippets. - Wikipedia 

- The following exercise was inspired by [Wickham's example](http://adv-r.had.co.nz/Functional-programming.html).

- Let's imagine `df` is a survey dataset. 

    - `a, b, c, d` = Survey questions 

    - `-99`: non-responses 
    
    - Your goal: replace `-99` with `NA` 
    

```r
# Data

set.seed(1234) # for reproducibility

df <- tibble(
  "a" = sample(c(-99, 1:3), size = 5, replace = TRUE),
  "b" = sample(c(-99, 1:3), size = 5, replace = TRUE),
  "c" = sample(c(-99, 1:3), size = 5, replace = TRUE),
  "d" = sample(c(-99, 1:3), size = 5, replace = TRUE)
)
```


```r
# Copy and paste
df$a[df$a == -99] <- NA
df$b[df$b == -99] <- NA
df$c[df$c == -99] <- NA
df$d[df$d == -99] <- NA

df
```

```
## # A tibble: 5 x 4
##       a     b     c     d
##   <dbl> <dbl> <dbl> <dbl>
## 1     3     3     3     1
## 2     3     2     3     1
## 3     1    NA     1     2
## 4     1    NA     2     1
## 5    NA     1     1     3
```

- **Challenge**. Explain why this solution is not very efficient (Hint: If `df$a[df$a == -99] <- NA` has an error, how are you going to fix it? A solution is not scalable if it's not automatable.

#### Using a function 

- Let's recall what's function in R: `input + computation + output` 

- If you write a function, you gain efficiency because you don't need to copy and paste the computation part. 

`
function(input){
  
  computation 
  
  return(output)
}
`


```r
# Function

fix_missing <- function(x) {
  x[x == -99] <- NA
  x
}

# Apply function to each column (vector)

df$a <- fix_missing(df$a)
df$b <- fix_missing(df$b)
df$c <- fix_missing(df$c)
df$d <- fix_missing(df$d)

df
```

```
## # A tibble: 5 x 4
##       a     b     c     d
##   <dbl> <dbl> <dbl> <dbl>
## 1     3     3     3     1
## 2     3     2     3     1
## 3     1    NA     1     2
## 4     1    NA     2     1
## 5    NA     1     1     3
```

- **Challenge** Why using function is more efficient than 100% copying and pasting? Can you think about a way we can automate the process?

- Many options for automation in R: `for loop`, `apply` family, etc. 

- Here's a tidy solution comes from `purrr` package.

- The power and joy of one-liner. 


```r
df <- purrr::map_df(df, fix_missing)

df
```

```
## # A tibble: 5 x 4
##       a     b     c     d
##   <dbl> <dbl> <dbl> <dbl>
## 1     3     3     3     1
## 2     3     2     3     1
## 3     1    NA     1     2
## 4     1    NA     2     1
## 5    NA     1     1     3
```

`map()` is a [higher-order function](https://en.wikipedia.org/wiki/Map_(higher-order_function)) that applies a given function to each element of a list/vector. 

![This is how map() works. It's easier to understand with a picture.](https://d33wubrfki0l68.cloudfront.net/f0494d020aa517ae7b1011cea4c4a9f21702df8b/2577b/diagrams/functionals/map.png)

    - Input: Takes a vector/list. 
    
    - Computation: Calls the function once for each element of the vector 
  
    - Output: Returns in a list or whatever data format you prefer (e.g., `_df helper: dataframe`)

- **Challenge** If you run the code below, what's going to be the data type of the output?


```r
map(df, fix_missing)
```

```
## $a
## [1]  3  3  1  1 NA
## 
## $b
## [1]  3  2 NA NA  1
## 
## $c
## [1] 3 3 1 2 1
## 
## $d
## [1] 1 1 2 1 3
```

- Why `map()` is a good alternative to `for loop`. 

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/bzUmK0Y07ck" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p>The Joy of Functional Programming (for Data Science) - Hadley Wickham</p>
```


```r
# Built-in data
data("airquality")

tic()

# Placeholder
out1 <- vector("double", ncol(airquality))
# Sequence variable
for (i in seq_along(airquality)) { #

  # Assign a computation result to each element
  out1[[i]] <- mean(airquality[[i]], na.rm = TRUE)
}
toc()
```

```
## 0.006 sec elapsed
```


```r
tic()
out1 <- airquality %>% map_dbl(mean, na.rm = TRUE)
toc()
```

```
## 0.002 sec elapsed
```

- In short, `map()` is more readable, faster, and easily extendable with other data science tasks (e.g., wrangling, modeling, and visualization) using `%>%`. 

- Final point: Why not base R `apply` family? 

- Short answer: `purrr::map()` is simpler to write. For instance, 

`map_dbl(x, mean, na.rm = TRUE)` = `vapply(x, mean, na.rm = TRUE, FUN.VALUE = double(1))`

#### Application (many models)

- One popular application of `map()` is to run regression models (or whatever model you want to run) on list-columns. No more copying and pasting for running many regression models on subgroups!


```r
# Have you ever tried this?
lm_A <- lm(y ~ x, subset(data, subgroup == "group_A"))
lm_B <- lm(y ~ x, subset(data, subgroup == "group_B"))
lm_C <- lm(y ~ x, subset(data, subgroup == "group_C"))
lm_D <- lm(y ~ x, subset(data, subgroup == "group_D"))
lm_E <- lm(y ~ x, subset(data, subgroup == "group_E"))
```

- For more information on this technique, read the Many Models subchapter of the [R for Data Science](https://r4ds.had.co.nz/many-models.html#creating-list-columns).


```r
# Function
lm_model <- function(df) {
  lm(Temp ~ Ozone, data = df)
}

# Map
models <- airquality %>%
  group_by(Month) %>%
  nest() %>% # Create list-columns
  mutate(ols = map(data, lm_model)) # Map
models$ols[1]
```

```
## [[1]]
## 
## Call:
## lm(formula = Temp ~ Ozone, data = df)
## 
## Coefficients:
## (Intercept)        Ozone  
##     62.8842       0.1629
```

```r
# Add tidying
tidy_lm_model <- purrr::compose( # compose multiple functions
  broom::tidy, # convert lm objects into tidy tibbles
  lm_model
)

tidied_models <- airquality %>%
  group_by(Month) %>%
  nest() %>% # Create list-columns
  mutate(ols = map(data, tidy_lm_model))

tidied_models$ols[1]
```

```
## [[1]]
## # A tibble: 2 x 5
##   term        estimate std.error statistic  p.value
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept)   62.9      1.61       39.2  2.88e-23
## 2 Ozone          0.163    0.0500      3.26 3.31e- 3
```

## Automote 2 or 2+ tasks

### Objectives 

- Learning how to use `map2()` and `pmap()` to avoid writing nested loops.

### Problem 

- Problem: How can you create something like below?

[1] "University =  Berkeley | Department =  waterbenders"

[1] "University =  Berkeley | Department =  earthbenders"

[1] "University =  Berkeley | Department =  firebenders"

[1] "University =  Berkeley | Department =  airbenders"

[1] "University =  Stanford | Department =  waterbenders"

[1] "University =  Stanford | Department =  earthbenders"

[1] "University =  Stanford | Department =  firebenders"

[1] "University =  Stanford | Department =  airbenders"

- The most manual way: You can copy and paste eight times.


```r
paste("University = Berkeley | Department = CS")
```

```
## [1] "University = Berkeley | Department = CS"
```

### For loop 

- A slightly more efficient way: using a for loop. 

- Think about which part of the statement is constant and which part varies ( = parameters).  
    
- Do we need a placeholder? No. We don't need a placeholder because we don't store the result of iterations.
    
- **Challenge**: How many parameters do you need to solve the problem below?
  

```r
# Outer loop

for (univ in c("Berkeley", "Stanford")) {

  # Inner loop

  for (dept in c("waterbenders", "earthbenders", "firebenders", "airbenders")) {
    print(paste("University = ", univ, "|", "Department = ", dept))
  }
}
```

```
## [1] "University =  Berkeley | Department =  waterbenders"
## [1] "University =  Berkeley | Department =  earthbenders"
## [1] "University =  Berkeley | Department =  firebenders"
## [1] "University =  Berkeley | Department =  airbenders"
## [1] "University =  Stanford | Department =  waterbenders"
## [1] "University =  Stanford | Department =  earthbenders"
## [1] "University =  Stanford | Department =  firebenders"
## [1] "University =  Stanford | Department =  airbenders"
```

- This is not bad, but ... `n` arguments -> `n-nested for loops`. As a scale of your problem grows, your code gets really complicated.

> To become significantly more reliable, code must become more transparent. In particular, nested conditions and loops must be viewed with great suspicion. Complicated control flows confuse programmers. Messy code often hides bugs. — [Bjarne Stroustrup](https://en.wikipedia.org/wiki/Bjarne_Stroustrup)

### map2 & pmap

- Step 1: Define inputs and a function.

- **Challenge** Why are we using `rep()` to create input vectors? For instance, for `univ_list` why not just use `c("Berkeley", "Stanford")`?


```r
# Inputs (remember the length of these inputs should be identical)

univ_list <- rep(c("Berkeley", "Stanford"), 4)
dept_list <- rep(c("waterbenders", "earthbenders", "firebenders", "airbenders"), 2)

# Function

print_lists <- function(univ, dept) {
  print(paste(
    "University = ", univ, "|",
    "Department = ", dept
  ))
}

# Test

print_lists(univ_list[1], dept_list[1])
```

```
## [1] "University =  Berkeley | Department =  waterbenders"
```

- Step2: Using `map2()` or `pmap()`

![](https://dcl-prog.stanford.edu/images/map2.png)


```r
# 2 arguments
map2_output <- map2(univ_list, dept_list, print_lists)
```

```
## [1] "University =  Berkeley | Department =  waterbenders"
## [1] "University =  Stanford | Department =  earthbenders"
## [1] "University =  Berkeley | Department =  firebenders"
## [1] "University =  Stanford | Department =  airbenders"
## [1] "University =  Berkeley | Department =  waterbenders"
## [1] "University =  Stanford | Department =  earthbenders"
## [1] "University =  Berkeley | Department =  firebenders"
## [1] "University =  Stanford | Department =  airbenders"
```

![](https://d33wubrfki0l68.cloudfront.net/e426c5755e2e65bdcc073d387775db79791f32fd/92902/diagrams/functionals/pmap.png)


```r
# 3+ arguments
pmap_output <- pmap(list(univ_list, dept_list), print_lists)
```

```
## [1] "University =  Berkeley | Department =  waterbenders"
## [1] "University =  Stanford | Department =  earthbenders"
## [1] "University =  Berkeley | Department =  firebenders"
## [1] "University =  Stanford | Department =  airbenders"
## [1] "University =  Berkeley | Department =  waterbenders"
## [1] "University =  Stanford | Department =  earthbenders"
## [1] "University =  Berkeley | Department =  firebenders"
## [1] "University =  Stanford | Department =  airbenders"
```

- **Challenge** Have you noticed that we used a slightly different input for `pmap()` compared to `map()` or `map2()`? What is the difference?

## Automate plotting

### Objective 

- Learning how to use `map()` and `glue()` to automate creating multiple plots

### Problem 

- Making the following data visualization process more efficient. 


```r
data("airquality")

airquality %>%
  ggplot(aes(x = Ozone, y = Solar.R)) +
  geom_point() +
  labs(
    title = "Relationship between Ozone and Solar.R",
    y = "Solar.R"
  )
```

```
## Warning: Removed 42 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-27-1.png" width="672" />

```r
airquality %>%
  ggplot(aes(x = Ozone, y = Wind)) +
  geom_point() +
  labs(
    title = "Relationship between Ozone and Wind",
    y = "Wind"
  )
```

```
## Warning: Removed 37 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-27-2.png" width="672" />

```r
airquality %>%
  ggplot(aes(x = Ozone, y = Temp)) +
  geom_point() +
  labs(
    title = "Relationship between Ozone and Temp",
    y = "Temp"
  )
```

```
## Warning: Removed 37 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-27-3.png" width="672" />

### Solution 

- Learn how `glue()` works. 

- `glue()` combines strings and objects and it works simpler and faster than `paste()` or `sprintif()`. 


```r
names <- c("Jae", "Aniket", "Avery")

fields <- c("Political Science", "Law", "Public Health")

glue("{names} studies {fields}.")
```

```
## Jae studies Political Science.
## Aniket studies Law.
## Avery studies Public Health.
```

- So, our next step is to combine `glue()` and `map()`. 

- Let's first think about writing a function that includes `glue()`.

- **Challenge**
How can you create the character vector of column names? 

- **Challenge**
How can you make `ggplot2()` take strings as x and y variable names? (Hint: Type `?aes_string()`) 


```r
airquality %>%
  ggplot(aes_string(x = names(airquality)[1], y = names(airquality)[2])) +
  geom_point() +
  labs(
    title = glue("Relationship between Ozone and {names(airquality)[2]}"),
    y = glue("{names(airquality)[2]}")
  )
```

```
## Warning: Removed 42 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-29-1.png" width="672" />

- The next step is to write an automatic plotting function. 

    - Note that in the function argument `i` (abstract) replaced 2 (specific): abstraction  


```r
create_point_plot <- function(i) {
  airquality %>%
    ggplot(aes_string(x = names(airquality)[1], y = names(airquality)[i])) +
    geom_point() +
    labs(
      title = glue("Relationship between Ozone and {names(airquality)[i]}"),
      y = glue("{names(airquality)[i]}")
    )
}
```

- The final step is to put the function in `map()`.


```r
map(2:ncol(airquality), create_point_plot)
```

```
## [[1]]
```

```
## Warning: Removed 42 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-31-1.png" width="672" />

```
## 
## [[2]]
```

```
## Warning: Removed 37 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-31-2.png" width="672" />

```
## 
## [[3]]
```

```
## Warning: Removed 37 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-31-3.png" width="672" />

```
## 
## [[4]]
```

```
## Warning: Removed 37 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-31-4.png" width="672" />

```
## 
## [[5]]
```

```
## Warning: Removed 37 rows containing missing values (geom_point).
```

<img src="04_functional_programming_files/figure-html/unnamed-chunk-31-5.png" width="672" />

## Automate joining

### Objective 

- Learning how to use `reduce()` to automate joining multiple dataframes

### Problem 

- How can you make joining multiple dataframes more efficient?

- Note that we will use `dplyr::left_join() = merge(x, y, all.x = TRUE)`.


```r
df1 <- tibble(
  x = sample(1:10, size = 3, replace = TRUE),
  y = sample(1:10, size = 3, replace = TRUE),
  z = sample(1:10, size = 3, replace = TRUE)
)

df2 <- tibble(
  x = sample(1:10, size = 3, replace = TRUE),
  y = sample(1:10, size = 3, replace = TRUE),
  z = sample(1:10, size = 3, replace = TRUE)
)

df3 <- tibble(
  x = sample(1:10, size = 3, replace = TRUE),
  y = sample(1:10, size = 3, replace = TRUE),
  z = sample(1:10, size = 3, replace = TRUE)
)
```

### Copy and paste


```r
first_join <- left_join(df1, df2)
```

```
## Joining, by = c("x", "y", "z")
```

```r
second_join <- left_join(first_join, df3)
```

```
## Joining, by = c("x", "y", "z")
```

```r
second_join
```

```
## # A tibble: 3 x 3
##       x     y     z
##   <int> <int> <int>
## 1     8     5     8
## 2     4     8     3
## 3     4     4     4
```

- **Challenge**
Why the above solution is not efficient?

### reduce 

![How reduce() works.](https://d33wubrfki0l68.cloudfront.net/9c239e1227c69b7a2c9c2df234c21f3e1c74dd57/eec0e/diagrams/functionals/reduce.png)

    - Input: Takes a vector of length n
  
    - Computation: Calls a function with a pair of values at a time
  
    - Output: Returns a vector of length 1
    

```r
reduced <- reduce(list(df1, df2, df3), left_join)
```

```
## Joining, by = c("x", "y", "z")
## Joining, by = c("x", "y", "z")
```

```r
reduced
```

```
## # A tibble: 3 x 3
##       x     y     z
##   <int> <int> <int>
## 1     8     5     8
## 2     4     8     3
## 3     4     4     4
```

## Make automation slower or faster 

### Objectives 

- Learning how to use `slowly()` and `future_` to make automation process either slower or faster

### How to make automation slower

- Scraping 50 pages from a website and you don't want to overload the server. How can you do that?

### For loop 



### Map 

- `walk()` works same as `map()` but doesn't store its output. 



- If you're web scraping, one problem with this approach is it's too fast by human standards.



- If you want to make the function run slowly ... 

> slowly() takes a function and modifies it to wait a given amount of time between each call. - `purrr` package vignette 
- If a function is a verb, then a helper function is an adverb (modifying the behavior of the verb). 



### How to make automation Faster 

In a different situation, you want to make your function run faster. This is a common situation when you collect and analyze data at large-scale. You can solve this problem using parallel processing. For more on the parallel processing in R, read [this review](https://yxue-me.com/post/2019-05-12-a-glossary-of-parallel-computing-packages-in-r-2019/).

- Parallel processing setup 

    - Step1: Determine the number of max workers (`availableCores()`)
    
    - Step2: Determine the parallel processing mode (`plan()`) 



## Make error handling easier

### Learning objective 

- Learning how to use `safely()` and `possibly()` to make error handling easier 
### Problem 

- **Challenge**

- Explain why we can't run `map(url_lists, read_html)`


```r
url_lists <- c(
  "https://en.wikipedia.org/wiki/University_of_California,_Berkeley",
  "https://en.wikipedia.org/wiki/Stanford_University",
  "https://en.wikipedia.org/wiki/Carnegie_Mellon_University",
  "https://DLAB"
)
```


```r
map(url_lists, read_html)
```

- This is a very simple problem so it's easy to tell where the problem is. How can you make your error more informative? 

### Solution 

#### Try-catch 

- There are three kinds of messages you will run into, if your code has an error based on the following functions.  

    - `stop()`: errors; Functions must stop. 
    - `warning()`: warnings; Functions may still work. Nonetheless, something is possibly messed up. 
    - `message()`: messages; Some actions happened. 
    
- The basic logic of `try-catch`, R's basic error handling function, works like the following. 


```r
tryCatch(
  {
    map(url_lists, read_html)
  },
  warning = function(w) {
    "Warning"
  },
  error = function(e) {
    "Error"
  },
  finally = {
    "Message"
  }
)
```

```
## [1] "Error"
```

- Here's `purrr` version of the `try-catch` mechanism (evaluates code and assigns exception handlers). 

#### safely

**Outputs** 

- result: result or `NULL`
- error: `NULL` or `error` 


```r
map(url_lists, safely(read_html))
```

```
## [[1]]
## [[1]]$result
## NULL
## 
## [[1]]$error
## <simpleError in open.connection(x, "rb"): Timeout was reached: [en.wikipedia.org] Connection timed out after 10000 milliseconds>
## 
## 
## [[2]]
## [[2]]$result
## NULL
## 
## [[2]]$error
## <simpleError in open.connection(x, "rb"): Timeout was reached: [en.wikipedia.org] Connection timed out after 10001 milliseconds>
## 
## 
## [[3]]
## [[3]]$result
## NULL
## 
## [[3]]$error
## <simpleError in open.connection(x, "rb"): Timeout was reached: [en.wikipedia.org] Connection timed out after 10001 milliseconds>
## 
## 
## [[4]]
## [[4]]$result
## NULL
## 
## [[4]]$error
## <simpleError in open.connection(x, "rb"): Could not resolve host: DLAB>
```

- The easier way to solve this problem is just avoiding the error.


```r
map(url_lists, safely(read_html)) %>%
  map("result") %>% 
  # = map(function(x) x[["result"]]) = map(~.x[["name"]])
  purrr::compact() # Remove empty elements
```

```
## list()
```

#### possibly 

What if the best way to solve the problem is not ignoring the error ... 


```r
# If error occurred, "The URL is broken." will be stored in that element(s).
out <- map(
  url_lists,
  possibly(read_html,
    otherwise = "The URL is broken."
  )
)

# Let's find the broken URL.
url_lists[out[seq(out)] == "The URL is broken."]
```

```
## [1] "https://en.wikipedia.org/wiki/University_of_California,_Berkeley"
## [2] "https://en.wikipedia.org/wiki/Stanford_University"               
## [3] "https://en.wikipedia.org/wiki/Carnegie_Mellon_University"        
## [4] "https://DLAB"
```

## Developing your own data products

> A data product is the production output from a statistical analysis. - [Brian Caffo](https://sites.google.com/view/bcaffo/home)

### Developing R packages 

1. Reuse your code 
2. Automate your workflow 
3. Help others (be part of an open source development community)

#### Workflow 

1. Write code in `\R`
2. Document code in `\man` (automated by `roxygen2` package)
  - `devtools::document()` 
3. Check dependencies in `NAMESPACE`
  - `devtools::update()` updates the documentation 
  - `devtools::check()` to see whether your package is ready to be submitted to CRAN
4. Build a package (for more information, read [this section](http://r-pkgs.had.co.nz/package.html) in Hadley's R package development book)
  - `devtools::build()` 
5. (Optional) Test (`devtools::test()`), teach in `\vignettes`, and add data in `\data`
6. Distribute the package either via CRAN or GitHub  

![]http://r-pkgs.had.co.nz/diagrams/package-files.png

#### Required Components

The 4 required components are necessary to build and distribute a minimally viable R package. The other steps are optional.

- Package 
  - `\R`: R functions 
  - `\man`: function documentations 
  - DESCRIPTION: provides meta data about the package (e.g., author)
  - LICENSE
    - GNU, MIT, etc.
  - NAMESPACE: package dependencies (to make your package self-contained)
  - README (optional)
  
1. Setup (**DESCRIPTION**)


```r
# This function creates DESCRIPTION file 
usethis::create_package(here("mypkg"))

# Initialize git repo 
usethis::use_git()

# License the package 
# You can use the MIT license by typing devtools::use_mit_license("author name"). The function produces MIT license related files (LICENSE, LICENSE.md).
use_mit_license("Jae Yeon Kim")

# Add README (optional)
# Makes the package more use-friendly 
use_readme_md()

# Add news (optional) 
# Helps track changes 
use_news_md() 
```

2. Write code (**R**)


```r
usethis::use_r("rbind_mutate")
```

```r
#' Add two numbers
#'
#' @param x A number
#' @param y A number
#' @return The sum of x and y 
#' @export

add <- function(x, y){
  
  x + y
  
}
```

3. Document (**man**)


```r
# Document 
# The function creates documentation related files (NAMESPACE, function_name.rd)
devtools::document()

# Load all 
devtools::load_all()

# Check 
devtools::check()
```

4. Organize (**NAMESPACE**)


```r
usethis::use_package("dplyr")
```

#### Optional Components  

1. Test (**test**)


```r
usethis::use_testthat()

usethis::use_test("rbind_mutate")
```

2. Add data (**data**)


```r
x <- "Jae"
y <- "Sun"
z <- "Jane"

usethis::use_data(x, y, z, overwrite = TRUE)
```

3. Teach (**vignetts**)


```r
usethis::use_vignette("rbind_mutate")
```

```r
title: "Vignette title"
author: "Vignette author"
date: "2020-10-17"
output: rmarkdown::html_vignette
vignette: blah blah
``` 

- You can build a package website using `pkgdown`


```r
# install.packages("pkgdown")
usethis::use_pkgdown()
pkgdown::build_site()
```

- A package site includes information on METADATA, Function references, Articles, News, etc. 

#### Building an R package 

- CMD (in the terminal)

You can run R commands in the terminal using R CMD.



- devtools 


```r
# Build 
devtools::build()

# Install 
devtools::install()
```

#### Distributing an R package 


```r
# Version update 
usethis::use_version()

# Spell check
usethis::use_spell_check()
```

1. [CRAN (The Comprehensive R Archive Network)](https://cran.r-project.org/)
  - R package submission should comply with [the CRAN Repository Policy](https://cran.r-project.org/)

2. GitHub 
  - Push everything to the Git repository (you can do it using command-line interface or RStudio).



  - Don't forget that your repository should be `public`.
  - I highly recommend connecting GitHub with SSH. For more information, visit [this link](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh).
  


### Developing Shiny apps

[Shiny](https://shiny.rstudio.com/) is a "framework for creating web applications using R code". You can create a dashboard or an interactive map without knowing anything about HTML, CSS, or JavaScript. Developing a shiny app helps people with little technical expertise to learn from your data in an intuitive and interactive way.

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/Wy3TY0gOmJw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p>Shiny in production: Principles, practices, and tools - Joe Cheng</p>

```

#### Workflow 

The workflow follows what Hadley Wickham recommened in his book on mastering shiny. 

1. Install libraries 

```r
install.packages("shiny")
```

2. Create app directory and file 

Add an `app.R` file.

The key objective here is defining your UI (how the app looks; front-end = INPUT) (defined in object `ui`) and server (how the app works; back-end = OUTPUT) (defined in object `server`).

If you're creating a complex app, you can achieve the same goal with two files: `ui.R` and `server.R`.

#### app.r 

- Front-end


```r
# Load packages 
# Do not use install.packages(), pacman::p_load(), or library() if you intend to deploy the app using shinyapps.io 

require("wordcloud2")
require("shiny")
require("shinydashboard")
require("colourpicker")

# Load data 

df <- read.csv(url("https://github.com/jaeyk/covid19antiasian/raw/master/processed_data/hash_counts.csv"))[,-1]

# Defines the user interface; how the app looks

ui <- fluidPage( # This is a layout function 
  
    # Input 
    h1("Word Cloud on the Hashtags of the Tweets related to COVID-19 & Asian|Chinese|Wuhan"),
  
    h4(tags$a(href = "https://jaeyk.github.io/", "Developer: Jae Yeon Kim")),
            
    # Interactive part 
    mainPanel(
    wordcloud2Output("cloud"),
        )
    
    )
```

- Back-end


```r
server <- function(input, output) {
  
  output$cloud <- renderWordcloud2({ 
    
    wordcloud2(df, 
               size = 2.5, 
               color = "random-dark") 
    
    })

  }
```

- Build a shiny app 


```r
shinyApp(ui = ui, server = server)
```

#### Deployment 

- Deploy to [the shinyapps.io cloud](https://www.shinyapps.io/?_ga=2.5503866.871102833.1602978469-100003412.1602392815) 


```r
# Install packages 
install.packages("devtools")
devtools::install_github("rstudio/shinyapps")
library(shinyapps)

# Setup 
shinyapps::setAccountInfo(name = "<Account name>", 
                          token = "<Token>",
                          secret = "<Secret>")

deployApp(appNames = "<App name>")
```

#### References 

[Mastering Shiny](https://mastering-shiny.org/) by Hadley Wickham. For newbies. 

[Shiny Documents](https://bookdown.org/yihui/rmarkdown/shiny-documents.html) by Yihui Xie

[Engineering Production-Grade Shiny Apps](https://engineering-shiny.org/) by Colin Fay, Sébastien Rochette, Vincent Guyader, Cervan Girard. For experienced developers.

[Building Shiny Apps](https://stat545.com/shiny-tutorial.html) by Dean Attali.

### Other useful data products 

- Automating data reports using rmarkdown (called [parameterized reports](https://rmarkdown.rstudio.com/developer_parameterized_reports.html%23parameter_types%2F))
- Automating R presentation using [slidify](http://slidify.org/index.html)
- Creating interactive web apps using [leaflet](https://rstudio.github.io/leaflet/) 
