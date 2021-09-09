{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  # Extract the highTemps column from the data frame -- save it to a variable
  highTemps = weatherData$highTemp;
  
  
  # Three different ways to get the high temperature from the 7th day (April 2)
  highTempDay7a = highTemps[7];
  highTempDay7b = weatherData$highTemp[7];
  highTempDay7c = weatherData[7, "highTemp"];  # think of this as [X,Y] notation

  # Get 3 values from highTemp individually and all at once 
  val_01 = highTemps[1];
  val_05 = highTemps[5];
  val_12 = highTemps[12];
  valComb = highTemps[c(1,5,12)];  
  
  # Use the sequence operator to get consecutive values
  consecVals = highTemps[3:11];     
  consecValsRev = highTemps[11:3]; # in reverse
  
  # Use the sequence function to subset the highTemps
  seq1 = highTemps[seq(from=1, to=14, by=2)];   # values 1,3,5,7,9,11,13
  seq2 = highTemps[seq(from=14, to=1, by=-2)];  # values 14,12,10,8,6,4,2
  seq3 = highTemps[seq(from=1, to=10, by=3)];   # values 1,4,7,10
  
  
  dowJonesData = read.csv(file="data/DowJones1980_2012.csv", 
                          sep=" ",
                          header=FALSE, 
                          stringsAsFactors = FALSE);  
  
  plot(dowJonesData$V2);
}