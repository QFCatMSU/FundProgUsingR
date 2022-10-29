{
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package=ggplot2);   

  #### There are no column names in this data... so, V1, V2...
  lansingJanDF = read.csv(file = "data/LansingJanTemps.csv");
  
  lansingJanDF2 = lansingJanDF;

  ## Not recommended to change column names to numbers only
  # colnames(lansingJanDF2) = 2011:2016;
  
  ### Change column names from V1, V2... to c2011...
  ##  Use column names that meet standards for variable naming
  colnames(lansingJanDF2) = paste("Jan", 2011:2016, sep="");
  
  ## convert data frame into a matrix
  lansingJanMat = as.matrix(lansingJanDF2);
  
  # 1) Divide by 10 to get units from tenths of Celsius to Celsius
  lansingJanMat2 = lansingJanMat / 10;
  
  # 2)  Converting from Celsius to Fahrenheit
  lansingJanMat3 = (9/5) * lansingJanMat2 + 32;
  
  # 3) Set the number of significant digits to 2
  lansingJanMat4 = signif(x=lansingJanMat3, digits=2);
  
  ### 4) finding mean values
  # find mean and standard deviation of the whole matrix
  meanAllTemps = mean(lansingJanMat4);
  sdAllTemps = sd(lansingJanMat4);
  
  
  #### Explain row/col notation....####
  
  # find mean of January 2013 (the third column)
  meanJan2013 = mean(lansingJanMat4[,3]);
  
  # find mean of all January 17ths (the 17th row)
  meanJan17 = mean(lansingJanMat4[17,]);
  
  # find mean of all January 10-19 from 2011-2013:
  meanJanPart = mean(lansingJanMat4[10:19, 1:3]);
 
  # find mean of every even days on odd years:
  evenDays = seq(from=2, to=31, by=2);
  oddYears = c(1,3,5);  

  meanJanEvenOdd = mean(lansingJanMat4[evenDays, oddYears]);
 
  ### Transposing the matrix:
  lansingJanMat_T = t(lansingJanMat4);
  
  ### Find the mean for all columns (year)
  # vector that holds the yearly mean values
  yearlyMean = c();
  
  # go through each of the six column and find the mean of the temperature values
  for(i in 1:6)  # remember i is used to index the iteration in the for()
  {
    # get the mean of all values in column i and save it to monthlyMean[i]
    yearlyMean[i] = mean(lansingJanMat4[,i]);
  }
  
  # Use apply to get the mean for each column
  yearlyMean2 = apply(lansingJanMat4, MARGIN=2, FUN=mean);

  ### Save the matrix to a CSV file for use in later lessons....
  write.csv(x=lansingJanMat4, file = "data/LansingJanTempsFixed.csv",
            row.names = FALSE);
  
  
#### The code below is being moved to another lesson #####
  
  #### Part 1: Line plot for all years ####
  #### Note: need to plot as data frame 
  ### Can do with for loop -- in GGPlot class ###
  plot1 = ggplot( data=as.data.frame(lansingJanMat4) ) +
    geom_line( mapping=aes(x=1:31, y=Jan2011),
               color = "red",
               show.legend = TRUE) +
    geom_line( mapping=aes(x=1:31, y=Jan2012),
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
          x = "January Days",
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
  #plot(plot2);
  
  
  #### Stack the columns??? -- Extension
  stackedDF = stack(lansingJanDF2);
  plot3 = ggplot( data=stackedDF ) +
    geom_line( mapping=aes(x=((1:186)%%31), 
                           y=values, 
                           color=ind) ) +
    scale_color_manual(values=c("red", "green","blue","orange",
                            "purple", "black")) +
    theme_bw();
  plot(plot3);

}
