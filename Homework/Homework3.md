Homework 3
Gwen Ellis

# Question 1 #
### Input
First String    Second      1.22      3.4
Second          More Text   1.555555  2.2220
Third           x           3         124
### Result
First String,Second,1.22,3.4
Second,More Text,1.555555,2.2220
Third,x,3,124
### Method
replace two or more spaces with a comma
```
find:\s{2,}
replace:,
```

# Question 2 #
### Input
Ballif, Bryan, University of Vermont
Ellison, Aaron, Harvard Forest
Record, Sydne, Bryn Mawr
### Result
Bryan Ballif (University of Vermont)
Aaron Ellison (Harvard Forest)
Sydne Record (Bryn Mawr)
### Method
find the first word (1), find a comma, find the space, find the next word (2), find the space, find everything else (3). Replace in the order of 2, 1, 3 with parentheses around 3
```
find:(\w+),\s*(\w+),\s(.*)
replace:\2 \1 (\3)
```

# Question 3 #
### Input
0001 Georgia Horseshoe.mp3 0002 Billy In The Lowground.mp3 0003 Winder Slide.mp3 0004 Walking Cane.mp3
### Result
0001 Georgia Horseshoe.mp3
0002 Billy In The Lowground.mp3
0003 Winder Slide.mp3
0004 Walking Cane.mp3
### Method
find text that matches exactly .mp3 (1), then find a space. Keep 1 and replace the space with a new line
```
find:(.mp3+)\s
replace:\1\n
```

# Question 4 #
### Input
0001 Georgia Horseshoe.mp3
0002 Billy In The Lowground.mp3
0003 Winder Slide.mp3
0004 Walking Cane.mp3
### Result
Georgia Horseshoe_0001.mp3
Billy In The Lowground_0002.mp3
Winder Slide_0003.mp3
Walking Cane_0004.mp3
### Method
find 4 digits (1), find the rest of the words until you hit .mp3 (2), find .mp3 (3). Replace with 2 then an underscore then 1 then 3
```
find:(\d{4})\s(.*[^.mp3])(.mp3)
replace:\2_\1\3
```

# Question 5 #
### Input
Camponotus,pennsylvanicus,10.2,44
Camponotus,herculeanus,10.5,3
Myrmica,punctiventris,12.2,4
Lasius,neoniger,3.3,55
### Result
C_pennsylvanicus,44
C_herculeanus,3
M_punctiventris,4
L_neoniger,55
### Method
find first letter (1), find rest of the word, find comma, find second word and comma (2),find one or more digits, find period, find next digit, find comma, find next digits (3). Extract 1 then add an underscore, then add 2 and 3
```
find:(\w)\w+,(\w+,)\d+.\d,(\d+)
replace:\1_\2\3
```

# Question 6 #
### Input
Camponotus,pennsylvanicus,10.2,44
Camponotus,herculeanus,10.5,3
Myrmica,punctiventris,12.2,4
Lasius,neoniger,3.3,55
### Result
C_penn,44
C_herc,3
M_punc,4
L_neon,55
### Method
find first letter (1), find rest of the word, find comma, find next 4 letters (2), find rest of the word, find comma, find next few digits, find period, find next few digits, find comma and find last digits (3). Replace to keep 1, 2, and 3 with underscore between 1 and 2
```
find:(\w)\w+.(\w{4})\w+,\d+.\d(,\d+)
replace:\1_\2\3
```

# Question 7 #
### Input
Camponotus,pennsylvanicus,10.2,44
Camponotus,herculeanus,10.5,3
Myrmica,punctiventris,12.2,4
Lasius,neoniger,3.3,55
### Result
Campen, 44, 10.2
Camher, 3, 10.5
Myrpun, 4, 12.2
Lasneo, 55, 3.3
### Method
find first 3 characters (1), find rest of word, find comma, find next 3 characters (2), find rest of word, find comma, find next set of numbers including period (3), find comma, then find rest of numbers (4). Replace with 1 and 2 together, then a comma and space, then 4, then space, then 3
```
find:(\w{3})\w+,(\w{3})\w+,([0-9.]+),(\d+)
replace:\1\2, \4, \3
```

