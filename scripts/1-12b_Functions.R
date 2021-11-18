{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  windSpeedCategory = function(speed)
  {
    if(speed == 0)
    {
      return("none");
    }
    else if(speed > 0 & speed <= 10)
    {
      return("light");
    }
    else if(speed > 10 & speed <= 25)
    {
      return("moderate");
    }
    else if(speed > 25 & speed <= 40)
    {
      return("strong");
    }
    else if(speed > 40)
    {
      return("gale");
    }
  }
  singleVal1 = windSpeedCategory(45);
  singleVal2 = windSpeedCategory(8);
  singleVal4 = windSpeedCategory(-4);  # note the NULL
  singleVal3 = windSpeedCategory(23);

  windSpeedCategory2 = function(speed)
  {
    categoryVec = c();
    for(i in 1:length(speed))
    {
      if(speed[i] == 0)
      {
        categoryVec[i] = "none";
      }
      else if(speed[i] > 0 & speed[i] <= 10)
      {
        categoryVec[i] = "light";
      }
      else if(speed[i] > 10 & speed[i] <= 25)
      {
        categoryVec[i] = "moderate";
      }
      else if(speed[i] > 25 & speed[i] <= 40)
      {
        categoryVec[i] = "strong";
      }
      else if(speed[i] > 40)
      {
        categoryVec[i] = "gale";
      }
    }
    return(categoryVec);
  }
  multValues = windSpeedCategory2(c(45,8,-4,23));  # note the NA
  windSpeeds = weatherData$windPeakSpeed;
  multValues = windSpeedCategory2(windSpeeds);
  
  windSpeedCategory3 = function(speed, miles_hour = TRUE)
  {
    if(miles_hour == FALSE)
    {
      speed = speed *10; 
    }
    categoryVec = c();
    for(i in 1:length(speed))
    {
      if(speed[i] == 0)
      {
        categoryVec[i] = "none";
      }
      else if(speed[i] > 0 & speed[i] <= 10)
      {
        categoryVec[i] = "light";
      }
      else if(speed[i] > 10 & speed[i] <= 25)
      {
        categoryVec[i] = "moderate";
      }
      else if(speed[i] > 25 & speed[i] <= 40)
      {
        categoryVec[i] = "strong";
      }
      else if(speed[i] > 40)
      {
        categoryVec[i] = "gale";
      }
    }
    return(categoryVec);
  }
  multValues2 = windSpeedCategory3(c(45,8,-4,23), FALSE);  # note the NA
  multValues2 = windSpeedCategory3(c(45,8,-4,23), TRUE);  # note the NA
  multValues2b = windSpeedCategory3(windSpeeds);
  
  windSpeedCategory4 = function(speed, units)  #just 2
  {
    if(units == "m_s")
    {
      speed = speed *10; 
    }
    categoryVec = c();
    for(i in 1:length(speed))
    {
      if(speed[i] == 0)
      {
        categoryVec[i] = "none";
      }
      else if(speed[i] > 0 & speed[i] <= 10)
      {
        categoryVec[i] = "light";
      }
      else if(speed[i] > 10 & speed[i] <= 25)
      {
        categoryVec[i] = "moderate";
      }
      else if(speed[i] > 25 & speed[i] <= 40)
      {
        categoryVec[i] = "strong";
      }
      else if(speed[i] > 40)
      {
        categoryVec[i] = "gale";
      }
    }
    return(categoryVec);
  }
}