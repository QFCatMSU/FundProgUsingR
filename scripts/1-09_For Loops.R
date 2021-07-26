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
  
  # get length of vector
  highTempsL = length(highTemps);
  
  for(i in 1:highTempsL)
  {
    cat(i, "\n"); 
  }

  for(i in 1:highTempsL)
  {
    cat(i, ") ", noonCond[i], "\n", sep=""); 
  }  
  
  for(i in 1:highTempsL)
  {
    if(noonCond[i] == "Cloudy")
    {
      cat("day ", i, " was cloudy\n", sep=""); 
    }
    else
    {
      cat("day ", i, " was not cloudy\n", sep="");       
    }
  }  
  
  cloudyDays = 0;
  for(i in 1:highTempsL)
  {
    if(noonCond[i] == "Cloudy")
    {
      cloudyDays = cloudyDays +1; 
    }   
  }
  
  # if-any
  anyTornados = FALSE;  # often called state variables
  anyFog = FALSE;
  
  cloudyDays = 0;
  for(i in 1:highTempsL)
  {
    if(noonCond[i] == "Fog")
    {
      anyFog = TRUE;
    }   
    if(noonCond[i] == "Blizzard")
    {
      anyBlizzard = TRUE; 
    }
  }
  # mention inefficiency of checking after values have been found
  cat("The number of cloudy days was: ", cloudyDays, "\n");
  
  # go through only even values - note why you don't want to use 14:
  evenNum = seq(from=1, by=2, to=length(highTempsL));
  
  for(i in evenNum)
  {
    if(noonCond[i] == "Cloudy")
    {
      cloudyDays = cloudyDays +1; 
    }   
  }
}