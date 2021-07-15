{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console

  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  ### Extract the highTemps column from the data frame -- save it to a variable
  highTemps = weatherData$highTemp;
  dates = weatherData$date;
  
  # checking the second highTemps (50) against 50
  if(highTemps[2] >= 50)
  {
    cat("high temp is greater than or equal to 50\n")
  }
  if(highTemps[2] <= 50)
  {
    cat("high temp is less than or equal to 50\n")
  }
  if(highTemps[2] > 50)
  {
    cat("high temp is greater than 50\n")
  }
  if(highTemps[2] < 50)
  {
    cat("high temp is less than 50\n")
  }
  if(highTemps[2] == 50)
  {
    cat("high temp is equal to 50\n")
  }
  if(highTemps[2] != 50)
  {
    cat("high temp is not equal to 50\n")
  }
  
  cat("---------\n");
  
  # checking the third highTemps (54) against 50
  if(highTemps[3] >= 50)
  {
    cat("high temp is greater than or equal to 50\n")
  }
  if(highTemps[3] <= 50)
  {
    cat("high temp is less than or equal to 50\n")
  }
  if(highTemps[3] > 50)
  {
    cat("high temp is greater than 50\n")
  }
  if(highTemps[3] < 50)
  {
    cat("high temp is less than 50\n")
  }
  if(highTemps[3] == 50)
  {
    cat("high temp is equal to 50\n")
  }
  if(highTemps[3] != 50)
  {
    cat("high temp is not equal to 50\n")
  }
  
  cat("---------\n");
  
  # checking the second date (Mar27) against Mar28
  if(dates[2] == "Mar28")
  {
    cat("Date is Mar28\n")
  }
  if(highTemps[2] == "mar28")
  {
    cat("Date is mar28\n")
  }
  if(dates[2] != "Mar28")
  {
    cat("Date is not Mar28\n")
  }
  if(highTemps[2] != "mar28")
  {
    cat("Date is not mar28\n")
  }
}