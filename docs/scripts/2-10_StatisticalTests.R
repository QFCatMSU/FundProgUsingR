{
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package="ggplot2");

  ### The code used in the last lesson to save data frames to a file:
  # save(temperatureDFs, file = "data/tempDFs.rdata");
  
  ### Get the four data frames saved to a List at the end of the last lesson
  load(file = "data/tempDFs.rdata"); 
  
  ### Extract the data frames from the List 
  lansJanTempsDF = temperatureDFs$origDF;
  stackedDF = temperatureDFs$stackedDF;
  stackedDF2 = temperatureDFs$stackDF_3_6;
  stackedDF3 = temperatureDFs$stackedDF_1_2_5_6;

  ## Do a t-test between the Jan2012 and Jan2014 (2nd and 4th columns) 
  tTest1 = t.test(x=lansJanTempsDF$Jan2012, y=lansJanTempsDF$Jan2014);
  print(tTest1);
  
  ## Do a t-test between the 3rd and 6th column 
  tTest2 = t.test(x=lansJanTempsDF[,3], y=lansJanTempsDF[,6]);
  print(tTest2);

  ### The seven ways to subset a column in a dataframe -- 
  ### All produce the exact same result
  ### Only the first two methods work with matrices
  # tTest2a = t.test(x=lansJanTempsDF[,2], y=lansJanTempsDF[,4]);
  # tTest2b = t.test(x=lansJanTempsDF[,"Jan2012"], y=lansJanTempsDF[,"Jan2014"]);
  # tTest2c = t.test(x=lansJanTempsDF[2], y=lansJanTempsDF[4]);
  # tTest2d = t.test(x=lansJanTempsDF["Jan2012"], y=lansJanTempsDF["Jan2014"]);
  # tTest2e = t.test(x=lansJanTempsDF[[2]], y=lansJanTempsDF[[4]]);
  # tTest2f = t.test(x=lansJanTempsDF[["Jan2012"]], y=lansJanTempsDF[["Jan2014"]]);
  # tTest2g = t.test(x=lansJanTempsDF$Jan2012, y=lansJanTempsDF$Jan2014;

  ### Need to use the stacked data frames to do the ANOVAS
  ##  Do an ANOVA to compare 2013 with 2016 (the same as the last t-test)
  Jan13_16_Anova = aov(data=stackedDF2, formula=values~ind);
  print(Jan13_16_Anova);
  print(summary(Jan13_16_Anova));
  
  ##  Do an ANOVA to compare four years
  Jan4MonthAnova = aov(formula=values~ind, data=stackedDF3);
  print(Jan4MonthAnova);
  print(summary(Jan4MonthAnova));

  ## Get the residuals form the ANOVA
  residuals = residuals(Jan4MonthAnova);

  ## Plot the residuals on a histogram
  plot1 = ggplot() +
    geom_histogram(mapping=aes(x=residuals)) +
    theme_bw();
  plot(plot1);
  
  ## For linear regressions, we will use the data from the larger dataframe
  weatherData = read.csv(file="data/Lansing2016Noaa-3.csv");
  
  ### Plot a linear regression in GGPlot (did this in lesson 2-01)
  plot1 = ggplot(data=weatherData) + 
    geom_point(mapping=aes( x=avgTemp, y=relHum ) ) + 
    geom_smooth(mapping=aes( x=avgTemp, y=relHum ),
                method="lm" ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          x = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    theme_bw();
  plot(plot1);
  
  # Create blank plot first (no points)
  plot(x = weatherData$avgTemp,
       y = weatherData$relHum,
       type = "n",  # don't draw points
       main = "Humidity vs Temperature\nLansing, MI -- 2016",
       col.main = "red",
       xlab = "Average Temperatures (Fahrenheit)", 
       ylab = "Relative Humidity",
       col.lab="green",
       xaxt = 'n')
  
  # Add custom axes
  axis(side = 1, at = seq(from = 10, to = 80, by = 10), col.axis = "brown")
  axis(side = 2, at = seq(from = 40, to = 90, by = 5), col.axis = "purple")
  
  # Draw regression line first (behind points)
  abline(lm(weatherData$relHum ~ weatherData$avgTemp), lwd = 3)
  
  # Now plot the actual points on top
  points(x = weatherData$avgTemp, y = weatherData$relHum,
         col="red",
         cex=2,
         lwd=3,
         pch=23,
         bg="blue")
  
  ### Calculate a linear regression
  tempHumLM = lm( formula = weatherData$relHum ~ weatherData$avgTemp );  
  print(tempHumLM);
  print(summary(tempHumLM));
}
  