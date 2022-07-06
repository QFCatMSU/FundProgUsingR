{
  rm(list=ls());  options(show.error.locations = TRUE);
  
  # have data in data frame format
  # switch to matrix
  # transpose the data
  # add two more -- have these files in vector format (Jan 2017/2018)
  # color the lines in the plot two ways: scale_color_manual, color subcomponent
  # t-test??
  
  # myToken is in the toolbox.r script
  #source(file="scripts/toolbox.r");
  # myToken = "LfoeHFkVUMLcokHXGCTTjukJteFEcvvM";
  library(package=ggplot2);   
  library(package=reshape2);   
  # give this script access to the functions in the rnoaa package
  #library(rnoaa);
  
  
  #### For creating the data...  
 # # get the maximum temperatures for every day in  January 2011 from the NOAA database
 #  lansWeather17 = ncdc(datasetid="GHCND",
 #                       datatypeid=c("TMAX"),
 #                       stationid="GHCND:USW00014836",
 #                       startdate = "2018-01-01", enddate ="2018-01-31",
 #                       token=myToken,
 #                       limit=50  );
 #  
 #  Jan2017Temps = lansWeather17$data$value;
 #  write.csv(x=Jan2017Temps, file = "data/LansingJan2018Temps.csv",
 #            row.names = FALSE);
  
  #### There are no column names in this data... so, V1, V2...
  lansingJanDF = read.csv(file = "data/LansingJanTemps.csv");
  
  lansingJanMat = as.matrix(lansingJanDF);
  
  ### Change column names from V1, V2... to c2011...
  ##  Explain why we add a letter at the beginning... (numeric column names)
  colnames(lansingJanMat) = paste("Jan", 2011:2016, sep="");
  
  
 # 1) Coverting the matrix from tenths of a Celsius to Celsius
  lansingJanMat = lansingJanMat * 0.1;
  
  # 2)  Converting the matrix from Celsius to Fahrenheit
  lansingJanMat = (9/5) * lansingJanMat + 32;
  
  # 3) Setting the number of significant digits to 2
  lansingJanMat = signif(x=lansingJanMat, digits=2);
  
  ### 4) finding mean values
  # find mean of the whole matrix
  meanAllJan = mean(lansingJanMat);
  
  
  #### EXplain row/col notation....####
  
  # find mean of January 2013 (the third column)
  meanJan2013 = mean(lansingJanMat[,3]);
  
  # find mean of all January 17ths (the 17th row)
  meanJan17 = mean(lansingJanMat[17,]);
  
  ### Find the mean for all columns (year)
  # vector that holds the yearly mean values
  yearlyMean = c();
  
  # go through each of the six column and find the mean of the temperature values
  for(i in 1:6)  # remember i is used to index the iteration in the for()
  {
    # get the mean of all values in column i and save it to monthlyMean[i]
    yearlyMean[i] = mean(lansingJanMat[,i]);
  }
  
  yearlyMean2 = apply(lansingJanMat, 2, mean);
  
  ### Find the mean for all rows (days in January)
  # vector that holds the daily mean values
  dailyMean = c();
  
  # go through each of the 31 rows and find the mean of the temperature values
  for(i in 1:31)
  {
    # get the mean of all values in row i and save it to dailyMean[i]
    dailyMean[i] = mean(lansingJanMat[i,]);
  }
  
  dailyMean2 = apply(lansingJanMat, 1, mean);
  
  
  # Reversing the matrix -- columns are days, rows are years
  lansWeatherMatRev = t(lansingJanMat);
  
  #### Part 1: Line plot for all years ####
  #### Note: need to plot as data frame 
  ### Can do with for loop -- in GGPlot class ###
  plot1 = ggplot( data=as.data.frame(lansingJanMat) ) +
    geom_line( mapping=aes(x=1:31, y=Jan2011),
               color = "red") +
    geom_line( mapping=aes(x=(1:31), y=Jan2012),
               color = "green") +
    geom_line( mapping=aes(x=(1:31), y=Jan2013),
               color = "orange") +
    geom_line( mapping=aes(x=(1:31), y=Jan2014),
               color = "blue") +
    geom_line( mapping=aes(x=(1:31), y=Jan2015),
               color = "purple") +
    geom_line( mapping=aes(x=(1:31), y=Jan2016),
               color = "black") +
    labs( title="January Temperature",
          subtitle="Lansing, MI -- 2011-2016",
          xlab = "day",
          y = "temperature (F)") +
    theme_bw();
  plot(plot1);
  
### Fix y-axis coords
  #### put color in the legend
  #### manually set the color 
  #### Might need to Zoom on this plot (not sure why it does not fully render) 
  plot2 = ggplot( data=as.data.frame(lansingJanMat) ) +
    geom_line( mapping=aes(x=(1:31), y=Jan2011, color="2011") ) +
    geom_line( mapping=aes(x=(1:31), y=Jan2012, color="2012") ) +
    geom_line( mapping=aes(x=(1:31), y=Jan2013, color="2013") ) +
    geom_line( mapping=aes(x=(1:31), y=Jan2014, color="2014") ) +
    geom_line( mapping=aes(x=(1:31), y=Jan2015, color="2015") ) +
    geom_line( mapping=aes(x=(1:31), y=Jan2016, color="2016") ) +
    scale_color_manual(values=c("red", "green","blue","orange",
                                "purple", "black")) +
    labs( title="January Temperature",
          subtitle="Lansing, MI -- 2011-2016",
          xlab = "day",
          y = "temperature (F)") +
    scale_x_continuous(breaks = seq(1, 31, 1)) +
    theme_bw();
  plot(plot2);
  


  


  
 

  
  #### cbind 2017 and 2018


  # # bind the temperature vectors into a matrix -- each vector becomes a column 
  # cbindMatrix = cbind(lw11Temps, lw12Temps, lw13Temps, 
  #                     lw14Temps, lw15Temps, lw16Temps);
  
    # In app do a rbind?
  
  #### t-test/ anovas/lists -- next lesson

}
