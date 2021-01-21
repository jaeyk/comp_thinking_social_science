# Managing data and code {#git_bash}



## Using Bash (command line interface)

As William Shotts the author of *[The Linux Command Line](http://linuxcommand.org/tlcl.php)* put it: 

> graphical user interfaces make easy tasks easy, while command line interfaces make difficult tasks possible.

### Why bother using command line?

Create a plain text file that contains word "test"

- `echo`: "Write arguments to the standard output" This is equivalent as using a text editor (e.g., nano, vim, emacs) and write something.
- `> test` Save the expression in a file named test.   
- In general, if you don't know what a command does, just type `<command name> --help`. If you need more detailed information, you can do `man <command name>`. `man` stands for manual. Finally, you can get more user-friendly information by using either [`tldr`](https://tldr.sh/). 

```sh

echo "test" > test 

```

- Make 100 duplicates of this file. Let's break down the seemingly complex commands. 
- I did this using for loop (`for i in {1..100}`). Curly braces `{}` makes 1..100 integers from 1 to 100.  
- `;` is used to use multiple commands without making line breaks. 
- `$var` returns the value associated with variable. Type `name=<Your name>`. Then, type `echo $name`. You should see your name printed. Variable assignment is one of the most basic things you'll learn in any programming.  
- For novice users, I warn you that these could be too much advanced concepts. If so, don't pay too much attention to this. For now, it's enough to have intuitions. 

```sh

for i in {1..100}; do cp test "test_$i"; done  

```

Append "COVID" to the file named test_100. Note that I used `>>` (append) not `>`. 

```sh

echo "COVID" >> test_100 

```

Let's read (=`cat` (concatenate)) what's in test_100 

```sh

cat test_100 

```

Find which fine contains the character "COVID." This is literally equivalent to finding a needle in a haystack. This is a daunting task for a human researcher, but not for our robotic assistant. `grep` finds PATTERNS in each FIEL. What follows - are options (called flags): `r` (recursive), `n` (line number), `w` (match only whole words), `e` (use patterns for matching). `rnw` are for output control and `e` is for pattern selection. 

You can write `grep -r -n -w -e "COVID"`, but the simpler the better. 

* `grep`: command 

* `-rnw -e`: flags 

* `COVID`: argument (usually file or file paths)

```sh

grep -rnw -e "COVID" 

```

Let's remove (=`rm`) all the duplicate files as well as the original file. `*` (any number of characters) is a wildcard (if you want to identify a single number of character, use `?`). It finds every file whose name starts with `test_`.

```sh

rm test_* test 

```

This command should return "test_100:2:COVID." (file test_100; line number 2; COVID)

What is this black magic? Can you do the same thing using graphical interface? Which method is more efficient? I hope that this quick demonstration will give you enough sense of why learning command line could be incredibly useful. In my experience, mastering command line helps automating your research process almost from end to end. For instance, you don't need to write files from a website using your web browser. You can run `wget` command in the terminal. Better yet, you don't even need to run the command for the second time. You can write a Shell script (`*.sh`) that automates downloading, moving, and sorting multiple files. You can find one example of this from the PS239T course repository. [`copy_syllabus.sh`](https://GitHub.com/PS239T/spring_2021/blob/main/copy_syllabus.sh) automatically runs an R markdown file, produces HTML and PDF outputs, and move these files to a desired location. When I modified something in the syllabus, I just need to run this Shell script again. (No worries! I will explain what is Shell shortly.) Finally, if you need to interact with servers or supercomputers for your research, you are likely to use the command-line interface.

### UNIX Shell 

The following materials on UNIX and Shell are adapted from [the software carpentry](https://bids.GitHub.io/2015-06-04-berkeley/shell/00-intro.html.

#### Unix

UNIX is an **operating system + a set of tools (utilities)**. It was developed by AT & T employees at Bell Labs (1969-1971). From Mac OS X to Linux, many of current operation systems are some versions of UNIX. For this reason, if you're using Max OS, then you don't need to do anything else to experience UNIX. You're already all set. If you're using Windows, you need to install either GitBash (a good option if you only use Bash for Git and GitHub) or Windows Subsystem (highly recommended if your use case goes beyond Git and GitHub). For more information, see [this installation guideline](https://GitHub.com/PS239T/spring_2021/blob/main/B_Install.md) from the course repo. If you're an Windows user and don't use Windows 10, I recommend installing [VirtualBox](https://www.virtualbox.org/).

UNIX is old, but it is still mainstream and it will be. Moreover, [the UNIX philosophy](https://en.wikipedia.org/wiki/Unix_philosophy) ("Do One Thing And Do It Well")---minimalist, modular software development---is highly and widely influential.  

![Ken Thompson and Dennis Ritchie, key proponents of the Unix philosophy](https://upload.wikimedia.org/wikipedia/commons/1/1b/Ken_Thompson_and_Dennis_Ritchie--1973.jpg)

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/tc4ROCJYbm0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  
<p>AT&T Archives: The UNIX Operating System</p>

```

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/xnCgoEyz31M" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p>Unix50 - Unix Today and Tomorrow: The Languages </p>
```

#### Kernel

The kernel of UNIX is the hub of the operating system: it allocates time and memory to programs and handles the [filestore](http://users.ox.ac.uk/~martinw/unix/chap3.html) (e.g., files and directories) and communications in response to system calls. 

#### Shell

The shell is an interactive program that provides an interface between the user and the kernel. The shell interprets commands entered by the user or supplied by a Shell script, and passes them to the kernel for execution. 

#### Human-Computer interfaces

At a high level, computers do four things:

- run programs
- store data
- communicate with each other
- interact with us (through either CLI or GUI)

#### The Command Line 

This kind of interface is called a **command-line interface**, or CLI,
to distinguish it from the **graphical user interface**, or GUI, that most people now use.

The heart of a CLI is a **read-evaluate-print loop**, or REPL: when the user types a command and then presses the enter (or return) key, the computer reads it, executes it, and prints its output. The user then types another command, and so on until the user logs off.

If you're using RStudio, you can use terminal inside RStudio (next to the "Console"). (For instance, type Alt + Shift + M)

#### The Shell 

This description makes it sound as though the user sends commands directly to the computer, and the computer sends output directly to the user. In fact, there is usually a program in between called a **command shell**.

![Source: Prashant Lakhera](https://miro.medium.com/max/1032/1*GuB5q_bWOSZa-8sDg1lEDA.png)

What the user types goes into the shell; it figures out what commands to run and orders the computer to execute them. 

Note, the reason why the shell is called *the shell*: it encloses the operating system in order to hide some of its complexity and make it simpler to interact with. 

A shell is a program like any other. What's special about it is that its job is to run other programs rather than to do calculations itself. The commands are themselves programs: when they terminate, the shell gives the user another prompt ($ on our systems).

#### Bash

The most popular Unix shell is **Bash**, the Bourne Again Shell (so-called because it's derived from a shell written by Stephen Bourne --- this is what passes for wit among programmers). Bash is the default shell on most modern implementations of **Unix**, and in most packages that provide Unix-like tools for Windows.

#### Why Shell?

Using Bash or any other shell sometimes feels more like programming than like using a mouse. Commands are terse (often only a couple of characters long), their names are frequently cryptic, and their output is lines of text rather than something visual like a graph. 

On the other hand, the shell allows us to combine existing tools in powerful ways with only a few keystrokes and to set up pipelines to handle large volumes of data automatically.

In addition, the command line is often the easiest way to interact with remote machines (explains why we learn Bash before learning Git and GitHub). As clusters and cloud computing become more popular for scientific data crunching, being able to drive them is becoming a necessary skill.

#### Our first command

The part of the operating system responsible for managing files and directories is called the **file system**. It organizes our data into files, which hold information, and directories (also called "folders"), which hold files or other directories.

Several commands are frequently used to create, inspect, rename, and delete files and directories. To start exploring them, let's open a shell window:

```sh
jae@jae-X705UDR:~$ 
```

* jae: a specific user name 

* jae-X705UDR: your computer/server name 

* `~`: current directory (`~` = home)

* `$`: a **prompt**, which shows us that the shell is waiting for input; your shell may show something more elaborate.

Type the command `whoami`, then press the Enter key (sometimes marked Return) to send the command to the shell.

The command's output is the ID of the current user, i.e., it shows us who the shell thinks we are:

```sh
$ whoami

# Should be your user name 
jae 
```

More specifically, when we type `whoami` the shell:

1.  finds a program called `whoami`,
2.  runs that program,
3.  displays that program's output, then
4.  displays a new prompt to tell us that it's ready for more commands.

#### Communicating to other systems

In the next unit, we'll be focusing on the structure of our own operating systems. But our operating systems rarely work in isolation; often, we are relying on the Internet to communicate with others! You can visualize this sort of communication within your own shell by asking your computer to `ping` (based on the old term for submarine sonar) an IP address provided by Google (8.8.8.8); in effect, this will test whether your Internet is working. 

```sh
$ ping 8.8.8.8
```

Note: Windows users may have to try a slightly different alternative:

```sh
$ ping -t 8.8.8.8
```

(Thanks [Paul Thissen](http://www.paulthissen.org/) for the suggestion!)

#### File system organization

Next, let's find out where we are by running a command called `pwd` (**print working directory**).

At any moment, our **current working directory** is our current default directory, i.e., the directory that the computer assumes we want to run commands in  unless we explicitly specify something else.

Here, the computer's response is `/home/jae`, which is the **home directory**:

```sh
$ pwd

/home/jae
```

**Additional tips**

You can also download files in the terminal. 

1. Install wget utility 

```sh

sudo apt-get install wget 

```
2. Download target files 

```sh 

wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1103-amd64.deb

```

![](misc/wget.png)

> #### Home Directory
>
> The home directory path will look different on different operating systems. On Linux it will look like `/home/jae`, and on Windows it will be similar to `C:\Documents and Settings\jae`. Note that it may look slightly different for different versions of Windows.

> #### Alphabet Soup
>
> If the command to find out who we are is `whoami`, the command to find out where we are ought to be called `whereami`, so why is it `pwd` instead? The usual answer is that in the early 1970s, when Unix was
>
> first being developed, every keystroke counted: the devices of the day were slow, and backspacing on a teletype was so painful that cutting the number of keystrokes in order to cut the number of typing mistakes was actually a win for usability. The reality is that commands were added to Unix one by one, without any master plan, by people who were immersed in its jargon. The result is as inconsistent as the roolz uv Inglish speling, but we're stuck with it now. 
>
> The good news: because these basic commands were so integral to the development of early Unix, they have stuck around, and appear (in some form) in almost all programming languages.

To understand what a "home directory" is, let's have a look at how the file system as a whole is organized. At the top is the **root directory** that holds everything else.

We refer to it using a slash character `/` on its own; this is the leading slash in `/home/jae`.

Inside that directory are several other directories: `bin` (which is where some built-in programs are stored), `data` (holding miscellaneous data files) `etc` (where local configuration files are stored), `tmp` (for temporary files that don't need to be stored long-term), and so on.

> If you're working on a Mac, the file structure will look similar, but not identical. The following image shows a file system graph for the typical Mac.

![File Directory](https://swcarpentry.GitHub.io/shell-novice/fig/home-directories.svg)

We know that our current working directory `/home/jae` is stored inside `/home` because `/home` is the first part of its name. Similarly, we know that `/home` is stored inside the root directory `/` because its name begins with `/`.

**Food for thought**

This hierarchical way of thinking about organizing things is prevalent in the design of computation systems. However, it doesn't need to be that way, especially when the system concerns something like conversations. 

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/P0H1m14Krmc" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p Reimagining the Internet 10: Amy Zhang, University of Washington, The Institute for Digital Public Infrastructure /p>
```

> #### Path
>
> Notice that there are two meanings for the `/` character.
> When it appears at the front of a file or directory name, it refers to the root directory. When it appears *inside* a name, it's just a separator.

#### Listing

Let's see what's in your home directory by running `ls` (**list files and directories):

```sh
$ ls

Applications		Dropbox			Pictures
Creative Cloud Files	Google Drive		Public
Desktop			Library			Untitled.ipynb
Documents		Movies			anaconda
Downloads		Music			file.txt
```

`ls` prints the names of the files and directories in the current directory in alphabetical order, arranged neatly into columns.

We can make `ls` more useful by adding flags. For instance, you can make your computer show only directories in the file system using the following command. Here `-F` flag classifies files based on some types. `/` indicates directories. 

```sh
ls -F /
```

The leading `/` tells the computer to follow the path from the root of the file system, so it always refers to exactly one directory, no matter where we are when we run the command.

What if we want to change our current working directory? Before we do this, `pwd` shows us that we're in `/home/jae`, and `ls` without any arguments shows us that directory's contents:

```sh
$ pwd

/home/jae

$ ls

Applications		Dropbox			Pictures
Creative Cloud Files	Google Drive		Public
Desktop			Library			Untitled.ipynb
Documents		Movies			anaconda
Downloads		Music			file.txt
```

Use relative paths (e.g., `../spring_2021/references.md`) whenever it's possible so that your code is not dependable on how your system is configured. 

**Additional tips**

How can I find pdf files in `Downloads` using the terminal? Remember `*` wildcard?

```sh
cd Downloads/ 

find *.pdf
```
Also, note that you don't need to type every character. Type the first few characters then press TAB (autocomplete). This is called **tab completion**, and we will see it in many other tools as we go on.

#### Moving around

We can use `cd` (**change directory**) followed by a directory name to change our working directory. 

```sh
$ cd Desktop
```

`cd` doesn't print anything, but if we run `pwd` after it, we can see that we are now in `/home/jae/Desktop`.

If we run `ls` without arguments now, it lists the contents of `/home/jae/Desktop`, because that's where we now are:

```sh

$ pwd

/home/jae/Desktop

```

We now know how to go down the directory tree: how do we go up? We could use an absolute path:

```sh
$ cd /home/jae/
```

but it's almost always simpler to use `cd ..` to go up one level:

```sh

$ pwd

/home/jae/Desktop

$ cd ..

```

`..` is a special directory name meaning "the directory containing this one", or more succinctly, the **parent** of the current directory. Sure enough, if we run `pwd` after running `cd ..`, we're back in `/home/jae/`:

```sh
$ pwd

/home/jae/
```

The special directory `..` doesn't usually show up when we run `ls`. If we want to display it, we can give `ls` the `-a` flag:

```sh
$ ls -a

.		.localized	Shared
..		Guest		rachel
```

`-a` stands for "show all"; it forces `ls` to show us file and directory names that begin with `.`, such as `..`.

> #### Hidden Files: For Your Own Protection
> 
> As you can see, a bunch of other items just appeared when we enter `ls -a`. These files and directories begin with `.` followed by a name. These areusually files and directories that hold important programmatic information, not usually edited by the casual computer user. They are kept hidden so that users don't accidentally delete or edit them without knowing what they're doing.

As you can see, it also displays another special directory that's just called `.`, which means "the current working directory". It may seem redundant to have a name for it, but we'll see some uses for it soon.

> #### Phone Home
> 
> If you ever want to get to the home directory immediately, you can use theshortcut `~`. For example, type `cd ~` and you'll get back home in a jiffy. `~` will also stand in for your home directory in paths, so for instance`~/Desktop` is the same as `/home/jae/Desktop`. This only works if it isthe first character in the path: `here/there/~/elsewhere` is not `/home/jae/elsewhere`.

**Additional tips**

Okay. These exercises help us get to know about `cd` command, but not very exciting. Let's do something more concrete and potentially useful. Let's say you downloaded a file using your web browser and locate that file. How could you do that?

Your first step should be learning more about `ls` command. You can do that by Googling or typing `ls --help`. By taking a look at the documentation, you can recognize that you need to add `-t` (sort by time). Then, what's `|`? It's called pipe and it chains commands. For instance, if `<command 1> | <command 2>`, then command1's output will be command2's input. `head` list the first ten lines of a file. `-n1` flag makes it show only the first line of the output (n1).

```sh
# Don't forget using TAB completion
cd Downloads/ 

ls -t | head -n1
```

Yeah! We can actually do more cool things. How can you find the most recently downloaded PDF file? You can do this by combining the two neat tricks you learned earlier. 

```sh
ls -t | find *.pdf | head -n1 
```

#### Creating, copying, removing, and renaming files 

##### Creating files 

1. First, let's create an empty directory named exercise 

```sh

mkdir exercise 

```

2. You can check whether the directory is created by typing `ls`. If the print format is difficult to read, add `-l` flag. Did you notice the difference?

3. Let's move to `exercise` subdirectory and create a file named test 

```sh 

cd exercise ; touch test ; ls 

```

4. Read test 

```sh

cat test 

```

5. Hmn. It's empty. Let's add something there. `>` = overwrite 

```sh 

echo "something" > test ; cat test 

```

6. Yeah! Can you add more? `>>` = append 

```sh 

echo "anything" >> test ; cat test 

```

7. Removing "anything" from `test` is a little bit more complex because you need to know how to use `grep` (remember that we used this command in the very first example). Here, I just demonstrate that you can do this task using Bash and let's dig into this more when we talk about working with text files.  

```sh 

grep -v 'anything' test

```

##### Copying and Removing Files 

1. Can we make a copy of `test`? Yes!

```sh

cp test test_1; cat 

```

2. Can we make 100 copies of `test?` Yes!

You can do this 

```sh

cp test test_1 
cp test test_2
cp test test_3 

... 

```

or 

```sh 

for i in {1..100}; do cp test "test_$i"; done  

```

Which one do you like? (Again, don't focus on for loop. We'll learn it and other similar tools to deal with iterations in the later chapters.)

3. Can you remove all of `test_` files?

You can do this 

```sh 
rm test_1
rm test_2
rm test_3 

...

```

or 

```

rm test_*

```

Which one do you like?

4. Let's remove the directory. 

```sh

cd .. 

rm exercise/

```

The `rm` command should not work because `exercise` is not a file. Type `rm --help` and see which flag is going to be helpful. It might be `-d` (remove empty directories).

```
rm -d exercise/  
```

Oops. Still not working because the directory is not empty. Try this. Now, it works. 

```
rm -r exercise/ 
```

What's `-r`? It stands for recursion (e.g., . Recursion is a very powerful idea in programming and helps solving complex problems. We'll come back to it many times (e.g., `purrr::reduce` in R). 

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/Mv9NEXX1VHc" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

```

##### Renaming files

1. Using `mv`

First, we will learn how to move files and see how it's relevant for renaming files. 

```sh

# Create two directories 
mkdir exercise_1 ; mkdir exercise_2 

# Check whether they were indeed created 
find exer*

# Create an empty file 
touch exercise_1/test 

# Move to exercise_1 and check 
cd exercise_1 ; ls 

# Move this file to exercise_2 
mv test ../exercise_2 

# Move to exercise_2 and check 
cd exercise_2 ; ls 
```

What `mv` has something to do with renaming?

* [mv] [source] [destination]

```sh

mv test new_test ; ls 

```

2. Using `rename`

`mv` is a good tool to rename one file. But how about renaming many files? (Note that your pwd is still `exercise_2` where you have `new_test` file.)

```sh

for i in {1..100}; do cp new_test "test_$i.csv"; done  

```

Then install `rename`. Either `sudo apt-get install -y rename` or `brew install rename` (MacOS).

Basic syntax: rename [flags] perlexpr (Perl Expression) files. Note that [Perl](https://en.wikipedia.org/wiki/Perl) is another programming language. 

```sh
# Rename every csv file to txt file 
rename 's/.csv/.txt/' *.csv

# Check 
ls -l
```

The key part is `s/.csv/.txt/` = `s/FIND/REPLACE`

Can you perform the same task using GUI? Yes, you can but it would be more time-consuming. Using the command line, you did this via just one-liner(!). [Keith Brandnam](http://korflab.ucdavis.edu/Bios/bio_keithb.html) wrote a wonderful book titled [UNIX and Perl to the Rescue! (Cambridge University Press 2012)](https://www.amazon.com/Unix-Perl-Rescue-Keith-Bradnam/dp/0521169828) that discusses how to use UNIX and Perl to deal with massively large datasets.

#### Working with CSV and text files 

1. Download a CSV file (Forbes World’s Billionaires lists from 1996-2014). For more on the data source, see [this site](https://corgis-edu.github.io/corgis/csv/billionaires/).

```sh
wget https://corgis-edu.github.io/corgis/datasets/csv/billionaires/billionaires.csv
```

2. Read the first two lines. We have learned `cat`, `|`, and `head` already. So, there's nothing new here.

**Additional tips 1**
If you have a large text file, the fact that `cat` prints everything at once is inconvenient. The alternative using `less`. 

```sh
cat billionaires.csv | head -n2
```

3. Check the size of the dataset (2615 rows). So, there are 2014 observations (n-1 because of the header). `wc` prints newline, word, and byte counts for each file. If you run `wc` without `-l` flag, you get the following: `2615 (line) 20433 (word) 607861 (byte) billionaires.csv`

```sh
wc -l billionaires.csv
```

4. How about the number of columns? `sed` is a stream editor and very powerful when it's used to filter text in a pipeline. For more information, see [this article](https://www.gnu.org/software/sed/manual/sed.html). You've already seen `s/FIND/REPLACE`. Here, the pattern we are using is `s/delimiter/\n/g`. We've seen that the delimiter is `,`, so that's what I plugged in the command below. 

```sh
head -1 billionaires.csv | sed 's/,/\n/g' | nl
```

**Additional tips 2**
The other cool command for text parsing is `awk`. This command is especially useful for filtering.

1. This is same as using `cat` (basically, printing). So, what's new? 

```sh
awk '{print}' billionaires.csv 
```

2. This is new. 

```sh
awk '/China/ {print}' billionaires.csv
```

3. Let's see only the five rows. We filtered rows so that the every row in the final dataset contains 'China'. 

```sh
awk '/China/ {print}' billionaires.csv | head -n5 
```

4. You can also get the numbers of these rows. 

```sh
awk '/China/ {print NR}' billionaires.csv 
```

#### User roles and file permissions

1. If you need admin access, use `sudo`. For instance, `sudo apt-get install <package name>`.

2. To run a Shell script (.sh), you need to change its file mode. You can make the script executable by typing `chmod +x <Shell script>`. Then, you can run it by typing `./pdf_copy_sh.` `.` refers the current working directory. Other options: `sh pdf_copy_sh.` or `bash pdf_copy_sh.` I use `./pdf_copy_sh.`

#### Writing your first Shell script (.sh)

Finally, we're learning how to write a Shell script (a file that ends with .sh). Here I show how to write a Shell script that creates a subdirectory called `/pdfs` under `/Download` directory, then find PDF files in `/Download` and copy those files to `pdfs`. Essentially, this Shell script creates a backup. Name this Shell script as 'pdf_copy.sh.' Pay attention to this example as a similar exercise is going to be part of your second assignment. 

```sh

#!/bin/sh # Stating this is a Shell script. 

mkdir /home/jae/Downloads/pdfs # Obviously, in your case this file path should be incorrect.

cd Download

cp *.pdf pdfs/ 

echo "Copied pdfs"

```

**Additional tips**

Using Make [TBD]

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/aw9wHbFTnAQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p Using make and writing Makefile (in C++ or C) by Programming Knowledge/p>
```

### References 

- [The Unix Workbench](https://seankross.com/the-unix-workbench/) by Sean Kross 

- [The Unix Shell](http://swcarpentry.GitHub.io/shell-novice/), Software Carpentry 

- [Data Science at the Command Line](https://www.datascienceatthecommandline.com/1e/) by Jeroen Janssens 

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/QxpOKbv-KQU" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p Obtaining, Scrubbing, and Exploring Data at the Command Line by Jeroen Janssens from YPlan, Data Council /p>
```

- [Shell Tools and Scripting](https://missing.csail.mit.edu/2020/shell-tools/), ./missing-semester, MIT  

- [Command-line Environment](https://missing.csail.mit.edu/2020/command-line/), ./missing-semester, MIT

## Git and GitHub

### Version control system 

**The most important point**

* Backup != Version control

* If you do version control, you need to save your **raw data** in your hard disk, external drive, or cloud, but nothing else. In other words, anything that you are going to change should be subject to version control (also, it's not same as saving your code with names like 20200120_Kim or something like that). Below, I will explain what is version control and how to do it using Git and GitHub. 

![Why you should do version control](https://i2.wp.com/cdn-images-1.medium.com/max/399/1*7HHA_UkjUK7wp7qP4CYu1g.png?zoom=1.75&w=456&ssl=1)

According to [GitHub Guides](https://guides.GitHub.com), a version control system "tracks the history of changes as people and teams collaborate on projects together". Specifically, it helps to track the following information:

* Which changes were made?
* Who made the changes?
* When were the changes made?
* Why were changes needed?

Git is a case of a [distributed version control system](https://en.wikipedia.org/wiki/Distributed_version_control), common in open source and commercial software development. This is no surprising given that Git [was originally created](https://lkml.org/lkml/2005/4/6/121) to deal with Linux kernal development. 

**Food for thought**

If you're curious about how the Internet works, learn one of the key ideas of the Internet: [end-to-end principle](https://en.wikipedia.org/wiki/End-to-end_principle). This also explains why [net neutrality](https://en.wikipedia.org/wiki/Net_neutrality) matters. 

The following images, from [Pro Git](git-scm.com), show how a centralized (e.g., CVS, Subversion, and Perforce) and decentralized VCS (e.g., Git, Mercurial, Bazzar or Darcs) works differently. 

![Centralized version control system](https://git-scm.com/book/en/v2/images/centralized.png)

Figure 2. Centralized VCS.

![Decentralized version control system](https://git-scm.com/book/en/v2/images/distributed.png)

Figure 3. Decentralized VCS.

For more information on the varieties of version control systems, please read [Petr Baudis's review](https://pdfs.semanticscholar.org/4490/4c70bc91e1bed4fe02b9e2282f031b7c90ea.pdf) on that subject.


```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/PFwUHTE6mFc" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p Webcast • Introduction to Git and GitHub • Featuring Mehan Jayasuriya, GitHub Training & Guides/p>
```


![Figure 2.1. A schematic git workflow from Healy's "The Plain Person’s Guide to Plain Text Social Science"](https://plain-text.co/figures/git-basic.png)

For more information, watch the following video:

```{=html}

<iframe width="560" height="315" src="https://www.youtube.com/embed/u6G3fbmpWr8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<p The Basics of Git and GitHub, GitHub Training & Guides /p>

```

### Setup 

#### Signup 

1. Make sure you have installed Git ([[tutorial]](https://happygitwithr.com/install-git.html#install-git)). 

```sh
git --version 
# git version 2.xx.x
```

2. If you haven't, sign up a GitHub account: https://github.com/
  - If you're a student, also sign up for GitHub Student Developer Pack: https://education.github.com/pack Basically, you can get a GitHub pro account for free (so why not?).
  
3. Access GitHub either using Hypertext Transfer Protocol Secure (HTTPS) or Secure Sheel (SSH).

**HTTPS**

1. Create a personal access token. Follow this guideline: https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token

2. Store your credential somewhere safe. You can use an R package like this [gitcreds](https://gitcreds.r-lib.org/) and [credentials](https://docs.ropensci.org/credentials/) to do so.













































































