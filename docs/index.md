---
title: "Computational Thinking for Social Scientists"
author: "Jae Yeon Kim"
date: "2025-04-19"
site: bookdown::bookdown_site
output: bookdown::gitbook
---

# Welcome


``` r
print("Hello, World!")
```

```
## [1] "Hello, World!"
```

> Make simple things simple, and complex things possible. - [Alan Kay](https://www.quora.com/What-is-the-story-behind-Alan-Kay-s-adage-Simple-things-should-be-simple-complex-things-should-be-possible)

This is the website for *Computational Thinking for Social Scientists*, an open-access book designed to help social scientists think computationally and develop proficiency with modern computational tools and techniques. Mastering these skills enables researchers to collect, wrangle, analyze, and interpret data more efficiently—and with more enjoyment. It also empowers them to pursue research questions that might once have seemed impossible.

Horace Mann, the first great advocate of public education in the United States, once said:

> "Education, then, beyond all other devices of human origin,  
> is a great equalizer of the conditions of men—the balance wheel of the social machinery."

I believe in the transformative power of education. At the same time, I recognize that access to high-quality education remains deeply unequal. Too often, historically disadvantaged groups face greater barriers to both education and technology. This book is my small contribution toward realizing the democratic promise of education—especially in the emerging field of computational social science.

That said, this book is not a comprehensive guide to computational social science or any specific programming language, tool, or technique. For a broader introduction to the field, I highly recommend [Matthew Salganik](http://www.princeton.edu/~mjs3/)'s [*Bit by Bit* (2017)](https://www.bitbybitbook.com/), which is comprehensive, accessible, and pedagogically rich.

This book is organized into two parts—Fundamentals and Applications—and includes eight main sessions:

- Part I: Fundamentals

1. [Why computational thinking](#motivation)  
2. [Best practices in data and code management using Git and Bash](#git_bash)  
3. [How to wrangle, model, and visualize data efficiently](#tidy_data)  
4. [How to use functional programming to automate repetitive tasks](#functional_programming)  
5. [How to develop data products (e.g., packages and Shiny apps)](#products)  

- Part II: Applications

6. [How to collect and parse semi-structured data at scale (e.g., APIs and web scraping)](#semi_structured_data)  
7. [How to analyze high-dimensional data (e.g., text) using machine learning](#machine_learning)  
8. [How to access, query, and manage big data using SQL](#big_data)  

This book primarily uses [**R**](https://www.r-project.org/about.html), and occasionally [**bash**](https://www.gnu.org/software/bash/) and [**Python**](https://www.python.org/about/).

- **Why R?**  
  R is free, accessible (especially thanks to the [`tidyverse`](https://www.tidyverse.org/) and [RStudio](https://posit.co)), and cross-platform (Mac/Windows/Linux). It’s fast (thanks to [`Rcpp`](https://cran.r-project.org/web/packages/Rcpp/index.html)), extensible (with over 16,000 packages on [CRAN](https://cran.r-project.org/web/packages/)), and supported by a large, inclusive community (see [`#rstats`](https://twitter.com/search?q=%23rstats&src=typed_query)).

- **Why R + Python + Bash?**  
  > “For R and Python—Python is first and foremost a programming language. That has many strengths, but it usually means that to do data science in Python, you must first learn to program. With R, you can get up and running faster because a lot is built in—you don’t need to learn as many programming concepts. You can focus on being a great political scientist, or whatever you do, and just learn enough R to get things done.”  
  > — Hadley Wickham

  That said, the R ecosystem presents some challenges:  
  > “Compared to other programming languages, the R community tends to focus more on results than on process. Software engineering practices such as source control or automated testing are not widely adopted. Inconsistencies persist across contributed packages and even within base R. The language reflects more than 20 years of evolution. R is not particularly fast, and poorly written R code can be painfully slow. It’s also memory-hungry.”  
  > — Hadley Wickham

  Still, the RStudio (now Posit) and tidyverse teams have made significant progress in addressing these limitations. This book will introduce some of those advances and show how combining R with Python and Bash can enhance your workflow.

  If you're serious about programming or software development, I strongly recommend learning Python as well—it can fill important gaps in software engineering that will also improve your R proficiency.

- Special Thanks

This book is as much collected as it is authored. It is a remix of [PS239T](https://github.com/rochelleterman/PS239T), a graduate-level course in computational methods at UC Berkeley originally developed by [Rochelle Terman](http://rochelleterman.com/) (now Assistant Professor of Political Science at the University of Chicago), and later revised by [Rachel Bernhard](http://rachelbernhard.com/) (now Associate Professor at Nuffield College and the University of Oxford).  

I have taught [PS239T](https://github.com/PS239T/spring_2021) as a lead instructor in Spring 2019, a TA in Spring 2018, and a co-instructor with [Nick Kuipers](https://nicholaskuipers.com/) (now Assistant Professor of Politics at Princeton) in Spring 2020.

Other materials are adapted from workshops I developed for [D-Lab](https://dlab.berkeley.edu/), the [Data Science Discovery Program](https://data.berkeley.edu/research/discovery-program-home) at UC Berkeley, and the [Summer Institute in Computational Social Science at Howard University and Mathematica](https://sicss.io/2021/howard-mathematica/).

I have cited all sources—books, articles, slides, blog posts, and videos—whenever I am aware of them.

- Suggestions, Questions, or Comments

Please feel free to [create an issue](https://github.com/jaeyk/PS239T/issues) on the GitHub repository. If you find any typos, errors, or missing citations, I’d be grateful if you reported them there.

- License

![](https://licensebuttons.net/l/by/4.0/88x31.png)  
This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).
