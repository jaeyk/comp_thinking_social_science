# Tidy data and its friends {#tidy_data}



## Setup

-   Check your `dplyr` package is up-to-date by typing `packageVersion("dplyr")`. If the current installed version is less than 1.0, then update by typing `update.packages("dplyr")`. You may need to restart R to make it work.


```r
ifelse(packageVersion("dplyr") >= 1,
  "The installed version of dplyr package is greater than or equal to 1.0.0", update.packages("dplyr")
)
```

```
## [1] "The installed version of dplyr package is greater than or equal to 1.0.0"
```

```r
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  tidyverse, # the tidyverse framework
  skimr, # skimming data 
  here, # computational reproducibility
  infer, # statistical inference 
  tidymodels, # statistical modeling 
  gapminder, # toy data
  nycflights13, # for exercise
  ggthemes, # additional themes
  ggrepel, # arranging ggplots
  patchwork, # arranging ggplots
  broom, # tidying model outputs
  waldo # side-by-side code comparison
)
```

## Base R data structure 

The rest of the chapter follows the basic structure in [the Data Wrangling Cheat Sheet](https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) created by RStudio.

To make the best use of the R language, you'll need a strong understanding of the basic data types and data structures and how to operate on those. R is an **object-oriented** language, so the importance of this cannot be understated. 

It is **critical** to understand because these are the objects you will manipulate on a day-to-day basis in R, and they are not always as easy to work with as they sound at the outset. Dealing with object conversions is one of the most common sources of frustration for beginners.

> To understand computations in R, two slogans are helpful:
  - Everything that exists is an object.
  - Everything that happens is a function call.
  
> __John Chambers__the creator of S (the mother of R)

