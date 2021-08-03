{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  
  ## add new data file with messy noonCond column
  
  ### Extract the highTemps column from the data frame -- save it to a variable
  highTemps = weatherData$highTemp;
  noonCond = weatherData$noonCondition;
  precip = weatherData$precipitation;

  # get length of vector
  numDays  = nrow(weatherData);  # length of the vectors is number of rows (14)
  
  # Using two state variables
  sunnyDays = 0; # state variable -- will hold the count of sunny days
  rainyDays = 0; # state variable -- will hold the count of sunny days
  
  for(i in 1:numDays)
  {
    if(noonCond[i] == "Sunny" || noonCond[i] == "Rain")
    {
      sunnyDays = sunnyDays +1;   # increases sunnyDays by 1
    }
  }
  
  # Using two state variables
  sunnyDays = 0; # state variable -- will hold the count of sunny days
  rainyDays = 0; # state variable -- will hold the count of sunny days
  
  for(i in 1:numDays)
  {
    if(noonCond[i] == "Sunny" || noonCond == "sunny" || noonCond == "sun")
    {
      sunnyDays = sunnyDays +1;   # increases sunnyDays by 1
    }
  }
  
  for(i in 1:numDays)
  {
    firstLetter = substr(noonCond[i], start=1, stop=1);
    
    if(firstLetter == "s" || firstLetter == "S")
    {
      sunnyDays = sunnyDays +1;   # increases sunnyDays by 1
    }
  }
  
  ## app -- alternate way to do this
  for(i in 1:numDays)
  {
    firstLetter = substr(noonCond[i], start=1, stop=1);
    secondLetter = substr(noonCond[i], start=2, stop=2);
    
    if( (firstLetter == "s" || firstLetter == "S") &&
        (secondLetter == "u" || secondLetter == "U") )
    {
      sunnyDays = sunnyDays +1;   # increases sunnyDays by 1
    }
  }
  
  # grep has better (and faster)  ways to do this
  
  tempGT60 = 0; # days with temperatures greater than 60
  tempLT50 = 0; # days with temperatures less than 50
  
  for(i in 1:numDays)
  {
    if(highTemps[i] > 50 && highTemps[i] < 60)
    {
      tempGT60 = tempGT60 +1;  
    }
    else if(highTemps[i] < -50 || highTemps > 150)
    {
      tempLT50 = tempLT50 +1;
    }
  }
  
  goOutDay = 0;
  
  for(i in 1:numDays)
  {
    if(highTemps[i] > 50 && noonCond[i] == "Sunny")
    {
      goOutDay = goOutDay +1;
    }
  }
  
  for(i in 1:numDays)
  {
    if(highTemps[i] > 50 && noonCond[i] == "Sunny")
    {
      goOutDay = goOutDay +1;
    }
    else if(highTemps[i] > 50 && noonCond[i] == "Cloudy")
    {
      goOutDay = goOutDay +1;
    }
    else if(highTemps[i] < 50 && noonCond[i] == "Sunny")
    {
      goOutDay = goOutDay +1;
    }
  }
}