# Python Basics: 0-1 Introduction.

Lectures draw heavily upon material from the D-Lab Python Intensives course, [Python for Everybody: Exploring Data Using Python 3](https://open.umn.edu/opentextbooks/textbooks/336) by Severance,  [Think Python: How to Think Like a Computer Scientist](http://www.greenteapress.com/thinkpython/thinkpython.pdf) by Downey, and [Python for Data Science](https://proquest.safaribooksonline.com/book/programming/python/9781491957653/preliminaries/why_python_html#X2ludGVybmFsX0h0bWxWaWV3P3htbGlkPTk3ODE0OTE5NTc2NTMlMkZlc3NlbnRpYWxfbnVtcHlfaHRtbCZxdWVyeT0=) by Wes McKinney. Additional homeworks are available in the folder should you be interested. These lectures will teach you how to:

1. Run Python from both the Shell and in an IPython (Jupyter) Notebook
2. Write basic commands using Python syntax
3. Grasp the major utilities of Python [object](https://github.com/dlab-berkeley/python-intensive/blob/master/Glossary.md#object) [types](https://github.com/dlab-berkeley/python-intensive/blob/master/Glossary.md#type), including [integers](https://github.com/dlab-berkeley/python-intensive/blob/master/Glossary.md#integer), [floats](https://github.com/dlab-berkeley/python-intensive/blob/master/Glossary.md#floating-point-number), [strings](https://github.com/dlab-berkeley/python-intensive/blob/master/Glossary.md#string), lists, sets, and dictionaries
4. Operate and manipulate those objects
5. Integrate choices into your programs using [conditionals](https://github.com/dlab-berkeley/python-intensive/blob/master/Glossary.md#conditional-statement)

# Differences Between R and Python 3



The number of questions on Stack Overflow on Python versus on R.

![python vs. r](https://community.rstudio.com/uploads/default/original/1X/bd81fdd73c8f6135d6ed35ae7dae62979abfd662.png)

## Similarities
* Python 3, like R, is a *functionalized* language (Python 2 is not). This means that commands (usually verbs or package functions) are followed by parentheses, e.g., `help()`. 
* By extension, this means that Python is also an *object-oriented* language. Every number, string, data structure, function, [class](https://docs.python.org/3/tutorial/classes.html?highlight=class), [module](https://docs.python.org/3/tutorial/modules.html) exist in its own box. However, it does not store data in memory the same way that R does.
* Both languages are open-source (with all the costs and benefits that entails). 
* The overall syntax is fairly similar: R and Python are both descendants of C and C++ (like French and Spanish are both Indo-European languages). 

## Differences
* Python is *white-space sensitive*. This means that the number of spaces you type or indent (using the tab function) on a multi-line piece of code will affect whether the code you've written runs correctly. An incorrect number of spaces will cause Python to return an error, which is often referred to as a "scoping" problem. Javascript is also very sensitive to scoping.
  * For Python and Markdown, using **four spaces** instead of tabs is a safe way to do indentation correctly.
* Python has informative errors. This means that it will tell you where the error occurred, and usually, why it occurred (e.g., missing parenthesis). I implore you, R!
* Where R uses piping (%), Python uses a very simple dot (.) syntax. 
* Python doesn't store everything in memory the way R does, and it's processed at a lower level than in R, which means that all else being equal, Python will be faster to execute than R. 
* Python doesn't have an IDE similar to RStudio, which means the interface is fairly different (though the process of typing a script in a notebook is very similar to an R-markdown file).

## Other Considerations
* Python is a multi-use or generalist-type programming language, whereas R is a statistical language built specifically for manipulating data. That means that Python is good at both scientific and general computing. Yet R has much more specific and tailored capabilities where it comes to things like analyzing and visualizing data. Personally, I use R for data manipulation, analysis, and visualization and Python for API, webscraping, and machine learning. Being fluent in both languages comes handy when your project requires a wide range of tasks.

### Python data science libraries 
* NumPy (Numerical Python) for manipulating numerical data (e.g., ndarray)
* Pandas for manipulating labeled data (closer to tidyverse in R)
* Matplotlib for data visualization (closer to ggplot2 in R)
* statsmodels for statistical analysis
* SciPy for scientific computing 
* Scikit-learn (an extension of SciPy) for machine learning 
