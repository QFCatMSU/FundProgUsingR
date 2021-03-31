{
  # all scripts for this class will contain the following 2 lines
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  # mention R v3 vs 4
  
  highTemp = weatherData$maxTemp;
  lowTemp = weatherData$minTemp;
  
  diffTemp = highTemp - lowTemp;
  
  print(highTemp[300:305]);
  print(lowTemp[300:305]);
  
  tempDiffDay302 = highTemp[302] - lowTemp[302];
  
  # show how this becomes a chr
  precipAmount = weatherData$precip;
  
  ## This  line will cause an error...
  #precipAmountDiff = precipAmount[2] - precipAmount[1];
  
  # note diffference bwteen int and num (real)
  precipAmount2 = as.numeric(precipAmount);
  precipAmountDiff2 = precipAmount2[2] - precipAmount2[1];
  precipAmountDiff2 = precipAmount2[3] - precipAmount2[2];
  
  ### WE could reassignment values to a variable ... just want to show everything in Env:
  ## Example of reassigning values
  
  ### Boolean -- next lesson? --
  ## WE will deal with handling the NA -- or go one step back and handle the "T"
  wasPrecip = precipAmount2 > 0;
  
  # add year to the dates
  date = weatherData$date;

  # going the other way on date will be a problem...
  # We will deal with different formatting later... for now we have a date!
  date = paste("2016", weatherData$date,  sep="-")
  date = as.Date(date)

  weatherData$dateYr = date;
  
  #get help on write.csv
  write.csv(weatherData,    # do x= ??
            file="data/LansingNOAA2016b.csv", 
            row.names=FALSE);
}