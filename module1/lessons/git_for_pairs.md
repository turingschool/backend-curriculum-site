---
title: Git for Pairs
length: 60
tags: ruby, git, workflow
---

## Learning Goals

* Describe flow integrating git and github  
* Describe how two people might work off the same repository
* Describe steps to resolving a merge conflict

## Structure

* 5   - Warmup
* 20  - Pairing Demonstration
* 5   - Break
* 25  - Resolve Merge Conflict Demonstration
* 5   - Closing/Synthesis

## Vocabulary 
* Git Commands
  * git status
  * git add file_name 
  * git add .
  * git commit -m "Add message"
  * git push origin branch_name
  * git pull origin branch_name
* Merge Conflict 

## WarmUp  

* What is git?  
* How does GitHub relate to git?  
* What are the steps to creating and interacting with a repo on GitHub? How is git involved?

## Modeling Workflow

### Git Flow for Pairs 101   
* Make a directory and CD into it  
* Check that repo is not already inited   
  (`git status`)  
* Initialize repo locally    
  (`git init`)     
* Create a repo on GitHub  
  (repositories/new)
* Add remote to local
  (`git remote add origin`)
* Check successful addition  
  (`git remote -v`)
* Check git status  
  (`git status`)
* Make a file  
  (`touch filename.rb`) 
* Commit and push  
  - `git status`
  - `git add .`
  - `git status`
  - `git commit -m "Add a message"`
  - `git push origin master`
* Add a branch (`git checkout -b add_content`)
* Add content to file 

* Add collaborator on github
* Collaborator accepts invitation through email  
* Collaborator clones repo (`git cone repo_name`)
* Collaborator cds into cloned repo  
* Collaborator checks out branch (`git checkout add_content`)
* Collaborator changes current line of file  
* Collaborator commits and pushes to branch  
  - `git status`
  - `git add .`
  - `git status`
  - `git commit -m "Add a message"`
  - `git push origin add_content`

### Merge Conflict Work Flow  

* Original makes a change to the line in the file  
* Original commits changes
* Original pulls from branch w/ Collaborator's changes  
  (`git pull origin add_content`)  
* Original resolves merge conflict  
  (choose which version of the code you'd like to keep    
   delete the code you do not want)  
* Original commits changes  
  (`git status`
   `git add .`  
   ` git status`
   `git commit -m "Add a message"`)   
* Original switches to master (`git checkout master`)
* Original pull from master (`git pull origin master`)
* Original switches back to branch (`git checkout add_content`)
* Original merges master into branch (`git merge master`)
* Original pushes updated branch to GitHub  
  (`git push origin add_content`)
* Original puts in PR 
* Collaborator comments and merges PR 

![Merging a Branch to Master](https://drive.google.com/file/d/0B7O23RVvI8-FT0lGbm5HUmJQNFU/view?usp=sharing)

### Optional: Work flow with branches  
* Collaborator pulls from master   
  (`git pull origin master`)  
* Collaborator creates new branch  
  (`git checkout -b new_branch_name`)   
* Check which branch you're on  
  (atom: bottom right of window  
   git: `git branch`)   
* Collaborator adds content on new branch  
* Collaborator commits and pushes branch  
* Collaborator reviews files pushed on GitHub
* Collaborator puts in a PR on GitHub
* Original merges branch to master on GitHub
* Original pulls down from master  
  (`git pull origin master`)
* Collaborator pulls down from master  
  (`git pull origin master`)

## Closing  
Talk with partner
* What are the commands to do the following:
   - Create a repo  
   - Connect a git repo to a GitHub repo  
   - Update your local git with new content  
   - Update GitHub with new content  
* What steps would you take if working with a partner on a separate computer? What are the pros/cons of this work flow?  
* What is a merge conflict? How might you resolve a merge conflict?

### Additional Resources  
[Git - the Simple Guide](http://rogerdudler.github.io/git-guide/)  
[Pro Git](https://git-scm.com/book/en/v2)  

### Alternate Way to Create a Repo:  
 Create a repo on GitHub using Hub
  (`hub create`)  
* Check GitHub for successful repo creation  
  (`hub browse`)
