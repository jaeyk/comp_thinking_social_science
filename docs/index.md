--- 
knitr: "bookdown::render_book"
title: "Computational Thinking for Social Scientists"
author: ["[Jae Yeon Kim](https://jaeyk.github.io/)"]
date: "2020-10-17"
site: bookdown::bookdown_site
github-repo: jaeyk/PS239T
twitter-handle: JaeJaeykim2
output: bookdown::gitbook
documentclass: book
bibliography:
  - book.bib
  - packages.bib
biblio-style: apalike
link-citations: yes
colorlinks: yes 
description: "Computational Thinking for Social Scientists. Online textbook for Teaching Computational Tools and Techniques for Social Scientists."
---

# Hello World 


```r
print("Hello, World!")
```

```
## [1] "Hello, World!"
```

This is the website for *Computational Thinking for Social Scientists*. This book intends to help social scientists to think computationally and develop proficiency with computational tools and techniques, necessary to conduct research in computational social science. Mastering these tools and techniques not only enables social scientists to collect, wrangle, analyze, and interpret data with less pain and more fun, but it also let them to work on research projects that would previously seem impossible.

The book is not intended to be a comprehensive guide for computational social science or any particular programming language, computational tool or technique. For general introduction to computational social science, I recommend [Matthew Salganik](http://www.princeton.edu/~mjs3/)'s [Bit By Bit (2017)](https://www.bitbybitbook.com/). 

The book is currently divided into two main subjects (fundamentals and applications) and seven main sessions.

### Part I Fundamentals

1. [Why computational thinking](#motivation)

2. [Best practices in data and code management using Git and Bash](#git_bash)

3. [How to wrangle, model, and visualize data easier and faster](#tidy_data) 

4. [How to use functions to automate repeated things and develop data products (e.g., packages and apps)](#functional_programming) 

### Part II Applications

5. [How to collect and parse semi-structured data at scale (e.g., using APIs and webscraping)](#semi_structured_data) 

6. [How to analyze high-dimensional data (e.g., text) using machine learning](#machine_learning) 

7. [How to access, query, and manage big data using SQL](#big_data) 

The book teaches how to do all of these mostly in [**R**](https://www.r-project.org/about.html), and sometimes in [**bash**](https://www.gnu.org/software/bash/) and [**Python**](https://www.python.org/about/).

  - Why R? R is free, easy to learn (thanks to [`tidyverse`](https://www.tidyverse.org/) and [RStudio](https://rstudio.com/)), fast (thanks to [`Rcpp`](https://cran.r-project.org/web/packages/Rcpp/index.html)), runs everywhere, **open** (16,000+ packages; counting only ones [available at CRAN](https://cran.r-project.org/web/packages/)), and has a growing massive and inclusive community ([`#rstats`](https://twitter.com/search?q=%23rstats&src=typed_query)).
  
  - Why R + Python + bash?

       >> "For R and Python, Python is first and foremost a programming language. And that has a lot of good features, but it tends to mean, that if you are going to do data science in Python, you have to first learn how to program in Python. Whereas I think you are going to get up and running faster with R, than with Python because there’s just a bunch more stuff built in and you don’t have to learn as many programming concepts. You can focus on being a great political scientist or whatever you do and learning enough R that you don’t have to become an expert programmer as well to get stuff done." - Hadley Wickham
  
      - However, this feature of the R community also raises a challenge. 
      
      >> Compared to other programming languages, the R community tends to be more focused on results instead of processes. Knowledge of software engineering best practices is patchy: for instance, not enough R programmers use source code control or automated testing. Inconsistency is rife across contributed packages, even within base R. You are confronted with over 20 years of evolution every time you use R. R is not a particularly fast programming language, and poorly written R code can be terribly slow. R is also a profligate user of memory. - Hadley Wickham
  
      - RStudio, especially the tidyverse team, has made heroic efforts to amend the problems listed above. Readers you will learn these recent advances in the R ecosystem and how to complement R with Python and Bash.
      
## Special thanks 

This book is a remix version of [PS239T](https://github.com/rochelleterman/PS239T), a graduate-level computational methods course at UC Berkeley, originally developed by [Rochelle Terman](http://rochelleterman.com/) then revised by [Rachel Bernhard](http://rachelbernhard.com/). I have taught PS239T as lead instructor in Spring 2019 and TA in Spring 2018 and will co-teach it in Spring 2020. Other teaching materials draw from the workshops I have created for [D-Lab](https://dlab.berkeley.edu/) and [Data Science Discovery Program](https://data.berkeley.edu/research/discovery-program-home) at UC Berkeley. 

## License 

![](https://i.creativecommons.org/l/by/4.0/88x31.png) This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).
