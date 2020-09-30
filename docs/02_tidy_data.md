# Tidy data and its friends {#tidy_data}

## Setup 


- Check your `dplyr` package is up-to-date by typing `packageVersion("dplyr")`. If the current installed version is less than 1.0, then update by typing `update.packages("dplyr")`. You may need to restart R to make it work.


```r
ifelse(packageVersion("dplyr") > 1, 
       "The installed version of dplyr package is greater than or equal to 1.0.0", update.packages("dplyr"))
```

```
## [1] "The installed version of dplyr package is greater than or equal to 1.0.0"
```

```r
if (!require("pacman")) install.packages("pacman")
```

```
## Loading required package: pacman
```

```r
pacman::p_load(
  tidyverse, # for the tidyverse framework
  here # for computational reproducibility
  )
```

The rest of the chapter follows the basic structure in [the Data Wrangling Cheat Sheet](https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) created by RStudio.

## Tidyverse way of thinking data science workflow 

- [Tidyverse design guide](https://design.tidyverse.org/unifying-principles.html)

    - Human centered 
    
    - Consistent 
    
    - Composable (modualized)
    
    - Inclusive 
    
    - Influenced by the [Basics of the Unix Philosophy](https://homepage.cs.uri.edu/~thenry/resources/unix_art/ch01s06.html), [The Zen of Python](https://www.python.org/dev/peps/pep-0020/), and the [Design Principles Behind Smalltalk](https://refs.devinmcgloin.com/smalltalk/Design-Principles-Behind-Smalltalk.pdf)
    
## Tidy data and why it matters

> "Tidy data sets are easy to manipulate, model and visualize, and have a specific structure: each variable is a column, each observation is a row, and each type of observational unit is a table." - Hadley Wickham

1. Variables -> **Columns**
2. Observations -> **Rows**
3. Values -> **Cells**

![Tidy Data Example (Source: R for Data Science)](https://garrettgman.github.io/images/tidy-1.png)

If dataframes are tidy, it's easy to transform, visualize, model, and program them using tidyverse packages (a whole workflow).

![Tidyverse: an opinionated collection of R packages](https://miro.medium.com/max/960/0*mlPyX0NE0WQwEzpS.png)

- Nevertheless, don't be **religious**.

> In summary, tidy data is a useful conceptual idea and is often the right way to go for general, small data sets, but may not be appropriate for all problems. - Jeff Leek

For instance, in many data science applications, linear algebra-based computations are essential (e.g., [Principal Component Analysis](https://www.math.upenn.edu/~kazdan/312S13/JJ/PCA-JJ.pdf)). These computations are optimized to work on matrices, not tidy data frames (for more information, read [Jeff Leek's blog post](https://simplystatistics.org/2016/02/17/non-tidy-data/)).


This is what a tidy data looks like.


```r
library(tidyverse)

table1
```

```
## # A tibble: 6 x 4
##   country      year  cases population
##   <chr>       <int>  <int>      <int>
## 1 Afghanistan  1999    745   19987071
## 2 Afghanistan  2000   2666   20595360
## 3 Brazil       1999  37737  172006362
## 4 Brazil       2000  80488  174504898
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```

## Wrangling data

## Wrangling data at scale

## Modeling and visualizing tidy data
