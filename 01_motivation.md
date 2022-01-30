# Computational thinking {#motivation}



## Why computational thinking

-   If social scientists want to know how to work smart and not just hard, they need to take full advantage of the power of modern programming languages, and that power is **automation**.

-   Let's think about the following two cases (these examples come from [the column](https://dlab.berkeley.edu/blog/why-teaching-social-scientists-how-code-professional-important) I contributed to the D-Lab website)

    -   Case 1: Suppose a social scientist needs to collect data on civic organizations in the United States from websites, Internal Revenue Service reports, and social media posts. As the number of these organizations is large, the researcher could not collect a large volume of data from diverse sources, so they would hire undergraduates and distribute tasks. This is a typical data collection plan in social science research, and it is labor-intensive. Automation is not part of the game plan. Yet, it is critical for so many reasons. Because the process is costly, no one is likely to replicate or update the data collection effort.

Case 1 illustrates that it is challenging to be reproducible and scalable without efficient data analytics pipelines.

    -   Case 2: An alternative is to write computer programs that collect such data automatically, parse them, and store them in interconnected databases. Additionally, someone may need to maintain and validate the quality of the data infrastructure. Nevertheless, this approach lowers the cost of the data collection process, thereby substantially increasing the **reproducibility** and **scalability**. Furthermore, the researcher can document their code and publicly share it using their GitHub repository or even gather some of the functions they used and distribute them as open-source libraries.

Case 2 illustrates the power of automation and how it benefits the academic community and the general public.

To reap these benefits, one needs to learn how to program. In the era of data science, programming is as valuable a skill as writing in social science research because the extent to which a researcher can automate the research process can determine its efficiency, reproducibility, and scalability.

Below is an insightful quote from Hadley Wickham, who won the 2019 COPSS Presidents' Award for his outstanding contribution to statistics via developing tidyverse R packages that have transformed how people wrangle, analyze, and visualize data. Even if you don't do big data or machine learning, you can still benefit from learning how to program and applying the programming skills to data analysis because it's a "force multiplier."  

> Every modern statistical and data analysis problem needs code to solve it. You shouldn't learn just the basics of programming, spend some time gaining mastery. Improving your programming skills pays off because code is a **force multiplier**: once you've solved a problem once, code allows you to solve it much faster in the future. As your programming skill increases, the generality of your solutions improves: you solve not just the precise problem you encountered, but a wider class of related problems (in this way programming skill is very much like mathematical skill). Finally, sharing your code with others allows them to benefit from your experience. - [Hadley Wickham](https://imstat.org/2014/12/16/hadley-wickham-impact-the-world-by-being-useful/)

However, I also do not claim that social scientists should learn programming like software engineers learn the subject. For social scientists, programming is a means, not an end. I encourage readers to think about what aspects of the social science research process can be automated. Again, programming is just a way to teach a machine to perform these tasks and get them done.

![From BBC Bitesize](https://bam.files.bbci.co.uk/bam/live/content/znmb87h/large)

Teaching a computer to perform a particular task requires computational thinking: "formulating a problem and expressing its solution in a way that a computer—human or machine—can effectively carry out" (defined by [Jeannette M. Wing](http://www.cs.cmu.edu/afs/cs/usr/wing/www/publications/Wing06.pdf)). Specifically, this means readers need to get familiar with how computers think about data and handle them. 

## How to teach and learn computational thinking

This book teaches how you learn this art in incremental steps.

-   From graphic user interface to command-line interface (ch 3)

-   From short programs to long programs (ch 4-5)

-   The ultimate goal is to solve complex problems at scale using computation (ch 6-7)

I will cover programming concepts, but I will emphasize practicing them more. As the following John Chamber's quote indicates, this approach helps you learn computational thinking and apply it in particular contexts by coding and solving problems. 

> "[W]e wanted users to be able to begin in an interactive environment, where they did not consciously think of themselves as programming. Then as their needs became clearer and their sophistication increased, they should be able to slide gradually into programming, when the language and system aspects would become more important." - *Stages in the Evolution of S* by John Chambers (S is the progenitor of R)

Here are also some valuable reminders. 

-   Beginners! Learning programming is a long game. The essential component of learning (for almost any subject) is consistency. Never stop writing code, even though your current code may fall far short of perfection.
    ![](misc/wickham.png)

-   Intermediate programmers! Try to empower, not intimidate, newbies. The most important rule in the computational social science community (at least, in my opinion) is being nice. Please read David Robinson's ["A Million Lines of Bad Code"](http://varianceexplained.org/programming/bad-code/) for more insights.

![](http://imgs.xkcd.com/comics/code_quality.png)

Finally, have fun. I've talked about how learning programming pays off. But I've taught long enough to know that this will not convince people to learn to program, especially those who've had negative experiences learning STEM. 

Instead, I will try to make the materials as accessible as possible by emphasizing the following two ideas in teaching: showing the **BIG PICTURE** and walking through the **WORKFLOW.** With [Margaret Ng](https://media.illinois.edu/margaret-yee-man-ng) (Assistant Professor of Journalism, UIUC), I wrote about why these two concepts are pedagogically important for teaching computational social science for all. [The article](https://osf.io/preprints/socarxiv/pf7n6/?fbclid=IwAR2ZI0yw_pehS0mxAmeUBOGpzIhiO2LMUPGBzBLTLNo4C2HrJSoH9uZhgTY) is forthcoming in *PS: Political Science and Politics.* If you are interested in my full argument, please read the article. 

Here is a quick summary of why I think they matter for social science students' inclusive teaching of programming.  

Showing the big picture: Every time you teach a new skill or technique, remind students what the input and output data type is. Students from either Excel, SPSS, or Stata backgrounds are not used to thinking about data structure when working on data. So, providing these guideposts is crucial to help them avoid making an obvious mistake (e.g., providing a character vector when a numeric vector is needed for the input data) and seeing the connection between different skills (e.g., using API and web scraping).  
Walking through the workflow: Break down the steps involved in moving from the input to the output data. This way helps students feel less overwhelmed by learning the complex steps required to solve a particular task. It also helps students learn how to formulate a workflow when they encourage the same problem in a different context. Although the exact context is not identical, they can find patterns across them. Finally, teaching the workflow means breaking down these steps as well as putting them together, ideally using functions. Acquiring this skill is critical for students to advance from beginners to intermediate programmers who can write readable and reusable code.
