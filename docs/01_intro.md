# Managing data and code {#Intro}

## Project-oriented research

### Computational reproducibility

#### Setup


```r
pacman::p_load(
  tidyverse, # tidyverse
  here # computational reproducibility
)
```

#### Motivation 

Why do you need to make your research project computationally reproducible?

For your self-interest and public benefits. 

![](https://github.com/dlab-berkeley/efficient-reproducible-project-management-in-R/blob/master/misc/screenshot.png?raw=true)

#### How to organize files in a project 

You won't be able to reproduce your project unless it is efficiently organized. 

Step 1. [**Environment**](https://environments.rstudio.com/) is part of your project. Don't share them across workspaces. If someone can't reproduce your environment, they won't be able to run your code.

- Launch R Studio. Choose Tools > Global Options. You should not check `Restor .RData into workspace at startup` and set saving workspace option to `NEVER`.

Step 2. For each project, create a project directory named after the project. 


```r
# Don't name it a project. Use a name that's more informative.

dir.create("../starwars")
```

Step 3. Launch R Studio. Choose File > New project > Browse existing directories > Create project This allows each project has its own workspace. 

Step 4. Organize files by putting them in separate subdirectories and naming them in a sensible way.

- Treat raw data as read only (raw data should be RAW!) and put in the `data` directory.


```r
dir.create(here::here("project", "data"))
```

- Separate read-only data from processed data and put in the `processed_data` subdirectory.


```r
dir.create(here::here("project", "processed_data"))
```

- Put your code in the `src` directory. 


```r
dir.create(here::here("project", "processed_data"))
```

- Put generated outputs (e.g., tables, figures) in the `outputs` subdirectory and treat them as disposable.


```r
dir.create(here::here("project", "outputs"))
```

- Put your custom functions in the `functions` subdirectory. You can put some of them together later as a package. 


```r
dir.create(here::here("project", "functions"))
```

**Challenge 2**

Set a project structure for a project named "starwars". 

#### How to organize code in a R markdown file 

- In addition to environment, **workflow** is an important component of project efficiency and reproducibility. 

- R Markdown basic syntax 


```r
# Header 1
## Header 2
### Header 3
```

- Use these section headings to indicate workflow.


```r
# Import packages and data
# Tidy data
# Wrangle data
# Model data
# Visualize data
```

- Press `ctrl + shift + o`. You can see a document outline based on these headings. This is a nice feature for finding code you need to focus. 

- If your project's scale is large, then divide these sections into files, number, and save them in `code` subdirectory. 

   - 01_tidying.Rmd
   - 02_transforming.Rmd 
   ... 

#### Making a project computationally reproducible

- `setwd()`: set a working directory. 

- Note that using `setwd()` is not a reproducible way to set up your project. For instance, none will be able to run the following code except me.


```r
# Set a working directory 
setwd("/home/jae/starwars")

# Do something 
ggplot(mtcars, aes(x = mpg, y = wt)) +
   geom_point()

# dot means the working directory set by setwd()
ggsave("./outputs/example.png") # This is called relative path 
```

- Instead, learn how to use `here()`'.

   - Key idea: separate workflow (e.g., workspace information) from products (code and data). For more information, read Jenny Bryan's wonderful piece on [project-oriented workflow](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/).

   - Example 


```r
# New: Reproducible 

ggplot(mtcars, aes(x = mpg, y = wt)) +
   geom_point()

ggsave(here("project", "outputs", "example.png"))
```

   - How `here` works 

   `here()` function shows what's the top-level project directory. 


```r
here::here()
```
   - Build a path including subdirectories 


```r
here::here("project", "outputs")
           #depth 1   #depth 2
```
   - How `here` defines the top-level project directory. The following list came from [the here package vignette](https://github.com/jennybc/here_here)).

      - Is a file named .here present?
      - Is this an RStudio Project? (**Note that we already set up an RStudio Project!** So, if you use RStudio's project feature, then you are ready to use `here`.)
      - Is this an R package? Does it have a DESCRIPTION file?
      - Is this a remake project? Does it have a file named `remake.yml`?
      - Is this a projectile project? Does it have a file named `.projectile`?
      - Is this a checkout from a version control system? Does it have a directory named `.git` or `.svn`? Currently, only Git and Subversion are supported.

      - If there's no match then use `set_here()` to create an empty `.here` file. 

**Challenge 1**

1. Can you define computational reproducibility? 
2. Can you explain why sharing code and data is not enough for computational reproducibility? 

### Version control (Git and Bash)

![](https://github.com/dlab-berkeley/BashGit/raw/master/octobash.png)

#### What Is Bash?

##### Writing your first shell script 

Write a shell script that creates a directory called `/pdfs` under `/Download` directory, then find PDF files in `/Download` and copy those files to `pdfs`. This shell script creates a backup.

```bash

#!/bin/sh

mkdir /home/jae/Downloads/pdfs 

cd Download

cp *.pdf pdfs/ 

echo "Copied pdfs"

```

#### What Are Git and GitHub?

![Figure 2.1. A schematic git workflow from Healy's "The Plain Person’s Guide to Plain Text Social Science"](https://plain-text.co/figures/git-basic.png)

##### Basics: `git push` and `git pull`

##### Time machine: `git revert` 

##### Parallel universe: `git branch`

##### User-manual: `readme`

- README.md 

![](https://libapps.s3.amazonaws.com/accounts/125446/images/README_Sample.png)

- In this simple markdown file, note some basic information about the project including the project structure.

- This is how I used the `README.md` file for this course. Check out [my GitHub account](https://github.com/jaeyk) to see how I manage my projects.

#### Deployment: GitHub Pages 

#### Tracking progress: GitHub Issues 

#### Project management: GitHub Dashboards

## Writing code: How to code like a professional

### Write readable code 

- Files 
- When naming files:
    - Don't use special characters.
    - Don't capitalize.
    - Numbering them if files should be run in an order.


```r
# Good
fit_models.R
# Bad
fit models.R
```

- Objects
- When naming objects:
    - Don't use special characters.
    - Don't capitalize.


```r
# Good 
day_one
    
# Bad 
DayOne
```

- Functions 
- When naming functions:
    - Don't use special characters.
    - Don't capitalize.
    - Use `verbs` instead of `nouns`.
    

```r
# Good 
run_rdd 

# Bad 
rdd
```
    
- Spacing 


```r
# Good
x[, 1] 

mean(x, na.rm = TRUE) 

if (debug) show(x) 

function(x) {}

height <- (feet * 12) + inches

sqrt(x^2 + y^2)

# Bad

x[,1]

mean (x, na.rm = TRUE)

if(debug) show(x)

function(x){}

height <- (feet*12) + inches

sqrt(x ^ 2 + y ^ 2)
```

- Indenting 


```r
# Good
if (y < 0 && debug) {
  message("y is negative")
}

# Bad
if (y < 0 && debug)
message("Y is negative")
```

- Long lines


```r
# Good
do_something_very_complicated(
  something = "that",
  requires = many,
  arguments = "some of which may be long"
)

# Bad
do_something_very_complicated("that", requires, many, arguments,
                              "some of which may be long"
                              )
```

- Comments 
   - Use comments to explain why you make what decisions. 
   - Show your code; Do not try to explain your code by comments.
   - Also, try to comment out rather than delete the code that you experiment with. 


```r
# Comment out
# mean(jae$sleep, na.rm = T)
```

- Pipes 


```r
# Good
iris %>%
  group_by(Species) %>%
  summarize_if(is.numeric, mean) %>%
  ungroup() %>%
  gather(measure, value, -Species) %>%
  arrange(value)

# Bad
iris %>% group_by(Species) %>% summarize_all(mean) %>%
ungroup %>% gather(measure, value, -Species) %>%
arrange(value)
```

- Additional tips 

- Use `lintr` to check whether your code complies with a recommended style guideline (e.g., `tidyverse`) and `styler` package to format your code according to the style guideline.

![how lintr works](https://camo.githubusercontent.com/6cb80270269165a8d3046d2da03cbf2b8f19ee2f/687474703a2f2f692e696d6775722e636f6d2f61635632374e562e676966)

### Write reusable code 

- Pasting 

> Copy-and-paste programming, sometimes referred to as just pasting, is the production of highly repetitive computer programming code, as produced by copy and paste operations. It is primarily a pejorative term; those who use the term are often implying a lack of programming competence. It may also be the result of technology limitations (e.g., an insufficiently expressive development environment) as subroutines or libraries would normally be used instead. However, there are occasions when copy-and-paste programming is considered acceptable or necessary, such as for boilerplate, loop unrolling (when not supported automatically by the compiler), or certain programming idioms, and it is supported by some source code editors in the form of snippets. - Wikipedia 

- Example 

- Let's imagine `df` is a survey data. 

    - a, b, c, d = Survey respondents 

    - -99: non-responses 
    
    - Your goal: replace -99 with NA 
    

```r
# Data
df <- tibble("a" = -99,
             "b" = -99,
             "c" = -99,
             "d" = -99)
             
# Copy and paste 
df$a[df$a == -99] <- NA
df$b[df$b == -99] <- NA
df$c[df$c == -99] <- NA
df$d[df$d == -99] <- NA

df
```

```
## # A tibble: 1 x 4
##       a     b     c     d
##   <dbl> <dbl> <dbl> <dbl>
## 1    NA    NA    NA    NA
```

- Using a function 
   - function: input + computation + output 
   - If you write a function, you gain efficiency because you don't need to copy and paste the computation part. 


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

- Automation
   - Many options for automation in R: `for loop`, `apply` family, etc. 
   - Here's a tidy solution comes from `purrr` package.
   - The power and joy of one-liner. 


```r
df <- purrr::map_df(df, fix_missing)
df
```

Takeaway: Your code is more reusable, when it's easier to change, debug, and scale up.

### Test your code systematically 

## Asking questions: Minimal reproducible example

### How to create a minimal reproducible example

**References**

- Project-oriented research 

   - Computational reproducibility 

      - ["Good Enough Practices in Scientific Computing"](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/good-enough-practices-for-scientific-computing.pdf) by PLOS
      
      - [Project Management with RStudio](https://swcarpentry.github.io/r-novice-gapminder/02-project-intro/) by Software Carpentry
      
      - [Initial steps toward reproducible research](https://kbroman.org/steps2rr/) by Karl Broman
      
   - Version control 
   
      - [Version Control with Git](https://swcarpentry.github.io/git-novice/) by Software Carpentry
   
      - [The Plain Person’s Guide to Plain Text Social Science](http://plain-text.co/) by Kieran Healy 
      
- Writing code 

   - Style guides 
      - R 
         - [Google's R style guide](https://google.github.io/styleguide/Rguide.xml)
         - [R code style guide](http://r-pkgs.had.co.nz/r.html) by Hadley Wickham 
         - [The tidyverse style guide](http://style.tidyverse.org/) by Hadley Wickham
      - Python 
         - [Google Python Style Guide](https://github.com/google/styleguide/blob/gh-pages/pyguide.md)
         - [Code Style](https://docs.python-guide.org/writing/style/#zen-of-python) by the Hitchhiker's Guide to Python

- Asking questions 
