# The Unix Shell: 5. Git basics 

> * The following contents are adapted from [git-fundamentals workshop materials](https://github.com/dlab-berkeley/git-fundamentals/blob/master/0-1_introduction.md) prepared by Dillon Niederhut at D-Lab. 
> * Learn how to use git  
>   * How to setup your git account on your local machine 
>   * How to make a repository
>   * How to commit changes 
>   * How to push and pull (fetch)
>   * How to branch (at least know about this conceptually) 

### 1. Setup 

We'll start with telling git who you are.

```shell
$ git config --global user.name "Firstname Lastname"
$ git config --global user.email username@company.extension
```
### 2. Making a repository 

Create a new directory and move to it. 

```shell 
$ mkdir code_exercise 
$ cd code_exercise 
```

```{shell}
$ git init 
```

Alternatively, you can create a git repository via github and then clone it on your local machine. 

```{shell}
$ git clone /path/to/repository
```

If you're unfamiliar with basic git commands, then please refer to [this git cheet sheet](http://rogerdudler.github.io/git-guide/files/git_cheat_sheet.pdf).

### 3. Commit changes 

This feautre shows how git works as a version control system. 

If you edited files or added new ones, then you need to update your repository. In git language, this action is called committing changes. 

```{shell}
$ git add . # update every change. 
$ git commit -m "your comment" # your comment for the commit. 
$ git push origin master # commit the change. 
```

#### 3.1. Other useful commands for version control 

```{shell}
$ git diff # to see what changed (e.g., inside a file)
$ git log # to track who committed what
$ git checkout the commit hash (e.g., a5e556) file name (fruit_list.txt) # to recover old files 
```

### 4. Push and pull (or fetch)

This feature shows how git works as a collaboration tool. 

If you have not already done, let's clone PS239T directory on your clocal machine.

```{shell}
$ git clone https://github.com/jaeyk/PS239T # clone 
```

Then, let's learn more about the repository.

```{shell}
$ git remote -v 
```

Previously, we learned how to send your data save in the local machine to the remote (the github server). You can do that by editing or creating files, commiting, and then typing **git push**. 

Instead, if you want to update your local data with the remote data, then you can type git pull origin (something like pwd in bash). Alternatively, you can use fetch (retrieve data from a remote). When you do that, git retrieves the data and merge it into your local data.

```{shell}
$ git fetch origin master
```

### 5. Branching 

It's an advanced feature of Git's version control system that allows developers to "diverge from the main line of development and continue to do work without messing with that main line" according to [the official git documentations](https://git-scm.com/book/en/v1/Git-Branching). 

If you start working on a new feature, then create a new branch. 

```{shell}
$ git branch new_features
$ git checkout new_features
```

You can see the newly created branch by typing **git branch**.
