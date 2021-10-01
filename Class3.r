# Project Folder in Teams -- issues??
# Can everyone open the project and work from the OneDrive folder
# (i.e., you do not have to resave the project)

# Text/text-formatted files/binary files (cat() to diff extensions, reading files in R)
# - images, word, R,
# html -- link one of the lessons
# js - regular and compressed. 
# - csv (open in Excel) vs xlsx
# notepad++ or textEdit

# jpg shows write.csv (stat.ethz.ch)

# cat() writes text -- and will save it to whatever name/extension you choose
# cat() is weird (... "R Objects") -- but far from the only function
# ... forces you to use argument (parameter) names for everything else (why?)
# can wrote to any extension -- but will be text-formatted

# Unicode and escape characters
cat("first line\n second line\n");
# \ is called an escape character (or, an alternate character)
# 1) for instructions like "go to newline" (not too many of these)
# 1) for characters not on your keyboard (unicode)
# 2) for character that have other meanings (", &, ...)
# > cat("\u18e") -- wiki page on unicode
# cat("And the llama said \"muenster cheese\" is the greatest")

# Activity:
# Writing unicode/escape to a file (later to plot)
# degree, two backslashs (https://...), 3 non-latin characters, emoji


######
# if-else bug in R (Run and Source)
# programming structure/brackets (which to use??)

if(highTemp > 50)
{
  
}
else
{
  
}
#focus on shortcuts:
# if shortcuts
# ifelse
# which()

# structure is very important to me!!
# embedded code: if() within if() is just the beginning 
#   for loops/ functions.. functions with for and if
# visually capture the flow/level the code is at

# if-else for mutually exclusive conditions
# the if-else bug

{
  if(1==0)
  {
    cat(1);
  } 
  else
  {
    cat(2);
  }
}

# Activity 2, create an else statement to part A 
# resolve my if-else issue!

randomTemp = rnorm(20, mean=50, sd=4);

conditions = c("Sun", "Fog", "Rain", "Snow");
chances = c(1,2,3,4)
randomCond = sample(x=conditions, size=20, replace=TRUE,
                    prob = chances);

r = as.factor(randomCond);

# randomly pick 
# if temp between 40-60 and condition is sunny
# 10%, 20%, 30%,40%

# Create the same "random" numbers
# Use sample to create random temp values between 40 and 60 
# with higher chances in the middle (50)

# No assignment next week.  1-8 the week after -- 
# for loops and functions after that.

## 1-8 application :
# Using if-else repeat parts c,d,e
