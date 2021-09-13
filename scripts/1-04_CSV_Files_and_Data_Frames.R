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
  
  # Create a vector with sequenced numbers 
  seq1 = seq(from=1, to=14, by=2);   # 1,3,5,7,9,11,13
  seq2 = seq(from=14, to=1, by=-2);  # 14,12,10,8,6,4,2
  seq3 = seq(from=1, to=10, by=3);   # 1,4,7,10

  # Use the sequenced indexes to subset the highTemps
  highTempSeq1 = highTemps[seq1];   # values 1,3,5,7,9,11,13
  highTempSeq2 = highTemps[seq2];   # values 14,12,10,8,6,4,2
  highTempSeq3 = highTemps[seq3];   # values 1,4,7,10
  
  # You could combine the two previous steps into 1 step:
  highTempSeq1b = highTemps[seq(from=1, to=14, by=2)];  
  highTempSeq2b = highTemps[seq(from=14, to=1, by=-2)];  
  highTempSeq3b = highTemps[seq(from=1, to=10, by=3)];
  
  
}