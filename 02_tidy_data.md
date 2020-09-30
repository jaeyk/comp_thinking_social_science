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
  here, # for computational reproducibility
  gapminder, # toy data
  nycflights13 # for exercise 
  )
```

The rest of the chapter follows the basic structure in [the Data Wrangling Cheat Sheet](https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) created by RStudio.

## Tidyverse 

- [Tidyverse design guide](https://design.tidyverse.org/unifying-principles.html)

    - Human centered 
    
    - Consistent 
    
    - Composable (modualized)
    
    - Inclusive 
    
    - Influenced by the [Basics of the Unix Philosophy](https://homepage.cs.uri.edu/~thenry/resources/unix_art/ch01s06.html), [The Zen of Python](https://www.python.org/dev/peps/pep-0020/), and the [Design Principles Behind Smalltalk](https://refs.devinmcgloin.com/smalltalk/Design-Principles-Behind-Smalltalk.pdf)
    
## Tidy data 

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

## Reshaping

Let's take a look at the cases of untidy data.

![Messy Data Case 1 (Source: R for Data Science)](https://garrettgman.github.io/images/tidy-5.png)

- Make It Longer

**Challenge**: Why this data is not tidy?


```r
table4a
```

```
## # A tibble: 3 x 3
##   country     `1999` `2000`
## * <chr>        <int>  <int>
## 1 Afghanistan    745   2666
## 2 Brazil       37737  80488
## 3 China       212258 213766
```

- Let's pivot (rotate by 90 degree).

- [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html) increases the number of rows (longer) and decreases the number of columns. The inverse function is `pivot_wider()`. These functions improve the usability of `gather()` and `spread()`.

![What pivot_longer() does (Source: https://www.storybench.org)](https://www.storybench.org/wp-content/uploads/2019/08/pivot-longer-image.png)


```r
# Old way, less intuitive
table4a %>%
  gather(key = "cases", # Current column names
         value = "year", # The values matched to cases
         c("1999", "2000")) # Selected columns
```

```
## # A tibble: 6 x 3
##   country     cases   year
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
    values_to = "cases") # Longer rows (the values are going to be in a separate column called named cases)
```

```
## # A tibble: 6 x 3
##   country     year   cases
##   <chr>       <chr>  <int>
## 1 Afghanistan 1999     745
## 2 Afghanistan 2000    2666
## 3 Brazil      1999   37737
## 4 Brazil      2000   80488
## 5 China       1999  212258
## 6 China       2000  213766
```

- There's another problem, did you catch it?

- The data type of `year` variable should be `numeric` not `character`. By default, `pivot_longer()` transforms uninformative columns to character.

- You can fix this problem by using `names_transform` argument.


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
## # A tibble: 6 x 3
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

- Let's do another practice. 

**Challenge**

1. Why this data is not tidy? (This exercise comes from [`pivot` function vigenette](https://tidyr.tidyverse.org/articles/pivot.html).) Too long or too wide?


```r
billboard
```

```
## # A tibble: 317 x 79
##    artist track date.entered   wk1   wk2   wk3   wk4   wk5   wk6   wk7   wk8
##    <chr>  <chr> <date>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 2 Pac  Baby… 2000-02-26      87    82    72    77    87    94    99    NA
##  2 2Ge+h… The … 2000-09-02      91    87    92    NA    NA    NA    NA    NA
##  3 3 Doo… Kryp… 2000-04-08      81    70    68    67    66    57    54    53
##  4 3 Doo… Loser 2000-10-21      76    76    72    69    67    65    55    59
##  5 504 B… Wobb… 2000-04-15      57    34    25    17    17    31    36    49
##  6 98^0   Give… 2000-08-19      51    39    34    26    26    19     2     2
##  7 A*Tee… Danc… 2000-07-08      97    97    96    95   100    NA    NA    NA
##  8 Aaliy… I Do… 2000-01-29      84    62    51    41    38    35    35    38
##  9 Aaliy… Try … 2000-03-18      59    53    38    28    21    18    16    14
## 10 Adams… Open… 2000-08-26      76    76    74    69    68    67    61    58
## # … with 307 more rows, and 68 more variables: wk9 <dbl>, wk10 <dbl>,
## #   wk11 <dbl>, wk12 <dbl>, wk13 <dbl>, wk14 <dbl>, wk15 <dbl>, wk16 <dbl>,
## #   wk17 <dbl>, wk18 <dbl>, wk19 <dbl>, wk20 <dbl>, wk21 <dbl>, wk22 <dbl>,
## #   wk23 <dbl>, wk24 <dbl>, wk25 <dbl>, wk26 <dbl>, wk27 <dbl>, wk28 <dbl>,
## #   wk29 <dbl>, wk30 <dbl>, wk31 <dbl>, wk32 <dbl>, wk33 <dbl>, wk34 <dbl>,
## #   wk35 <dbl>, wk36 <dbl>, wk37 <dbl>, wk38 <dbl>, wk39 <dbl>, wk40 <dbl>,
## #   wk41 <dbl>, wk42 <dbl>, wk43 <dbl>, wk44 <dbl>, wk45 <dbl>, wk46 <dbl>,
## #   wk47 <dbl>, wk48 <dbl>, wk49 <dbl>, wk50 <dbl>, wk51 <dbl>, wk52 <dbl>,
## #   wk53 <dbl>, wk54 <dbl>, wk55 <dbl>, wk56 <dbl>, wk57 <dbl>, wk58 <dbl>,
## #   wk59 <dbl>, wk60 <dbl>, wk61 <dbl>, wk62 <dbl>, wk63 <dbl>, wk64 <dbl>,
## #   wk65 <dbl>, wk66 <lgl>, wk67 <lgl>, wk68 <lgl>, wk69 <lgl>, wk70 <lgl>,
## #   wk71 <lgl>, wk72 <lgl>, wk73 <lgl>, wk74 <lgl>, wk75 <lgl>, wk76 <lgl>
```

2. How can you fix it? Which pivot?


```r
# Old way
billboard %>%
  gather(key = "week",
         value = "rank",
         starts_with("wk")) %>% # Use regular expressions
  drop_na() # Drop NAs
```

```
## # A tibble: 5,307 x 5
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

- Note that `pivot_longer()` is more versatile than `gather()`.


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
## # A tibble: 5,307 x 5
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

- Make It Wider

- Why this data is not tidy? 


```r
table2
```

```
## # A tibble: 12 x 4
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

- Each observation is spread across two rows.

- How can you fix it?: `pivot_wider()`.

**Two differences between `pivot_longer()` and `pivot_wider()`**

- In `pivot_longer()`, the arguments are named `names_to` and `values_to` (*to*). 

- In `pivot_wider()`, this pattern is opposite. The arguments are named `names_from` and `values_from` (*from*).

- The number of required arguments for `pivot_longer()` is 3 (col, names_to, values_to). 

- The number of required arguments for `pivot_wider()` is 2 (names_from, values_from).

![What pivot_wider() does (Source: https://www.storybench.org)](https://www.storybench.org/wp-content/uploads/2019/08/pivot-wider-image.png)


```r
# Old way
table2 %>%
  spread(key = type,
         value = count)
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


```r
# New way
table2 %>%
  pivot_wider(
    names_from = type, # first
    values_from = count # second
  )
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

Sometimes, a consultee came to me and asked: "I don't have missing values in my original dataframe. Then R said that I have missing values after I've done some data transformations. What happened?" 

Here's an answer. 

R defines missing values in two ways.

- *Implicit missing values*: simply not present in the data.

- *Explicit missing values*: flagged with NA

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
## # A tibble: 6 x 3
##    year   qtr return
##   <dbl> <dbl>  <dbl>
## 1  2019     1      1
## 2  2019     2      2
## 3  2019     3      3
## 4  2020     2     NA
## 5  2020     3      2
## 6  2020     4      3
```

- Where is explicit missing value?

- Does `stocks` have implicit missing values?