1. [Main Classes](#main-classes) introduces you to R's one-dimensional or atomic classes and data structures. R has five basic atomic classes: logical, integer, numeric, complex, character. Social scientists don't use complex classes. 

2. [Attributes](#attributes) takes a small detour to discuss attributes, R's flexible metadata specification. Here, you'll learn about factors, an important data structure created by setting attributes of an atomic vector. R has many data structures: vector, list, matrix, data frame, factors, tables.


![Concept map for data types. By Meghan Sposato, Brendan Cullen, Monica Alonso.](https://github.com/rstudio/concept-maps/raw/master/en/data-types.svg)


### 1D data: Vectors 

#### Atomic classes

`R`'s main atomic classes are:

* character (or a "string" in Python and Stata)
* numeric (integer or float)
* integer (just integer)
* logical (booleans)

| Example | Type |
| ------- | ---- |
| "a", "swc" | character |
| 2, 15.5 | numeric | 
| 2 (Must add a `L` at end to denote integer) | integer |
| `TRUE`, `FALSE` | logical |

Like Python, R is dynamically typed. There are a few differences in terminology, however, that are pertinent. 

- First, "types" in Python are referred to as "classes" in R. 

What is a class?

![from https://brilliant.org/](https://ds055uzetaobb.cloudfront.net/brioche/uploads/pJZt3mh3Ht-prettycars.png?width=2400)

- Second, R has different names for the types string, integer, and float --- specifically **character**, **integer** (not different), and **numeric**. Because there is no "float" class in R, users tend to default to the "numeric" class when working with numerical data.

The function for recovering object classes is ```class()```. L suffix to qualify any number with the intent of making it an explicit integer. See more from the [R language definition](https://cran.r-project.org/doc/manuals/R-lang.html).


```r
class(3)
```

```
## [1] "numeric"
```

```r
class(3L)
```

```
## [1] "integer"
```

```r
class("Three")
```

```
## [1] "character"
```

```r
class(F)
```

```
## [1] "logical"
```

### Data structures

R's base data structures can be organized by their dimensionality (1d, 2d, or nd) and whether they're homogeneous (all contents must be of the same type) or heterogeneous (the contents can be of different types). This gives rise to the five data types most often used in data analysis: 

|    | Homogeneous   | Heterogeneous |
|----|---------------|---------------|
| 1d | Atomic vector | List          |
| 2d | Matrix        | Data frame    |
| nd | Array         |               |

Each data structure has its specifications and behavior. For our purposes, an important thing to remember is that R is always **faster** (more efficient) working with homogeneous (**vectorized**) data.

#### Vector properties

Vectors have three common properties:

* Class, `class()`, or what type of object it is (same as `type()` in Python).
* Length, `length()`, how many elements it contains (same as `len()` in Python).
* Attributes, `attributes()`, additional arbitrary metadata.

They differ in the types of their elements: all atomic vector elements must be the same type, whereas the elements of a list can have different types.

#### Creating different types of atomic vectors

Remember, there are four common types of vectors: 
* `logical` 
* `integer` 
* `numeric` (same as `double`)
* `character`.

You can create an empty vector with `vector()` (By default, the mode is `logical.` You can be more explicit as shown in the examples below.) It is more common to use direct constructors such as `character()`, `numeric()`, etc.


```r
x <- vector()

# with a length and type
vector("character", length = 10)
```

```
##  [1] "" "" "" "" "" "" "" "" "" ""
```

```r
## character vector of length 5
character(5)
```

```
## [1] "" "" "" "" ""
```

```r
numeric(5)
```

```
## [1] 0 0 0 0 0
```

```r
logical(5)
```

```
## [1] FALSE FALSE FALSE FALSE FALSE
```

Atomic vectors are usually created with `c()`, which is short for concatenate:


```r
x <- c(1, 2, 3)

x
```

```
## [1] 1 2 3
```

```r
length(x)
```

```
## [1] 3
```

`x` is a numeric vector. These are the most common kind. You can also have logical vectors. 


```r
y <- c(TRUE, TRUE, FALSE, FALSE)

y
```

```
## [1]  TRUE  TRUE FALSE FALSE
```

Finally, you can have character vectors:


```r
kim_family <- c("Jae", "Sun", "Jane")

is.integer(kim_family) # integer?
```

```
## [1] FALSE
```

```r
is.character(kim_family) # character?
```

```
## [1] TRUE
```

```r
is.atomic(kim_family) # atomic?
```

```
## [1] TRUE
```

```r
typeof(kim_family) # what's the type?
```

```
## [1] "character"
```

**Short exercise: Create and examine your vector**  

Create a character vector called `fruit` containing 4 of your favorite fruits. Then evaluate its structure using the commands below.


```r
# First, create your fruit vector
# YOUR CODE HERE
fruit <-

  # Examine your vector
  length(fruit)
class(fruit)
str(fruit)
```

**Add elements**

You can add elements to the end of a vector by passing the original vector into the `c` function, like the following:


```r
z <- c("Beyonce", "Kelly", "Michelle", "LeToya")

z <- c(z, "Farrah")

z
```

```
## [1] "Beyonce"  "Kelly"    "Michelle" "LeToya"   "Farrah"
```

More examples of vectors


```r
x <- c(0.5, 0.7)

x <- c(TRUE, FALSE)

x <- c("a", "b", "c", "d", "e")

x <- 9:100
```

You can also create vectors as a sequence of numbers:


```r
series <- 1:10

series
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
seq(10)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
seq(1, 10, by = 0.1)
```

```
##  [1]  1.0  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9  2.0  2.1  2.2  2.3  2.4
## [16]  2.5  2.6  2.7  2.8  2.9  3.0  3.1  3.2  3.3  3.4  3.5  3.6  3.7  3.8  3.9
## [31]  4.0  4.1  4.2  4.3  4.4  4.5  4.6  4.7  4.8  4.9  5.0  5.1  5.2  5.3  5.4
## [46]  5.5  5.6  5.7  5.8  5.9  6.0  6.1  6.2  6.3  6.4  6.5  6.6  6.7  6.8  6.9
## [61]  7.0  7.1  7.2  7.3  7.4  7.5  7.6  7.7  7.8  7.9  8.0  8.1  8.2  8.3  8.4
## [76]  8.5  8.6  8.7  8.8  8.9  9.0  9.1  9.2  9.3  9.4  9.5  9.6  9.7  9.8  9.9
## [91] 10.0
```

Atomic vectors are always flat, even if you nest `c()`'s:


```r
c(1, c(2, c(3, 4)))
```

```
## [1] 1 2 3 4
```

```r
# the same as
c(1, 2, 3, 4)
```

```
## [1] 1 2 3 4
```

**Types and Tests**

Given a vector, you can determine its class with `class`, or check if it's a specific type with an "is" function: `is.character()`, `is.numeric()`, `is.integer()`, `is.logical()`, or, more generally, `is.atomic()`.


```r
char_var <- c("harry", "sally")

class(char_var)
```

```
## [1] "character"
```

```r
is.character(char_var)
```

```
## [1] TRUE
```

```r
is.atomic(char_var)
```

```
## [1] TRUE
```

```r
num_var <- c(1, 2.5, 4.5)

class(num_var)
```

```
## [1] "numeric"
```

```r
is.numeric(num_var)
```

```
## [1] TRUE
```

```r
is.atomic(num_var)
```

```
## [1] TRUE
```

NB: `is.vector()` does not test if an object is a vector. Instead, it returns `TRUE` only if the object is a vector with no attributes apart from names. Use `is.atomic(x) || is.list(x)` to test if an object is actually a vector.

**Coercion**

All atomic vector elements must be the same type, so when you attempt to combine different types, they will be __coerced__ to the **most flexible type.** Types from least to most flexible are: logical > integer > double > character. 

For example, combining a character and an integer yields a character:


```r
str(c("a", 1))
```

```
##  chr [1:2] "a" "1"
```

**Guess what the following do without running them first**


```r
c(1.7, "a")

c(TRUE, 2)

c("a", TRUE)
```

Notice that when a logical vector is coerced to an integer or double, `TRUE` becomes 1, and `FALSE` becomes 0. This is very useful in conjunction with `sum()` and `mean()`


```r
x <- c(FALSE, FALSE, TRUE)

as.numeric(x)
```

```
## [1] 0 0 1
```

```r
# Total number of TRUEs
sum(x)
```

```
## [1] 1
```

```r
# Proportion that is TRUE
mean(x)
```

```
## [1] 0.3333333
```

Coercion often happens automatically. This is called implicit coercion. Most mathematical functions (`+`, `log`, `abs`, etc.) will coerce to a numeric or integer, and most logical operations (`&`, `|`, `any`, etc) will coerce to a logical. You will usually get a warning message if the coercion might lose information. 


```r
1 < "2"
```

```
## [1] TRUE
```

```r
"1" > 2
```

```
## [1] FALSE
```

You can also coerce vectors explicitly coerce with `as.character()`, `as.numeric()`, `as.integer()`, or `as.logical()`. Example:


```r
x <- 0:6

as.numeric(x)
```

```
## [1] 0 1 2 3 4 5 6
```

```r
as.logical(x)
```

```
## [1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
```

```r
as.character(x)
```

```
## [1] "0" "1" "2" "3" "4" "5" "6"
```

Sometimes coercions, especially nonsensical ones, won’t work.


```r
x <- c("a", "b", "c")

as.numeric(x)
```

```
## Warning: NAs introduced by coercion
```

```
## [1] NA NA NA
```

```r
as.logical(x)
```

```
## [1] NA NA NA
```

**Short Exercise**


```r
# 1. Create a vector of a sequence of numbers between 1 to 10.

# 2. Coerce that vector into a character vector

# 3. Add the element "11" to the end of the vector

# 4. Coerce it back to a numeric vector.
```

#### Lists

Lists are also vectors, but different from atomic vectors because their elements can be of any type. In short, they are generic vectors. For example, you construct lists by using `list()` instead of `c()`: 

Lists are sometimes called recursive vectors, because a list can contain other lists. This makes them fundamentally different from atomic vectors. 


```r
x <- list(1, "a", TRUE, c(4, 5, 6))

x
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] "a"
## 
## [[3]]
## [1] TRUE
## 
## [[4]]
## [1] 4 5 6
```

You can coerce other objects using `as.list()`. You can test for a list with `is.list()`


```r
x <- 1:10

x <- as.list(x)

is.list(x)
```

```
## [1] TRUE
```

```r
length(x)
```

```
## [1] 10
```

`c()` will combine several lists into one. If given a combination of atomic vectors and lists, `c()` (con**c**atenate) will coerce the vectors to lists before combining them. Compare the results of `list()` and `c()`:


```r
x <- list(list(1, 2), c(3, 4))

y <- c(list(1, 2), c(3, 4))

str(x)
```

```
## List of 2
##  $ :List of 2
##   ..$ : num 1
##   ..$ : num 2
##  $ : num [1:2] 3 4
```

```r
str(y)
```

```
## List of 4
##  $ : num 1
##  $ : num 2
##  $ : num 3
##  $ : num 4
```

You can turn a list into an atomic vector with `unlist()`. If the elements of a list have different types, `unlist()` uses the same coercion rules as `c()`.


```r
x <- list(list(1, 2), c(3, 4))

x
```

```
## [[1]]
## [[1]][[1]]
## [1] 1
## 
## [[1]][[2]]
## [1] 2
## 
## 
## [[2]]
## [1] 3 4
```

```r
unlist(x)
```

```
## [1] 1 2 3 4
```

Lists are used to build up many of the more complicated data structures in R. For example, both data frames and linear models objects (as produced by `lm()`) are lists:


```r
is.list(mtcars)
```

```
## [1] TRUE
```

```r
mod <- lm(mpg ~ wt, data = mtcars)

is.list(mod)
```

```
## [1] TRUE
```

For this reason, lists are handy inside functions. You can "staple" together many different kinds of results into a single object that a function can return.

A list does not print to the console like a vector. Instead, each element of the list starts on a new line.


```r
x.vec <- c(1, 2, 3)
x.list <- list(1, 2, 3)
x.vec
```

```
## [1] 1 2 3
```

```r
x.list
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] 3
```

For lists, elements are **indexed by double brackets**. Single brackets will still return a(nother) list. (We'll talk more about subsetting and indexing in the fourth lesson.)

**Exercises**

1. What are the four basic types of atomic vectors? How does a list differ from an atomic vector?

2. Why is `1 == "1"` true? Why is `-1 < FALSE` true? Why is `"one" < 2` false?

3. Create three vectors and then combine them into a list.

4.  If `x` is a list, what is the class of `x[1]`?  How about `x[[1]]`?


### Attributes

Attributes provide additional information about the data to you, the user, and to R. We've already seen the following three attributes in action:

* Names (`names(x)`), a character vector giving each element a name. 

* Dimensions (`dim(x)`), used to turn vectors into matrices.

* Class (`class(x)`), used to implement the S3 object system.

**Additional tips**

In an object-oriented system, a [class](https://www.google.com/search?q=what+is+class+programming&oq=what+is+class+programming&aqs=chrome.0.0l6.3543j0j4&sourceid=chrome&ie=UTF-8) (an extensible problem-code-template) defines a type of object like what its properties are, how it behaves, and how it relates to other types of objects. Therefore, technically, an object is an [instance](https://en.wikipedia.org/wiki/Instance_(computer_science)) (or occurrence) of a class. A method is a function associated with a particular type of object.

#### Names

You can name a vector when you create it:


```r
x <- c(a = 1, b = 2, c = 3)
```

You can also modify an existing vector: 


```r
x <- 1:3

names(x)
```

```
## NULL
```

```r
names(x) <- c("e", "f", "g")

names(x)
```

```
## [1] "e" "f" "g"
```

Names don't have to be unique. However, character subsetting, described in the next lesson, is the most important reason to use names, and it is most useful when the names are unique. (For Python users: when names are unique, a vector behaves like a Python dictionary key.)

Not all elements of a vector need to have a name. If some names are missing, `names()` will return an empty string for those elements. If all names are missing, `names()` will return `NULL`.


```r
y <- c(a = 1, 2, 3)

names(y)
```

```
## [1] "a" ""  ""
```

```r
z <- c(1, 2, 3)

names(z)
```

```
## NULL
```

You can create a new vector without names using `unname(x)`, or remove names in place with `names(x) <- NULL`.

#### Factors

Factors are special vectors that represent categorical data. Factors can be ordered (ordinal variable) or unordered (nominal or categorical variable) and are important for modeling functions such as `lm()` and `glm()` and also in plot methods.

**Quiz**
1. If you want to enter dummy variables (Democrats = 1, Non-democrats = 0) in your regression model, should you use a numeric or factor variable?

Factors can only contain pre-defined values. Set allowed values using the `levels()` attribute. Note that a factor's levels will always be character values. 



```r
x <- c("a", "b", "b", "a")

x <- factor(c("a", "b", "b", "a"))

x
```

```
## [1] a b b a
## Levels: a b
```

```r
class(x)
```

```
## [1] "factor"
```

```r
levels(x)
```

```
## [1] "a" "b"
```

```r
# You can't use values that are not in the levels
x[2] <- "c"
```

```
## Warning in `[<-.factor`(`*tmp*`, 2, value = "c"): invalid factor level, NA
## generated
```

```r
# NB: you can't combine factors
c(factor("a"), factor("b"))
```

```
## [1] a b
## Levels: a b
```

```r
rep(1:5, rep(6, 5))
```

```
##  [1] 1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5
```

Factors are pretty much integers that have labels on them. Underneath, it's really numbers (1, 2, 3...). 


```r
x <- factor(c("a", "b", "b", "a"))

str(x)
```

```
##  Factor w/ 2 levels "a","b": 1 2 2 1
```

They are better than using simple integer labels because factors are what are called self-describing. For example, `democrat` and `republican` is more descriptive than `1`s and `2`s. 

Factors are useful when you know the possible values a variable may take, even if you don't see all values in a given dataset. Using a factor instead of a character vector makes it obvious when some groups contain no observations:


```r
party_char <- c("democrat", "democrat", "democrat")

party_char
```

```
## [1] "democrat" "democrat" "democrat"
```

```r
party_factor <- factor(party_char, levels = c("democrat", "republican"))

party_factor
```

```
## [1] democrat democrat democrat
## Levels: democrat republican
```

```r
table(party_char) # shows only democrats
```

```
## party_char
## democrat 
##        3
```

```r
table(party_factor) # shows republicans too
```

```
## party_factor
##   democrat republican 
##          3          0
```

Sometimes factors can be left unordered. Example: `democrat`, `republican.`

Other times you might want factors to be ordered (or ranked). Example: `low`, `medium`, `high`. 


```r
x <- factor(c("low", "medium", "high"))

str(x)
```

```
##  Factor w/ 3 levels "high","low","medium": 2 3 1
```

```r
is.ordered(x)
```

```
## [1] FALSE
```

```r
y <- ordered(c("low", "medium", "high"), levels = c("high", "medium", "low"))

is.ordered(y)
```

```
## [1] TRUE
```

While factors look (and often behave) like character vectors, they are integers. So be careful when treating them like strings. Some string methods (like `gsub()` and `grepl()`) will coerce factors to strings, while others (like `nchar()`) will throw an error, and still others (like `c()`) will use the underlying integer values. 


```r
x <- c("a", "b", "b", "a")

x
```

```
## [1] "a" "b" "b" "a"
```

```r
is.factor(x)
```

```
## [1] FALSE
```

```r
x <- as.factor(x)

x
```

```
## [1] a b b a
## Levels: a b
```

```r
c(x, "c")
```

```
## [1] "1" "2" "2" "1" "c"
```

For this reason, it's usually best to explicitly convert factors to character vectors if you need string-like behavior. There was a memory advantage to using factors instead of character vectors in early versions of R, but this is no longer the case.

Unfortunately, most data loading functions in R automatically convert character vectors to factors. This is suboptimal, because there's no way for those functions to know the set of all possible levels or their optimal order. If this becomes a problem, use the argument `stringsAsFactors = FALSE` to suppress this behavior and manually convert character vectors to factors using your knowledge of the data.

**More attributes**

All R objects can have arbitrary additional attributes used to store metadata about the object. Attributes can be considered a named list (with unique names). Attributes can be accessed individually with `attr()` or all at once (as a list) with `attributes().` 


```r
y <- 1:10

attr(y, "my_attribute") <- "This is a vector"

attr(y, "my_attribute")
```

```
## [1] "This is a vector"
```

```r
# str returns a new object with modified information
str(attributes(y))
```

```
## List of 1
##  $ my_attribute: chr "This is a vector"
```

**Exercises**

1.  What happens to a factor when you modify its levels? 
    

```r
f1 <- factor(letters)

levels(f1) <- rev(levels(f1))

f1
```

```
##  [1] z y x w v u t s r q p o n m l k j i h g f e d c b a
## Levels: z y x w v u t s r q p o n m l k j i h g f e d c b a
```

2.  What does this code do? How do `f2` and `f3` differ from `f1`?


```r
f2 <- rev(factor(letters))

f3 <- factor(letters, levels = rev(letters))
```

### 2D data: Matrices and dataframes 

1. Matrices:  data structures for storing 2d data that is all the same class.
2. Dataframes: teaches you about the dataframe, the most important data structure for storing data in R, because it stores different kinds of (2d) data.

#### Matrices

Matrices are created when we combine multiple vectors with the same class (e.g., numeric). This creates a dataset with rows and columns. By definition, if you want to combine multiple classes of vectors, you want a dataframe. You can coerce a matrix to become a dataframe and vice-versa, but as with all vector coercions, the results can be unpredictable, so be sure you know how each variable (column) will convert.


```r
m <- matrix(nrow = 2, ncol = 2)

m
```

```
##      [,1] [,2]
## [1,]   NA   NA
## [2,]   NA   NA
```

```r
dim(m)
```

```
## [1] 2 2
```

Matrices are filled column-wise. 


```r
m <- matrix(1:6, nrow = 2, ncol = 3)

m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

Other ways to construct a matrix


```r
m <- 1:10

dim(m) <- c(2, 5)

m
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    5    7    9
## [2,]    2    4    6    8   10
```

```r
dim(m) <- c(5, 2)

m
```

```
##      [,1] [,2]
## [1,]    1    6
## [2,]    2    7
## [3,]    3    8
## [4,]    4    9
## [5,]    5   10
```

You can transpose a matrix (or dataframe) with `t()`


```r
m <- 1:10

dim(m) <- c(2, 5)

m
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    5    7    9
## [2,]    2    4    6    8   10
```

```r
t(m)
```

```
##      [,1] [,2]
## [1,]    1    2
## [2,]    3    4
## [3,]    5    6
## [4,]    7    8
## [5,]    9   10
```

Another way is to bind columns or rows using `cbind()` and `rbind()`.


```r
x <- 1:3

y <- 10:12

cbind(x, y)
```

```
##      x  y
## [1,] 1 10
## [2,] 2 11
## [3,] 3 12
```

```r
# or

rbind(x, y)
```

```
##   [,1] [,2] [,3]
## x    1    2    3
## y   10   11   12
```

You can also use the `byrow` argument to specify how the matrix is filled. From R's own documentation:


```r
mdat <- matrix(c(1, 2, 3, 11, 12, 13),
  nrow = 2,
  ncol = 3,
  byrow = TRUE,
  dimnames = list(
    c("row1", "row2"),
    c("C.1", "C.2", "C.3")
  )
)
mdat
```

```
##      C.1 C.2 C.3
## row1   1   2   3
## row2  11  12  13
```

Notice that we gave `names` to the dimensions in `mdat`.


```r
dimnames(mdat)
```

```
## [[1]]
## [1] "row1" "row2"
## 
## [[2]]
## [1] "C.1" "C.2" "C.3"
```

```r
rownames(mdat)
```

```
## [1] "row1" "row2"
```

```r
colnames(mdat)
```

```
## [1] "C.1" "C.2" "C.3"
```

#### Dataframes 

A data frame is an essential data type in R. It's pretty much the **de facto** data structure for most tabular data and what we use for statistics. 

##### Creation

You create a data frame using `data.frame()`, which takes named vectors as input:


```r
vec1 <- 1:3
vec2 <- c("a", "b", "c")
df <- data.frame(vec1, vec2)
df
```

```
##   vec1 vec2
## 1    1    a
## 2    2    b
## 3    3    c
```

```r
str(df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ vec1: int  1 2 3
##  $ vec2: chr  "a" "b" "c"
```

Beware: `data.frame()`'s default behavior which turns strings into factors. Remember to use `stringAsFactors = FALSE` to suppress this behavior as needed:


```r
df <- data.frame(
  x = 1:3,
  y = c("a", "b", "c"),
  stringsAsFactors = FALSE
)
str(df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ x: int  1 2 3
##  $ y: chr  "a" "b" "c"
```

In reality, we rarely type up our datasets ourselves, and certainly not in R. The most common way to make a data.frame is by calling a file using `read.csv` (which relies on the `foreign` package), `read.dta` (if you're using a Stata file), or some other kinds of data file input.

##### Structure and Attributes

Under the hood, a data frame is a list of equal-length vectors. This makes it a 2-dimensional structure, so it shares properties of both the matrix and the list. 


```r
vec1 <- 1:3
vec2 <- c("a", "b", "c")
df <- data.frame(vec1, vec2)

str(df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ vec1: int  1 2 3
##  $ vec2: chr  "a" "b" "c"
```

This means that a dataframe has `names()`, `colnames()`, and `rownames()`, although `names()` and `colnames()` are the same thing. 

** Summary **

- Set column names: `names()` in data frame, `colnames()` in matrix 
- Set row names: `row.names()` in data frame, `rownames()` in matrix


```r
vec1 <- 1:3
vec2 <- c("a", "b", "c")
df <- data.frame(vec1, vec2)

# these two are equivalent
names(df)
```

```
## [1] "vec1" "vec2"
```

```r
colnames(df)
```

```
## [1] "vec1" "vec2"
```

```r
# change the colnames
colnames(df) <- c("Number", "Character")
df
```

```
##   Number Character
## 1      1         a
## 2      2         b
## 3      3         c
```


```r
names(df) <- c("Number", "Character")
df
```

```
##   Number Character
## 1      1         a
## 2      2         b
## 3      3         c
```


```r
# change the rownames
rownames(df)
```

```
## [1] "1" "2" "3"
```

```r
rownames(df) <- c("donut", "pickle", "pretzel")
df
```

```
##         Number Character
## donut        1         a
## pickle       2         b
## pretzel      3         c
```

The `length()` of a dataframe is the length of the underlying list and so is the same as `ncol()`; `nrow()` gives the number of rows. 


```r
vec1 <- 1:3
vec2 <- c("a", "b", "c")
df <- data.frame(vec1, vec2)

# these two are equivalent - number of columns
length(df)
```

```
## [1] 2
```

```r
ncol(df)
```

```
## [1] 2
```

```r
# get number of rows
nrow(df)
```

```
## [1] 3
```

```r
# get number of both columns and rows
dim(df)
```

```
## [1] 3 2
```

##### Testing and coercion

To check if an object is a dataframe, use `class()` or test explicitly with `is.data.frame()`:


```r
class(df)
```

```
## [1] "data.frame"
```

```r
is.data.frame(df)
```

```
## [1] TRUE
```

You can coerce an object to a dataframe with `as.data.frame()`:

* A vector will create a one-column dataframe.

* A list will create one column for each element; it's an error if they're 
  not all the same length.
  
* A matrix will create a data frame with the same number of columns and rows as the matrix.

##### Combining dataframes

You can combine dataframes using `cbind()` and `rbind()`:


```r
df <- data.frame(
  x = 1:3,
  y = c("a", "b", "c"),
  stringsAsFactors = FALSE
)

cbind(df, data.frame(z = 3:1))
```

```
##   x y z
## 1 1 a 3
## 2 2 b 2
## 3 3 c 1
```

```r
rbind(df, data.frame(x = 10, y = "z"))
```

```
##    x y
## 1  1 a
## 2  2 b
## 3  3 c
## 4 10 z
```

When combining column-wise, the number of rows must match, but row names are ignored. When combining row-wise, both the number and names of columns must match. (If you want to combine rows that don't have the same columns, other functions/packages in R can help.)

It's a common mistake to try and create a dataframe by `cbind()`ing vectors together. This doesn't work because `cbind()` will create a matrix unless one of the arguments is already a dataframe. Instead use `data.frame()` directly:


```r
bad <- (cbind(x = 1:2, y = c("a", "b")))
bad
```

```
##      x   y  
## [1,] "1" "a"
## [2,] "2" "b"
```

```r
str(bad)
```

```
##  chr [1:2, 1:2] "1" "2" "a" "b"
##  - attr(*, "dimnames")=List of 2
##   ..$ : NULL
##   ..$ : chr [1:2] "x" "y"
```

```r
good <- data.frame(
  x = 1:2, y = c("a", "b"),
  stringsAsFactors = FALSE
)
good
```

```
##   x y
## 1 1 a
## 2 2 b
```

```r
str(good)
```

```
## 'data.frame':	2 obs. of  2 variables:
##  $ x: int  1 2
##  $ y: chr  "a" "b"
```

The conversion rules for `cbind()` are complicated and best avoided by ensuring all inputs are of the same type.

**Other objects**

Missing values are specified with `NA,` which is a logical vector of length 1. `NA` will always be coerced to the correct type if used inside `c()`


```r
x <- c(NA, 1)
x
```

```
## [1] NA  1
```

```r
typeof(NA)
```

```
## [1] "logical"
```

```r
typeof(x)
```

```
## [1] "double"
```

`Inf` is infinity. You can have either positive or negative infinity.


```r
1 / 0
```

```
## [1] Inf
```

```r
1 / Inf
```

```
## [1] 0
```

`NaN` means Not a number. It's an undefined value.


```r
0 / 0
```

```
## [1] NaN
```

### Subset

When working with data, you'll need to subset objects early and often. Luckily, R's subsetting operators are powerful and fast. Mastery of subsetting allows you to succinctly express complex operations in a way that few other languages can match. Subsetting is hard to learn because you need to master several interrelated concepts:

* The three subsetting operators, `[`, `[[`, and `$`.

* Important differences in behavior for different objects (e.g., vectors, lists, factors, matrices, and data frames).

* The use of subsetting in conjunction with assignment.

This unit helps you master subsetting by starting with the simplest type of subsetting: subsetting an atomic vector with `[`. It then gradually extends your knowledge to more complicated data types (like dataframes and lists) and then to the other subsetting operators, `[[` and `$`. You'll then learn how subsetting and assignment can be combined to modify parts of an object, and, finally, you'll see a large number of useful applications.

#### Atomic vectors

Let's explore the different types of subsetting with a simple vector, `x`. 


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

Note that the number after the decimal point gives the original position in the vector.

**NB:** In R, positions start at 1, unlike Python, which starts at 0. Fun!**

There are five things that you can use to subset a vector: 

##### Positive integers


```r
x <- c(2.1, 4.2, 3.3, 5.4)
x
```

```
## [1] 2.1 4.2 3.3 5.4
```

```r
x[1]
```

```
## [1] 2.1
```

```r
x[c(3, 1)]
```

```
## [1] 3.3 2.1
```

```r
# `order(x)` gives the positions of smallest to largest values.
order(x)
```

```
## [1] 1 3 2 4
```

```r
x[order(x)]
```

```
## [1] 2.1 3.3 4.2 5.4
```

```r
x[c(1, 3, 2, 4)]
```

```
## [1] 2.1 3.3 4.2 5.4
```

```r
# Duplicated indices yield duplicated values
x[c(1, 1)]
```

```
## [1] 2.1 2.1
```

##### Negative integers


```r
x <- c(2.1, 4.2, 3.3, 5.4)
x[-1]
```

```
## [1] 4.2 3.3 5.4
```

```r
x[-c(3, 1)]
```

```
## [1] 4.2 5.4
```

You can't mix positive and negative integers in a single subset:


```r
x <- c(2.1, 4.2, 3.3, 5.4)
x[c(-1, 2)]
```

```
## Error in x[c(-1, 2)]: only 0's may be mixed with negative subscripts
```

##### Logical vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)

x[c(TRUE, TRUE, FALSE, FALSE)]
```

```
## [1] 2.1 4.2
```

This is probably the most useful type of subsetting because you write the expression that creates the logical vector.


```r
x <- c(2.1, 4.2, 3.3, 5.4)

# this returns a logical vector
x > 3
```

```
## [1] FALSE  TRUE  TRUE  TRUE
```

```r
x
```

```
## [1] 2.1 4.2 3.3 5.4
```

```r
# use a conditional statement to create an implicit logical vector
x[x > 3]
```

```
## [1] 4.2 3.3 5.4
```

You can combine conditional statements with `&` (and), `|` (or), and `!` (not)


```r
x <- c(2.1, 4.2, 3.3, 5.4)

# combing two conditional statements with &
x > 3 & x < 5
```

```
## [1] FALSE  TRUE  TRUE FALSE
```

```r
x[x > 3 & x < 5]
```

```
## [1] 4.2 3.3
```

```r
# combing two conditional statements with |
x < 3 | x > 5
```

```
## [1]  TRUE FALSE FALSE  TRUE
```

```r
x[x < 3 | x > 5]
```

```
## [1] 2.1 5.4
```

```r
# combining conditional statements with !
!x > 5
```

```
## [1]  TRUE  TRUE  TRUE FALSE
```

```r
x[!x > 5]
```

```
## [1] 2.1 4.2 3.3
```

Another way to generate implicit conditional statements is using the `%in%` operator, which works like the `in` keywords in Python.


```r
# generate implicit logical vectors through the %in% operator
x %in% c(3.3, 4.2)
```

```
## [1] FALSE  TRUE  TRUE FALSE
```

```r
x
```

```
## [1] 2.1 4.2 3.3 5.4
```

```r
x[x %in% c(3.3, 4.2)]
```

```
## [1] 4.2 3.3
```

##### Character vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)

# apply names
names(x) <- c("a", "b", "c", "d")
x
```

```
##   a   b   c   d 
## 2.1 4.2 3.3 5.4
```

```r
# subset using names
x[c("d", "c", "a")]
```

```
##   d   c   a 
## 5.4 3.3 2.1
```

```r
# Like integer indices, you can repeat indices
x[c("a", "a", "a")]
```

```
##   a   a   a 
## 2.1 2.1 2.1
```

```r
# Careful! names are always matched exactly
x <- c(abc = 1, def = 2)
x
```

```
## abc def 
##   1   2
```

```r
x[c("a", "d")]
```

```
## <NA> <NA> 
##   NA   NA
```

###### More on string operations 


```r
firstName <- "Jae Yeon"
lastName <- "Kim"
```

Unlike in Python, R does not have a reserved operator for string concatenation such as `+`.  Furthermore, using the usual concatenation operator ```c()``` on two or more character strings will not create a single character string, but rather a **vector** of character strings. 


```r
fullName <- c(firstName, lastName)

print(fullName)
```

```
## [1] "Jae Yeon" "Kim"
```

```r
length(fullName)
```

```
## [1] 2
```

To combine two or more character strings into one larger character string, we use the ```paste()``` function.  This function takes character strings or vectors and collapses their values into a single character string, with each value separated by a character string selected by the user.


```r
fullName <- paste(firstName, lastName)

print(fullName)

fullName <- paste(firstName, lastName, sep = "+")

print(fullName)

fullName <- paste(firstName, lastName, sep = "___")
print(fullName)
```

As with Python, R can also extract substrings based on the index position of its characters.  There are, however, two critical differences.  First, **index positions in R start at 1**.  This is in contrast to Python, where indexation begins at 0.  

Second, **object subsets using index positions in R contain all the elements in the specified range**.  If some object called ```data``` contains five elements, ```data[2:4]``` will return the elements at the second, third, and fourth positions.  By contrast, the same subset in Python would return the objects at the third and fourth positions (or second and third positions, depending upon whether your index starts at 0 or 1).  

Third, **R does not allow indexing of character strings***. Instead, you must use the ```substr()``` function.  Note that this function must receive both the ```start``` and ```stop``` arguments.  So if you want to get all the characters between some index and the end of the string, you must use the ```nchar()``` function, which will tell you the length of a character string.


```r
fullName <- paste(firstName, lastName)

# this won't work like in Python
fullName[1] # R sees the string as a unitary object - it can't be indexed this way
```

```
## [1] "Jae Yeon Kim"
```

```r
fullName[1:4]
```

```
## [1] "Jae Yeon Kim" NA             NA             NA
```

```r
# So use this instead
substr(x = fullName, start = 1, stop = 2)
```

```
## [1] "Ja"
```

```r
substr(x = fullName, start = 5, stop = 5)
```

```
## [1] "Y"
```

```r
substr(x = fullName, start = 1, stop = 10)
```

```
## [1] "Jae Yeon K"
```

```r
substr(x = fullName, start = 11, stop = nchar(fullName))
```

```
## [1] "im"
```

Like Python, R has a number of string methods, though these exist as individual rather than "mix-and-match" functions. For example:


```r
toupper(x = fullName)
```

```
## [1] "JAE YEON KIM"
```

```r
tolower(x = fullName)
```

```
## [1] "jae yeon kim"
```

```r
strsplit(x = fullName, split = " ")
```

```
## [[1]]
## [1] "Jae"  "Yeon" "Kim"
```

```r
strsplit(x = fullName, split = "n")
```

```
## [[1]]
## [1] "Jae Yeo" " Kim"
```

```r
gsub(pattern = "Kim", replacement = "Choi", x = fullName)
```

```
## [1] "Jae Yeon Choi"
```

```r
gsub(pattern = "Jae Yeon", replacement = "Danny", x = fullName)
```

```
## [1] "Danny Kim"
```

```r
# Note the importance of cases! This doesn't throw an error, so you won't realize your function didn't work unless you double-check several entries.

gsub(pattern = " ", replacement = "", x = fullName) # The same function is used for replacements and stripping
```

```
## [1] "JaeYeonKim"
```

#### Lists

Subsetting a list works in the same way as subsetting an atomic vector. Using `[` will always return a list; `[[` and `$`, as described below, let you pull out the list's components.


```r
l <- list("a" = 1, "b" = 2)
l
```

```
## $a
## [1] 1
## 
## $b
## [1] 2
```

```r
l[1]
```

```
## $a
## [1] 1
```

```r
l[[1]]
```

```
## [1] 1
```

```r
l["a"]
```

```
## $a
## [1] 1
```

#### Matrices

The most common way of subsetting matrices (2d) is a simple generalization of 1d subsetting: you supply a 1d index for each dimension, separated by a comma. Blank subsetting is now useful because it lets you keep all rows or all columns.


```r
a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
a
```

```
##      A B C
## [1,] 1 4 7
## [2,] 2 5 8
## [3,] 3 6 9
```

```r
# rows come first, then columns
a[c(1, 2), ]
```

```
##      A B C
## [1,] 1 4 7
## [2,] 2 5 8
```

```r
a[c(T, F, T), c("B", "A")]
```

```
##      B A
## [1,] 4 1
## [2,] 6 3
```

```r
a[0, -2]
```

```
##      A C
```

```r
a[c(1, 2), -2]
```

```
##      A C
## [1,] 1 7
## [2,] 2 8
```

#### Data frames

Data from data frames can be addressed like matrices (with row and column indicators separated by a comma).


```r
df <- data.frame(x = 4:6, y = 3:1, z = letters[1:3])
df
```

```
##   x y z
## 1 4 3 a
## 2 5 2 b
## 3 6 1 c
```

```r
# return only the rows where x == 6
df[df$x == 6, ]
```

```
##   x y z
## 3 6 1 c
```

```r
# return the first and third row
df[c(1, 3), ]
```

```
##   x y z
## 1 4 3 a
## 3 6 1 c
```

```r
# return the first and third row and the first and second column
df[c(1, 3), c(1, 2)]
```

```
##   x y
## 1 4 3
## 3 6 1
```

Data frames possess both lists and matrices' characteristics: if you subset with a single vector, they behave like lists and return only the columns.


```r
# There are two ways to select columns from a data frame
# Like a list:
df[c("x", "z")]
```

```
##   x z
## 1 4 a
## 2 5 b
## 3 6 c
```

```r
# Like a matrix
df[, c("x", "z")]
```

```
##   x z
## 1 4 a
## 2 5 b
## 3 6 c
```

But there's a significant difference when selecting a single column: matrix subsetting simplifies by default, list subsetting does not.


```r
(df["x"])
```

```
##   x
## 1 4
## 2 5
## 3 6
```

```r
class((df["x"]))
```

```
## [1] "data.frame"
```

```r
(df[, "x"])
```

```
## [1] 4 5 6
```

```r
class((df[, "x"]))
```

```
## [1] "integer"
```

See the bottom section on [Simplying and Preserving to know more](#simplify-preserve)

#### Subsetting operators 

There are two other subsetting operators: `[[` and `$`. 

* `[[` is similar to `[`, except it can only return a single value, and it allows you to pull pieces out of a list. 
* `$` is a useful shorthand for `[[` combined with character subsetting. 

##### `[[`

You need `[[` when working with lists. When `[` is applied to a list it always returns a list: it never gives you the list's contents. To get the contents, you need `[[`:

>  "If list `x` is a train carrying objects, then `x[[5]]` is
> the object in car 5; `x[4:6]` is a train of cars 4-6." 
>
> --- @RLangTip

Because data frames are lists of columns, you can use `[[` to extract a column from data frames:


```r
mtcars
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

```r
# these two are equivalent
mtcars[[1]]
```

```
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

```r
mtcars[, 1]
```

```
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

```r
# which differs from this:
mtcars[1]
```

```
##                      mpg
## Mazda RX4           21.0
## Mazda RX4 Wag       21.0
## Datsun 710          22.8
## Hornet 4 Drive      21.4
## Hornet Sportabout   18.7
## Valiant             18.1
## Duster 360          14.3
## Merc 240D           24.4
## Merc 230            22.8
## Merc 280            19.2
## Merc 280C           17.8
## Merc 450SE          16.4
## Merc 450SL          17.3
## Merc 450SLC         15.2
## Cadillac Fleetwood  10.4
## Lincoln Continental 10.4
## Chrysler Imperial   14.7
## Fiat 128            32.4
## Honda Civic         30.4
## Toyota Corolla      33.9
## Toyota Corona       21.5
## Dodge Challenger    15.5
## AMC Javelin         15.2
## Camaro Z28          13.3
## Pontiac Firebird    19.2
## Fiat X1-9           27.3
## Porsche 914-2       26.0
## Lotus Europa        30.4
## Ford Pantera L      15.8
## Ferrari Dino        19.7
## Maserati Bora       15.0
## Volvo 142E          21.4
```

##### `$`

`$` is a shorthand operator, where `x$y` is equivalent to `x[["y", exact = FALSE]]`.  It's often used to access variables in a data frame:


```r
# these two are equivalent
mtcars[["cyl"]]
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
```

```r
mtcars$cyl
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
```

One common mistake with `$` is to try and use it when you have the name of a column stored in a variable:


```r
var <- "cyl"
# Doesn't work - mtcars$var translated to mtcars[["var"]]
mtcars$var
```

```
## NULL
```

```r
# Instead use [[
mtcars[[var]]
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
```

#### Subassignment

All subsetting operators can be combined with an assignment operator to modify selected values of the input vector.


```r
x <- 1:5
x
```

```
## [1] 1 2 3 4 5
```

```r
x[c(1, 2)] <- 2:3
x
```

```
## [1] 2 3 3 4 5
```

```r
# The length of the LHS needs to match the RHS!
x[-1] <- 4:1
x
```

```
## [1] 2 4 3 2 1
```

```r
x[1] <- 4:1
```

```
## Warning in x[1] <- 4:1: number of items to replace is not a multiple of
## replacement length
```

```r
# This is mostly useful when conditionally modifying vectors
df <- data.frame(a = c(1, 10, NA))
df
```

```
##    a
## 1  1
## 2 10
## 3 NA
```

```r
df$a[df$a < 5] <- 0
df
```

```
##    a
## 1  0
## 2 10
## 3 NA
```


## Tidyverse

### The Big Picture

> "Tidy data sets are easy to manipulate, model and visualize, and have a specific structure: each variable is a column, each observation is a row, and each type of observational unit is a table." - Hadley Wickham

1.  Variables -\> **Columns**
2.  Observations -\> **Rows**
3.  Values -\> **Cells**

![Tidy Data Example (Source: R for Data Science)](https://garrettgman.github.io/images/tidy-1.png)

If dataframes are tidy, it's easy to transform, visualize, model, and program them using tidyverse packages (a whole workflow).

![Tidyverse: an opinionated collection of R packages](https://miro.medium.com/max/960/0*mlPyX0NE0WQwEzpS.png)

-   Nevertheless, don't be **religious**.

> In summary, tidy data is a useful conceptual idea and is often the right way to go for general, small data sets, but may not be appropriate for all problems. - Jeff Leek

For instance, in many data science applications, linear algebra-based computations are essential (e.g., [Principal Component Analysis](https://www.math.upenn.edu/~kazdan/312S13/JJ/PCA-JJ.pdf)). These computations are optimized to work on matrices, not tidy data frames (for more information, read [Jeff Leek's blog post](https://simplystatistics.org/2016/02/17/non-tidy-data/)).

This is what tidy data looks like.


```r
library(tidyverse)

table1
```

```
## # A tibble: 6 × 4
##   country      year  cases population
##   <chr>       <int>  <int>      <int>
## 1 Afghanistan  1999    745   19987071
## 2 Afghanistan  2000   2666   20595360
## 3 Brazil       1999  37737  172006362
## 4 Brazil       2000  80488  174504898
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```


**Additional tips** 

There are so many different ways of looking at data in R. Can you discuss the pros and cons of each approach? Which one do you prefer and why?


* `str(table1)`

* `glimpse(table1)`: similar to `str()` cleaner output 

* `skim(table1)`: `str()` + `summary()` + more 


- The big picture 
    - Tidying data with **tidyr**
    - Processing data with **dplyr**
    
These two packages don't do anything new but simplify most common tasks in data manipulation. Plus, they are fast, consistent, and more readable.

Practically, this approach is right because you will have consistency in data format across all the projects you're working on. Also, tidy data works well with key packages (e.g., `dplyr,` `ggplot2`) in R.

Computationally, this approach is useful for vectorized programming because "different variables from the same observation are always paired". Vectorized means a function applies to a vector that treats each element individually (=operations working in parallel).

## Tidying (tidyr)

### Reshaping

**Signs of messy datasets**

* 1. Column headers are values, not variable names.
* 2. Multiple variables are not stored in one column.
* 3. Variables are stored in both rows and columns.
* 4. Multiple types of observational units are stored in the same table.
* 5. A single observational unit is stored in multiple tables.

Let's take a look at the cases of untidy data.

![Messy Data Case 1 (Source: R for Data Science)](https://garrettgman.github.io/images/tidy-5.png)

-   Make It Longer

    | Col1 | Col2 | Col3 |
    |------|------|------|
    |      |      |      |
    |      |      |      |
    |      |      |      |

**Challenge**: Why is this data not tidy?


```r
table4a
```

```
## # A tibble: 3 × 3
##   country     `1999` `2000`
## * <chr>        <int>  <int>
## 1 Afghanistan    745   2666
## 2 Brazil       37737  80488
## 3 China       212258 213766
```

-   Let's pivot (rotate by 90 degrees).


![Concept map for pivoting. By Florian Schmoll, Monica Alonso.](https://github.com/rstudio/concept-maps/raw/master/en/pivoting.svg)


-   [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html) increases the number of rows (longer) and decreases the number of columns. The inverse function is `pivot_wider()`. These functions improve the usability of `gather()` and `spread()`.

![What pivot\_longer() does (Source: <https://www.storybench.org>)](https://www.storybench.org/wp-content/uploads/2019/08/pivot-longer-image.png)


![Concept map for pipe operator. By Jeroen Janssens, Monica Alonso.](https://education.rstudio.com/blog/2020/09/concept-maps/pipe-operator.png)

- The pipe operator `%>%` originally comes from the `magrittr` package. The idea behind the pipe operator is [similar to](https://www.datacamp.com/community/tutorials/pipe-r-tutorial) what we learned about chaining functions in high school. f: B -> C and g: A -> B can be expressed as $f(g(x))$. The pipe operator chains operations. When reading the pipe operator, read as "and then" (Wickham's recommendation). The keyboard shortcut is ctrl + shift + M. The key idea here is not creating temporary variables and focusing on verbs (functions). We'll learn more about this functional programming paradigm later on.


```r
table4a 
```

```
## # A tibble: 3 × 3
##   country     `1999` `2000`
## * <chr>        <int>  <int>
## 1 Afghanistan    745   2666
## 2 Brazil       37737  80488
## 3 China       212258 213766
```

```r
# Old way, less intuitive
table4a %>%
  gather(
    key = "year", # Current column names
    value = "cases", # The values matched to cases
    c("1999", "2000")
  ) # Selected columns
```

```
## # A tibble: 6 × 3
##   country     year   cases
##   <chr>       <chr>  <int>
## 1 Afghanistan 1999     745
## 2 Brazil      1999   37737
## 3 China       1999  212258
## 4 Afghanistan 2000    2666
## 5 Brazil      2000   80488
## 6 China       2000  213766
```


```r
# New way, more intuitive
table4a %>%
  pivot_longer(
    cols = c("1999", "2000"), # Selected columns
    names_to = "year", # Shorter columns (the columns going to be in one column called year)
    values_to = "cases"
  ) # Longer rows (the values are going to be in a separate column called named cases)
```

```
## # A tibble: 6 × 3
##   country     year   cases
##   <chr>       <chr>  <int>
## 1 Afghanistan 1999     745
## 2 Afghanistan 2000    2666
## 3 Brazil      1999   37737
## 4 Brazil      2000   80488
## 5 China       1999  212258
## 6 China       2000  213766
```

-   There's another problem, did you catch it?

-   The data type of `year` variable should be `numeric` not `character`. By default, `pivot_longer()` transforms uninformative columns to character.

-   You can fix this problem by using `names_transform` argument.


```r
table4a %>%
  pivot_longer(
    cols = c("1999", "2000"), # Put two columns together
    names_to = "year", # Shorter columns (the columns going to be in one column called year)
    values_to = "cases", # Longer rows (the values are going to be in a separate column called named cases)
    names_transform = list(year = readr::parse_number)
  ) # Transform the variable
```

```
## # A tibble: 6 × 3
##   country      year  cases
##   <chr>       <dbl>  <int>
## 1 Afghanistan  1999    745
## 2 Afghanistan  2000   2666
## 3 Brazil       1999  37737
## 4 Brazil       2000  80488
## 5 China        1999 212258
## 6 China        2000 213766
```

**Additional tips**

`parse_number()` also keeps only numeric information in a variable.


```r
parse_number("reply1994")
```

```
## [1] 1994
```

A flat file (e.g., CSV) is a rectangular shaped combination of strings. [Parsing](https://cran.r-project.org/web/packages/readr/vignettes/readr.html) determines the type of each column and turns into a vector of a more specific type. Tidyverse has `parse_` functions (from `readr` package) that are flexible and fast (e.g., `parse_integer()`, `parse_double()`, `parse_logical()`, `parse_datetime()`, `parse_date()`, `parse_time()`, `parse_factor()`, etc).

-   Let's do another practice.

**Challenge**

1.  Why is this data not tidy? (This exercise comes from [`pivot` function vigenette](https://tidyr.tidyverse.org/articles/pivot.html).) Too long or too wide?


```r
billboard
```

```
## # A tibble: 317 × 79
##    artist   track   date.entered   wk1   wk2   wk3   wk4   wk5   wk6   wk7   wk8
##    <chr>    <chr>   <date>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 2 Pac    Baby D… 2000-02-26      87    82    72    77    87    94    99    NA
##  2 2Ge+her  The Ha… 2000-09-02      91    87    92    NA    NA    NA    NA    NA
##  3 3 Doors… Krypto… 2000-04-08      81    70    68    67    66    57    54    53
##  4 3 Doors… Loser   2000-10-21      76    76    72    69    67    65    55    59
##  5 504 Boyz Wobble… 2000-04-15      57    34    25    17    17    31    36    49
##  6 98^0     Give M… 2000-08-19      51    39    34    26    26    19     2     2
##  7 A*Teens  Dancin… 2000-07-08      97    97    96    95   100    NA    NA    NA
##  8 Aaliyah  I Don'… 2000-01-29      84    62    51    41    38    35    35    38
##  9 Aaliyah  Try Ag… 2000-03-18      59    53    38    28    21    18    16    14
## 10 Adams, … Open M… 2000-08-26      76    76    74    69    68    67    61    58
## # … with 307 more rows, and 68 more variables: wk9 <dbl>, wk10 <dbl>,
## #   wk11 <dbl>, wk12 <dbl>, wk13 <dbl>, wk14 <dbl>, wk15 <dbl>, wk16 <dbl>,
## #   wk17 <dbl>, wk18 <dbl>, wk19 <dbl>, wk20 <dbl>, wk21 <dbl>, wk22 <dbl>,
## #   wk23 <dbl>, wk24 <dbl>, wk25 <dbl>, wk26 <dbl>, wk27 <dbl>, wk28 <dbl>,
## #   wk29 <dbl>, wk30 <dbl>, wk31 <dbl>, wk32 <dbl>, wk33 <dbl>, wk34 <dbl>,
## #   wk35 <dbl>, wk36 <dbl>, wk37 <dbl>, wk38 <dbl>, wk39 <dbl>, wk40 <dbl>,
## #   wk41 <dbl>, wk42 <dbl>, wk43 <dbl>, wk44 <dbl>, wk45 <dbl>, wk46 <dbl>, …
```

2.  How can you fix it? Which pivot?


```r
# Old way
billboard %>%
  gather(
    key = "week",
    value = "rank",
    starts_with("wk")
  ) %>% # Use regular expressions
  drop_na() # Drop NAs
```

```
## # A tibble: 5,307 × 5
##    artist         track                   date.entered week   rank
##    <chr>          <chr>                   <date>       <chr> <dbl>
##  1 2 Pac          Baby Don't Cry (Keep... 2000-02-26   wk1      87
##  2 2Ge+her        The Hardest Part Of ... 2000-09-02   wk1      91
##  3 3 Doors Down   Kryptonite              2000-04-08   wk1      81
##  4 3 Doors Down   Loser                   2000-10-21   wk1      76
##  5 504 Boyz       Wobble Wobble           2000-04-15   wk1      57
##  6 98^0           Give Me Just One Nig... 2000-08-19   wk1      51
##  7 A*Teens        Dancing Queen           2000-07-08   wk1      97
##  8 Aaliyah        I Don't Wanna           2000-01-29   wk1      84
##  9 Aaliyah        Try Again               2000-03-18   wk1      59
## 10 Adams, Yolanda Open My Heart           2000-08-26   wk1      76
## # … with 5,297 more rows
```

-   Note that `pivot_longer()` is more versatile than `gather()`.


```r
# New way
billboard %>%
  pivot_longer(
    cols = starts_with("wk"), # Use regular expressions
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE # Drop NAs
  )
```

```
## # A tibble: 5,307 × 5
##    artist  track                   date.entered week   rank
##    <chr>   <chr>                   <date>       <chr> <dbl>
##  1 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk1      87
##  2 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk2      82
##  3 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk3      72
##  4 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk4      77
##  5 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk5      87
##  6 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk6      94
##  7 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk7      99
##  8 2Ge+her The Hardest Part Of ... 2000-09-02   wk1      91
##  9 2Ge+her The Hardest Part Of ... 2000-09-02   wk2      87
## 10 2Ge+her The Hardest Part Of ... 2000-09-02   wk3      92
## # … with 5,297 more rows
```

-   Make It Wider

-   Why is this data not tidy?


```r
table2
```

```
## # A tibble: 12 × 4
##    country      year type            count
##    <chr>       <int> <chr>           <int>
##  1 Afghanistan  1999 cases             745
##  2 Afghanistan  1999 population   19987071
##  3 Afghanistan  2000 cases            2666
##  4 Afghanistan  2000 population   20595360
##  5 Brazil       1999 cases           37737
##  6 Brazil       1999 population  172006362
##  7 Brazil       2000 cases           80488
##  8 Brazil       2000 population  174504898
##  9 China        1999 cases          212258
## 10 China        1999 population 1272915272
## 11 China        2000 cases          213766
## 12 China        2000 population 1280428583
```

-   Each observation is spread across two rows.

-   How can you fix it?: `pivot_wider()`.

**Two differences between `pivot_longer()` and `pivot_wider()`**

-   In `pivot_longer()`, the arguments are named `names_to` and `values_to` (*to*).

-   In `pivot_wider()`, this pattern is opposite. The arguments are named `names_from` and `values_from` (*from*).

-   The number of required arguments for `pivot_longer()` is 3 (col, names\_to, values\_to).

-   The number of required arguments for `pivot_wider()` is 2 (names\_from, values\_from).

![What pivot\_wider() does (Source: <https://www.storybench.org>)](https://www.storybench.org/wp-content/uploads/2019/08/pivot-wider-image.png)


```r
# Old way
table2 %>%
  spread(
    key = type,
    value = count
  )
```

```
## # A tibble: 6 × 4
##   country      year  cases population
##   <chr>       <int>  <int>      <int>
## 1 Afghanistan  1999    745   19987071
## 2 Afghanistan  2000   2666   20595360
## 3 Brazil       1999  37737  172006362
## 4 Brazil       2000  80488  174504898
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```


```r
# New way
table2 %>%
  pivot_wider(
    names_from = type, # first
    values_from = count # second
  )
```

```
## # A tibble: 6 × 4
##   country      year  cases population
##   <chr>       <int>  <int>      <int>
## 1 Afghanistan  1999    745   19987071
## 2 Afghanistan  2000   2666   20595360
## 3 Brazil       1999  37737  172006362
## 4 Brazil       2000  80488  174504898
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```

Sometimes, a consultee came to me and asked: "I don't have missing values in my original dataframe. Then R said that I had missing values after doing some data transformations. What happened?"

Here's an answer.

R defines missing values in two ways.

-   *Implicit missing values*: simply not present in the data.

-   *Explicit missing values*: flagged with NA

**Challenge**

The example comes from [*R for Data Science*](https://r4ds.had.co.nz/tidy-data.html).


```r
stocks <- tibble(
  year = c(2019, 2019, 2019, 2020, 2020, 2020),
  qtr = c(1, 2, 3, 2, 3, 4),
  return = c(1, 2, 3, NA, 2, 3)
)

stocks
```

```
## # A tibble: 6 × 3
##    year   qtr return
##   <dbl> <dbl>  <dbl>
## 1  2019     1      1
## 2  2019     2      2
## 3  2019     3      3
## 4  2020     2     NA
## 5  2020     3      2
## 6  2020     4      3
```

-   Where is the explicit missing value?

-   Does `stocks` have implicit missing values?


```r
# implicit missing values become explicit
stocks %>%
  pivot_wider(
    names_from = year,
    values_from = return
  )
```

```
## # A tibble: 4 × 3
##     qtr `2019` `2020`
##   <dbl>  <dbl>  <dbl>
## 1     1      1     NA
## 2     2      2     NA
## 3     3      3      2
## 4     4     NA      3
```

**Challenge**

-   This exercise comes from [`pivot` function vigenette](https://tidyr.tidyverse.org/articles/pivot.html).

-   Could you make `station` a series of dummy variables using `pivot_wider()`?


```r
fish_encounters
```

```
## # A tibble: 114 × 3
##    fish  station  seen
##    <fct> <fct>   <int>
##  1 4842  Release     1
##  2 4842  I80_1       1
##  3 4842  Lisbon      1
##  4 4842  Rstr        1
##  5 4842  Base_TD     1
##  6 4842  BCE         1
##  7 4842  BCW         1
##  8 4842  BCE2        1
##  9 4842  BCW2        1
## 10 4842  MAE         1
## # … with 104 more rows
```

1.  Which pivot should you use?

2.  Are there explicit missing values?

3.  How could you turn these NAs into 0s? Check `values_fill` argument in the `pivot_wider()` function.

-   Separate

![Messy Data Case 2 (Source: R for Data Science)](https://garrettgman.github.io/images/tidy-6.png)


```r
# Toy example
df <- data.frame(x = c(NA, "Dad.apple", "Mom.orange", "Daughter.banana"))

df
```

```
##                 x
## 1            <NA>
## 2       Dad.apple
## 3      Mom.orange
## 4 Daughter.banana
```


```r
# Separate
df %>%
  separate(x, into = c("Name", "Preferred_fruit"))
```

```
##       Name Preferred_fruit
## 1     <NA>            <NA>
## 2      Dad           apple
## 3      Mom          orange
## 4 Daughter          banana
```

```r
# Don't need the first variable

df %>%
  separate(x, into = c(NA, "Preferred_fruit"))
```

```
##   Preferred_fruit
## 1            <NA>
## 2           apple
## 3          orange
## 4          banana
```

**Practice**


```r
table3
```

```
## # A tibble: 6 × 3
##   country      year rate             
## * <chr>       <int> <chr>            
## 1 Afghanistan  1999 745/19987071     
## 2 Afghanistan  2000 2666/20595360    
## 3 Brazil       1999 37737/172006362  
## 4 Brazil       2000 80488/174504898  
## 5 China        1999 212258/1272915272
## 6 China        2000 213766/1280428583
```

-   Note `sep` argument. You can specify how to separate joined values.


```r
table3 %>%
  separate(rate,
    into = c("cases", "population"),
    sep = "/"
  )
```

```
## # A tibble: 6 × 4
##   country      year cases  population
##   <chr>       <int> <chr>  <chr>     
## 1 Afghanistan  1999 745    19987071  
## 2 Afghanistan  2000 2666   20595360  
## 3 Brazil       1999 37737  172006362 
## 4 Brazil       2000 80488  174504898 
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```

-   Note `convert` argument. You can specify whether automatically convert the new values or not.


```r
table3 %>%
  separate(rate,
    into = c("cases", "population"),
    sep = "/",
    convert = TRUE
  ) # cases and population become integers
```

```
## # A tibble: 6 × 4
##   country      year  cases population
##   <chr>       <int>  <int>      <int>
## 1 Afghanistan  1999    745   19987071
## 2 Afghanistan  2000   2666   20595360
## 3 Brazil       1999  37737  172006362
## 4 Brazil       2000  80488  174504898
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```

-   Unite

`pivot_longer()` \<-\> `pivot_wider()`

`separate()` \<-\> `unite()`


```r
# Create a toy example
df <- data.frame(
  name = c("Jae", "Sun", "Jane", NA),
  birthmonth = c("April", "April", "June", NA)
)

# Include missing values
df %>% unite(
  "contact",
  c("name", "birthmonth")
)
```

```
##     contact
## 1 Jae_April
## 2 Sun_April
## 3 Jane_June
## 4     NA_NA
```

```r
# Do not include missing values
df %>% unite("contact",
  c("name", "birthmonth"),
  na.rm = TRUE
)
```

```
##     contact
## 1 Jae_April
## 2 Sun_April
## 3 Jane_June
## 4
```

### Filling

This is a relatively less-known function of the tidyr package. However, I found this function super useful to complete time-series data. For instance, how can you replace NA in the following example (this use case is drawn from the [tidyr package vignette](https://tidyr.tidyverse.org/reference/fill.html).)?


```r
# Example 
stock <- tibble::tribble(
  ~ quarter, ~ year, ~stock_price, 
  "Q1", 2000, 10000, 
  "Q2", NA, 10001, # Replace NA with 2000  
  "Q3", NA, 10002, # Replace NA with 2000 
  "Q4", NA, 10003, # Replace NA with 2000 
  "Q1", 2001, 10004, 
  "Q2", NA, 10005, # Replace NA with 2001 
  "Q3", NA, 10006, # Replace NA with 2001 
  "Q4", NA, 10007, # Replace NA with 2001
)

fill(stock, year)
```

```
## # A tibble: 8 × 3
##   quarter  year stock_price
##   <chr>   <dbl>       <dbl>
## 1 Q1       2000       10000
## 2 Q2       2000       10001
## 3 Q3       2000       10002
## 4 Q4       2000       10003
## 5 Q1       2001       10004
## 6 Q2       2001       10005
## 7 Q3       2001       10006
## 8 Q4       2001       10007
```

Let's take a slightly more complex example. 


```r
# Example 
yelp_rate <- tibble::tribble(
  ~ neighborhood, ~restraurant_type, ~popularity_rate, 
  "N1", "Chinese", 5, 
  "N2", NA, 4,   
  "N3", NA, 3,  
  "N4", NA, 2,  
  "N1", "Indian", 1, 
  "N2", NA, 2,  
  "N3", NA, 3,  
  "N4", NA, 4, 
  "N1", "Mexican", 5
)

fill(yelp_rate, restraurant_type) # default is direction = .down 
```

```
## # A tibble: 9 × 3
##   neighborhood restraurant_type popularity_rate
##   <chr>        <chr>                      <dbl>
## 1 N1           Chinese                        5
## 2 N2           Chinese                        4
## 3 N3           Chinese                        3
## 4 N4           Chinese                        2
## 5 N1           Indian                         1
## 6 N2           Indian                         2
## 7 N3           Indian                         3
## 8 N4           Indian                         4
## 9 N1           Mexican                        5
```

```r
fill(yelp_rate, restraurant_type, .direction = "up") 
```

```
## # A tibble: 9 × 3
##   neighborhood restraurant_type popularity_rate
##   <chr>        <chr>                      <dbl>
## 1 N1           Chinese                        5
## 2 N2           Indian                         4
## 3 N3           Indian                         3
## 4 N4           Indian                         2
## 5 N1           Indian                         1
## 6 N2           Mexican                        2
## 7 N3           Mexican                        3
## 8 N4           Mexican                        4
## 9 N1           Mexican                        5
```

## Manipulating (dplyr)


![Concept map for dplyr. By Monica Alonso, Greg Wilson.](https://education.rstudio.com/blog/2020/09/concept-maps/dplyr.png)

`dplyr` is better than the base R approaches to data processing:

- fast to run (due to the C++ backed) and intuitive to type
- works well with tidy data and databases (thanks to [`dbplyr`](https://dbplyr.tidyverse.org/))

### Rearranging

-   Arrange

-   Order rows


```r
dplyr::arrange(mtcars, mpg) # Low to High (default)
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
```

```r
dplyr::arrange(mtcars, desc(mpg)) # High to Row
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
```

-   Rename

-   Rename columns


```r
df <- tibble(y = c(2011, 2012, 2013))

df %>%
  rename(
    Year = # NEW name
    y
  ) # OLD name
```

```
## # A tibble: 3 × 1
##    Year
##   <dbl>
## 1  2011
## 2  2012
## 3  2013
```

### Subset observations (rows)

-   Choose row by logical condition

-   Single condition

































































































































































































































