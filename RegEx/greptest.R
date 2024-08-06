{
   rm(list=ls());
   options(show.error.locations = TRUE);
   library(stringr);
   
   ### Character classes:
   # .: all characters except \n
   # []: permitted chars  [^]: exclude characters
   # \\: escape character
   # (...): grouping, enables back referencing using \\N (??)
   # digits: [0-9] or \\d    invert: \\D
   # hex: [0-9A-Fa-f] or \\x
   # lowercase: [a-z]   uppercase: [A-Z]   all letters: [A-z]
   # numbers and letters: [A-z0-9] or \\w  invert: \\W
   # whitespaces: \\s  invert: \\S
   # puncutation: [[:punct:]]
   # control characters: \\c
   ###
   
   ### Anchors
   # ^: Start of string    $: end of string
   # \\b: empty string at either edge of word
   # \\B: not at edge of word
   # \\<: beginning of word   \\>: end of word
   ###
   
   ### Number of iterations:
   #       *: >=0      +: >=1     ?: 0|1
   #     {n}: n     {n,}: >=n  {,n}: <=n
   #   {n,m}: >=n & <=m
   ###

   ### grep vs. grepl (find)
   # grep returns a vector of indexes for values meeting the pattern
   # grepl returns a Boolean vector
   ###

   ### regexpr vs. gregexpr vs. regexec (location)
   # regexpr returns a vector of integers indicating the beginning
   #     of the first instance of the pattern (-1 if pattern not matched)
   # gregexpr returns an list of vector indicating every beginning
   #     of the pattern found (-1 if pattern is not matched)
   # regexec is like gregexpr but it also includes the strings that
   #     match the patterns
   ###
   
   ### sub vs. gsub (replace)
   # sub replaces the first instance of the pattern
   # gsub replaces all instances of the pattern
   ###
   
   # a = read.csv("MasterGear.csv");
   # vec = c("sdfsdafa2342dgd ser345 a2344",
   #         "fssda2342",
   #         "23432gdg",
   #         453);
   measVec = c("24.7mm", "15.23", "0.00214", "81 mm");
   measVec1 = gsub("([0-9.]+).*", "\\1", measVec);
   measVec2 = gsub("([0-9.]+)(.*)", "\\2", measVec);
   
   decimalVec = c("534,435,633.234mm", "324.324.633,45mm", "45.23.mm")
   decimalVec1 = gsub("([0-9]{1,3}[,.]?[0-9]{1,3}).*", "\\1", decimalVec);
   decimalVec2 = gsub("([0-9]{1,3}[,.]?[0-9]{1,3}).*", "\\1", decimalVec);
 #  measVec2 = gsub("([0-9.]+)(.*)", "\\2", measVec);  
   
   numberVec = c("h00h111oo2222", "asdf", "33jj4444kk", "555 hhh 666h 77");
   numGrep = grep("[0-9]+", numberVec);
   numGrepValue = grep("[0-9]+", numberVec, value = TRUE);
   numGrepl = grepl("[0-9]+", numberVec);
   # Can we substitute the nth example?
   numSub = sub("[0-9]+", " ** ", numberVec);  
   numSubPa = sub("[(0)-9]+", " **\\1 ", numberVec);  
   numGsub = gsub("[0-9]+", " ** ", numberVec);
   numRegexpr = regexpr("[0-9]+", numberVec);
   numGregexpr = gregexpr("[0-9]+", numberVec);
   numRegexec = regexec("[0-9]+", numberVec);
   numRegexprFix = regexpr("[0-9]+", numberVec, fixed = TRUE);
   numGregexprFix = gregexpr("[0-9]+", numberVec, fixed = TRUE);
   numRegexecFix = regexec("[0-9]+", numberVec, fixed = TRUE);
   
   regMatchRegexpr = regmatches(numberVec, numRegexpr);
   regMatchGregexpr = regmatches(numberVec, numGregexpr);
   regMatchRegexec = regmatches(numberVec, numRegexec);
   
   uglyVector = c("",
                  "herg234mm dfgh5678.9jdfsh -987.23nm",
                  "",
                  "");
        
   uglyVec01 = grep(pattern="[0-9]+", x=uglyVector);
   uglyVec02 = regexpr(pattern="[0-9]+", text=uglyVector);
   uglyVec03 = gregexpr(pattern="[0-9]+", text=uglyVector);
   uglyVec04 = regexec(pattern="[0-9]+", text=uglyVector);
   uglyVec05 = regmatches(m=uglyVec02, x=uglyVector);
   uglyVec06 = regmatches(m=uglyVec03, x=uglyVector);  ## gives the best answer
   uglyVec07 = regmatches(m=uglyVec04, x=uglyVector);
   
   ## combine 3 and 6
   uglyVec08 = regmatches(m=gregexpr(pattern="[0-9]+", text=uglyVector),
                         x=uglyVector);  
   
   ## stringr method
   uglyVec09 = str_extract(string=uglyVector, pattern="[0-9]+");
   uglyVec10 = str_extract_all(string=uglyVector, pattern="[0-9]+");
   uglyVec11 = str_extract_all(string=uglyVector, pattern="[0-9]+", 
                               simplify = TRUE);
   uglyVec12 = str_detect(string=uglyVector,                 # same as grepl
                          pattern="[0-9]+", negate = FALSE);
   uglyVec13 = str_locate(string=uglyVector, pattern="[0-9]+");
   uglyVec14 = str_locate_all(string=uglyVector, pattern="[0-9]+");
   uglyVec15 = str_replace(string=uglyVector, pattern="[0-9]+",
                           replacement="~**~");
   uglyVec16 = str_replace_all(string=uglyVector, pattern="[0-9]+",
                              replacement="~**~");
   uglyVec17 = str_view(string=uglyVector, pattern="[0-9]+", match=TRUE);
   uglyVec18 = str_view_all(string=uglyVector, pattern="[0-9]+", match=FALSE);
   # f = grep("a[[:digit:]]*d", vec);
   # f1 = grepl("a[[:digit:]]*d", vec);
   # 
   # c = (gsub("[0-9]+.*$", "\\1", vec))   
   # d = (gsub(".*?[0-9]+.*", "\\1", vec))   
   # e = (gsub(".*?[0-9]+.*", "\\2", vec))   
   # # comments = a$Comments[16320:16420];
   # # b = grep("Nor", comments);
   # 
   # g = gsub(".*a\\d*.*", "~~", vec);
   # h = gsub("a\\d*", "~~", vec);
}