```r
# implicit missing values become explicit 
stocks %>%
  pivot_wider(names_from = year, 
              values_from = return)
```

```
## # A tibble: 4 x 3
##     qtr `2019` `2020`
##   <dbl>  <dbl>  <dbl>
## 1     1      1     NA
## 2     2      2     NA
## 3     3      3      2
## 4     4     NA      3
```

**Challenge**

- This exercise comes from [`pivot` function vigenette](https://tidyr.tidyverse.org/articles/pivot.html).

- Could you make `station` a series of dummy variables using `pivot_wider()`?


```r
fish_encounters 
```

```
## # A tibble: 114 x 3
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

1. Which pivot you should use?

2. Are there explicit missing values? 

3. How could you turn these NAs into 0s? Check `values_fill` argument in the `pivot_wider()` function. 

- Separate

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
## # A tibble: 6 x 3
##   country      year rate             
## * <chr>       <int> <chr>            
## 1 Afghanistan  1999 745/19987071     
## 2 Afghanistan  2000 2666/20595360    
## 3 Brazil       1999 37737/172006362  
## 4 Brazil       2000 80488/174504898  
## 5 China        1999 212258/1272915272
## 6 China        2000 213766/1280428583
```

- Note `sep` argument. You can specify how to separate joined values.


```r
table3 %>%
  separate(rate,
           into = c("cases", "population"),
           sep = "/")
```

```
## # A tibble: 6 x 4
##   country      year cases  population
##   <chr>       <int> <chr>  <chr>     
## 1 Afghanistan  1999 745    19987071  
## 2 Afghanistan  2000 2666   20595360  
## 3 Brazil       1999 37737  172006362 
## 4 Brazil       2000 80488  174504898 
## 5 China        1999 212258 1272915272
## 6 China        2000 213766 1280428583
```

- Note `convert` argument. You can specify whether automatically convert the new values or not.


```r
table3 %>%
  separate(rate,
           into = c("cases", "population"),
           sep = "/",
           convert = TRUE) # cases and population become integers
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

- Unite

`pivot_longer()` <-> `pivot_wider()`

`separate()` <-> `unite()`


```r
# Create a toy example
df <- data.frame(
  name = c("Jae", "Sun", "Jane", NA),
  birthmonth = c("April", "April", "June", NA))

# Include missing values
df %>% unite("contact",
             c("name", "birthmonth"))
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
             na.rm = TRUE)
```

```
##     contact
## 1 Jae_April
## 2 Sun_April
## 3 Jane_June
## 4
```

## Rearranging

- Arrange

- Order rows


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

- Rename

- Rename columns


```r
df <- tibble(y = c(2011, 2012, 2013))

df
```

```
## # A tibble: 3 x 1
##       y
##   <dbl>
## 1  2011
## 2  2012
## 3  2013
```

```r
df %>% rename(Year = # OLD name
                y) # NEW name
```

```
## # A tibble: 3 x 1
##    Year
##   <dbl>
## 1  2011
## 2  2012
## 3  2013
```


## Subset observations (rows)

- Choose row by logical condition 

- Single condition 


```r
starwars %>%
  filter(gender == "female") %>%
  arrange(desc(height))
```

```
## # A tibble: 0 x 14
## # … with 14 variables: name <chr>, height <int>, mass <dbl>, hair_color <chr>,
## #   skin_color <chr>, eye_color <chr>, birth_year <dbl>, sex <chr>,
## #   gender <chr>, homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

