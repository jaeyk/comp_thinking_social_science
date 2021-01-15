# Managing data and code {#git_bash}



## Using Bash (command line interface)

As William Shotts the author of *[The Linux Command Line](http://linuxcommand.org/tlcl.php)* put it: 

> graphical user interfaces make easy tasks easy, while command line interfaces make difficult tasks possible.

### Why bother using command line?

Create a plain text file that contains word "test"

- `echo`: "Write arguments to the standard output" This is equivalent as using a text editor (e.g., nano, vim, emacs) and write something.
- `> test` Save the expression in a file named test.   
- In general, if you don't know what a command does, just type `<command name> --help` or `<command name> -h`. If you need more detailed information, you can do `man <command name>`. `man` stands for manual. Finally, you can get more user-friendly information by using either [`tldr`](https://tldr.sh/). 


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

Append "no_test" to the file named test_100. Note that I used `>>` (append) not `>`. 


```sh

echo "no_test" >> test_100 

```

Let's read (=`cat` (concatenate)) what's in test_100 


```sh

cat test_100 

```

```
## no_test
```

Find which fine contains the character "no_test." This is literally equivalent to finding a needle in a haystack. This is a daunting task for a human researcher, but not for our robotic assistant. `grep` finds PATTERNS in each FIEL. What follows - are options (called flags): `r` (recursive), `n` (line number), `w` (match only whole words), `e` (use patterns for matching). `rnw` are for output control and `e` is for pattern selection. 

You can write `grep -r -n -w -e "no_test"`, but the simpler the better. 

* `grep`: command 

* `-rnw -e`: flags 

* `no_test`: argument (usually file or file paths)


```sh

grep -rnw -e "no_test" 

```

```
## test_100:1:no_test
## 02_intro.Rmd:40:Append "no_test" to the file named test_100. Note that I used `>>` (append) not `>`. 
## 02_intro.Rmd:44:echo "no_test" >> test_100 
## 02_intro.Rmd:56:Find which fine contains the character "no_test." This is literally equivalent to finding a needle in a haystack. This is a daunting task for a human researcher, but not for our robotic assistant. `grep` finds PATTERNS in each FIEL. What follows - are options (called flags): `r` (recursive), `n` (line number), `w` (match only whole words), `e` (use patterns for matching). `rnw` are for output control and `e` is for pattern selection. 
## 02_intro.Rmd:58:You can write `grep -r -n -w -e "no_test"`, but the simpler the better. 
## 02_intro.Rmd:64:* `no_test`: argument (usually file or file paths)
## 02_intro.Rmd:68:grep -rnw -e "no_test" 
## 02_intro.Rmd:80:This command should return "test_100:2:no_test." (file test_100; line number 2; no_test)
## 02_intro.knit.md:39:Append "no_test" to the file named test_100. Note that I used `>>` (append) not `>`. 
## 02_intro.knit.md:44:echo "no_test" >> test_100 
## 02_intro.knit.md:58:## no_test
## 02_intro.knit.md:61:Find which fine contains the character "no_test." This is literally equivalent to finding a needle in a haystack. This is a daunting task for a human researcher, but not for our robotic assistant. `grep` finds PATTERNS in each FIEL. What follows - are options (called flags): `r` (recursive), `n` (line number), `w` (match only whole words), `e` (use patterns for matching). `rnw` are for output control and `e` is for pattern selection.
## .Rproj.user/B75B1E19/sources/s-734BA493/A87AAC6A-contents:40:Append "no_test" to the file named test_100. Note that I used `>>` (append) not `>`. 
## .Rproj.user/B75B1E19/sources/s-734BA493/A87AAC6A-contents:44:echo "no_test" >> test_100 
## .Rproj.user/B75B1E19/sources/s-734BA493/A87AAC6A-contents:56:Find which fine contains the character "no_test." This is literally equivalent to finding a needle in a haystack. This is a daunting task for a human researcher, but not for our robotic assistant. `grep` finds PATTERNS in each FIEL. What follows - are options (called flags): `r` (recursive), `n` (line number), `w` (match only whole words), `e` (use patterns for matching). `rnw` are for output control and `e` is for pattern selection. 
## .Rproj.user/B75B1E19/sources/s-734BA493/A87AAC6A-contents:58:You can write `grep -r -n -w -e "no_test"`, but the simpler the better. 
## .Rproj.user/B75B1E19/sources/s-734BA493/A87AAC6A-contents:64:* `no_test`: argument (usually file or file paths)
## .Rproj.user/B75B1E19/sources/s-734BA493/A87AAC6A-contents:68:grep -rnw -e "no_test" 
## .Rproj.user/B75B1E19/sources/s-734BA493/A87AAC6A-contents:80:This command should return "test_100:2:no_test." (file test_100; line number 2; no_test)
```

Let's remove (=`rm`) all the duplicate files as well as the original file. `*` (any number of characters) is a wildcard (if you want to identify a single number of character, use `?`). It finds every file whose name starts with `test_`.


```sh

rm test_* test 

```

This command should return "test_100:2:no_test." (file test_100; line number 2; no_test)

What is this black magic? Can you do the same thing using graphical interface? Which method is more efficient? I hope that this quick demonstration will give you enough sense of why learning command line could be incredibly useful. In my experience, mastering command line helps automating your research process almost from end to end. For instance, you don't need to write files from a website using your web browser. You can run `wget` command in the terminal. Better yet, you don't even need to run the command for the second time. You can write a shell script (`*.sh`) that automates downloading, moving, and sorting multiple files. You can find one example of this from the PS239T course repository. [`copy_syllabus.sh`](https://github.com/PS239T/spring_2021/blob/main/copy_syllabus.sh) automatically runs an R markdown file, produces HTML and PDF outputs, and move these files to a desired location. When I modified something in the syllabus, I just need to run this shell script again. (No worries! I will explain what is Shell shortly.) Finally, if you need to interact with servers or supercomputers for your research, you are likely to use the command-line interface.

### What Is Bash?

The following materials on UNIX and Shell are adapted from [the software carpentry](https://bids.github.io/2015-06-04-berkeley/shell/00-intro.html.

#### Unix

UNIX is an operating system which was first developed by AT & T employees at Bell Labs (1969-1971). From Mac OS X to Linux, many of current operation systems are some versions of UNIX. For this reason, if you're using Max OS, then you don't need to do anything else. You're already all set. If you're using Windows. You need to install either GitBash (works if you only use Bash for Git and GitHub) or Windows Subsystem (strongly recommended if your use case goes beyond these limited usages). For more information, see [this installation guideline](https://github.com/PS239T/spring_2021/blob/main/B_Install.md) from the course repo. 

UNIX is old, but it is still mainstream. Moreover, [the UNIX philosophy](https://en.wikipedia.org/wiki/Unix_philosophy) ("Do One Thing And Do It Well")---minimalist, modular software development---is highly and widely influential.  

![Ken Thompson and Dennis Ritchie, key proponents of the Unix philosophy](https://upload.wikimedia.org/wikipedia/commons/1/1b/Ken_Thompson_and_Dennis_Ritchie--1973.jpg)



#### Kernel

The kernel of UNIX is the hub of the operating system: it allocates time and memory to programs and handles the [filestore](http://users.ox.ac.uk/~martinw/unix/chap3.html) (e.g., files and directories) and communications in response to system calls. 

#### Shell

The shell is an interactive program that provides an interface between the user and the kernel. The shell interprets commands entered by the user or supplied by a shell script, and passes them to the kernel for execution. 

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









































































































































