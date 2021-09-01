{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  source("scripts/toolbox.r");  # load script with isDivisible() function
  
  weatherData = read.csv(file="data/Lansing2016NOAA.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);
  
  dateOnly = substr(weatherData$dateTime, start=6, stop=10);
  dateYear = paste(dateOnly, "-2016", sep="");
  
  dateYearMistake1 = paste(dateOnly, "-2016");
  dateYearMistake2 = paste(dateOnly, "-2016", "");
  
  windSpeedRounded = round(weatherData$windSpeed, digits=1);
  weatherData$windSpeed = windSpeedRounded;
  
  TSDays1 = grep(pattern="TS", x=weatherData$weatherType);
  TSDays2 = grepl(pattern="TS", x=weatherData$weatherType);
  
  day100_1 = TSDays2[100];
  day100_2 = 100 %in% TSDays1;
  
  day91_1 = TSDays2[91];
  day91_2 = 91 %in% TSDays1;
  
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