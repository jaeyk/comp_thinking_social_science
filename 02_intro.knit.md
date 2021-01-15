# Managing data and code {#git_bash}



## Using Bash (command line interface)

As William Shotts the author of *[The Linux Command Line](http://linuxcommand.org/tlcl.php)* put it: 

> graphical user interfaces make easy tasks easy, while command line interfaces make difficult tasks possible.

### Why bother using command line?

Create a plain text file that contains word "test"

- `echo`: "Write arguments to the standard output" This is equivalent as using a text editor (e.g., nano, vim, emacs) and write something.
- `> test` Save the expression in a file named test.   
- In general, if you don't know what a command does, just type `<command name> --help` or `<command name> -h`. If you need more detailed information, you can do `man <command name>`. `man` stands for manual. Finally, you can get more user-friendly information by using [`tldr`](https://tldr.sh/). 


```sh

echo "test" > test 

```

- Make 100 duplicates of this file. Let's break down the seemingly complex commands. 
- I did this using for loop (`for i in {1..100}`). Curly braces `{}` makes 1..100 integers from 1 to 100.  
- `;` is used to use multiple commands without making line breaks. 
- `$var` returns the value associated with variable. Type `name=<Your name>`. Then, type `echo $name`. You should see your name printed. Variable assignment is one of the most basic things you'll learn in any programming.  
- For novice users, I warn you that these could be little advanced concepts. So, don't pay too much attention to this. For now, it's enough to have intuitions. 


```sh

for i in {1..100}; do cp test "test_$i"; done  

```

Append "no_test" to the file named test_100. Note that I used `>>` (append) not `>`. 


```sh

echo "no_test" >> test_100 

```

Let's see (=`cat`) what's in test_100 


```sh

cat test_100 

```

```
## no_test
```

Find which fine contains the character "no_test." This is literally equivalent to finding a needle in a haystack. This is a daunting task for a human researcher, but not for our robotic assistant. `grep` finds PATTERNS in each FIEL. What follows - are options (called flags): `r` (recursive), `n` (line number), `w` (match only whole words), `e` (use patterns for matching). `rnw` are for output control and `e` is for pattern selection.













































































































































