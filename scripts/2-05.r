{
  # make precip column numeric (put in data frames lesson)
  # Switch to GGplot

  rm(list=ls()); options(show.error.locations = TRUE);  
  library(package=ggplot2);              # get the GGPlot package

  # Get weather data for 2016 in Lansing, MI
  weatherData = read.csv(file="data/Lansing2016Noaa.csv");
  
  # test vectors
  ages = c(2,7,3,9,6,3,5);
  animals = c("llama", "alpaca", "goat", "llama", "guanaco");
  
  # give the index of the values that meet the condition 
  index1 = which(ages > 4);
  index2 = which(ages < 4);
  index3 = which(animals == "llama");
  index4 = which(animals != "llama");

  # Extract the various parts of the weather data and save each to a vector
  date = weatherData$date;
  weatherType = weatherData$weatherType;
  avgTemp = weatherData$avgTemp;
  tempDept = weatherData$tempDept;  
  precip = as.numeric(weatherData$precip);  
  humidity = weatherData$relHum;
  barometer = weatherData$stnPressure;
  avgWind = weatherData$windSpeed;
  maxWind = weatherData$windPeakSpeed;
  windDirection =  weatherData$windPeakDir;

  # An easier way to conditionally subset a vector -- using which()
  snowyDays = which(weatherType == "SN");
   
  # get the temperature and wind speed on days where it snowed
  snowyDayTemps = avgTemp[snowyDays];
  snowyDayWinds = avgWind[snowyDays];  
  
  # give the days in which there was no precipitation (0) and high precipitation (>= 1.00)
  daysNoPrecip = which(precip == 0.00);   # no precipitation days
  daysHighPrecip = which(precip > 1.00);  # high precipitation days
   
  # make scatterplots of temperature vs. humidity on days with no precip and high precip
  plot1 = ggplot( ) +
    geom_point( mapping=aes(x=avgTemp[daysNoPrecip], y=humidity[daysNoPrecip]),
                color = "red") +
    geom_point( mapping=aes(x=avgTemp[daysHighPrecip], y=humidity[daysHighPrecip]),
                color = "blue") +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          x = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) ) +
    theme_bw();
  plot(plot1);
  
  # output to the Console Window the days where peak winds were greater than 45mph
  windyDays = which(maxWind > 45);
  print(windyDays);
  
  # Now let's print to the Console Window the actual dates
  print(date[windyDays]);

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
  maxPrecip60s = max(precip[tempsIn60s], na.rm=TRUE);
   
  # give the index of values where temperatures are more than 15 degrees from normal
  highDepart = which(tempDept > 15 | tempDept < -15);
   
  ### plotting and modelling subset data
  # plot temperature vs pressure on the days when temperature is more than 15 degrees from normal
  plot2 = ggplot(  ) +
    geom_point( mapping=aes(x=avgTemp[highDepart], y=barometer[highDepart]) ) +
    geom_smooth( mapping=aes(x=avgTemp[highDepart], y=barometer[highDepart]), 
                 method="lm" ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          xlab = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) );
  plot(plot2);

  # show summary of the relationship
 # print(summary(model));      
   
  # repeat the process above with southerly winds (winds between 90 and 270 degrees)
  southWinds = which(windDirection > 90 & windDirection < 270);

  plot3 = ggplot(  ) +
    geom_point( mapping=aes(x=avgTemp[southWinds], y=barometer[southWinds]) ) +
    geom_smooth( mapping=aes(x=avgTemp[southWinds], y=barometer[southWinds]), 
                 method="lm" ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          xlab = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    theme_bw();
  plot(plot3);

  #print(summary(model2));      
  

  #### Probably not in this lesson! ####
  
  ### multiple conditions on multiple variable in which()
  # days with high wind (>15mph) and abnormal temperature (more than 10 degrees from normal)
  abnormalTempHighWind = which( (avgWind > 15) &
                      (tempDept < -10 | tempDept > 10 ) );
  
  # days with temperatures between 40 and 50 and precipitation between 0.1 and 0.2 inches
  chillyLightRain = which( (avgTemp > 40 & avgTemp < 50) &
                      (precip > 0.1 & precip < 0.2 ));
  
  # get the dates for the above conditions
  dates1 = date[abnormalTempHighWind];
  dates2 = date[chillyLightRain];

  # print to console the information from above.
  cat("Abnormal temps and high winds:\n");
  print(dates1);
  cat("\nChilly days and light rain:\n");
  print(dates2);
}