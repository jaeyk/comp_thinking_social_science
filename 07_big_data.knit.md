# Big data {#big_data}



## Motivation

- Big data problem: data is too big to fit into memory (=local environment).
- R reads data into random-access memory (RAM) at once and this object lives in memory entirely. So, object > memory will crash R. 
- So, the key to deal with big data in R is reducing the size of data you want to bring into it.

**Techniques to deal with big data**

- Medium sized file (1-2 GB)
   - Try to reduce the size of the file using slicing and dicing
   - Tools: 
      - R:`data.table::fread(file path, select = c("column 1", "column 2"))`. This command imports data faster than `read.csv()` does.
      - Command line: [`csvkit`](https://csvkit.readthedocs.io/en/latest/) - a suite of command-line tools to and working with CSV 
- Large file (> 2-10 GB)
   - Put the data into a database and **ACCESS** it 
   - Explore the data and pull the objects of interest 
   - Types of databases
      - Relational database = a collection of tables (fixed columns and rows): SQL is a staple tool to define and **query** (focus of the workshop today) this type of database
      - Non-relational database = a collection of documents (MongoDB), key-values (Redis and DyanoDB), wide-column stores (Cassandra and HBase), or graph (Neo4j and JanusGraph). This type of database does not preclude SQL. Note that NoSQL stands for ["not only SQL."](https://www.mongodb.com/nosql-explained)
     
**Relational database**

![Relational Database. Source: MySQL Tutorial](https://sp.mysqltutorial.org/wp-content/uploads/2009/12/MySQL-Sample-Database-Schema.png)

## What is SQL? 

- Structured Query Language. Called SEQUEL and developed by IBM Corporation in the 1970s.

- Remains the standard language for a relational database management system.

- It's a DECLARATIVE language ([what to do > how to do](https://www.sqlite.org/queryplanner.html))
  - Database management systems figures optimal way to execute query (query optimization)
    
```sql
SELECT COLUMN FROM TABLE 
```

## Learning objectives 
* Embracing a new mindset: shifting from ownership (opening CSVs in your laptop) to access (accessing data stored in a database)

* Learning how to use R and SQL to access and query a database

## Quick overview 

* SQL and R

SQL           | R
------------- | --------------------------------------------------------------------------
SELECT        | select() for columns, mutate() for expressions, summarise() for aggregates
FROM          | which data frame 
WHERE         | filter()
GROUP BY      | group_by()
HAVING        | filter() **after group_by()**
ORDER BY      | arrange()
LIMIT         | head()
  
**Challenge 1**
1. Can you tell me the difference in the order in which the following `R` and `SQL` code were written to wrangle data? For instance, in R, what command comes first? In contrast, in SQL, what command comes first?

- R example 

```r

data %>% # Data 
  select() %>% # Column
  filter() %>% # Row 
  group_by() %>% # Group by 
  summarise(n = n()) %>% # Aggregation
  filter() %>% # Row 
  order_by() # Arrange 

```

- SQL example 

```sql 

SELECT column, aggregation (count())` # Column

FROM data # Data 

WHERE condition # Row 

GROUP BY column # Group by

HAVING condition # Row  

ORDER BY column # Arrange 

```

![SQL Zine by by [Julia Evans](https://jvns.ca/)](https://wizardzines.com/zines/sql/samples/from.png)

## Setup

Let's get to work. 

## Packages 

- `pacman::p_load()` reduces steps for installing and loading several packages simultaneously. 


```r
# pacman 
if (!require("pacman")) install.packages("pacman")
```

```
## Loading required package: pacman
```

```r
# The rest of pkgs 
pacman::p_load(
 
 tidyverse, # tidyverse packages 
 
 DBI, # using SQL queries
 
 RSQLite, # SQLite
 
 dbplyr, # use database with dplyr 
 
 glue, # glue to automate workflow 
 
 nycflights13 # toy data 
)
```

## Datasets 

- [The flight on-time performance data](https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236) from the Bureau of Transpiration Statistics of the U.S. government. The data goes back to 1987 and its size is more than 20 gigabytes. For practice, we only use a small subset of the original data (flight data departing NYC in 2013) provided by RStudio.

![From RStudio.](https://d33wubrfki0l68.cloudfront.net/245292d1ea724f6c3fd8a92063dcd7bfb9758d02/5751b/diagrams/relational-nycflights.png)

## Workflow 

1. Create/connect to a database 

- Note that server also can be your laptop (called [localhost](https://en.wikipedia.org/wiki/Localhost#:~:text=In%20computer%20networking%2C%20localhost%20is,via%20the%20loopback%20network%20interface.)).

- Short answer: To do so, you need interfaces between R and a database. We use [`RSQLite`](https://github.com/r-dbi/RSQLite) in this tutorial because it's easy to set up. 

- Long answer: The `DBI` package in R provides a client-side interface that allows `dplyr` to work with databases. DBI is automatically installed when you installed `dbplyr`. However, you need to install a specific backend engine (a tool for communication between R and a database management system) for the database (e.g., `RMariaDB`, `RPostgres`, `RSQLite`). In this workshop, we use SQLite because it is the easiest to get started with. Personally, I love PostgreSQL because it's an open-source and also powerful to do [many amazing things](https://www.postgresql.org/docs/current/functions.html) (e.g., text mining, geospatial analysis).

2. Copy a table to the database 

- Option 1: You can create a table and insert rows manually.

- Table
    - Collection of rows 
    - Collection of columns (fields or attributes)
    - Each col has a type:
        - String: `VARCHAR(20)`
        - Integer: `INTEGER`
        - Floating-point: `FLOAT`, `DOUBLE`
        - Date/time: `DATE`, `TIME`, `DATETIME`
    - **Schema**: the structure of the database
        - The table name
        - The names and types of its columns
        - Various optional additional information (e.g., constraints)
        
```sql

CREATE TABLE students (
    id INT AUTO_INCREMENT,
    name VARCHAR(30),
    birth DATE,
    gpa FLOAT,
    grad INT,
    PRIMARY KEY(id));
    
INSERT INTO students(name, birth, gpa, grad)
      VALUES ('Adam', '2000-08-04', 4.0, 2020);

```

- Option 2: Copy a file (object) to a table in a database using `copy_to`). We take this option as it's fast and we would like to focus on querying in this workshop. 

3. Query the table 

- Main focus 

4. Pull the results of interests (**data**) using `collect()`

5. Disconnect the database 

### Create a database 


```r
# Define a backend engine 

drv <- RSQLite::SQLite()

# Create an empty in-memory database 
con <- DBI::dbConnect(drv, 
                      dbname = ":memory:")

# Connect to an existing database 
#con <- DBI::dbConnect(RMariaDB::MariaDB(), 
 # host = "database.rstudio.com",
 # user = "hadley",
 # password = rstudioapi::askForPassword("Database password")
#)

dbListTables(con)
```

```
## character(0)
```

- Note that con is empty at this stage.

### Copy an object as a table to the database (push)


```r
# Copy objects to the data 
copy_to(dest = con, 
        df = flights)

copy_to(dest = con, 
        df = airports)

copy_to(dest = con,
        df = planes)

copy_to(dest = con, 
        df = weather)

# If you want you can also decide what columns you want to copy:

# copy_to(dest = con, 
#          df = flights, 
#          name = "flights",
#          indexes = list(c("year", "tailnum", "dest")))
```



```r
# Show two tables in the database 

dbListTables(con)
```

```
## [1] "airports"     "flights"      "planes"       "sqlite_stat1" "sqlite_stat4"
## [6] "weather"
```

```r
# Show the columns/attributes/fields of a table 

dbListFields(con, "flights")
```

```
##  [1] "year"           "month"          "day"            "dep_time"      
##  [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
##  [9] "arr_delay"      "carrier"        "flight"         "tailnum"       
## [13] "origin"         "dest"           "air_time"       "distance"      
## [17] "hour"           "minute"         "time_hour"
```

```r
dbListFields(con, "weather")
```

```
##  [1] "origin"     "year"       "month"      "day"        "hour"      
##  [6] "temp"       "dewp"       "humid"      "wind_dir"   "wind_speed"
## [11] "wind_gust"  "precip"     "pressure"   "visib"      "time_hour"
```

### Quick demonstrations:

- SELECT desired columns 
- FROM tables 

- Select all columns (*) from `flights` table and show the `first ten rows`
- Note that you can combine SQL and R commands thanks to `dbplyr`.

- Option 1 


```r
DBI::dbGetQuery(con, "SELECT * FROM flights;") %>%
  head(10) 
```

```
##    year month day dep_time sched_dep_time dep_delay arr_time sched_arr_time
## 1  2013     1   1      517            515         2      830            819
## 2  2013     1   1      533            529         4      850            830
## 3  2013     1   1      542            540         2      923            850
## 4  2013     1   1      544            545        -1     1004           1022
## 5  2013     1   1      554            600        -6      812            837
## 6  2013     1   1      554            558        -4      740            728
## 7  2013     1   1      555            600        -5      913            854
## 8  2013     1   1      557            600        -3      709            723
## 9  2013     1   1      557            600        -3      838            846
## 10 2013     1   1      558            600        -2      753            745
##    arr_delay carrier flight tailnum origin dest air_time distance hour minute
## 1         11      UA   1545  N14228    EWR  IAH      227     1400    5     15
## 2         20      UA   1714  N24211    LGA  IAH      227     1416    5     29
## 3         33      AA   1141  N619AA    JFK  MIA      160     1089    5     40
## 4        -18      B6    725  N804JB    JFK  BQN      183     1576    5     45
## 5        -25      DL    461  N668DN    LGA  ATL      116      762    6      0
## 6         12      UA   1696  N39463    EWR  ORD      150      719    5     58
## 7         19      B6    507  N516JB    EWR  FLL      158     1065    6      0
## 8        -14      EV   5708  N829AS    LGA  IAD       53      229    6      0
## 9         -8      B6     79  N593JB    JFK  MCO      140      944    6      0
## 10         8      AA    301  N3ALAA    LGA  ORD      138      733    6      0
##     time_hour
## 1  1357034400
## 2  1357034400
## 3  1357034400
## 4  1357034400
## 5  1357038000
## 6  1357034400
## 7  1357038000
## 8  1357038000
## 9  1357038000
## 10 1357038000
```

- Option 2 (works faster)



































