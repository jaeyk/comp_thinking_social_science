# The Unix Shell: 5. Git basics 

> * The following contents are adapted from [the git-fundamentals workshop materials](https://github.com/dlab-berkeley/git-fundamentals/blob/master/0-1_introduction.md) prepared by Dillon Niederhut at D-Lab and other resources from [Pro Git](https://git-scm.com) by Scott Chacon and Ben Straub. 
> * Learn what is a version control system and what is Git
> * Learn how to use Git  
>   * How to setup your Git account on your local machine 
>   * How to make a repository
>   * How to commit changes 
>   * How to push and pull (fetch)
>   * How to branch (at least know about this conceptually) 

![Why you should do version control](https://i2.wp.com/cdn-images-1.medium.com/max/399/1*7HHA_UkjUK7wp7qP4CYu1g.png?zoom=1.75&w=456&ssl=1)

### 1. Version control system 

According to [Github Guides](https://guides.github.com), a versin control system "tracks the history of changes as people and teams collaborate on projects together". Specifically, it helps to track the following information:

* Which changes were made?
* Who made the changes?
* When were the changes made?
* Why were changes needed?

Git is a case of a [distributed version control system](https://en.wikipedia.org/wiki/Distributed_version_control), common in open source and commercial software development. This is no surprising given that Git [was originally created](https://lkml.org/lkml/2005/4/6/121) to deal with Linux kernal development. 

* If you're curious about how the Intenret works, learn one of the key ideas of the Internet: [end-to-end principle](https://en.wikipedia.org/wiki/End-to-end_principle). This also explains why [net neutrality](https://en.wikipedia.org/wiki/Net_neutrality) matters. 

The following images, from [Pro Git](git-scm.com), show how a centralized (e.g., CVS, Subversion, and Perforce) and decentralized VCS (e.g., Git, Mercurial, Bazzar or Darcs) works differently. 

![Centralized version control system](https://git-scm.com/book/en/v2/images/centralized.png)

Figure 2. Centralized VCS.

![Decentralized version control system](https://git-scm.com/book/en/v2/images/distributed.png)

Figure 3. Decentralized VCS.

For more information on the varieties of version control systems, please read [Petr Baudis's review](https://pdfs.semanticscholar.org/4490/4c70bc91e1bed4fe02b9e2282f031b7c90ea.pdf) on that subject.

### 2. Setup 

We'll start with telling Git who you are.

```shell
$ git config --global user.name "Firstname Lastname"
$ git config --global user.email username@company.extension
```
### 3. Making a repository 

Create a new directory and move to it. 

```shell 
$ mkdir code_exercise 
$ cd code_exercise 
```

```{shell}
$ git init 
```

Alternatively, you can create a Git repository via Github and then clone it on your local machine. 

```{shell}
$ git clone /path/to/repository
```

If you're unfamiliar with basic Git commands, then please refer to [this Git cheet sheet](http://rogerdudler.github.io/git-guide/files/git_cheat_sheet.pdf).

### 4. Commit changes 

These feature show how Git works as a version control system. 

If you edited files or added new ones, then you need to update your repository. In Git terms, this action is called committing changes. 

```{shell}
$ git add . # update every change. In Git terms, you're staging. 
$ git add file_name # or stage a specific file.
$ git commit -m "your comment" # your comment for the commit. 
$ git push origin master # commit the change. Origin is a defaul name given to a server by Git. 
```
Another image from [Pro Git](https://git-scm.com/about/staging-area) well illustrates this process.

![Git Workflow](https://git-scm.com/images/about/index1@2x.png)

Figure 4. Staging and committing in Git.

#### 4.1. Other useful commands for tracking history

```{shell}
$ git diff # to see what changed (e.g., inside a file)
$ git log # to track who committed what
$ git checkout the commit hash (e.g., a5e556) file name (fruit_list.txt) # to recover old files 
$ git revert 1q84 # revert to the previous commit 
```
#### 4.2. Doing other than adding 

```{shell}
$ git rm file_name # remove 
$ git mv old_file_name new_file_name # rename a file 
```

### 5. Push and pull (or fetch)

These features show how Git works as a collaboration tool. 

If you have not already done, let's clone PS239T directory on your local machine.

```{shell}
$ git clone https://github.com/jaeyk/PS239T # clone 
```

Then, let's learn more about the repository.

```{shell}
$ git remote -v 
```

Previously, we learned how to send your data save in the local machine to the remote (the Github server). You can do that by editing or creating files, committing, and then typing **git push**. 

Instead, if you want to update your local data with the remote data, then you can type **git pull origin** (something like pwd in bash). Alternatively, you can use fetch (retrieve data from a remote). When you do that, Git retrieves the data and merge it into your local data.

```{shell}
$ git fetch origin
```

### 6. Branching 

It's an advanced feature of Git's version control system that allows developers to "diverge from the main line of development and continue to do work without messing with that main line" according to [Scott Chacon and Ben Straub](https://git-scm.com/book/en/v1/Git-Branching). 

If you start working on a new feature, then create a new branch. 

```{shell}
$ git branch new_features
$ git checkout new_features
```

You can see the newly created branch by typing **git branch**.

In short, branching makes Git [works like](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics) a mini file system.

### 7. Collaborations 

Two options. 

* Sharing a repository (suitable for a private project).
* Fork and pull (suitable for an open source project). 
    ​    * The one who maintains the repository becomes the maintainer. 
    ​    * The others can [fork](https://help.github.com/articles/about-forks/), make changes, and even [pull](https://help.github.com/articles/about-pull-requests/) them back.

### 8. Other stuff 

```{shell}
$ git status # show the status of changes 
$ git branch # show the branch being worked on locally
$ git merge # merge branches 
$ git reset --hard # restore the pristine version
$ git commit -a -m "additional backup" # to save the state again
```


