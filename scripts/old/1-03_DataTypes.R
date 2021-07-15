{
  # all scripts for this class will contain the following 2 lines
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  # mention R v3 vs 4
  
  int1 = 40;
  int2 = 30;
  intAdd = int1 + int2;
  intSub = int1 - int2;
  
  intVec1 = c(20,40,10,-10);
  intVec2 = c(5,10,15,20);
  intVecAdd = intVec1 + intVec2;
  intVecSub = intVec1 - intVec2;
  
  highTemp = weatherData$maxTemp;
  lowTemp = weatherData$minTemp;
  
  diffTemp = highTemp - lowTemp;
  
  diffTemp302 = highTemp[302] - lowTemp[302];

  diffTemp36_47 = highTemp[36:47] - lowTemp[36:47];

  
  ## App: do a subtraction for a sequence of days...
  
  # Note: this in a num, not an int
  windSpeed = weatherData$windSpeed;    # real 
  windPeak = weatherData$windPeakSpeed; # integer
  windPeakToAvg = windPeak - windSpeed;
  
  windDiff = windSpeed[25] - windSpeed[24];
  
  ## convert into 
  ## subtract by average windSpped
    
  # show how this becomes a chr
  precip = weatherData$precip;
  
  ## This  line will cause an error...
  #precipDiff = precip[25] - precip[24];
  
  # this converts all "T" into NA
  precipNum = as.numeric(precip);
  
  
  precipDiff2 = precipNum[2] - precipNum[1];
  precipDiff3 = precipNum[3] - precipNum[2]; # will have an NA
  
  
  ## App: snow is in -- multiplyu to get it into cm
  
  ### WE could reassignment values to a variable ... just want to show everything in Env:
  ## Example of reassigning values
  
  ### Boolean -- next lesson? --
  ## WE will deal with handling the NA -- or go one step back and handle the "T"
  wasPrecip = precipNum > 0;
  
  daysWithPrecip = which(wasPrecip);
  # App: Boolean vector to tell which days has wind speed > 15 mph
  
  maxTempWithPrecip = highTemp[daysWithPrecip]
  
  ### Factor:
  windDir = as.factor(weatherData$windPeakDir)
  print(windDir)
  
  
  #App: in comment 
  
  
  ##### Dates will be done later! #####
  # add year to the dates
  dates = weatherData$date;

  datesFormattedWell = as.Date(c("1975-05-23", "2021-02-25"));
  
  # going the other way on date will be a problem...
  # We will deal with different formatting later... for now we have a date!
  # dateYr = paste(weatherData$date,  "2016", sep="-")
  # dateYr2 = as.Date(date)
  # 
  # 
  # 
  # 
  # weatherData$dateYr = date;
  # 
  # #get help on write.csv
  # write.csv(weatherData,    # do x= ??
  #           file="data/LansingNOAA2016b.csv", 
  #           row.names=FALSE);
}