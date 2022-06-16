{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  weatherData = read.csv(file="data/Lansing2016NOAA.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);
  
  # subset the dateTime column so that you only have the month and day (MM-DD)
  dateOnly = substr(weatherData$dateTime, start=6, stop=10);

  # add the year after the date so you have MM-DD-YYYY
  dateYearMistake = paste(dateOnly, "-2016");     # sep default to " "
  
  # use sep="" to take out the extra space
  dateYear = paste(dateOnly, "-2016", sep="");

  # rounding the wind speed to one decimal:
  windSpeedRounded = round(weatherData$windSpeed, digits=1);

  # Create a copy of weatherData called weatherData2 
  weatherData2 = weatherData;
    
  # add dateYear to the data frame as a column
  weatherData2$dateYear = dateYear;
  
  # putting the rounded values in the data frame -- 
  #   this will overwrite the windSpeed column
  weatherData2$windSpeed = windSpeedRounded;

  # create another copy
  weatherData3 = weatherData2;
  
  # remove a column:
  weatherData3$dateTime = NULL; 
  
  # Another way to remove a column
  # weatherData3 = within(weatherData, rm(dateTime));  
  
  # Could use this method to remove multiple columns:
  # weatherData3 = within(weatherData, rm(maxTemp, minTemp, avgTemp))
  
  # create another copy
  weatherData4 = weatherData3;
  
  # Move the last column (dateYear) to the beginning:
  weatherData4 = subset(weatherData2, select=c(dateYear, maxTemp:windSusDir));
  
  # One last copy
  weatherData5 = weatherData4;
  
  # Move heatDays and coolDays after weatherType:
  weatherData5 = subset(weatherData5, select=c(dateYear:tempDept, 
                                               heatDays:coolDays,
                                               relHum:wetBulbTemp,
                                               sunrise:windSusDir));
  
  # write the new data frame to a csv file
  write.csv(weatherData5, file="data/Lansing2016Noaa-2-bad.csv");  
  
  newData_Mistake = read.csv(file="data/Lansing2016Noaa-2-bad.csv");
  
  # ... but don't include the row number as a new column
  write.csv(weatherData5, file="data/Lansing2016Noaa-2.csv",
            row.names = FALSE);  
  
  newData = read.csv(file="data/Lansing2016Noaa-2.csv");
  
  
  ### End of lesson  -- the code underneath will go into later lessons. ###
  yearDate = substr(weatherData$dateTime, start=1, stop=10);
  dateOnly = substr(weatherData$dateTime, start=6, stop=10);
  dateYear = paste(dateOnly, "-2016", sep="");
  weatherData$dateTime = dateYear;
  
  colnames(weatherData)[1] = "date";

  yearDate = as.Date(yearDate);
  
  precip = weatherData$precip;

  for(i in 1:length(precip))
  {
    if(precip[i] == "T")
    {
      precip[i] = 0.005;
    }
  }

  precip2 = as.numeric(precip);
  
  # write.csv(weatherData, file="data/Lansing2016Noaa.csv",
  #           row.names = FALSE);
  
  dateYear = as.Date(dateYear);
  aaa = substr(weatherData$weatherType, start=4, stop=5);
}