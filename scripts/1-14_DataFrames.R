{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  source("scripts/toolbox.r");  # load script with isDivisible() function
  
  weatherData = read.csv(file="data/Lansing2016NOAA.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);
  
  # subset the dateTime column so that you only have the month and day (MM-DD)
  dateOnly = substr(weatherData$dateTime, start=6, stop=10);

  # attach the year to the month and date (MM-DD-YYYY)
  dateYear = paste(dateOnly, "-2016", sep="");
  
  # both of these common errors will add an extra space in the string
  dateYearMistake1 = paste(dateOnly, "-2016");     # sep default to " "
  dateYearMistake2 = paste(dateOnly, "-2016", ""); # "" is considered part of the paste
  
  # rounding the wind speed to one decimal:
  windSpeedRounded = round(weatherData$windSpeed, digits=1);

  # putting the rounded values in the data frame (save to next lesson?)
  weatherData$windSpeedRound = windSpeedRounded;
  
  # This will overwrite the windSpeed column:
  # weatherData$windSpeed = windSpeedRounded;
  
  # finding which values in a vector have a certain patterns 
  TSDays1 = grep(pattern="TS", x=weatherData$weatherType);
  TSDays2 = grepl(pattern="TS", x=weatherData$weatherType);
  
  # find if days 91 and 100 are contained IN TSDays1
  day91_1 = 91 %in% TSDays1; 
  day100_1 = 100 %in% TSDays1;
  
  # find if days 91 and 100 are TRUE in TSDays2
  day91_2 = TSDays2[91];  
  day100_2 = TSDays2[100];

  # Use grep() to find which days were breezy (BR):
  breezyDays = grep(pattern="BR", x=weatherData$weatherType);

  # find which days had both TS and BR
  bothTSandBR = intersect(x=TSDays1, y=breezyDays);
  
  # find which days had either TS or BR
  eitherTSorBR = union(x=TSDays1, y=breezyDays);
  
  # put the numbers in numeric order
  eitherTSorBR2 = sort(eitherTSorBR);
  
  
  
  ### End of lesson 14 -- this code will go into later lessons.
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