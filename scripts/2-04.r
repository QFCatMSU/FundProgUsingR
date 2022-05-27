{
  rm(list=ls()); options(show.error.locations = TRUE);  
  source(file="scripts/toolbox.r");

  # test vectors
  ages = c(2,7,3,9,6,3,5);
  animals = c("llama", "alpaca", "goat", "llama", "guanaco");
  
  # give the index of the values that meet the condition 
  index1 = which(ages > 4);
  index2 = which(ages < 4);
  index3 = which(animals == "llama");
  index4 = which(animals != "llama");

  # Get weather data for 2016 in Lansing, MI
  lansing2016Weather = read.csv(file="data/LansingNOAA2016Formatted.csv",
                                stringsAsFactors = FALSE);
  
  # Extract the various parts of the weather data and save each to a vector
  date = lansing2016Weather[,"date"];
  eventData = lansing2016Weather[,"eventData"];
  avgTemp = lansing2016Weather[,"avgTemp"];
  tempDept = lansing2016Weather[,"tempDept"];  
  precipitation = lansing2016Weather[,"precipitation"];  
  humidity = lansing2016Weather[,"humidity"];
  barometer = lansing2016Weather[,"barometer"];
  dewPoint = lansing2016Weather[,"dewPoint"];
  avgWind = lansing2016Weather[,"avgWind"];
  maxWind = lansing2016Weather[,"maxWind"];  
  windDirection =  lansing2016Weather[,"windDirection"];
  sunrise = lansing2016Weather[,"sunrise"];
  sunset = lansing2016Weather[,"sunset"];

  ### Use for() and if() to check for all days that had snow (SN)
  # Create a vector that will hold the index values for the days that have snow
  snowyDays1 = c();
  
  # go through every value in the vector weatherType (366 in all)
  for(i in 1:366)
  {
    # if the currently indexed value in weatherType equals "SN"
    if(eventData[i] == "SN")
    {
      # add the index number (i) to the snowDays1 vector 
      snowyDays1 = c(snowyDays1, i);
    }
  }
   
  # An easier way to conditionally subset a vector -- using which()
  snowyDays2 = which(eventData == "SN");
   
  # get the temperature and wind speed on days where it snowed
  snowyDayTemps = avgTemp[snowyDays2];
  snowyDayWinds = avgWind[snowyDays2];  
  
  # We need to use regular expressions (grep) to get all values that have "SN" in it
  snowyDays3 = grep("SN", eventData);
  
  # get the minimum temperature and mean precipitation on days where it snowed
  snowDaysMinTemp = min(x=avgTemp[snowyDays3]);
  snowDaysMeanWind = mean(x=avgWind[snowyDays3]);  
  
  # give the days in which there was no precipitation (0) and high precipitation (>= 1.00)
  daysNoPrecip = which(precipitation == 0.00);   # no precipitation days
  daysHighPrecip = which(precipitation > 1.00);  # high precipitation days
   
  # make scatterplots of temperature vs. humidity on days with no precip and high precip
  plot(x=avgTemp[daysNoPrecip], y=humidity[daysNoPrecip]);
  plot(x=avgTemp[daysHighPrecip], y=humidity[daysHighPrecip]);
  
  # output to the Console Window the days where peak winds were greater than 45mph
  windyDays = which(maxWind > 45);
  print(windyDays);
  
  # Now let's print to the Console Window the actual dates
  print(date[windyDays]);
}