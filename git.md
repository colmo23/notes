# Stages of git

untracked file -> staging -> local repository (.git) -> remote repository

staging area == cache == git's index
working tree == untracked file or change

## Adding changes

- git add - add to staging area
- git commit - add to local repository (.git)
- git push - push to remote repository

## Removing changes
- git restore
- git restore --cached

## Viewing changes
- git diff
- git diff --cached

# Misc

distributed version control - all clients have full copy of the change history

### Config
git global user configuration
~/.gitconfig

git config --list

git config --global user.name "your name"

open vscode on local directory
```
code .
```

Open file explorer on local directory
```
explorer.exe .
```

### add all local changed files to staging area
git add .


### Connect your local repo to a remote repo (for the first time)
git remote add origin <git url>


### View all commits and their checksums
git log

### View changes in a commit
git show <checksum>

### Show detailed log of every commit
git log -p

### Show visualisation of how branches are
git log --graph 


### find a particular commit message
git log --grep='regex to search for in commit messages'

### Put this file in an empty folder to tell git the folder is in use
.gitkeep

### Revert changes that are in staging area
git restore --staged <filename>

### Go to a particular commit:
git checkout <checksum>

### Go to latest commit
git checkout main

### view commit messages only (one line each)
git log --oneline

### amending to a commit
For example you have done a commit, but then want to add more changes to it. Then add the files and do:

git commit --amend

### revert change

go back to a previous state

git log --oneline
git revert <commit hash>

### rebase

Add a commit to an earlier stage in history

Do interactive editing of full commit history:
git rebase -i --root

Do interactive editing of last 3 commits:
git rebase -i HEAD~3

### Branches

#### View all branches:
git branch

#### Create and checkout a branch
git branch new-branch
git checkout new-branch
