{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console

  cat("---------\nRepeating the same code multiple times:\n");
  for(i in 1:5)  # repeat 5 times
  {
    cat("Hello\n");
  }
  
  cat("---------\nUsing the indexing variable as a counter:\n");
  for(i in 1:5) # repeat 5 times
  {
    cat("The count is:", i, "\n");
  }

  cat("---------\nUsing a more complicated sequence:\n");
  for(day in seq(from=20, to=2, by=-3))
  {
    cat("The count is:", day, "\n");
  }
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  
  
  ### Extract the highTemps column from the data frame -- save it to a variable
  highTemps = weatherData$highTemp;
  noonCond = weatherData$noonCondition;
  
  # get length of vector
  numDays  = nrow(weatherData);  # length of the vectors is number of rows (14)
  # numDays = length(highTemp);  # an alternate way to get length
 
  cat("---------\nIndexing highTemps with the indexing variable:\n");
  for(day in 1:numDays)
  {
    cat(highTemps[day], "\n");  # day will take the values 1-14
  }

  cat("---------\nUsing indexing variable as a counter and an index for noonCond:\n");
  for(day in 1:numDays)
  {
    cat(day, ") ", noonCond[day], "\n", sep="");
  }

  cat("---------\nUsing if-else statements within a for loop:\n");
  for(i in 1:numDays)
  {
    if(noonCond[i] == "Sunny")
    {
      cat("day ", i, " was sunny\n", sep="");
    }
    else
    {
      cat("day ", i, " was not sunny\n", sep="");
    }
  }
  
  # Using state variables to find general information about the values in a vector
  sunnyDays = 0; # state variable -- will hold the count of sunny days
  for(i in 1:numDays)
  {
    if(noonCond[i] == "Sunny")
    {
      sunnyDays = sunnyDays +1;   # increases sunnyDays by 1
    }
    # there is no else here -- we don't care about non-sunny days
  }
}