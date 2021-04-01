{
  # all scripts in this class will have a curly bracket on the first line matched
  # by an end curly bracket at the end.  This is to fix a bug in R that will be
  # explained when we get to if-else statements

  # all scripts for this class will contain the following 2 lines
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ## file structure in an RStudio Project
  weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  # mention R v3 vs 4
  

  # 366 rows (observations) and 23 columns (variables)
  
  # double-click on data frame to see in EDitor window
  
  # Note that you could skip many of the parameters
  # We will talk more about this when you are creating your own functions
  weatherData2 = read.csv("data/LansingNOAA2016.csv");  # same in R4 not R3
  
  # access a column -- note that options come up when you start typing
  highTemps = weatherData$maxTemp;
  
  lowTemps = weatherData$m
  
  highTempDay137a = weatherData$maxTemp[137];
  highTempDay137b = highTemps[137];
  highTempDay137c = weatherData[137, "maxTemp"];  # row/col format
  # mention the L in the Environment
 
  # note the chr
  weatherType = weatherData$weatherType; 
  weatherTypeDay137 = weatherData$weatherType[137];
  
  # weatherDataFactor = read.csv(file="data/LansingNOAA2016.csv", 
  #                              stringsAsFactors = TRUE);
  # weatherTypeFactor = weatherData3$weatherType; 
  # weatherTypeDay137_Factor = weatherData3$weatherType[137];
  
  # do an extention (if StringAsFactors = TRUE)
  
  # multiple values
  weatherTypeDayMult = weatherData$maxTemp[131:147];
  weatherTypeDayMultSeq = weatherData$maxTemp[seq(from=131, to=147, by=1)];
 
}   # matches curly bracket on first line