--- 
title: Computational Thinking for Social Scientists
author: Jae Yeon Kim
date: "2020-09-27"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography:
  - book.bib
  - packages.bib
biblio-style: apalike
link-citations: yes
github-repo: github.com/jaeyk/PS239T
description: Computational Thinking for Social Scientists
---

# PS239T

Welcome to PS239T

___

This course will help social science graduate students to think computationally and develop proficiency with computational tools and techniques, necessary to conduct research in computational social science. Mastering these tools and techniques not only enables students to collect, wrangle, analyze, and interpret data with less pain and more fun, but it also let students to work on research projects that would previously seem impossible.

## Objectives

The course is currently divided into two main subjects (fundamentals and applications) and six main sessions. 

### Part I Fundamentals

- In the first section, students learn best practices in data and code management using Git and Bash. 

- In the second, students learn how to wrangle, model, and visualize data easier and faster. 

- In the third, students learn how to use functions to automate repeated things and develop their own data tools (e.g., packages). 

### Part II Applications

- In the fourth, students learn how to collect and parse semi-structured data at scale (e.g., using APIs and webscraping). 

- In the fifth, students learn how to analyze high-dimensional data (e.g., text) using machine learning. 

- In the final, students learn how to access, query, and manage big data using SQL. 

We will learn how to do all of the above mostly in **R**, and sometimes in **bash** and **Python**.
  
## Logistics 

### Instructor

