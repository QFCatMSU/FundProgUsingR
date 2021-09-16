{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ### Output a text message
  cat("Hello"); 
  
  ### Error -- forgot to put the text message in quotes
  # cat(Hello);   # error unless there is a variable named Hello
  
  ### Outputting multiple text messages
  cat("Hello, World");
  cat("How are you?");
  cat("I am fine?");
  
  ### adding linefeeds to the output ( \n )
  cat("Hello, World.Hello, World.\n");
  cat("How are you?\n");
  cat("I am\n fine?\n");
  
  ### Combining message into one cat command
  cat("Hello, World.\nHow are you?\nI am\n fine?\n");
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  ### Extract the highTemps column from the data frame -- save it to a variable
  highTemps = weatherData$highTemp;
  lowTemps = weatherData$lowTemp;
  
  ### Outputting the 14 values in the variable lowTemps, followed by a line feed
  cat(lowTemps); 
  cat("\n");      #  adds a line feed (need to be in quotes!)
  
  ### Can combine text and variable output using commas
  cat("The low temps are: ", lowTemps, "\n");  
    
  ### Output a single value from a variable
  cat(lowTemps[4], "\n");     # 4th value in LowTemps
  
  ### Output a more robust message about the 4th day:
  cat("On the 4th day the high temperature was", highTemps[4], "and the low temperature was", lowTemps[4], "\n");
  
  ### Can do math on the values:
  cat("On the 4th day the difference in temperature was", 
      highTemps[4] - lowTemps[4], "degrees\n"); 
  
  ### Output a sequence of values from a variable
  cat(lowTemps[5:9], "\n");   # 5th through 9th value
  cat(lowTemps[seq(from=1, by=2, to=10)], "\n"); # Values 1,3,5,7,9
  
  ### Adding message to the output to make it more readable
  cat("Day 5-9 temperature:",lowTemps[5:9], "\n");  
  cat("Temp on odd days:", lowTemps[seq(from=1, by=2, to=10)], "\n");
  
  ### Same as above but combined into one cat() statement
  cat("Day 5-9 temperature:", lowTemps[5:9], "\n", 
      "Temp on odd days:", lowTemps[seq(from=1, by=2, to=10)], "\n");
}
