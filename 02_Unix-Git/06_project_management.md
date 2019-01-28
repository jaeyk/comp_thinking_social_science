# The Unix Shell: 6. Project management 101 

> * The following contents are adapted from [R for Reproducible Scientific Analysis](https://swcarpentry.github.io/r-novice-gapminder/02-project-intro/) by Software Carpentry, [Before We Start](https://datacarpentry.org/R-ecology-lesson/00-before-we-start.html) by Data Carpentry, and [Project-Oriented Workflow] by [Iegor Rudnytskyi](https://www.r-bloggers.com/author/iegor-rudnytskyi/).
> * How to manage a project
> * How to organize directories and files  



### 1. Create a directory 

Put each project in its own directory. Name the directory after the project. 



### 2. The organization of a project 

The following is an example of how you can organize a project. Keep raw data as raw. Treat processed data as replaceable. 



name_of_the_project 

- data: 
  - raw 
  - processed (all processed, cleaned, and tided)
- figures 
- packrat (optional) 
- reports (PDF, HTML, TEX, etc.,) 
- results (model outcomes, etc.,)
- scripts (i.e., functions)
- .gitignore (for Git)
- name_of_project.Rproj (for R)
- README.md (for Git) 

![Working directory structure example](https://datacarpentry.org/R-ecology-lesson/img/working-directory-structure.png)



#### 2. Naming files 

- Machine readable (avoid spaces, punctuation, periods, and any other special characters except _ and -)
- Human readable (should be meaningful. No text1, image1, etc.,)
- Ordering (e.g., 01, 02, 03,  ... )



#### 3. Self-Oriented Project  

When we cover R and Python, we'll learn more about what is [a self-contained project](https://www.tidyverse.org/articles/2017/12/workflow-vs-script/). A project is [self-contained](https://www.r-bloggers.com/%F0%9F%93%81-project-oriented-workflow/) when 

> you have everything you need at hand and your project does not affect anything it did not create.

