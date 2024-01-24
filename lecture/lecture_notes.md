---
editor_options: 
  markdown: 
    wrap: 72
---

01-18-2024 
  - library(devtools) for prepping R to use version control 
  -create_project("new_project_name")
  - use_git() after devtools package loaded, tells R that you want to use git as the version control 
  - once you make a new project and have it set up with commit, use_github() to connect it to specific github account
  - remember! any time where you need to use a git based command, make sure devtools package is loaded first
  - in R terminal, can check version control of the working project using "git status" 
  - "git pull" check that there's no other versions that need to be pulled down
  - "git add -A" to add ALL new files that you've created to be tracked
  - "git commit -am"commit message"" commits all changes with a message
  - "git push" to push commits to remote repository

01-24-2024
  - to clone repository from github, copy repo link, open new project in Rstudio, choose version control and paste url
  - rmarkdown:::site_skeleton(getwd()) in console use rmarkdown package and use site skeleton command to set up basic webpage version and make it using the current working directory (looks for an index file)s --> this will across create a yml file which is part of a basic site infrastructure