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
  - for adding site to github, go to settings>pages within repository and deploy from branch, branch>main/master and save. It will take a few minutes and then should be live
  
01-25-2024
  - echo shows code or not
  - eval shows results or not
  
01-30-2024
  - purl function purl("file.Rmd") will create an R script file from the code chunks in the Rmd, part of the knitr package
  - in regular expressions (regex, aka grep) a period . denotes every character. To escape this, a backslash is put in front \.
  - wild cards can be used in regular expressions to find specific things
    - \w a single word character [letter,number or _]
    - \d a single number character [0-9]
    - \t a single tab space
    - \s a single space, tab, or line break
    - \n a single line break (or try \r)
  - Quantifiers can be used with wild cards to find additional characters
    - \w+ one or more consecutive word characters
    - \w* zero or more consecutive word characters
    - \w{3} exactly 3 consecutive word characters
    - \w{3,} 3 or more consecutive word characters
    - \w{3,5} 3, 4, or 5 consecutive word characters
  - to capture a certain part of a search, surround it with parentheses. Those captured parts can now be refered to in the search in numerical order left to right \1 \2 ...
  - custom character sets can be denoted by brackets [ ], these can also be used with quantifiers
    - to negate a character set, include an up carrot [^ ]
    
    
02-01-2024
   - atomic vector: 1 dimensional homogeneous data type
    - ex: character strings, integers/doubles (numeric), logicals (true, false), factor, vector of lists
   - matrix: 2 dimensional homogeneous data type
   - array: n dimensional homogeneous data type
   - list: 1 dimensional heterogeneous (multiple kinds of data) data type
   - data frame: 2 dimensional heterogeneous data type
   
02-08-2024
  - Relational operators in R
    - < less than
    - > greater than
    - <= less than or equal to
    - >= greater than or equal to
    - == equal to
    - ! not
    - & and (vector)
    - | or (vector)
    - xor(x,y) either x or y needs to be true