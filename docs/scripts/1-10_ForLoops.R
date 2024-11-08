{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console

  cat("---------\nRepeating the same code multiple times:\n");
  for(i in 1:5)  # repeat 5 times
  {
    cat("Hello, World\n");
  }

  helloVector = c("Ann", "Bob", "Charlie", "Dave", "Eve");

  cat("---------\nGoing through each value in a vector by changing the index value:\n");
  for(i in 1:5)
  {
    # i takes on the values 1 through 5 through the 5 cycles of the for loop
    cat("Hello,", helloVector[i], "\n");
  }
  
  cat("---------\nUsing the indexing variable as a counter:\n");
  for(i in 1:5) # repeat 5 times
  {
    cat("The count is:", i, "\n");
  }
  
  cat("---------\n#Changing the sequence numbers -- length is still 5:\n");
  for(i in 12:8) # 12, 11, 10, 9, 8 (five values in sequence)
  {
    cat("The count is:", i, "\n");
  }

  cat("---------\nUsing a more complicated sequence with seven values:\n");
  for(day in seq(from=20, to=2, by=-3)) # 20, 17, 14, 11, 8, 5, 2 (seven values)
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
  numDays = length(highTemps); # numDays will be 14 (the number of values in highTemps)
 
  cat("---------\nThe 14 values in the vector highTemps in order:\n");
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
  
  cat("---------\nUsing a sequence to subset the values:\n");
  for(i in c(8,2,13))
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