# Semi-structured data {#semi_structured_data}

## Setup 



```r
# Install packages 
if (!require("pacman")) install.packages("pacman")
```

```
## Loading required package: pacman
```

```r
pacman::p_load(tidyverse, # tidyverse pkgs including purrr
               furrr, # parallel processing 
               tictoc, # performance test  
               tcltk, # GUI for choosing a dir path 
               tidyjson, # tidying JSON files 
               XML, # parsing XML
               rvest, # parsing HTML
               jsonlite, # downloading JSON file from web
               glue, # pasting string and objects
               xopen, # opepn URLs in browser 
               urltools, # regex and url parsing 
               here) # computational reproducibility

## Install the current development version from GitHub
devtools::install_github("jaeyk/tidytweetjson", dependencies = TRUE) ; library(tidytweetjson)
```

```
## Skipping install of 'tidytweetjson' from a github remote, the SHA1 (b598dcc1) has not changed since last install.
##   Use `force = TRUE` to force installation
```

## Objectives

-   Automating the process of turning semi-structured data (input) into structured data (output)

## What is semi-structured data?

> Semi-structured data is a form of structured data that does not obey the tabular structure of data models associated with relational databases or other forms of data tables, but nonetheless contains tags or other markers to separate semantic elements and enforce hierarchies of records and fields within the data. Therefore, it is also known as self-describing structure. - [Wikipedia](https://en.wikipedia.org/wiki/Semi-structured_data#:~:text=Semi%2Dstructured%20data%20is%20a,and%20fields%20within%20the%20data.)

-   Examples: `HTML (Hypertext Markup Language)` files (e.g., websites) and `JSON (JavaScript Object Notation)` files (e.g., tweets)

-   Why should we care semi-structured data?

    -   Because this is what the data frontier looks like: \# of unstructured data \> \# of semi-structured data \> \# of structured data
    -   There are easy and fast ways to turn semi-structured data into structured data (ideally in a tidy format) using R, Python, and command-line tools. See my own examples ([tidyethnicnews](https://github.com/jaeyk/tidyethnicnews) and [tidytweetjson](https://github.com/jaeyk/tidytweetjson)).

## Workflow

1.  Import/connect to a semi-structured file using `rvest,` `jsonlite,` `xml2,` `pdftools,` `tidyjson`, etc.

2.  Define target elements in the single file and extract them

-   [`readr`](https://readr.tidyverse.org/) package providers `parse_` functions that are useful for vector parsing.

-   [`stringr`](https://stringr.tidyverse.org/) package for string manipulations (e.g., using regular expressions in a tidy way). Quite useful for parsing PDF files (see [this example](https://themockup.blog/posts/2020-04-03-beer-and-pdftools-a-vignette/)).

-   [`rvest`](https://github.com/tidyverse/rvest) package for parsing HTML (R equivalent to `beautiful soup` in Python)

-   [`tidyjson`](https://github.com/sailthru/tidyjson) package for parsing JSON data

3.  Create a list of files (in this case URLs) to parse

4.  Write a parsing function

5.  Automate parsing process

## HTML/CSS: web scraping

Let's go back to the example we covered in the earlier chapter of the book. 


```r
url_list <- c(
  "https://en.wikipedia.org/wiki/University_of_California,_Berkeley",
  "https://en.wikipedia.org/wiki/Stanford_University",
  "https://en.wikipedia.org/wiki/Carnegie_Mellon_University",
  "https://DLAB"
)
```

* Step 1: Inspection 

Examine the Berkeley website so that we could identify a node which indicates the school's motto. If you're using Chrome, draw the elements of your interest, then `right click > inspect > copy full xpath`.






















































