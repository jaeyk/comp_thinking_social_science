--- 
knitr: "bookdown::render_book"
title: "Computational Thinking for Social Scientists"
author: ["[Jae Yeon Kim](https://jaeyk.github.io/)"]
date: "2020-10-09"
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



___

This book intends to help social science graduate students to think computationally and develop proficiency with computational tools and techniques, necessary to conduct research in computational social science. Mastering these tools and techniques not only enables students to collect, wrangle, analyze, and interpret data with less pain and more fun, but it also let students to work on research projects that would previously seem impossible.

The book is currently divided into two main subjects (fundamentals and applications) and six main sessions. 

### Part I Fundamentals

- In the first section, students learn best practices in data and code management using Git and Bash. 

- In the second, students learn how to wrangle, model, and visualize data easier and faster. 

- In the third, students learn how to use functions to automate repeated things and develop their own data tools (e.g., packages). 

### Part II Applications

- In the fourth, students learn how to collect and parse semi-structured data at scale (e.g., using APIs and webscraping). 

- In the fifth, students learn how to analyze high-dimensional data (e.g., text) using machine learning. 

- In the final, students learn how to access, query, and manage big data using SQL. 

We will learn how to do all of the above mostly in [**R**](https://www.r-project.org/about.html), and sometimes in [**bash**](https://www.gnu.org/software/bash/) and [**Python**](https://www.python.org/about/).

  - Why R? R is free, easy to learn (thanks to [`tidyverse`](https://www.tidyverse.org/) and [RStudio](https://rstudio.com/)), fast (thanks to [`rcpp`](https://cran.r-project.org/web/packages/Rcpp/index.html)), runs everywhere, **open** (16,000+ packages; counting only ones [available at CRAN](https://cran.r-project.org/web/packages/)), and has a growing massive and inclusive community ([`#rstats`](https://twitter.com/search?q=%23rstats&src=typed_query)).
  
  - Why R + Python + bash?

       >> "For R and Python, Python is first and foremost a programming language. And that has a lot of good features, but it tends to mean, that if you are going to do data science in Python, you have to first learn how to program in Python. Whereas I think you are going to get up and running faster with R, than with Python because there’s just a bunch more stuff built in and you don’t have to learn as many programming concepts. You can focus on being a great political scientist or whatever you do and learning enough R that you don’t have to become an expert programmer as well to get stuff done." - Hadley Wickham
  
      - However, this feature of the R community also raises a challenge. 
      
      >> Compared to other programming languages, the R community tends to be more focused on results instead of processes. Knowledge of software engineering best practices is patchy: for instance, not enough R programmers use source code control or automated testing. Inconsistency is rife across contributed packages, even within base R. You are confronted with over 20 years of evolution every time you use R. R is not a particularly fast programming language, and poorly written R code can be terribly slow. R is also a profligate user of memory. - Hadley Wickham
  
      - RStudio, especially the tidyverse team, has made heroic efforts to amend the problems listed above. In this course, you will learn these recent advances in the R ecosystem and how to complement R with Python and Bash.
      
## Special thanks 

This book is a remix version of [the course](https://github.com/rochelleterman/PS239T) originally developed by [Rochelle Terman](http://rochelleterman.com/) then revised by [Rachel Bernhard](http://rachelbernhard.com/). Other teaching materials draw from the workshops I created for [D-Lab](https://dlab.berkeley.edu/) and [Data Science Discovery Program](https://data.berkeley.edu/research/discovery-program-home) at UC Berkeley.

## License 

![](https://i.creativecommons.org/l/by/4.0/88x31.png) This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).