The following filtering example was inspired by [the suzanbert's dplyr blog post](https://suzan.rbind.io/2018/02/dplyr-tutorial-3/).

- Multiple conditions (numeric)


```r
# First example
starwars %>%
  filter(height < 180, height > 160) %>%
  nrow()
```

```
## [1] 24
```

```r
# Same as above
starwars %>%
  filter(height < 180 & height > 160) %>%
  nrow()
```

```
## [1] 24
```

```r
# Not same as above
starwars %>%
  filter(height < 180 | height > 160) %>%
  nrow()
```

```
## [1] 81
```

**Challenge**

(1) Use `filter(between())` to find characters whose heights are between 180 and 160 and (2) count the number of these observations.  

- Minimum reproducible example 


```r
df <- tibble(
  heights = c(160:180),
  char = rep("none", length(c(160:180)))
)

df %>%
  filter(between(heights, 161, 179))
```

```
## # A tibble: 19 x 2
##    heights char 
##      <int> <chr>
##  1     161 none 
##  2     162 none 
##  3     163 none 
##  4     164 none 
##  5     165 none 
##  6     166 none 
##  7     167 none 
##  8     168 none 
##  9     169 none 
## 10     170 none 
## 11     171 none 
## 12     172 none 
## 13     173 none 
## 14     174 none 
## 15     175 none 
## 16     176 none 
## 17     177 none 
## 18     178 none 
## 19     179 none
```

- Multiple conditions (character)


```r
# Filter names include ars; `grepl` is a base R function  

starwars %>%
  filter(grepl("ars", tolower(name)))
```

```
## # A tibble: 4 x 14
##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
## 1 Owen…    178   120 brown, gr… light      blue              52 male  mascu…
## 2 Beru…    165    75 brown      light      blue              47 fema… femin…
## 3 Quar…    183    NA black      dark       brown             62 <NA>  <NA>  
## 4 Clie…    183    NA brown      fair       blue              82 male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

```r
# Or, if you prefer dplyr way 

starwars %>%
  filter(str_detect(tolower(name), "ars"))
```

```
## # A tibble: 4 x 14
##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
## 1 Owen…    178   120 brown, gr… light      blue              52 male  mascu…
## 2 Beru…    165    75 brown      light      blue              47 fema… femin…
## 3 Quar…    183    NA black      dark       brown             62 <NA>  <NA>  
## 4 Clie…    183    NA brown      fair       blue              82 male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

```r
# Filter brown and black hair_color

starwars %>%
  filter(hair_color %in% c("black", "brown"))
```

```
## # A tibble: 31 x 14
##    name  height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Leia…    150  49   brown      light      brown           19   fema… femin…
##  2 Beru…    165  75   brown      light      blue            47   fema… femin…
##  3 Bigg…    183  84   black      light      brown           24   male  mascu…
##  4 Chew…    228 112   brown      unknown    blue           200   male  mascu…
##  5 Han …    180  80   brown      fair       brown           29   male  mascu…
##  6 Wedg…    170  77   brown      fair       hazel           21   male  mascu…
##  7 Jek …    180 110   brown      fair       blue            NA   male  mascu…
##  8 Boba…    183  78.2 black      fair       brown           31.5 male  mascu…
##  9 Land…    177  79   black      dark       brown           31   male  mascu…
## 10 Arve…     NA  NA   brown      fair       brown           NA   male  mascu…
## # … with 21 more rows, and 5 more variables: homeworld <chr>, species <chr>,
## #   films <list>, vehicles <list>, starships <list>
```

**Challenge**

Use `str_detect()` to find characters whose names include "Han".

- Choose row by position (row index)


```r
starwars %>%
  arrange(desc(height)) %>%
  slice(1:6)
```

```
## # A tibble: 6 x 14
##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
## 1 Yara…    264    NA none       white      yellow            NA male  mascu…
## 2 Tarf…    234   136 brown      brown      blue              NA male  mascu…
## 3 Lama…    229    88 none       grey       black             NA male  mascu…
## 4 Chew…    228   112 brown      unknown    blue             200 male  mascu…
## 5 Roos…    224    82 none       grey       orange            NA male  mascu…
## 6 Grie…    216   159 none       brown, wh… green, y…         NA male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

- Sample by fraction


```r
# For reproducibility 
set.seed(1234)

# Old way 

starwars %>%
  sample_frac(0.10, 
              replace = FALSE) # Without replacement 
```

```
## # A tibble: 9 x 14
##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
## 1 Arve…     NA    NA brown      fair       brown           NA   male  mascu…
## 2 Sly …    178    48 none       pale       white           NA   <NA>  <NA>  
## 3 IG-88    200   140 none       metal      red             15   none  mascu…
## 4 Bigg…    183    84 black      light      brown           24   male  mascu…
## 5 Leia…    150    49 brown      light      brown           19   fema… femin…
## 6 Watto    137    NA black      blue, grey yellow          NA   male  mascu…
## 7 Jabb…    175  1358 <NA>       green-tan… orange         600   herm… mascu…
## 8 Dart…    202   136 none       white      yellow          41.9 male  mascu…
## 9 Taun…    213    NA none       grey       black           NA   fema… femin…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

```r
# New way

starwars %>%
  slice_sample(prop = 0.10, 
             replace = FALSE)
```

```
## # A tibble: 8 x 14
##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
## 1 Raym…    188  79   brown      light      brown           NA   male  mascu…
## 2 Tarf…    234 136   brown      brown      blue            NA   male  mascu…
## 3 Han …    180  80   brown      fair       brown           29   male  mascu…
## 4 Mas …    196  NA   none       blue       blue            NA   male  mascu…
## 5 Barr…    166  50   black      yellow     blue            40   fema… femin…
## 6 Dart…    202 136   none       white      yellow          41.9 male  mascu…
## 7 Finn      NA  NA   black      dark       dark            NA   male  mascu…
## 8 Boba…    183  78.2 black      fair       brown           31.5 male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

- Sample by number 


```r
# Old way 

starwars %>%
  sample_n(20, 
           replace = FALSE) # Without replacement 
```

```
## # A tibble: 20 x 14
##    name  height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Quar…    183    NA black      dark       brown             62 <NA>  <NA>  
##  2 Poe …     NA    NA brown      light      brown             NA male  mascu…
##  3 Mas …    196    NA none       blue       blue              NA male  mascu…
##  4 Zam …    168    55 blonde     fair, gre… yellow            NA fema… femin…
##  5 Leia…    150    49 brown      light      brown             19 fema… femin…
##  6 Jang…    183    79 black      tan        brown             66 male  mascu…
##  7 Ben …    163    65 none       grey, gre… orange            NA male  mascu…
##  8 Padm…    165    45 brown      light      brown             46 fema… femin…
##  9 Mace…    188    84 none       dark       brown             72 male  mascu…
## 10 R2-D2     96    32 <NA>       white, bl… red               33 none  mascu…
## 11 Shmi…    163    NA black      fair       brown             72 fema… femin…
## 12 Ratt…     79    15 none       grey, blue unknown           NA male  mascu…
## 13 Nute…    191    90 none       mottled g… red               NA male  mascu…
## 14 Dart…    175    80 none       red        yellow            54 male  mascu…
## 15 Bib …    180    NA none       pale       pink              NA male  mascu…
## 16 C-3PO    167    75 <NA>       gold       yellow           112 none  mascu…
## 17 Yara…    264    NA none       white      yellow            NA male  mascu…
## 18 Ki-A…    198    82 white      pale       yellow            92 male  mascu…
## 19 BB8       NA    NA none       none       black             NA none  mascu…
## 20 Eeth…    171    NA black      brown      brown             NA male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

```r
# New way

starwars %>%
  slice_sample(n = 20, 
             replace = FALSE) # Without replacement 
```

```
## # A tibble: 20 x 14
##    name  height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Owen…    178   120 brown, gr… light      blue              52 male  mascu…
##  2 Ki-A…    198    82 white      pale       yellow            92 male  mascu…
##  3 Capt…     NA    NA unknown    unknown    unknown           NA <NA>  <NA>  
##  4 Greg…    185    85 black      dark       brown             NA male  mascu…
##  5 R5-D4     97    32 <NA>       white, red red               NA none  mascu…
##  6 Ackb…    180    83 none       brown mot… orange            41 male  mascu…
##  7 Wedg…    170    77 brown      fair       hazel             21 male  mascu…
##  8 Dormé    165    NA brown      light      brown             NA fema… femin…
##  9 Rey       NA    NA brown      light      hazel             NA fema… femin…
## 10 IG-88    200   140 none       metal      red               15 none  mascu…
## 11 Roos…    224    82 none       grey       orange            NA male  mascu…
## 12 Shmi…    163    NA black      fair       brown             72 fema… femin…
## 13 R2-D2     96    32 <NA>       white, bl… red               33 none  mascu…
## 14 Poe …     NA    NA brown      light      brown             NA male  mascu…
## 15 Obi-…    182    77 auburn, w… fair       blue-gray         57 male  mascu…
## 16 Plo …    188    80 none       orange     black             22 male  mascu…
## 17 Tarf…    234   136 brown      brown      blue              NA male  mascu…
## 18 Lobot    175    79 none       light      blue              37 male  mascu…
## 19 San …    191    NA none       grey       gold              NA male  mascu…
## 20 Kit …    196    87 none       green      black             NA male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

- Top 10 rows orderd by height


```r
# Old way 
starwars %>% 
  top_n(10, height) 
```

```
## # A tibble: 10 x 14
##    name  height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Dart…    202   136 none       white      yellow          41.9 male  mascu…
##  2 Chew…    228   112 brown      unknown    blue           200   male  mascu…
##  3 Roos…    224    82 none       grey       orange          NA   male  mascu…
##  4 Rugo…    206    NA none       green      orange          NA   male  mascu…
##  5 Yara…    264    NA none       white      yellow          NA   male  mascu…
##  6 Lama…    229    88 none       grey       black           NA   male  mascu…
##  7 Taun…    213    NA none       grey       black           NA   fema… femin…
##  8 Grie…    216   159 none       brown, wh… green, y…       NA   male  mascu…
##  9 Tarf…    234   136 brown      brown      blue            NA   male  mascu…
## 10 Tion…    206    80 none       grey       black           NA   male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

```r
# New way
starwars %>%
  slice_max(height, n = 10) # Variable first, Argument second 
```

```
## # A tibble: 10 x 14
##    name  height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Yara…    264    NA none       white      yellow          NA   male  mascu…
##  2 Tarf…    234   136 brown      brown      blue            NA   male  mascu…
##  3 Lama…    229    88 none       grey       black           NA   male  mascu…
##  4 Chew…    228   112 brown      unknown    blue           200   male  mascu…
##  5 Roos…    224    82 none       grey       orange          NA   male  mascu…
##  6 Grie…    216   159 none       brown, wh… green, y…       NA   male  mascu…
##  7 Taun…    213    NA none       grey       black           NA   fema… femin…
##  8 Rugo…    206    NA none       green      orange          NA   male  mascu…
##  9 Tion…    206    80 none       grey       black           NA   male  mascu…
## 10 Dart…    202   136 none       white      yellow          41.9 male  mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

## Subset variables (columns)


```r
names(msleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```

- Select only numeric columns 


```r
# Only numeric 
msleep %>%
  select(where(is.numeric))
```

```
## # A tibble: 83 x 6
##    sleep_total sleep_rem sleep_cycle awake  brainwt  bodywt
##          <dbl>     <dbl>       <dbl> <dbl>    <dbl>   <dbl>
##  1        12.1      NA        NA      11.9 NA        50    
##  2        17         1.8      NA       7    0.0155    0.48 
##  3        14.4       2.4      NA       9.6 NA         1.35 
##  4        14.9       2.3       0.133   9.1  0.00029   0.019
##  5         4         0.7       0.667  20    0.423   600    
##  6        14.4       2.2       0.767   9.6 NA         3.85 
##  7         8.7       1.4       0.383  15.3 NA        20.5  
##  8         7        NA        NA      17   NA         0.045
##  9        10.1       2.9       0.333  13.9  0.07     14    
## 10         3        NA        NA      21    0.0982   14.8  
## # … with 73 more rows
```

**Challenge** 

Use `select(where())` to find only non-numeric columns 

- Select the columns that include "sleep" in their names 
 

```r
msleep %>%
  select(contains("sleep"))
```

```
## # A tibble: 83 x 3
##    sleep_total sleep_rem sleep_cycle
##          <dbl>     <dbl>       <dbl>
##  1        12.1      NA        NA    
##  2        17         1.8      NA    
##  3        14.4       2.4      NA    
##  4        14.9       2.3       0.133
##  5         4         0.7       0.667
##  6        14.4       2.2       0.767
##  7         8.7       1.4       0.383
##  8         7        NA        NA    
##  9        10.1       2.9       0.333
## 10         3        NA        NA    
## # … with 73 more rows
```

- Select the columns that include either "sleep" or "wt" in their names 

- Basic R way 

`grepl` is one of the R base pattern matching functions. 


```r
msleep[grepl('sleep|wt', names(msleep))]
```

```
## # A tibble: 83 x 5
##    sleep_total sleep_rem sleep_cycle  brainwt  bodywt
##          <dbl>     <dbl>       <dbl>    <dbl>   <dbl>
##  1        12.1      NA        NA     NA        50    
##  2        17         1.8      NA      0.0155    0.48 
##  3        14.4       2.4      NA     NA         1.35 
##  4        14.9       2.3       0.133  0.00029   0.019
##  5         4         0.7       0.667  0.423   600    
##  6        14.4       2.2       0.767 NA         3.85 
##  7         8.7       1.4       0.383 NA        20.5  
##  8         7        NA        NA     NA         0.045
##  9        10.1       2.9       0.333  0.07     14    
## 10         3        NA        NA      0.0982   14.8  
## # … with 73 more rows
```

**Challenge**

Use `select(match())` to find columns whose names include either "sleep" or "wt". 

- Select the columns that starts with "b"


```r
msleep %>%
  select(starts_with("b"))
```

```
## # A tibble: 83 x 2
##     brainwt  bodywt
##       <dbl>   <dbl>
##  1 NA        50    
##  2  0.0155    0.48 
##  3 NA         1.35 
##  4  0.00029   0.019
##  5  0.423   600    
##  6 NA         3.85 
##  7 NA        20.5  
##  8 NA         0.045
##  9  0.07     14    
## 10  0.0982   14.8  
## # … with 73 more rows
```

- Select the columns that ends with "wt"


```r
msleep %>%
  select(ends_with("wt"))
```

```
## # A tibble: 83 x 2
##     brainwt  bodywt
##       <dbl>   <dbl>
##  1 NA        50    
##  2  0.0155    0.48 
##  3 NA         1.35 
##  4  0.00029   0.019
##  5  0.423   600    
##  6 NA         3.85 
##  7 NA        20.5  
##  8 NA         0.045
##  9  0.07     14    
## 10  0.0982   14.8  
## # … with 73 more rows
```

- Select the columns using both beginning and end string patterns 

The key idea is you can use Boolean operators (`!`, `&`, `|`)to combine different string pattern matching statements. 


```r
msleep %>%
  select(starts_with("b") & ends_with("wt"))
```

```
## # A tibble: 83 x 2
##     brainwt  bodywt
##       <dbl>   <dbl>
##  1 NA        50    
##  2  0.0155    0.48 
##  3 NA         1.35 
##  4  0.00029   0.019
##  5  0.423   600    
##  6 NA         3.85 
##  7 NA        20.5  
##  8 NA         0.045
##  9  0.07     14    
## 10  0.0982   14.8  
## # … with 73 more rows
```

- Select order and move it before everything 


```r
# By specifying a column 
msleep %>%
  select(order, everything())
```

```
## # A tibble: 83 x 11
##    order name  genus vore  conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Carn… Chee… Acin… carni lc                  12.1      NA        NA      11.9
##  2 Prim… Owl … Aotus omni  <NA>                17         1.8      NA       7  
##  3 Rode… Moun… Aplo… herbi nt                  14.4       2.4      NA       9.6
##  4 Sori… Grea… Blar… omni  lc                  14.9       2.3       0.133   9.1
##  5 Arti… Cow   Bos   herbi domesticated         4         0.7       0.667  20  
##  6 Pilo… Thre… Brad… herbi <NA>                14.4       2.2       0.767   9.6
##  7 Carn… Nort… Call… carni vu                   8.7       1.4       0.383  15.3
##  8 Rode… Vesp… Calo… <NA>  <NA>                 7        NA        NA      17  
##  9 Carn… Dog   Canis carni domesticated        10.1       2.9       0.333  13.9
## 10 Arti… Roe … Capr… herbi lc                   3        NA        NA      21  
## # … with 73 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```

- Select variables from a character vector.


```r
msleep %>%
  select(any_of(c("name", "order"))) %>%
  colnames()
```

```
## [1] "name"  "order"
```

- Select the variables named in the character + number pattern


```r
msleep$week8 <- NA

msleep$week12 <- NA

msleep$week_extra <- 0 

msleep %>%
  select(num_range("week", c(1:12)))
```

```
## # A tibble: 83 x 2
##    week8 week12
##    <lgl> <lgl> 
##  1 NA    NA    
##  2 NA    NA    
##  3 NA    NA    
##  4 NA    NA    
##  5 NA    NA    
##  6 NA    NA    
##  7 NA    NA    
##  8 NA    NA    
##  9 NA    NA    
## 10 NA    NA    
## # … with 73 more rows
```

## Counting 

- How may countries in each continent?


```r
gapminder %>%
  count(continent)
```

```
## # A tibble: 5 x 2
##   continent     n
##   <fct>     <int>
## 1 Africa      624
## 2 Americas    300
## 3 Asia        396
## 4 Europe      360
## 5 Oceania      24
```

- Let's arrange the result. 


```r
# Just add a new argument `sort = TRUE`
gapminder %>%
  count(continent, sort = TRUE)
```

```
## # A tibble: 5 x 2
##   continent     n
##   <fct>     <int>
## 1 Africa      624
## 2 Asia        396
## 3 Europe      360
## 4 Americas    300
## 5 Oceania      24
```

```r
# Same as above; How nice!
gapminder %>%
  count(continent) %>%
  arrange(desc(n))
```

```
## # A tibble: 5 x 2
##   continent     n
##   <fct>     <int>
## 1 Africa      624
## 2 Asia        396
## 3 Europe      360
## 4 Americas    300
## 5 Oceania      24
```

**Challenge**

Count the number of observations per `continent` as well as `year` and arrange them with descending order. 

Let's take a deeper look at how things work under the hood.

- `tally()` works similar to `nrow()`: Calculate the total number of cases in a dataframe 

- `count` = `group_by()` + `tally()`


```r
gapminder %>%
  tally()
```

```
## # A tibble: 1 x 1
##       n
##   <int>
## 1  1704
```

- `add_tally()` = `mutate(n = n())`

**Challenge** 

What does n in the below example represent? 


```r
gapminder %>%
  select(continent, country) %>%
  add_tally()
```

```
## # A tibble: 1,704 x 3
##    continent country         n
##    <fct>     <fct>       <int>
##  1 Asia      Afghanistan  1704
##  2 Asia      Afghanistan  1704
##  3 Asia      Afghanistan  1704
##  4 Asia      Afghanistan  1704
##  5 Asia      Afghanistan  1704
##  6 Asia      Afghanistan  1704
##  7 Asia      Afghanistan  1704
##  8 Asia      Afghanistan  1704
##  9 Asia      Afghanistan  1704
## 10 Asia      Afghanistan  1704
## # … with 1,694 more rows
```

- `add_count`

Add count as a column 


```r
# Add count as a column
gapminder %>%
  group_by(continent) %>%
  add_count(year)
```

```
## # A tibble: 1,704 x 7
## # Groups:   continent [5]
##    country     continent  year lifeExp      pop gdpPercap     n
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl> <int>
##  1 Afghanistan Asia       1952    28.8  8425333      779.    33
##  2 Afghanistan Asia       1957    30.3  9240934      821.    33
##  3 Afghanistan Asia       1962    32.0 10267083      853.    33
##  4 Afghanistan Asia       1967    34.0 11537966      836.    33
##  5 Afghanistan Asia       1972    36.1 13079460      740.    33
##  6 Afghanistan Asia       1977    38.4 14880372      786.    33
##  7 Afghanistan Asia       1982    39.9 12881816      978.    33
##  8 Afghanistan Asia       1987    40.8 13867957      852.    33
##  9 Afghanistan Asia       1992    41.7 16317921      649.    33
## 10 Afghanistan Asia       1997    41.8 22227415      635.    33
## # … with 1,694 more rows
```

**Challenge**

Do the cases 1 and 2 in the below code chunk produce same outputs? If so, why?


```r
# Case 1
gapminder %>%
  group_by(continent, year) %>%
  count()
```

```
## # A tibble: 60 x 3
## # Groups:   continent, year [60]
##    continent  year     n
##    <fct>     <int> <int>
##  1 Africa     1952    52
##  2 Africa     1957    52
##  3 Africa     1962    52
##  4 Africa     1967    52
##  5 Africa     1972    52
##  6 Africa     1977    52
##  7 Africa     1982    52
##  8 Africa     1987    52
##  9 Africa     1992    52
## 10 Africa     1997    52
## # … with 50 more rows
```

```r
# Case 2
gapminder %>%
  group_by(continent) %>%
  count(year)
```

```
## # A tibble: 60 x 3
## # Groups:   continent [5]
##    continent  year     n
##    <fct>     <int> <int>
##  1 Africa     1952    52
##  2 Africa     1957    52
##  3 Africa     1962    52
##  4 Africa     1967    52
##  5 Africa     1972    52
##  6 Africa     1977    52
##  7 Africa     1982    52
##  8 Africa     1987    52
##  9 Africa     1992    52
## 10 Africa     1997    52
## # … with 50 more rows
```

## Summarizing 

### Basic 

- Create a summary 


```r
gapminder %>%
  group_by(continent) %>%
  summarise(n = n(), 
            mean_gdp = mean(gdpPercap),
            sd_gdp = sd(gdpPercap))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 4
##   continent     n mean_gdp sd_gdp
##   <fct>     <int>    <dbl>  <dbl>
## 1 Africa      624    2194.  2828.
## 2 Americas    300    7136.  6397.
## 3 Asia        396    7902. 14045.
## 4 Europe      360   14469.  9355.
## 5 Oceania      24   18622.  6359.
```

```r
tablea <- gapminder %>%
  group_by(continent) %>%
  summarise(n = n(), 
            mean_gdp = mean(gdpPercap),
            sd_gdp = sd(gdpPercap))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```
- Produce publishable tables 


```r
# For HTML and LaTeX
tablea %>% kableExtra::kable()
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> continent </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> mean_gdp </th>
   <th style="text-align:right;"> sd_gdp </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Africa </td>
   <td style="text-align:right;"> 624 </td>
   <td style="text-align:right;"> 2193.755 </td>
   <td style="text-align:right;"> 2827.930 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Americas </td>
   <td style="text-align:right;"> 300 </td>
   <td style="text-align:right;"> 7136.110 </td>
   <td style="text-align:right;"> 6396.764 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Asia </td>
   <td style="text-align:right;"> 396 </td>
   <td style="text-align:right;"> 7902.150 </td>
   <td style="text-align:right;"> 14045.373 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Europe </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> 14469.476 </td>
   <td style="text-align:right;"> 9355.213 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Oceania </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 18621.609 </td>
   <td style="text-align:right;"> 6358.983 </td>
  </tr>
</tbody>
</table>

```r
# For HTML and MS Office suite 
tablea %>% flextable::flextable()
```

<!--html_preserve--><div class="tabwid"><style>.cl-fa2ce068{font-family:'Roboto';font-size:11px;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(17, 17, 17, 1.00);background-color:transparent;}.cl-fa2cf6d4{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2px;padding-top:2px;padding-left:5px;padding-right:5px;line-height: 1.00;background-color:transparent;}.cl-fa2cf6f2{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2px;padding-top:2px;padding-left:5px;padding-right:5px;line-height: 1.00;background-color:transparent;}.cl-fa2d22bc{width:54px;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-fa2d22da{width:54px;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-fa2d22e4{width:54px;background-color:transparent;vertical-align: middle;border-bottom: 2.00px solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-fa2d22f8{width:54px;background-color:transparent;vertical-align: middle;border-bottom: 2.00px solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-fa2d2302{width:54px;background-color:transparent;vertical-align: middle;border-bottom: 2.00px solid rgba(0, 0, 0, 1.00);border-top: 2.00px solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-fa2d2316{width:54px;background-color:transparent;vertical-align: middle;border-bottom: 2.00px solid rgba(0, 0, 0, 1.00);border-top: 2.00px solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table style='border-collapse:collapse;'><thead><tr style="overflow-wrap:break-word;"><td class="cl-fa2d2302"><p class="cl-fa2cf6d4"><span class="cl-fa2ce068">continent</span></p></td><td class="cl-fa2d2316"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">n</span></p></td><td class="cl-fa2d2316"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">mean_gdp</span></p></td><td class="cl-fa2d2316"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">sd_gdp</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-fa2d22bc"><p class="cl-fa2cf6d4"><span class="cl-fa2ce068">Africa</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">624</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">2193.755</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">2827.930</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-fa2d22bc"><p class="cl-fa2cf6d4"><span class="cl-fa2ce068">Americas</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">300</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">7136.110</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">6396.764</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-fa2d22bc"><p class="cl-fa2cf6d4"><span class="cl-fa2ce068">Asia</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">396</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">7902.150</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">14045.373</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-fa2d22bc"><p class="cl-fa2cf6d4"><span class="cl-fa2ce068">Europe</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">360</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">14469.476</span></p></td><td class="cl-fa2d22da"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">9355.213</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-fa2d22e4"><p class="cl-fa2cf6d4"><span class="cl-fa2ce068">Oceania</span></p></td><td class="cl-fa2d22f8"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">24</span></p></td><td class="cl-fa2d22f8"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">18621.609</span></p></td><td class="cl-fa2d22f8"><p class="cl-fa2cf6f2"><span class="cl-fa2ce068">6358.983</span></p></td></tr></tbody></table></div><!--/html_preserve-->

### Scoped summaries

- Old way 

- `summarise_all()`


```r
# Create a wide-shaped data example 
wide_gapminder <- gapminder %>%
  filter(continent == "Europe") %>%
  pivot_wider(names_from = country, 
              values_from = gdpPercap)

# Apply summarise_all 
wide_gapminder %>%
  select(-c(1:4)) %>%
  summarise_all(mean, na.rm = TRUE)
```

```
## # A tibble: 1 x 30
##   Albania Austria Belgium `Bosnia and Her… Bulgaria Croatia `Czech Republic`
##     <dbl>   <dbl>   <dbl>            <dbl>    <dbl>   <dbl>            <dbl>
## 1   3255.  20412.  19901.            3485.    6384.   9332.           13920.
## # … with 23 more variables: Denmark <dbl>, Finland <dbl>, France <dbl>,
## #   Germany <dbl>, Greece <dbl>, Hungary <dbl>, Iceland <dbl>, Ireland <dbl>,
## #   Italy <dbl>, Montenegro <dbl>, Netherlands <dbl>, Norway <dbl>,
## #   Poland <dbl>, Portugal <dbl>, Romania <dbl>, Serbia <dbl>, `Slovak
## #   Republic` <dbl>, Slovenia <dbl>, Spain <dbl>, Sweden <dbl>,
## #   Switzerland <dbl>, Turkey <dbl>, `United Kingdom` <dbl>
```

- `summarise_if()`: using a logical condition 


```r
wide_gapminder %>%
  summarise_if(is.double, mean, na.rm = TRUE)
```

```
## # A tibble: 1 x 31
##   lifeExp Albania Austria Belgium `Bosnia and Her… Bulgaria Croatia
##     <dbl>   <dbl>   <dbl>   <dbl>            <dbl>    <dbl>   <dbl>
## 1    71.9   3255.  20412.  19901.            3485.    6384.   9332.
## # … with 24 more variables: `Czech Republic` <dbl>, Denmark <dbl>,
## #   Finland <dbl>, France <dbl>, Germany <dbl>, Greece <dbl>, Hungary <dbl>,
## #   Iceland <dbl>, Ireland <dbl>, Italy <dbl>, Montenegro <dbl>,
## #   Netherlands <dbl>, Norway <dbl>, Poland <dbl>, Portugal <dbl>,
## #   Romania <dbl>, Serbia <dbl>, `Slovak Republic` <dbl>, Slovenia <dbl>,
## #   Spain <dbl>, Sweden <dbl>, Switzerland <dbl>, Turkey <dbl>, `United
## #   Kingdom` <dbl>
```
- `summarise_at()`

- `vars() = select()`


```r
wide_gapminder %>%
  summarise_at(vars(-c(1:4)), 
               mean, na.rm = TRUE)
```

```
## # A tibble: 1 x 30
##   Albania Austria Belgium `Bosnia and Her… Bulgaria Croatia `Czech Republic`
##     <dbl>   <dbl>   <dbl>            <dbl>    <dbl>   <dbl>            <dbl>
## 1   3255.  20412.  19901.            3485.    6384.   9332.           13920.
## # … with 23 more variables: Denmark <dbl>, Finland <dbl>, France <dbl>,
## #   Germany <dbl>, Greece <dbl>, Hungary <dbl>, Iceland <dbl>, Ireland <dbl>,
## #   Italy <dbl>, Montenegro <dbl>, Netherlands <dbl>, Norway <dbl>,
## #   Poland <dbl>, Portugal <dbl>, Romania <dbl>, Serbia <dbl>, `Slovak
## #   Republic` <dbl>, Slovenia <dbl>, Spain <dbl>, Sweden <dbl>,
## #   Switzerland <dbl>, Turkey <dbl>, `United Kingdom` <dbl>
```

```r
wide_gapminder %>%
  summarise_at(vars(contains("life")), 
               mean, na.rm = TRUE)
```

```
## # A tibble: 1 x 1
##   lifeExp
##     <dbl>
## 1    71.9
```

- New way 

- `summarise()` + `across()`

- If you find using `summarise_all()`, `summarise_if()` and `summarise_at()` confusing, here's a solution: use `summarise()` with `across()`.   

- `summarise_all()`


```r
wide_gapminder %>%
  summarise(across(Albania:`United Kingdom`, mean, na.rm = TRUE))
```

```
## # A tibble: 1 x 30
##   Albania Austria Belgium `Bosnia and Her… Bulgaria Croatia `Czech Republic`
##     <dbl>   <dbl>   <dbl>            <dbl>    <dbl>   <dbl>            <dbl>
## 1   3255.  20412.  19901.            3485.    6384.   9332.           13920.
## # … with 23 more variables: Denmark <dbl>, Finland <dbl>, France <dbl>,
## #   Germany <dbl>, Greece <dbl>, Hungary <dbl>, Iceland <dbl>, Ireland <dbl>,
## #   Italy <dbl>, Montenegro <dbl>, Netherlands <dbl>, Norway <dbl>,
## #   Poland <dbl>, Portugal <dbl>, Romania <dbl>, Serbia <dbl>, `Slovak
## #   Republic` <dbl>, Slovenia <dbl>, Spain <dbl>, Sweden <dbl>,
## #   Switzerland <dbl>, Turkey <dbl>, `United Kingdom` <dbl>
```

```r
wide_gapminder %>%
  summarise(across(-c(1:4), mean, na.rm = TRUE))
```

```
## # A tibble: 1 x 30
##   Albania Austria Belgium `Bosnia and Her… Bulgaria Croatia `Czech Republic`
##     <dbl>   <dbl>   <dbl>            <dbl>    <dbl>   <dbl>            <dbl>
## 1   3255.  20412.  19901.            3485.    6384.   9332.           13920.
## # … with 23 more variables: Denmark <dbl>, Finland <dbl>, France <dbl>,
## #   Germany <dbl>, Greece <dbl>, Hungary <dbl>, Iceland <dbl>, Ireland <dbl>,
## #   Italy <dbl>, Montenegro <dbl>, Netherlands <dbl>, Norway <dbl>,
## #   Poland <dbl>, Portugal <dbl>, Romania <dbl>, Serbia <dbl>, `Slovak
## #   Republic` <dbl>, Slovenia <dbl>, Spain <dbl>, Sweden <dbl>,
## #   Switzerland <dbl>, Turkey <dbl>, `United Kingdom` <dbl>
```

- `summarise_if()`


```r
wide_gapminder %>%
  summarise(across(is.double, mean, na.rm = TRUE))
```

```
## Warning: Predicate functions must be wrapped in `where()`.
## 
##   # Bad
##   data %>% select(is.double)
## 
##   # Good
##   data %>% select(where(is.double))
## 
## ℹ Please update your code.
## This message is displayed once per session.
```

```
## # A tibble: 1 x 31
##   lifeExp Albania Austria Belgium `Bosnia and Her… Bulgaria Croatia
##     <dbl>   <dbl>   <dbl>   <dbl>            <dbl>    <dbl>   <dbl>
## 1    71.9   3255.  20412.  19901.            3485.    6384.   9332.
## # … with 24 more variables: `Czech Republic` <dbl>, Denmark <dbl>,
## #   Finland <dbl>, France <dbl>, Germany <dbl>, Greece <dbl>, Hungary <dbl>,
## #   Iceland <dbl>, Ireland <dbl>, Italy <dbl>, Montenegro <dbl>,
## #   Netherlands <dbl>, Norway <dbl>, Poland <dbl>, Portugal <dbl>,
## #   Romania <dbl>, Serbia <dbl>, `Slovak Republic` <dbl>, Slovenia <dbl>,
## #   Spain <dbl>, Sweden <dbl>, Switzerland <dbl>, Turkey <dbl>, `United
## #   Kingdom` <dbl>
```

- `summarise_at()`


```r
wide_gapminder %>%
  summarise(across(-c(1:4), 
               mean, na.rm = TRUE))
```

```
## # A tibble: 1 x 30
##   Albania Austria Belgium `Bosnia and Her… Bulgaria Croatia `Czech Republic`
##     <dbl>   <dbl>   <dbl>            <dbl>    <dbl>   <dbl>            <dbl>
## 1   3255.  20412.  19901.            3485.    6384.   9332.           13920.
## # … with 23 more variables: Denmark <dbl>, Finland <dbl>, France <dbl>,
## #   Germany <dbl>, Greece <dbl>, Hungary <dbl>, Iceland <dbl>, Ireland <dbl>,
## #   Italy <dbl>, Montenegro <dbl>, Netherlands <dbl>, Norway <dbl>,
## #   Poland <dbl>, Portugal <dbl>, Romania <dbl>, Serbia <dbl>, `Slovak
## #   Republic` <dbl>, Slovenia <dbl>, Spain <dbl>, Sweden <dbl>,
## #   Switzerland <dbl>, Turkey <dbl>, `United Kingdom` <dbl>
```

```r
wide_gapminder %>%
  summarise(across(contains("life"), 
               mean, na.rm = TRUE))
```

```
## # A tibble: 1 x 1
##   lifeExp
##     <dbl>
## 1    71.9
```

```r
wide_gapminder %>%
  summarise(across(contains("A", ignore.case = FALSE)))
```

```
## # A tibble: 360 x 2
##    Albania Austria
##      <dbl>   <dbl>
##  1   1601.      NA
##  2   1942.      NA
##  3   2313.      NA
##  4   2760.      NA
##  5   3313.      NA
##  6   3533.      NA
##  7   3631.      NA
##  8   3739.      NA
##  9   2497.      NA
## 10   3193.      NA
## # … with 350 more rows
```

Note that this workshop does not cover creating and manipulating variables using `mutate()` because many techniques you learned from playing with `summarise()` can be directly applied to `mutate()`. 

**Challenge**

1. Summarize average GDP of countries whose names starting with alphabet "A".

2. Turn the summary dataframe into a publishable table using either `kableExtra` or `flextable` package. 

## Grouping 

### Grouped summaries 

- Calculate the mean of `gdpPercap`.


```r
gapminder %>%
  group_by(continent) %>% # 
  summarise(mean_gdp = mean(gdpPercap))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 2
##   continent mean_gdp
##   <fct>        <dbl>
## 1 Africa       2194.
## 2 Americas     7136.
## 3 Asia         7902.
## 4 Europe      14469.
## 5 Oceania     18622.
```

- Calculate multiple summary statistics.


```r
gapminder %>%
  group_by(continent) %>% # 
  summarise(mean_gdp = mean(gdpPercap),
            count = n())
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 3
##   continent mean_gdp count
##   <fct>        <dbl> <int>
## 1 Africa       2194.   624
## 2 Americas     7136.   300
## 3 Asia         7902.   396
## 4 Europe      14469.   360
## 5 Oceania     18622.    24
```

**Optional**

- Other summary statistics

1. Measures of spread: `median(x)`, `sd(x)`, `IQR(x)`, `mad(x)` (the median absolute deviation)


```r
# The Interquartile Range = The Difference Between 75t and 25t Percentiles 

gapminder %>%
  group_by(continent) %>% # 
  summarise(IQR_gdp = IQR(gdpPercap))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 2
##   continent IQR_gdp
##   <fct>       <dbl>
## 1 Africa      1616.
## 2 Americas    4402.
## 3 Asia        7492.
## 4 Europe     13248.
## 5 Oceania     8072.
```

2. Measures of rank: `min(x)`, `quantile(x, 0.25)`, `max(x)`


```r
gapminder %>%
  group_by(continent) %>% # 
  summarise(min_gdp = min(gdpPercap),
            max_gdp = max(gdpPercap))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 3
##   continent min_gdp max_gdp
##   <fct>       <dbl>   <dbl>
## 1 Africa       241.  21951.
## 2 Americas    1202.  42952.
## 3 Asia         331  113523.
## 4 Europe       974.  49357.
## 5 Oceania    10040.  34435.
```

3. Measures of position: `first(x)`, `last(x)`, `nth(x, 2)`


```r
gapminder %>%
  group_by(continent) %>% 
  summarise(first_gdp = first(gdpPercap),
            last_gdp = last(gdpPercap))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 3
##   continent first_gdp last_gdp
##   <fct>         <dbl>    <dbl>
## 1 Africa        2449.     470.
## 2 Americas      5911.   11416.
## 3 Asia           779.    2281.
## 4 Europe        1601.   33203.
## 5 Oceania      10040.   25185.
```

```r
gapminder %>%
  group_by(continent) %>% 
  arrange(gdpPercap) %>% # Adding arrange
  summarise(first_gdp = first(gdpPercap),
            last_gdp = last(gdpPercap))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 3
##   continent first_gdp last_gdp
##   <fct>         <dbl>    <dbl>
## 1 Africa         241.   21951.
## 2 Americas      1202.   42952.
## 3 Asia           331   113523.
## 4 Europe         974.   49357.
## 5 Oceania      10040.   34435.
```

4. Measures of counts: `n(x)` (all rows), `sum(!is.na(x))` (only non-missing rows) = `n_distinct(x)`


```r
gapminder %>%
  group_by(continent) %>%
  summarise(ns = n())
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 2
##   continent    ns
##   <fct>     <int>
## 1 Africa      624
## 2 Americas    300
## 3 Asia        396
## 4 Europe      360
## 5 Oceania      24
```

5. Counts and proportions of logical values: `sum(condition about x)` (the number of TRUEs in x), `mean(condition about x)` (the proportion of TRUEs in x)


```r
gapminder %>%
  group_by(continent) %>% 
  summarise(rich_countries = mean(gdpPercap > 20000))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 5 x 2
##   continent rich_countries
##   <fct>              <dbl>
## 1 Africa           0.00481
## 2 Americas         0.05   
## 3 Asia             0.111  
## 4 Europe           0.261  
## 5 Oceania          0.333
```

## Nesting

### nest

The following example comes from [R for Data Science](https://r4ds.had.co.nz/many-models.html) by by Garrett Grolemund and Hadley Wickham.

- How can you run multiple models simultaneously? Using a nested data frame. 

- **Grouped data: each row = an observation**

- **Nested data: each row = a group**

**Challenge**

In the following example, why did we use `country` and `continent` for nesting variables? 


```r
nested <- gapminder %>%
  group_by(country, continent) %>%
  nest() 

head(nested)
```

```
## # A tibble: 6 x 3
## # Groups:   country, continent [6]
##   country     continent data             
##   <fct>       <fct>     <list>           
## 1 Afghanistan Asia      <tibble [12 × 4]>
## 2 Albania     Europe    <tibble [12 × 4]>
## 3 Algeria     Africa    <tibble [12 × 4]>
## 4 Angola      Africa    <tibble [12 × 4]>
## 5 Argentina   Americas  <tibble [12 × 4]>
## 6 Australia   Oceania   <tibble [12 × 4]>
```

```r
nested$data[[1]]
```

```
## # A tibble: 12 x 4
##     year lifeExp      pop gdpPercap
##    <int>   <dbl>    <int>     <dbl>
##  1  1952    28.8  8425333      779.
##  2  1957    30.3  9240934      821.
##  3  1962    32.0 10267083      853.
##  4  1967    34.0 11537966      836.
##  5  1972    36.1 13079460      740.
##  6  1977    38.4 14880372      786.
##  7  1982    39.9 12881816      978.
##  8  1987    40.8 13867957      852.
##  9  1992    41.7 16317921      649.
## 10  1997    41.8 22227415      635.
## 11  2002    42.1 25268405      727.
## 12  2007    43.8 31889923      975.
```

- Custom function 


```r
lm_model <- function(df) {
  
  lm(lifeExp ~ year, data = df)
}
```

- Apply function to the nested data 


```r
# Apply m_model to the nested data 

nested <- nested %>%
  mutate(models = map(data, lm_model)) # Add the list object as a new column

head(nested)
```

```
## # A tibble: 6 x 4
## # Groups:   country, continent [6]
##   country     continent data              models
##   <fct>       <fct>     <list>            <list>
## 1 Afghanistan Asia      <tibble [12 × 4]> <lm>  
## 2 Albania     Europe    <tibble [12 × 4]> <lm>  
## 3 Algeria     Africa    <tibble [12 × 4]> <lm>  
## 4 Angola      Africa    <tibble [12 × 4]> <lm>  
## 5 Argentina   Americas  <tibble [12 × 4]> <lm>  
## 6 Australia   Oceania   <tibble [12 × 4]> <lm>
```
S3 is part of R's object oriented systems. If you need more information, check [this section](http://adv-r.had.co.nz/S3.html) in Hadley's Advanced R out.

### unnest 

`glance()` function from `broom` package inspects the quality of a statistical model.

**Additional tips**

- `broom::glance(model)`: for evaluating model quality and/or complexity 
- `broom::tidy(model)`: for extracting each coefficient in the model (the estimates + its variability)
- `broom::augment(model, data)`: for getting extra values (residuals, and influence statistics)



```r
glanced <- nested %>%
  mutate(glance = map(models, broom::glance))

glanced$glance[[1]]
```

```
## # A tibble: 1 x 12
##   r.squared adj.r.squared sigma statistic p.value    df logLik   AIC   BIC
##       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>
## 1     0.948         0.942  1.22      181. 9.84e-8     1  -18.3  42.7  44.1
## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>
```

`unnest()` unpacks the list objects stored in glance column 


```r
glanced %>% 
  unnest(glance) %>%
  arrange(BIC) # Low to High; Lower BIC indicates a better model fit 
```

```
## # A tibble: 142 x 16
## # Groups:   country, continent [142]
##    country continent data  models r.squared adj.r.squared sigma statistic
##    <fct>   <fct>     <lis> <list>     <dbl>         <dbl> <dbl>     <dbl>
##  1 Sweden  Europe    <tib… <lm>       0.995         0.995 0.212     2203.
##  2 Switze… Europe    <tib… <lm>       0.997         0.997 0.215     3823.
##  3 France  Europe    <tib… <lm>       0.998         0.997 0.220     4200.
##  4 Canada  Americas  <tib… <lm>       0.996         0.996 0.249     2757.
##  5 Argent… Americas  <tib… <lm>       0.996         0.995 0.292     2246.
##  6 Belgium Europe    <tib… <lm>       0.995         0.994 0.293     1822.
##  7 Brazil  Americas  <tib… <lm>       0.998         0.998 0.326     5111.
##  8 Equato… Africa    <tib… <lm>       0.997         0.997 0.329     3184.
##  9 Nether… Europe    <tib… <lm>       0.982         0.980 0.348      552.
## 10 Finland Europe    <tib… <lm>       0.994         0.993 0.354     1613.
## # … with 132 more rows, and 8 more variables: p.value <dbl>, df <dbl>,
## #   logLik <dbl>, AIC <dbl>, BIC <dbl>, deviance <dbl>, df.residual <int>,
## #   nobs <int>
```

```r
glanced %>% 
  unnest(glance) %>%
  ggplot(aes(continent, BIC)) +
    geom_jitter(width = 0.5)
```

<img src="02_tidy_data_files/figure-html/unnamed-chunk-68-1.png" width="672" />

## Mapping 

We tasted a little bit about how `map()` function works. Let's dig into it deeper as this family of functions is really useful. For more information, see Rebecca Barter's wonderful tutorial on the `purrr` package. In her words, this is "the tidyverse's answer to apply functions for iteration". `map()` function can take a vector (of any type), a list, and a dataframe for input. 


```r
multiply <- function(x){
  x*x 
}

df <- list(first_obs = rnorm(7, 1, sd =1),
           second_obs = rnorm(7, 2, sd = 2)) # normal distribution 
```

**Challenge**

Try `map_df(.x = df, .f = multiply)` and tell me what's the difference between the output you got and what you saw earlier. 

If you want to know more about the power and joy of functional programming in R (e.g., `purrr::map()`), then please take ["How to Automate Repeated Things in R"](https://github.com/dlab-berkeley/R-functional-programming) workshop.

## Joining

### Mutating joins

> Add new variables to one data frame from matching observations in another"

Using a simple toy example is great because it is easy to see how things work in that much narrow context. 

- Toy example 


```r
# Table 1 
x <- tibble(key = c(1:4),
            val_x = c("x1", "x2", "x3", "x4"))

# Table 2
y <- tibble(key = c(1:5),
            val_y = c("y1", "y2", "y3", "y4", "y5"))
```

- Inner Join

`inner_join()` keeps the matched values in both tables. If the left table is a subset of the right table, then the result of `left_join()` is same as `inner_join()`.

**Challenge**

What are going to be the shared keys?


```r
inner_join(x, y)
```

```
## Joining, by = "key"
```

```
## # A tibble: 4 x 3
##     key val_x val_y
##   <int> <chr> <chr>
## 1     1 x1    y1   
## 2     2 x2    y2   
## 3     3 x3    y3   
## 4     4 x4    y4
```

![Mutating joins](https://d33wubrfki0l68.cloudfront.net/aeab386461820b029b7e7606ccff1286f623bae1/ef0d4/diagrams/join-venn.png)

- Left Join

`left_join()`, `right_join()` and `full_join()` are outer join functions. Unlike `inner_join()`, outer join functions keep observations that appear in at least one of the tables.

`left_join()` keeps only the matched observations in the right table.


```r
left_join(x, y)
```

```
## Joining, by = "key"
```

```
## # A tibble: 4 x 3
##     key val_x val_y
##   <int> <chr> <chr>
## 1     1 x1    y1   
## 2     2 x2    y2   
## 3     3 x3    y3   
## 4     4 x4    y4
```

- Right Join

`right_join()` does the opposite.


```r
right_join(x, y)
```

```
## Joining, by = "key"
```

```
## # A tibble: 5 x 3
##     key val_x val_y
##   <int> <chr> <chr>
## 1     1 x1    y1   
## 2     2 x2    y2   
## 3     3 x3    y3   
## 4     4 x4    y4   
## 5     5 <NA>  y5
```

- Full Join

`full_join()` keeps the observations from both tables. If they were unmatched, then NAs were recoded in one of the two tables.


```r
full_join(x, y)
```

```
## Joining, by = "key"
```

```
## # A tibble: 5 x 3
##     key val_x val_y
##   <int> <chr> <chr>
## 1     1 x1    y1   
## 2     2 x2    y2   
## 3     3 x3    y3   
## 4     4 x4    y4   
## 5     5 <NA>  y5
```

### Filtering joins 

> Filter observations from one data frame based on whether or not they match an observation in the other table.

- Semi Join

In SQL, this type of query is also called subqueries. 

- Filtering without joining 


```r
# Create the list of the top 10 destinations 
top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  top_n(10)
```

```
## Selecting by n
```

```r
# Filter
filtered <- flights %>%
  filter(dest %in% top_dest$dest)
```

- Using semi join: only keep (INCLUDE) the rows that were matched between the two tables 


```r
joined <- flights %>%
  semi_join(top_dest)
```

```
## Joining, by = "dest"
```

```r
head(filtered == joined)
```

```
##      year month  day dep_time sched_dep_time dep_delay arr_time sched_arr_time
## [1,] TRUE  TRUE TRUE     TRUE           TRUE      TRUE     TRUE           TRUE
## [2,] TRUE  TRUE TRUE     TRUE           TRUE      TRUE     TRUE           TRUE
## [3,] TRUE  TRUE TRUE     TRUE           TRUE      TRUE     TRUE           TRUE
## [4,] TRUE  TRUE TRUE     TRUE           TRUE      TRUE     TRUE           TRUE
## [5,] TRUE  TRUE TRUE     TRUE           TRUE      TRUE     TRUE           TRUE
## [6,] TRUE  TRUE TRUE     TRUE           TRUE      TRUE     TRUE           TRUE
##      arr_delay carrier flight tailnum origin dest air_time distance hour minute
## [1,]      TRUE    TRUE   TRUE    TRUE   TRUE TRUE     TRUE     TRUE TRUE   TRUE
## [2,]      TRUE    TRUE   TRUE    TRUE   TRUE TRUE     TRUE     TRUE TRUE   TRUE
## [3,]      TRUE    TRUE   TRUE    TRUE   TRUE TRUE     TRUE     TRUE TRUE   TRUE
## [4,]      TRUE    TRUE   TRUE    TRUE   TRUE TRUE     TRUE     TRUE TRUE   TRUE
## [5,]      TRUE    TRUE   TRUE    TRUE   TRUE TRUE     TRUE     TRUE TRUE   TRUE
## [6,]      TRUE    TRUE   TRUE    TRUE   TRUE TRUE     TRUE     TRUE TRUE   TRUE
##      time_hour
## [1,]      TRUE
## [2,]      TRUE
## [3,]      TRUE
## [4,]      TRUE
## [5,]      TRUE
## [6,]      TRUE
```

- Anti Join

`anti_join()` dose the opposite. Exclude the rows that were matched between the two tables. Great technique to filter stopwords when you do a computational text analysis.


```r
flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)
```

```
## # A tibble: 722 x 2
##    tailnum     n
##    <chr>   <int>
##  1 <NA>     2512
##  2 N725MQ    575
##  3 N722MQ    513
##  4 N723MQ    507
##  5 N713MQ    483
##  6 N735MQ    396
##  7 N0EGMQ    371
##  8 N534MQ    364
##  9 N542MQ    363
## 10 N531MQ    349
## # … with 712 more rows
```
