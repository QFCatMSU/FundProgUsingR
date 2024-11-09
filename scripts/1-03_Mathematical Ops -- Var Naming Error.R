rm(list=ls());   # Clear out environment
options(show.error.locations = TRUE); # give line number of error*

finalDistance = 100;
initDistance = 50;
finaltime = 20;       # misspelled: use t instead of T
initTime = 15;
# error will be on the line below:
velocity = (finalDistance - initDistance) / (finalTime - initTime)