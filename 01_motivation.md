
# Computational thinking {#motivation}



## Why computational thinking 

- If social scientists want to know how to work smart and not just hard, they need to take full advantage of the power of modern programming languages, and that power is **automation**.

- Let's think about the following two cases (these examples come from [the column](https://dlab.berkeley.edu/blog/why-teaching-social-scientists-how-code-professional-important) I contributed to D-Lab website).

  - Case 1: Suppose a social scientist needs to collect data on civic organizations in the United States from websites, Internal Revenue Service reports, and social media posts. As the number of these organizations is large, the researcher could not collect a large volume of data from diverse sources, so they would hire undergraduates and distribute tasks among them. This is a typical data collection plan in social science research, and it is labor-intensive. Automation is not part of the game plan. Yet, it is critical for so many reasons. Because the process is costly, no one is likely to either replicate or update the data collection effort. Put differently, without making the process efficient, it is difficult for it to be reproducible and scalable. 

  - Case 2: An alternative is to write computer programs that collect such data automatically, parse them, and store them in interconnected databases. Additionally, someone may need to maintain and validate the quality of the data infrastructure. Nevertheless, this approach lowers the cost of the data collection process, thereby substantially increasing the **reproducibility** and **scalability** of the process. Furthermore, the researcher can document their code and publicly share it using their GitHub repository or even gather some of the functions they used and distribute them as open-source libraries. 
  
- Programming is as valuable a skill as writing in social science research. The extent to which a researcher can automate the research process can determine its efficiency, reproducibility, and scalability.
  
> Every modern statistical and data analysis problem needs code to solve it. You shouldn’t learn just the basics of programming, spend some time gaining mastery. Improving your programming skills pays off because code is a **force multiplier**: once you’ve solved a problem once, code allows you to solve it much faster in the future. As your programming skill increases, the generality of your solutions improves: you solve not just the precise problem you encountered, but a wider class of related problems (in this way programming skill is very much like mathematical skill). Finally, sharing your code with others allows them to benefit from your experience. - [Hadley Wickham](https://imstat.org/2014/12/16/hadley-wickham-impact-the-world-by-being-useful/) 

- How can we automate our research process? How can we teach a machine?

![From BBC Bitesize](https://bam.files.bbci.co.uk/bam/live/content/znmb87h/large)

This book teaches how you to do that in R in incremental steps. 

* From graphic user interface to command-line interface 

* From short programs to long programs 

* The ultimate goal is to solve complex problems at scale using computation 

> "[W]e wanted users to be able to begin in an interactive environment, where they did not consciously think of themselves as progamming. Then as their needs became clearer and their sophistication increased, they should be able to slide gradually into programming, when the language and system aspects would become more important." - *Stages in the Evolution of S* by John Chambers (S is the progenitor of R)

## Computational way of thinking about data 

### Structure 

- Fixed number of columns and rows?
  - Yes: Structured data (e.g., Excel spreadsheets, CSVs)
    - Tidy data (a special case of structured data)
  - No: semi-structured data (e.g., PDFs, websites, and social media posts)
        unstructured data (e.g., plain texts)

### Dimension

Suppose n = the number of observations and p = the number of variables 

- Low-dimensional data (n > p)
  - Most survey, experimental, and administrative data 

- High-dimensional data (n < p)
  - Text, speech, image, video, etc  

### Size 

- Small and medium data: Data fit in your laptop's memory 
- Big data: Data don't fit in your laptop's memory

## Computational way of thinking about research process

Computational tools and techniques make ... 

- Doing traditional research easier, faster, and scalable
  - Data wrangling 
  - Modeling 
  - Visualization 

- Documentation and collaboration easier, faster and scalable 
  - Dynamic reporting (markdown)
  - Version control system (Git and GitHub)

- Collecting and analyzing large and complex data possible 
  - Digital data collection (web scraping and API)
      - Building a data infrastructure (SQL)
  - Machine learning 
      - Text as data, image as data, etc 
      - Machine learning applications to surveys and experiments 