[Jae Yeon Kim](https://jaeyk.github.io/): jaeyeonkim@berkeley.edu

### Time and location 

- Lecture: TBD (Zoom)

- Section: TBD (Zoom)

### Office hours 

By appointment with ... 

### Slack & bCourses

- We will [Slack](https://slack.com/) for communication (announcements and questions) and bCourses for turning in assignments. You should ask questions about class material and assignments through the Slack channels so that everyone can benefit from the discussion. We encourage you to respond to each other’s questions as well.  

- All course materials will be posted on GitHub at https://github.com/jaeyk/PS239T, including class notes, code demonstrations, sample data, and assignments. Students are required to use GitHub for their final projects, which will be publicly available, unless they have special considerations (e.g. proprietary data).

- Textbook: https://jaeyk.github.io/PS239T/ (bookdown version of the course Git repository)

### Accessibility

This class is committed to creating an environment in which everyone can participate, regardless of background, discipline, or disability. If you have a particular concern, please come to me as soon as possible so that we can make special arrangements.
 
### Code for conduct 

TBD

### Course requirements and grades 

This is a graded class based on the following:

- Completion of assigned homework (50%)
- Participation (25%)
- Final project (25%)

#### Assignments 

Assignments will be assigned at the end of every session. They will be due at the start of the following class unless otherwise noted. The assignments will be frequent but each of them should be fairly short.

You are encouraged to work in groups, but the work you turn in must be your own. Group submission of homework, or turning in copies of the same code or output, is not acceptable. Remember, the only way you actually learn how to write code is to write code.

Unless otherwise specified, assignments should be turned in as pdf documents via the bCourses site.

#### Class participation 

The class participation portion of the grade can be satisfied in one or more of the following ways:

* attending the lecture and section (note that section is non-optional)
* asking and answering questions in class
* contributing to class discussion through the bCourse site, and/or
* collaborating with the campus computing community, either by attending a D-Lab or BIDS workshop, submitting a pull request to a campus github repository (including the class repository), answering a question on StackExchange, or other involvement in the social computing / digital humanities community.

Because we will be using laptops every class, the temptation to attend to other things during slow moments will be high. While you may choose to do so, I do request that you think of your laptop screen as in the public domain for the duration of classtime. Please do not load anything that will distract your classmates or is otherwise inappropriate to a classroom setting.  

#### Final project 

The final project consists of using the tools we learned in class on your own data of interest. First- and second-year students in the political science department are encouraged to use this as an opportunity to gather data to be used for other courses or the second-year thesis. Students are required to write a short proposal by March (no more than 2 paragraphs) in order to get approval and feedback from the instructor. 

During sections in April we will have **lightning talk sessions** where students present their projects in a maximum 5 minute talk, with 5 minutes for class Q&A. Since there is no expectation of a formal paper, you should select a project that is completable by the end of the term. In other words, submitting a research design for your future dissertation that will use skills from the class but collects no data is not acceptable, but completing a viably small portion of a study or thesis is. 

### Class activities and materials 

#### Lecture 

Classes will follow a “workshop” style, combining lecture and lab formats. The class is interactive, with students programming every session. During the “skills” parts of the class, we will be learning how to program in Unix, HTML, and R by following course notes and tutorials. During the “applications” sections, we will follow a similar structure, with occasional guest speakers.  

#### Section 

The "lab" section will generally be a less formal session dedicated to helping students with materials from lecture and homework. It will be mostly student led, so come with questions. If there are no questions, the lab turns into a "hackathon" where groups can work on the assignments together. Section is required unless prior permission to miss it is obtained from both the instructor and one's groupmates. Attending office hours is not a substitute for attending section. 

#### Computer requirements 

The software needed for the course is as follows:

* Access to the UNIX command line (e.g., a Mac laptop, a Bash wrapper on Windows)
* Git
* R and RStudio (latest versions)
* Anaconda and Python 3 (latest versions)
* Pandoc and LaTeX

This requires a computer that can handle all this software. Almost any Mac will do the job. Most Windows machines are fine too if they have enough space and memory.

You must have all the software downloaded and installed PRIOR to the first day of class. If there are issues with installation on your machine, please contact the section assistant, Julia Christensen, for assistance. 

See [B_Install.md](https://github.com/jaeyk/PS239T/blob/master/B_Install.md) for more information. 

## Course schedule

### Part I Fundamentals 



* Week 1 Computational thinking and setup
* Week 2 Managing data and code
* Week 3 Tidy data and why it matters
* Week 4 Wrangling data
* Week 5 Wrangling data at scale
* Week 6 Modeling and visualizing tidy data
* Week 7 From for loop to functional programming
* Week 8 Developing your own data tools

### Part II Applications

* Week 9 Computational thinking and setup
* Week 10 Managing data and code
* Week 11 Tidy data and why it matters
* Week 12 Wrangling data
* Week 13 Wrangling data at scale
* Week 14 Modeling and visualizing tidy data
* Week 15 From for loop to functional programming

## Questions, comments, or suggestions

Please [create issues](https://github.com/jaeyk/PS239T/issues), if you have questions, comments, or suggestions.

## Special thanks 

This course is a remix version of [the course](https://github.com/rochelleterman/PS239T) originally developed by [Rochelle Terman](https://github.com/rochelleterman).

## License 

![](https://i.creativecommons.org/l/by/4.0/88x31.png) This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

<!--chapter:end:index.Rmd-->

# Computational thinking {#motivation}

## Why computational thinking 

- If social scientists want to know how to work smart and not just hard, they need to take full advantage of the power of modern programming languages, and that power is automation. 

- Let's think about the following two cases.

  - Case 1: Suppose a social scientist needs to collect data on civic organizations in the United States from websites, Internal Revenue Service reports, and social media posts. As the number of these organizations is large, the researcher could not collect a large volume of data from diverse sources, so they would hire undergraduates and distribute tasks among them. This is a typical data collection plan in social science research, and it is labor-intensive. Automation is not part of the game plan. Yet, it is critical for so many reasons. Because the process is costly, no one is likely to either replicate or update the data collection effort. Put differently, without making the process efficient, it is difficult for it to be reproducible and scalable. 

  - Case 2: An alternative is to write computer programs that collect such data automatically, parse them, and store them in interconnected databases. Additionally, someone may need to maintain and validate the quality of the data infrastructure. Nevertheless, this approach lowers the cost of the data collection process, thereby substantially increasing the reproducibility and scalability of the process. Furthermore, the researcher can document their code and publicly share it using their GitHub repository or even gather some of the functions they used and distribute them as open-source libraries. 
  
- How can we automate our research process? How can we teach machine so that it could take over our boring job? 

- If we want social scientists to conduct research more like tech start-ups by building data infrastructure first and then developing applications (including but not limited to research articles), we also need to teach and train them to write code like professionals. To achieve this level of proficiency, it is not enough for social scientists to know how to write code that works. They also need to be able to write code that is efficient, reproducible, and reusable. Programming is as valuable a skill as writing in social science research. The extent to which a researcher can automate the research process can determine its efficiency, reproducibility, and scalability.

## Computational way of thinking about data 

### Structure 
- Structured data (Excel spreadsheets, CSVs)
  - Tidy data 
- Semi-structured data 
  - HTML/CSS: Websites 
  - JSON/XML: APIs

### Dimension
- Low-dimensional data (n > p)
  - Survey, experimental, and administrative data 
- High-dimensional data (n < p)
  - Text, speech, image, video, etc. 

### Size 
- Data fit in your laptop's memory 
- Data don't fit in your laptop's memory (=big data)

## Computational way of thinking about research process

Computational tools and techniques make ... 

- Doing traditional research easier, faster, scalable, and more reproducible
  - Data wrangling 
  - Modeling 
  - Visualization 
- Documentation and collaboration easier, faster, scalable, safer, and more experimental 
  - Dynamic reporting (markdown)
  - Version control system (Git and GitHub)
- Collecting and analyzing large and complex data possible 
  - Digital data collection (API and web scraping)
      - Building a data infrastructure (SQL)
  - Machine learning 

<!--chapter:end:00_motivation.Rmd-->

# Managing data and code {#intro}

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

Step 1. [**Environment**](https://environments.rstudio.com/) is part of your project. If someone can't reproduce your environment, they won't be able to run your code.

- Launch R Studio. Choose Tools > Global Options. You should not check `Restor .RData into workspace at startup` and set saving workspace option to `NEVER`.

Step 2. For each project, create a project directory named after the project. 


```r
# Don't name it a project. Use a name that's more informative. For instance, us_election not my_project.

dir.create("../us_election")
```

Step 3. Launch R Studio. Choose File > New project > Browse existing directories > Create project This allows each project has its own workspace. 

Step 4. Organize files by putting them in separate subdirectories and naming them in a sensible way.

- Treat raw data as read only (raw data should be RAW!) and put in the `data` directory.


```r
dir.create(here::here("us_election", "data"))
```

- Separate read-only data from processed data and put in the `processed_data` subdirectory.


```r
dir.create(here::here("us_election", "processed_data"))
```

- Put your code in the `src` directory. 


```r
dir.create(here::here("us_election", "src"))
```

- Put generated outputs (e.g., tables, figures) in the `outputs` subdirectory and treat them as disposable.


```r
dir.create(here::here("us_election", "outputs"))
```

- Put your custom functions in the `functions` subdirectory. You can gather some of these functions and distribute them as an open-source library. 


```r
dir.create(here::here("us_election", "functions"))
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

   - 01_wrangling.Rmd
   - 02_modeling.Rmd 
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

# Export the object. 
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

- What is code style?

> Every major open-source project has its own style guide: a set of conventions (sometimes arbitrary) about how to write code for that project. It is much easier to understand a large codebase when all the code in it is in a consistent style. - [Google Style Guides](https://google.github.io/styleguide/) 

- Files 
- When naming files:
    - Don't use special characters. (Spaces make filenames awkward in the console/command-line.)
    - Don't capitalize. (UNIX is case sensitive.)
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
    - Use `verbs` instead of `nouns`. (Functions do something!)
    

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

# Bad

x[,1]

mean (x, na.rm = TRUE)
```

- Indenting 


```r
# Good
if (y < 0) {
  message("y is negative")
}

# Bad
if (y < 0) {
message("Y is negative")}
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
do_something_very_complicated("that", requires = many, arguments =
                              "some of which may be long"
                              )
```

- Comments 
   - Use comments to explain your decisions. 
   - But, show your code; Do not try to explain your code by comments.
   - Also, try to comment out rather than delete the code that you experiment with. 


```r
# Average sleep hours of Jae
jae %>%
  # By week
  group_by(week) %>%
  # Mean sleep hours 
  summarise(week_sleep = mean(sleep, na.rm = TRUE))
```

- Pipes (chaining commands)


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

> Copy-and-paste programming, sometimes referred to as just pasting, is the production of highly repetitive computer programming code, as produced by copy and paste operations. It is primarily a pejorative term; those who use the term are often implying a lack of programming competence. It may also be the result of technology limitations (e.g., an insufficiently expressive development environment) as subroutines or libraries would normally be used instead. However, there are occasions when copy-and-paste programming is considered acceptable or necessary, such as for boilerplate, loop unrolling (when not supported automatically by the compiler), or certain programming idioms, and it is supported by some source code editors in the form of snippets. - [Wikipedia](https://en.wikipedia.org/wiki/Copy-and-paste_programming) 

- It's okay for pasting for the first attempt to solve a problem. But if you copy and paste three times (a.k.a. [Rule of Three](https://en.wikipedia.org/wiki/Rule_of_three_(computer_programming)) in programming), something's wrong. You're working too hard. You need to be lazy. What do I mean and how can you do that?

- Example 

- Let's imagine `df` is a survey dataset. 

    - `a, b, c, d` = Survey questions 

    - `-99`: non-responses 
    
    - Your goal: replace `-99` with `NA` 
    

```r
# Data

set.seed(1234) # for reproducibility 

df <- tibble("a" = sample(c(-99, 1:3), size = 5 , replace= TRUE),
             "b" = sample(c(-99, 1:3), size = 5 , replace= TRUE),
             "c" = sample(c(-99, 1:3), size = 5 , replace= TRUE),
             "d" = sample(c(-99, 1:3), size = 5 , replace= TRUE))
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

- Using a function 
   - function: input + computation + output 
   - If you write a function, you gain efficiency because you don't need to copy and paste the computation part. 


```r
# Create a custom function
fix_missing <- function(x) { # INPUT
  x[x == -99] <- NA # COMPUTATION
  x # OUTPUT 
}

# Apply the function to each column (vector)
# This iterated part can and should be automated.
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
df <- purrr::map_df(df, fix_missing) # What is this magic? We will unpack the blackbox (`map_df()`) later.

df
```

- Takeaways

  1. Your code becomes more reusable, when it's easier to **change, debug, and scale up**. Don't repeat yourself and embrace the power of lazy programming. 

> Lazy, because only lazy programmers will want to write the kind of tools that might replace them in the end. Lazy, because only a lazy programmer will avoid writing monotonous, repetitive code—thus avoiding redundancy, the enemy of software maintenance and flexible refactoring. Mostly, the tools and processes that come out of this endeavor fired by laziness will speed up the production. -  [Philipp Lenssen](http://blogoscoped.com/archive/2005-08-24-n14.html)
  
  2. Only when your code becomes **reusable**, you would become **efficient** in your data work. Otherwise, you need to start from scratch or copy and paste, when you work on a new project.

> Code reuse aims to save time and resources and reduce redundancy by taking advantage of assets that have already been created in some form within the software product development process.[2] The key idea in reuse is that parts of a computer program written at one time can be or should be used in the construction of other programs written at a later time. - Wikipedia 

### Test your code systematically 

## Asking questions: Minimal reproducible example

### How to create a minimal reproducible example

## References

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

<!--chapter:end:01_intro.Rmd-->

# Tidy data and its friends {#tidy_data}

## Tidy data and why it matters

## Wrangling data

## How to wrangle data

## How to wrangle data at scale

## Modeling and visualizing tidy data

<!--chapter:end:02_tidy_data.Rmd-->

# Automating repeated things {#functional_programming}

## From for loop to functional programing

## Developing your own data tools

<!--chapter:end:03_functional_programming.Rmd-->

# Semi-structured data {#semi_structured_data}

## HTML/CSS: web scraping

## XML/JSON: social media scraping

<!--chapter:end:04_semi_structured_data.Rmd-->

# High-dimensional data {#machine_learning}

## Supervised machine learning

### Regularization

### Decision tree and ensemble models

## Unsupervised machine learning

### Dimension reduction

### Clustering

<!--chapter:end:05_high_dimensional_data.Rmd-->

# Big data {#big_data}

## Database and SQL

<!--chapter:end:06_big_data.Rmd-->

