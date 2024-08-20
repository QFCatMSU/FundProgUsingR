rm(list=ls());        # clear out the Environment  

weatherData = read.csv(file="data/twoWeekWeatherData.csv", # path to file
                       sep=",",                   # values are separated by commas
                       header=TRUE);              # there is a header row

# create a sequence that goes from 1 to 10 by 3
seq1 = seq(from=1, to=10, by=3);  # will have 4 values

# create a vector of values
vec1 = c(3,4,5,6,21,45,61);

# find the median value of the above vector
medianVal1 = median(vec1);

# equivalent to above but explicitly naming the argument x
medianVal1b = median(x=vec1);

# same vector with an NA added
vec2 = c(3,4,5,NA,6,21,45,61);

# the median value of the above vector will be NA
medianVal2 = median(x=vec2);

# use na.rm to instruct median() to remove NA values beforehand
medianVal2b = median(x=vec2, na.rm=TRUE);

# alternate ways to call median with the same arguments
medianVal2c = median(vec2, TRUE);
medianVal2d = median(vec2, na.rm=TRUE);
medianVal2e = median(na.rm=TRUE, x=vec2);
medianVal2f = median(x=vec2, TRUE);

# using length.out, forcing the number of value in the seq to be 5
seq2 = seq(from=1, to=10, length.out=5);


# calling read.csv() with only the file argument
weatherData2 = read.csv(file = "data/twoWeekWeatherData.csv");

# weatherData3 is how people using R version 3 would see weatherData2
weatherData3 = read.csv(file="data/twoWeekWeatherData.csv",
                        sep=",",
                        header=TRUE);