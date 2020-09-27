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
