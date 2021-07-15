{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  # Extract the highTemps column from the data frame -- save it to a variable
  highTemps = weatherData$highTemp;
  lowTemps = weatherData$lowTemp;
  dates = weatherData$dates;
  precip = weatherData$precipitation;

  # Using the Console for output
  cat(highTemps);
  
  # Better:
  cat("The high temps are:", highTemps);
    
  # obviously, we are dealing with a very small set
  # where you can easily eyeball things 
  if(highTemps[3] > 50)
  {
    # This will output to Console because the condition is TRUE
    cat("On day 3 the temp was higher than 50\n")
  }
  
  if(highTemps[3] < 50)
  {
    # nothing will happen because the condition is FALSE
    cat("On day 3 the temp was lower than 50\n")
  }
  
  
}