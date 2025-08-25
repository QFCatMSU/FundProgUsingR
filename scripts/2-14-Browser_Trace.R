rm(list=ls()); 

# install.packages("pkgload")
library(pkgload)
pkgload::load_all("c:/users/charlie/desktop/pracma")


source("scripts/2-14-myFunctions.R");
debugSource("scripts/2-14-myFunctions.R");
# setBreakpoint("scripts/2-14-myFunctions.R", 9)
# trace(what=isPrime, at=4, tracer=browser); 
# 
# 
# untrace(isPrime)
# trace(what=isPrime, at=list(c(5,4)), tracer=browser); 

# 
bits(12);
isPrime(c(1,2,3,4));
