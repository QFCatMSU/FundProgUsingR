{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  weatherData = read.csv(file="data/Lansing2016NOAA.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);
  
  # subset the dateTime column so that you only have the month and day (MM-DD)
  dateOnly = substr(weatherData$dateTime, start=6, stop=10);

  # paste dateOnly and the year, 2016 together  
  dateYear = paste(dateOnly, "-2016", sep="");
  
  # if you do not use the argument sep, then the default separator is a space
  dateYearMistake = paste(dateOnly, "-2016");     # sep default to " "
  
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
  # weatherData5[c("dateYear", "maxTemp", "minTemp")] = NULL 
  # weatherData5[,c("dateYear", "maxTemp", "minTemp")] = NULL 
  # weatherData3 = within(weatherData, rm(dateTime, maxTemp, minTemp));  
  
  # Could also use this method to remove multiple columns:
  # weatherData3 = within(weatherData, rm(maxTemp, minTemp, avgTemp))
  
  # create another copy
  weatherData4 = weatherData3;
  
  # Move the last column (dateYear) to the beginning:
  weatherData4 = subset(weatherData2, select=c(dateYear, maxTemp:windSusDir));
  
  # One last copy
  weatherData5 = weatherData4;
  
  # Move heatDays and coolDays after tempDept:
  weatherData5 = subset(weatherData5, select=c(dateYear:tempDept,
                                               heatDays:coolDays,
                                               relHum:wetBulbTemp,
                                               sunrise:windSusDir));
  
  # write the new data frame to a csv file
  write.csv(weatherData5, file="data/Lansing2016Noaa-2-bad.csv");  
  
  # ... but don't include the row number as a new column
  write.csv(weatherData5, file="data/Lansing2016Noaa-2.csv",
            row.names = FALSE);  
  
  weatherData6 = subset(weatherData, select=c(-(maxTemp:minTemp)));
}