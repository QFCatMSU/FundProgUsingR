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

  ### Get weatherData from the CSV file created last lesson
  weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");
  
  
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
  
  # go through every value in the vector eventData (366 in all)
  for(i in 1:366)
  {
    # if the currently indexed value in eventData equals "SN"
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
  
  
  ##### From 3-8 ######
  
  ### using which() to index values from a vector
  # give the index of the values in avgTemp that are greater than 80
  daysOver80 = which(avgTemp > 80);
  
  # # index the dates and humidity vectors by the days over 80 degrees
  datesOver80 = date[daysOver80];
  humidityOver80 = humidity[daysOver80];
  
  # give the min and max humdity for days over 80 degrees
  minHumOver80 = min(humidity[daysOver80]);
  maxHumOver80 = max(humidity[daysOver80]);
  
  ### multiple conditions using a which()
  # give the index of values where avgTemp is between 60 and 70  
  tempsIn60s = which(avgTemp > 60 & avgTemp < 70);
  
  # find the mean wind and mean precipiation when avgTemp is between 60 and 70
  meanWind60s = mean(avgWind[tempsIn60s]);
  maxPrecip60s = max(precipitation[tempsIn60s]);
  
  # give the index of values where temperatures are more than 15 degrees from normal
  highDepart = which(tempDept > 15 | tempDept < -15);
  
  ### plotting and modelling subset data
  # plot temperature vs pressure on the days when temperature is more than 15 degrees from normal
  plot(formula=avgTemp[highDepart]~barometer[highDepart]);
  
  # do a linear model of temp vs. pressure on the abnormal temperature days
  model = lm(formula=avgTemp[highDepart]~barometer[highDepart]);
  
  # add the regression line to the plot
  abline(model, col="blue");  
  
  # show summary of the relationship
  print(summary(model));      
  
  # repeat the process above with southerly winds (winds between 90 and 270 degrees)
  southWinds = which(windDirection > 90 & windDirection < 270);
  plot(formula=avgTemp[southWinds]~barometer[southWinds]);
  model2 = lm(formula=avgTemp[southWinds]~barometer[southWinds]);
  abline(model2, col="blue");  
  print(summary(model2));      
  
  ### use grep() to get index values from a string vecto (eventData)
  # get days that had snow
  snowyDays = grep("SN", eventData);
  
  # get days that had rain
  rainyDays = grep("RA", eventData);
  
  # find the days that had either rain OR snow
  precipDays = grep("SN|RA", eventData);
  
  # find the days that had either rain AND snow
  daysWithRainAndSnow1  = grep("SN&RA", eventData);  # does not work!
  daysWithRainAndSnow2 = intersect(snowyDays, rainyDays);  # works!
  
  ### multiple conditions on multiple variable in which()
  # days with high wind (>15mph) and abnomal temperature (more than 10 degrees from normal)
  abnormalTempHighWind = which( (avgWind > 15) &
                                  (tempDept < -10 | tempDept > 10 ) );
  
  # days with temperatures between 40 and 50 and precipitation between 0.1 and 0.2 inches
  chillyLightRain = which( (avgTemp > 40 & avgTemp < 50) &
                             (precipitation > 0.1 & precipitation < 0.2 ));
  
  # get the dates for the above conditions
  dates1 = date[abnormalTempHighWind];
  dates2 = date[chillyLightRain];
  
  # print to console the information from above.
  cat("Abnormal temps and high winds:\n");
  print(dates1);
  cat("\nChilly days and light rain:\n");
  print(dates2);
}