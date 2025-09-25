rm(list=ls());  

# get the function from the functions script and put them in the Environment
source("scripts/1-13_Functions_Only.R");

# Testing the hello, you function
hi1 = hello_you("Bob");
hi2 = hello_you(who="Charlie");
hi3 = hello_you("David", feeling_good=FALSE);
hi4 = hello_you(who="Evelyn", feeling_good=FALSE);
hi5 = hello_you("Frank", FALSE);
hi6 = hello_you(feeling_good=FALSE, who="George");

# Testing the built-in R function mean() -- this script is in the lesson's Extension
testVector = c(10, 15, 5, NA, -100, 10); # has an NA value
meanBase1 = mean(x=testVector);               # uses default for na.rm, which is FALSE
meanBase2 = mean(x=testVector, na.rm=FALSE);  # same as above
meanBase3 = mean(x=testVector, na.rm=TRUE);   # remove NAs
meanBase4 = mean(x=testVector, na.rm=TRUE, trim=0.1);  # remove NAs and trims high and low value

# Testing the mean_simple() function in the function script for the lesson
meanSimp1 = mean_simple(vec=c(6,2,8,3));        # 4.75
# meanSimp2 = mean_simple();                    # error because argument not provided
meanSimp3 = mean_simple(vec=c(6,2, NA, 8,3));   # NA_Real because of the NA 
meanSimp4 = mean_simple(vec=c(6,2,8,3,75,200)); # 49
anotherVec = c(7, -7, 10, -8);
meanSimp5 = mean_simple(vec=anotherVec);        # can use a predefined vector

# Testing the mean_advanced() function in the function script for the lesson
meanAdv1 = mean_advanced(vec=c(6,2,8,3));       # 4.75
# meanAdv2 = mean_advanced();                   # will cause error because argument not provided 
meanAdv3 = mean_advanced(vec=c(6,2, NA, 8,3));  # will be NA (removeNA default is FALSE)
meanAdv4 = mean_advanced(vec=c(6,2, NA, 8,3), removeNA = TRUE);  # 4.75
meanAdv5 = mean_advanced(vec=c(6,2,8,3, 75,200)); # 49
