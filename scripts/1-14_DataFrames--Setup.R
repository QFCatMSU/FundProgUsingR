{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  library(rnoaa);
  library(reshape2);
  # myToken = "LfoeHFkVUMLcokHXGCTTjukJteFEcvvM";
  
  source("scripts/toolbox.r");  # load script with isDivisible() function
  
  weatherData = read.csv(file="data/LansingNOAA2016.csv");
  colnames(weatherData)[1] = "dateTime";
  date_time = weatherData$dateTime;
  date_time = paste("2016-", date_time, "T00:00:00", sep="");
  
  weatherData$dateTime = date_time;
  
  windSpeedOrig = weatherData$windSpeed;
  
  randomNum = (sample(-50:49, size=366, replace=TRUE))/1000;
  windSpeed = windSpeedOrig + randomNum;
  
  weatherData$windSpeed = windSpeed;
  
  ### Note that for rounding off a 5, the IEC 60559 standard 
  #   (see also ‘IEEE 754’) is expected to be used, 
  #   ‘go to the even digit’. 
  windSpeedRounded = round(weatherData$windSpeed, digits=1);
  
  test = windSpeedOrig - windSpeedRounded;
  error = which(test != 0);
  
  # write.csv(weatherData, file="data/Lansing2016Noaa.csv",
  #           row.names = FALSE);
  
  
}