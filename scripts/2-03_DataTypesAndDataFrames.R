{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  library(package=ggplot2);
  
  ### First let's read in the bad csv file:
  badData = read.csv(file="data/Lansing2016Noaa-2-bad.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);
  
  ### Keep writing with row.names then you can have multiple X columns
  
  ### Adding/modifying columns with incorrect number of values
  ## badData$test1 = c(1:400); 
  ## badData$test2 = c(1:10);
  ## The above lines will give an error


  ### Unless the number of values evenly divides the number of row in the data frame
  badData$test3 = 10;       # adding 1 value 366 times
  badData$test4 = c(1:6);   # adding 6 values 61 time (6*61 = 366)
  
  ### Repeating values in a vector --
  ##  The following two lines will both create a vector with 366 values
  vectorAF = rep(c("A", "B", "C", "D", "E", "F"), times = 61);  
  vector1_10 = rep(1:10, length.out=366);
  
  ### Multiple repeated values within a vector:
  firstThreeMonths = c(rep("Jan", 31), rep("Feb", 29), rep("Mar", 31));
  
  ### Now let's read to good data frame
  weatherData = read.csv(file="data/Lansing2016Noaa-2.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);

  ### Let's grab the precip column 
  precip = weatherData$precip;
  
  ### Mathematical operations on a string column will cause an error
  #  totalPrecip = sum(precip);
  #  meanPrecip = mean(precip);
  
  # Create a numeric version of precip -- call it precip2
  precip2 = as.numeric(precip);
  
  ### The error goes away but, because there are NA values, the result is NA
  totalPrecip = sum(precip2);
  meanPrecip = mean(precip2);
  
  ## One way to fix is to explicitly remove the NA values:
  totalPrecip2 = sum(precip2, na.rm = TRUE);
  meanPrecip2 = mean(precip2, na.rm = TRUE);
  
  # But, it might be better to assign values to NA, otherwise NA days are excluded
  
  # Make another copy of precip so we can see the progress
  precip3 = precip2;
  
  ## Go through every precip value 
  for(i in 1:length(precip3))
  { # is the value NA - note: if(precip[3] == NA or "NA") does not work
    # NA is a pseudo variable in R
    if(is.na(precip3[i]))   
    {
      precip3[i] = 0.005;
    }
  }

  # Mean will be a bit lower because of the multiple NA days
  meanPrecip3 = mean(precip3);
  totalPrecip3 = sum(precip3); 
  
  ### SAve the precip3 vector as the column precipNum in weatherData
  weatherData$precipNum = precip3;
  
  ### Write the current data frame to a new CSV file -- this will be used next lesson
  write.csv(weatherData, file="data/Lansing2016Noaa-3.csv",
            row.names = FALSE);

  ## Scatterplot of precipitation vs date number
  plot1 = ggplot(data=weatherData ) +
    geom_point( mapping=aes(x=1:nrow(weatherData),  # 366
                            y=precipNum),
                color = "red") +
    labs( title="Daily Precipitation",
          subtitle="Lansing, MI -- 2016",
          x = "Day Number",
          y = "Precipitation (inches)") +
    theme_bw();
  plot(plot1);
  
  ## Scatterplot using the precip column with chr values --
  #  This lists every precip value with T at top since T is > all #s)
  plot2 = ggplot(data=weatherData ) +
    geom_point( mapping=aes(x=1:nrow(weatherData),  
                            y=precip),  # chr values
                color = "red") +
    labs( title="Daily Precipitation",
          subtitle="Lansing, MI -- 2016",
          x = "Day Number",
          y = "Precipitation (inches)") +
    theme_bw();
  plot(plot2);
  
  #### End of code for this lesson ####
  #### Below are plots that will be used in a future lesson ####
  
  # ## Mapping color to the temperature
  # plot3 = ggplot(data=weatherData ) +
  #   geom_point( mapping=aes(x=1:nrow(weatherData),
  #                           y=precipNum,
  #                           color=avgTemp)) +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Day Number",
  #         y = "Precipitation (inches)") +
  #   theme_bw();
  # plot(plot3);
  # 
  # ## Customizing the color of the temperature mapping
  # plot4 = ggplot(data=weatherData ) +
  #   geom_point( mapping=aes(x=1:nrow(weatherData),
  #                           y=precipNum,
  #                           color=avgTemp)) +
  #   scale_color_gradientn(colors = c("blue", "green", "red")) +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Day Number",
  #         y = "Precipitation (inches)") +
  #   theme_bw();
  # plot(plot4);
  # 
  # # plot3 = ggplot(data=weatherData ) +
  #   geom_col( mapping=aes(x=1:nrow(weatherData), 
  #                         y=precipNum),
  #             color="red") +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Day Number",
  #         y = "Precipitation (inches)") +
  #   theme_bw();
  # plot(plot3);
  # 
  # plot3b = ggplot(data=weatherData ) +
  #   geom_col( mapping=aes(x=precipNum,, 
  #                         y=1:nrow(weatherData)),
  #             color="red") +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Precipitation (inches)",
  #         y = "Day Number") +
  #   theme_bw();
  # plot(plot3b);
  # 
  # plot4 = ggplot(data=weatherData ) +
  #   geom_histogram( mapping=aes(x=precipNum),
  #                   fill="red",
  #                   color="black") +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Precipitation (inches)",
  #         y = "Number of Days") +
  #   theme_bw();
  # plot(plot4);
  # 
  # plot4b = ggplot(data=weatherData ) +
  #   geom_histogram( mapping=aes(x=precipNum),
  #                   fill="red",
  #                   color="black",
  #                   binwidth = 0.005) +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Precipitation (inches)",
  #         y = "Number of Days") +
  #   theme_bw();
  # plot(plot4b);
  # 
  # plot5 = ggplot(data=weatherData ) +
  #   geom_bar( mapping=aes(x=precipNum),
  #             color="red") +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Precipitation (inches)",
  #         y = "Number of Days") +
  #   theme_bw();
  # plot(plot5);
  # 

  # plot6 = ggplot(data=weatherData ) +
  #   geom_point( mapping=aes(x=precipNum,  # 366
  #                           y=relHum),
  #               color = "red") +
  #   labs( title="Daily Precipitation",
  #         subtitle="Lansing, MI -- 2016",
  #         x = "Day Number",
  #         y = "Precipitation (inches)") +
  #   theme_bw();
  # plot(plot6);
  # 
  # 
  # ### work with Dates later...
}