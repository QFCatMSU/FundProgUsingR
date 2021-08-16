{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData3.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  highTemps = weatherData$highTemp;
  precipBad = weatherData$precipBad;
  
  maxHigh = max(highTemps);
  minHigh = min(highTemps);
  meanHigh = mean(highTemps);
  sdHigh = sd(highTemps);
  varHigh = var(highTemps);
  medianHigh = median(highTemps,na.rm=TRUE);
  
  maxPreci = max(precipBad);
  maxPrecip2 = max(precipBad, na.rm=TRUE, "", "SDFDSA");
  
  bc = max(weatherData$noonCondition);
}