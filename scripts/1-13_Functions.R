rm(list=ls());  

# get the function from the functions script and put them in the Environment
source("scripts/1-13_myFunctions.R");

# Testing the built-in R function mean()
testVector = c(10, 15, 5, NA, -100, 10); # has an NA value
ret1a = mean(x=testVector);               # uses default for na.rm, which is FALSE
ret1b = mean(x=testVector, na.rm=FALSE);  # same as above
ret1c = mean(x=testVector, na.rm=TRUE);   # remove NAs
ret1d = mean(x=testVector, na.rm=TRUE, trim=0.1);  # remove NAs and trims high and low value

# Testing the mean_class() function in the function script for the lesson
ret2a = mean_class(vec=c(6,2,8,3));        # 4.75
# ret2b = mean_class();                    # error because argument not provided
ret2c = mean_class(vec=c(6,2, NA, 8,3));   # NA_Real because of the NA 
ret2d = mean_class(vec=c(6,2,8,3,75,200)); # 49
anotherVec = c(7, -7, 10, -8);
ret2e = mean_class(vec=anotherVec);        # can use a predefined vector

# Testing the mean_adv() function in the function script for the lesson
ret3a = mean_adv(vec=c(6,2,8,3));       # 4.75
# ret3b = mean_adv();                   # will cause error because argument not provided 
ret3c = mean_adv(vec=c(6,2, NA, 8,3));  # will be NA (removeNA default is FALSE)
ret3d = mean_adv(vec=c(6,2, NA, 8,3), removeNA = TRUE);  # 4.75
ret3e = mean_adv(vec=c(6,2,8,3, 75,200)); # 49
