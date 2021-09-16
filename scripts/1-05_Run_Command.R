{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ### Output a text message
  cat("Hello"); 
  
  ### Multiple commands on one line
  a=3; b=7; cat("a+b=", a+b);
  
  ### Outputting multiple text messages (\n means go to next line)
  cat("Hello, World.\n");
  cat("How are you?\n");
  cat("I am fine?\n");
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  ### same command as above on one line (ugly! don't do this)
  weatherData2 = read.csv(file="data/twoWeekWeatherData.csv", sep=",", header=TRUE, stringsAsFactors = FALSE);  
}
