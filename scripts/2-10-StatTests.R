{
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package="ggplot2");

  
  ### Get the four data frames saved to a List at the end of the last lesson
  load(file = "data/tempDFs.rdata"); 
  
  lansJanTempsDF = temperatureDFs$origDF;
  stackedDF = temperatureDFs$stackedDF;
  stackedDF2 = temperatureDFs$stackDF_3_6;
  stackedDF3 = temperatureDFs$stackedDF_1_2_5_6

  ## Do a t-test between the Jan2012 and Jan2014 (2nd and 4th columns) 
  tTest1 = t.test(x=lansJanTempsDF[,"Jan2012"], y=lansJanTempsDF[,"Jan2014"]);
  print(tTest1);
  
  ## Do a t-test between the 3rd and 6th column 
  tTest2 = t.test(x=lansJanTempsDF[,3], y=lansJanTempsDF[,6]);
  print(tTest2);

  ### Need to use the stacked data frames to do the ANOVAS
  ##  Do an ANOVA to compare 2013 with 2016 (the same as the last t-test)
  Jan13_16_Anova = aov(data=stackedDF2, formula=values~ind);
  print(Jan13_16_Anova);
  print(summary(Jan13_16_Anova));
  
  ##  Do an ANOVA to compare four years
  Jan4MonthAnova = aov(formula=values~ind, data=stackedDF3);
  print(Jan4MonthAnova);
  print(summary(Jan4MonthAnova));

  residuals = residuals(Jan4MonthAnova);

  plot3 = ggplot() +
    geom_histogram(mapping=aes(x=residuals)) +
    theme_bw();
  plot(plot3);
  
  weatherData = read.csv(file="data/Lansing2016Noaa-3.csv");
  
  ### Plot a linear regression in GGPlot (did this in lesson 2-01)
  plot1 = ggplot(data=weatherData,
                 mapping=aes( x=avgTemp, y=relHum )) + 
    geom_point() + 
    geom_smooth(method="lm") +
    theme_bw();
  plot(plot1);
  
  ### Calculate a linear regression
  tempHumLM = lm( formula = weatherData$relHum ~ weatherData$avgTemp );  
  print(tempHumLM);
  print(summary(tempHumLM));
}
  