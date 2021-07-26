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
  noonCond = weatherData$noonCondition;
  
  cat("---------\nChecking highTemps 3, 4, and 5 to see which are > 50:\n");
  
  if(highTemps[3] > 50)
  {
    cat("  high temp 3 is greater than 50\n");
  }
  else
  {
    cat("  high temp 3 is not greater than 50\n");
  }
  if(highTemps[4] > 50)
  {
    cat("  high temp 4 is greater than 50\n");
  } 
  else
  {
    cat("  high temp 4 is not greater than 50\n");
  }
  if(highTemps[5] > 50)
  {
    cat("  high temp 5 is greater than 50\n");
  }
  else
  {
    cat("  high temp 5 is not greater than 50\n");
  }
  
  cat("\n---------\nCheck to see the noon condition on the days 2 and 3:\n");
  
  # checking the second noonCond, which is "Cloudy"
  if(noonCond[2] == "Cloudy")  # noonCond[2] is "Cloudy"
  {
    cat("  Day was Cloudy\n");
  }
  else # noonCond[2] is not "Cloudy"
  {
    cat("  Day was not Cloudy\n");
  }
  if(noonCond[3] != "Sunny")   # noonCond[3] is not "Sunny"
  {
    cat("  Day was not Sunny\n")
  }
  else # noonCond[3] is "Sunny"
  {
    cat("  Day was Sunny\n")
  }
 
  cat("\n---------\nChecking day 4 against multiple conditions:\n");
  
  if(noonCond[4] == "Cloudy")       # 1st check: the day is cloudy
  {
    cat("  Day 4 was cloudy\n");
  }
  else if(noonCond[4] == "Sunny")   # 2nd check: the day is sunny
  {
    cat("  Day 4 was sunny\n"); 
  }
  else if(noonCond[4] == "Rain")   # 3rd check: the day is rainy
  {
    cat("  Day 4 was rainy\n"); 
  }
  
  cat("\n---------\nChecking day 5 against multiple conditions:\n");
  
  
  if(noonCond[5] == "Cloudy")       # 1st check: the day is cloudy
  {
    cat("  Day 5 was cloudy\n");
  }
  else if(noonCond[5] == "Sunny")   # 2nd check: the day is sunny
  {
    cat("  Day 5 was sunny\n"); 
  }
  else if(noonCond[5] == "Rain")    # 3rd check: the day is rainy
  {
    cat("  Day 5 was rainy\n"); 
  }
  else  # none of the above are TRUE so output some error message
  {
    cat("  The condition for day 5 is unknown"); 
  }
  
  cat("\n---------\nChecking temperature of day 3:\n");
  if(highTemps[3] > 70)      # check for anything above 70
  {
    cat("  That is hot for April!"); 
  }
  else if(highTemps[3] > 60) # check for temps 61-70
  {
    cat("  That is warm for April!");   
  }
  else if(highTemps[3] > 50) # check for temps 51-60
  {
    cat("  That temperature is about right for April!");   
  }
  else if(highTemps[3] > 40) # check for temps 41-50
  {
    cat("  That is a little cold for April!");   
  }
  else # temperatures 40 and below
  {
    cat("  That is a usually cold for April!");   
  }
}