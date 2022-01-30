# Semi-structured data {#semi_structured_data}



## Setup 


```r
# Install packages 
if (!require("pacman")) install.packages("pacman")

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
## Skipping install of 'tidytweetjson' from a github remote, the SHA1 (9a00ec8a) has not changed since last install.
##   Use `force = TRUE` to force installation
```

## The Big Picture

-   Automating the process of turning semi-structured data (input) into structured data (output)

## What is semi-structured data?

> Semi-structured data is a form of structured data that does not obey the tabular structure of data models associated with relational databases or other forms of data tables, but nonetheless contains tags or other markers to separate semantic elements and enforce hierarchies of records and fields within the data. Therefore, it is also known as a self-describing structure. - [Wikipedia](https://en.wikipedia.org/wiki/Semi-structured_data#:~:text=Semi%2Dstructured%20data%20is%20a,and%20fields%20within%20the%20data.)

-   Examples: HTML (e.g., websites), XML (e.g., government data), JSON (e.g., social media API)

Below is how JSON (tweet) looks like. 


- A tree-like structure 

- Keys and values (key: value) 
 
{
  "created_at": "Thu Apr 06 15:24:15 +0000 2017",
  "id_str": "850006245121695744",
  "text": "1\/ Today we\u2019re sharing our vision for the future of the Twitter API platform!\nhttps:\/\/t.co\/XweGngmxlP",
  "user": {
    "id": 2244994945,
    "name": "Twitter Dev",
    "screen_name": "TwitterDev",
    "location": "Internet",
    "url": "https:\/\/dev.twitter.com\/",
    "description": "Your official source for Twitter Platform news, updates & events. Need technical help? Visit https:\/\/twittercommunity.com\/ \u2328\ufe0f #TapIntoTwitter"
  }
}

-   Why should we care about semi-structured data?

    -   Because this is what the data frontier looks like: \# of unstructured data \> \# of semi-structured data \> \# of structured data
    -   There are easy and fast ways to turn semi-structured data into structured data (ideally in a tidy format) using R, Python, and command-line tools. See my own examples ([tidyethnicnews](https://github.com/jaeyk/tidyethnicnews) and [tidytweetjson](https://github.com/jaeyk/tidytweetjson)).

## Workflow

1.  Import/connect to a semi-structured file using `rvest,` `jsonlite,` `xml2,` `pdftools,` `tidyjson`, etc.

2.  Define target elements in a single file and extract them

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

Examine the Berkeley website so that we could identify a node that indicates the school's motto. Then, if you're using Chrome, draw your interest elements, then `right click > inspect > copy full xpath.`


```r
url <- "https://en.wikipedia.org/wiki/University_of_California,_Berkeley"

download.file(url, destfile = "scraped_page.html", quiet = TRUE)

target <- read_html("scraped_page.html")

# If you want character vector output
target %>%
  html_nodes(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[1]") %>%
  html_text() 

# If you want table output 
target %>%
  html_nodes(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[1]") %>%
  html_table()
```

* Step 2: Write a function 

I highly recommend writing your function working slowly by wrapping the function with [`slowly()`](https://purrr.tidyverse.org/reference/insistently.html).


```r
get_table_from_wiki <- function(url){
  
  download.file(url, destfile = "scraped_page.html", quiet = TRUE)

  target <- read_html("scraped_page.html")
  
  table <- target %>%
    html_nodes(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[1]") %>%
    html_table() 
  
  return(table)
}
```

* Step 3: Test


```r
get_table_from_wiki(url_list[[2]])
```

* Step 4: Automation 


```r
map(url_list, get_table_from_wiki)
```

* Step 5: Error handling 


```r
map(url_lists, safely(get_table_from_wiki)) %>%
  map("result") %>% 
  # = map(function(x) x[["result"]]) = map(~.x[["name"]])
  purrr::compact() # Remove empty elements
```


```r
# If error occurred, "The URL is broken." will be stored in that element(s).
out <- map(
  url_list,
  possibly(get_table_from_wiki,
    otherwise = "The URL is broken."
  )
)
```

## XML/JSON: government database/social media scraping

### Governemnt database (XML) 

The following tax return data example comes from the U.S. Internal Revenue Service (IRS) Amazon database. [This PDf file](https://www.irs.gov/pub/irs-pdf/f990.pdf) shows what the original document looks like.

**Workflow**

1. Get the XML link and parse it
2. Go to the root of the XML document 
3. Identify a specific node you care about 
4. Get values related to that node 

![XML DOM (Document Object Model). Source: https://www.w3schools.com](https://www.w3schools.com/xml/nodetree.gif)

Step1: Get an XML document link


```r
xml_link <- c("http://s3.amazonaws.com/irs-form-990/201910919349301206_public.xml")
```

Step 2: Get the page and parse the XML document. 


```r
xml_root <- xml_link %>%
  # Get page and parse xml 
  xmlTreeParse() %>%
  # Get root
  xmlRoot()

# Data output: list 
typeof(xml_root) 
```

```
## [1] "list"
```

```r
# Two elements. Our target is the second one.
summary(xml_root)
```

```
##              Length Class   Mode
## ReturnHeader 11     XMLNode list
## ReturnData    6     XMLNode list
```

Step 3: Get nodes 

We grab the mission statement of this org from its tax report (990). `//` is an [XPath syntax](https://www.w3schools.com/xml/xpath_syntax.asp) that helps to "select nodes in the document from the current node that matches the selection no matter where they are."


```r
xml_root %>%
  purrr::pluck(2) %>% # Second element (Return Data)
  getNodeSet("//MissionDesc") # Mission statement 
```

```
## [[1]]
## <MissionDesc>DISTRIBUTION OF LITERATURE, MUSIC, AND OTHER RELATED RESOURCES WHICH COMPLIMENT LITERATURE; SUPPORT OF MINISTRIES.</MissionDesc>
```

Step 4: Get values 


```r
xml_root %>%
  purrr::pluck(2) %>% # Second element (Return Data)
  getNodeSet("//MissionDesc") %>% # Mission statement 
  xmlValue()
```

```
## [1] "DISTRIBUTION OF LITERATURE, MUSIC, AND OTHER RELATED RESOURCES WHICH COMPLIMENT LITERATURE; SUPPORT OF MINISTRIES."
```

### Social media API (JSON)

#### Objectives

-   Learning what kind of social media data are accessible through application programming interfaces (APIs)

**Review question**

In the previous session, we learned the difference between semi-structured data and structured data. Can anyone tell us the difference between them?

#### The big picture for digital data collection

1.  Input: semi-structured data

2.  Output: structured data

3.  Process:

    -   Getting **target data** from a remote server

        -   The target data is usually massive (\>10 G.B.) by the traditional social science standard.

    -   Parsing the target data your laptop/database

        -   Laptop (sample-parse): Downsamle the large target data and parse it on your laptop. This is just one option to [deal with big data in R](https://rviews.rstudio.com/2019/07/17/3-big-data-strategies-for-r/). It's a simple strategy that doesn't require storing target data in your database.

    -   Database (push-parse): Push the large target data to a database, then explore, select, and filter it. If you are interested in using this option, check out my [SQL for R Users](https://github.com/dlab-berkeley/sql-for-r-users) workshop.

![Sample-Parse. From RStudio.](https://rviews.rstudio.com/post/2019-07-01-3-big-data-paradigms-for-r_files/sample_model.png)

![Push-Parse. From RStudio.](https://rviews.rstudio.com/post/2019-07-01-3-big-data-paradigms-for-r_files/push_data.png)

-   But what exactly is this target data?

    -   When you scrape websites, you mostly deal with HTML (defines a structure of a website), CSS (its style), and JavaScript (its dynamic interactions).

    -   When you access social media data through API, you deal with either XML or JSON (major formats for storing and transporting data; they are light and flexible).

    -   XML and JSON have tree-like (nested; a root and branches) structures and keys and values (or elements and attributes).

    -   If HTML, CSS, and JavaScript are storefronts, then XML and JSON are warehouses.

![By Andreas Praefcke (Own work), via Wikimedia Commons](https://upload.wikimedia.org/wikipedia/commons/9/97/Automatisches_Kleinteilelager.jpg)

#### Opportunities and challenges for parsing social media data

This explanation draws on Pablo Barbara's [LSE social media workshop slides](http://pablobarbera.com/social-media-workshop/social-media-slides.pdf).

**Basic information**

-   What is an API?: An interface (you can think of it as something akin to a restaurant menu. API parameters are API menu items.)

    -   [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) (Representational state transfer) API: static information (e.g., user profiles, list of followers and friends)

    -   [Streaming](https://blog.axway.com/amplify/api-management/streaming-apis#:~:text=Streaming%20APIs%20are%20used%20to,a%20subset%20of%20Streaming%20APIS.) API: dynamic information (e.g, new tweets)

**Why should we care?** 

- API is the new data frontier. [ProgrammableWeb](https://www.programmableweb.com/apis/directory) shows that there are more than 24,046 APIs as of April 1, 2021.

  - Big and streaming (real-time) data 
  
  - High-dimensional data (e.g., text, image, video, etc.)
  
  - Lots of analytic opportunities (e.g., time-series, network, spatial analysis)
  
- Also, this type of data has many limitations (external validity, algorithmic bias, etc).

- Think about taking the API + approach (i.e., API not replacing but augmenting traditional data collection)

**How API works** 

Request (you form a request URL) <-> Response (API responses to your request by sending you data usually in JSON format)

![](https://mk0appinventiv4394ey.kinstacdn.com/wp-content/uploads/sites/1/2018/05/What-are-APIs-Learn-How-API-Works.jpg)

**API Statuses**

1. Twitter 

-   Twitter API is still widely accessible ([v2](https://developer.twitter.com/en/docs/twitter-api/early-access) 


  - In January 2021, Twitter introduced the [academic Twitter API](https://developer.twitter.com/en/solutions/academic-research) that allows generous access to Twitter's historical data for academic researchers 

    - Many R packages exist for the Twitter API: [rtweet](https://cran.r-project.org/web/packages/rtweet/rtweet.pdf) (REST + streaming), [tweetscores](https://github.com/pablobarbera/twitter_ideology/tree/master/pkg/tweetscores) (REST), [streamR](https://github.com/pablobarbera/streamR) (streaming)

    - Some notable limitations. If Twitter users don't share their tweets' locations (e.g., GPS), you can't collect them. 
    
> Twitter data is unique from data shared by most other social platforms because it reflects information that users *choose* to share publicly. Our API platform provides broad access to public Twitter data that users have chosen to share with the world. - Twitter Help Center

-   What does this policy mean? If Twitter users don't share their tweets' locations (e.g., GPS), you can't collect them. However, you can get around this problem to identify a user's location based on their self-reported profile. 

2. Other APIs

The following comments draw on Alexandra Siegel's talk on "Collecting and Analyzing Social Media Data" given at Montréal Methods Workshops. 

- [Facebook API](https://developers.facebook.com/) access has become constrained since the 2016 U.S. election.  

  - Exception: [Social Science One](https://socialscience.one/blog/unprecedented-facebook-urls-dataset-now-available-research-through-social-science-one).

  - Also, check out [Crowdtangle](https://www.crowdtangle.com/) for collecting public FB page data 
  
  - Using FB ads is still a popular method, especially among scholars studying developing countries. 
  
- [YouTube API](https://developers.google.com/youtube/v3): generous access + (computer-generated) transcript in many languages 

  - Documentation on [captions](https://developers.google.com/youtube/v3/docs/captions) from YouTube
  
- [Instragram API](https://www.instagram.com/developer/): Data from public accounts are available. 

- [Reddit API](https://www.reddit.com/dev/api/): Well-annotated text data suitable for machine learning 

**Upside**

-   Legal and well-documented.

Web scraping (Wild Wild West) \<\> API (Big Gated Garden)

-   You have legal but limited access to (growing) big data that can be divided into text, image, and video and transformed into cross-sectional (geocodes), longitudinal (timestamps), and historical event data (hashtags). See Zachary C. Steinert-Threlkeld's [2020 APSA Short Course Generating Event Data From Social Media](https://github.com/ZacharyST/APSA2020_EventDataFromSocialMedia).

-   Social media data are also well-organized, managed, and curated data. It's easy to navigate because XML and JSON have keys and values. If you find keys, you will find observations you look for.

**Downside**

1.  Rate-limited.

2.  If you want to access more and various data than those available, you need to pay for premium access.

### Next steps

We will learn how to access and collect data using Twitter and New York Times API. We are going to learn this in two ways: (1) using plug-and-play packages (both using RStudio and the terminal) and (2) getting API data from scratch (`httr,` `jsonlite`).

First, sign up for the Twitter developer account before everything else. If you want to know how to sign up for a new Twitter developer account and access Twitter API, see Steinert-Threlkeld's [APSA workshop slides](https://github.com/ZacharyST/APSA2020_EventDataFromSocialMedia/blob/master/Presentation/02_AccessTwitter.pdf).


### rtweet 

The `rtweet` examples come from [Chris Bail's tutorial](https://cbail.github.io/SICSS_APIs_markdown.html). 

#### Setup 

The first thing you need to do is set up.

Assuming that you already signed up for a Twitter developer account 


```r
app_name <- "YOUR APP NAME"
consumer_key <- "YOUR CONSUMER KEY"
consumer_secret <- "YOUR CONSUMER SECRET"

rtweet::create_token(app = app_name, 
                     consumer_key = consumer_key, 
                     consumer_secret = consumer_secret)
```

#### Search API

Using **search API**; This API returns a collection of Tweets mentioning a particular query.






















































