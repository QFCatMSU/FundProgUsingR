{
  rm(list=ls());                         # clear Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);              # get the GGPlot package

  # read in CSV file and save the content to weatherData
  weatherData = read.csv(file="data/Lansing2016NOAA.csv");
  
  #### Part 1: Create a scatterplot ####
  plot1 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum) );
  plot(plot1);

  #### Part 2: Same scatterplot without argument names ####
  #   From here on out, this class uses argument names! ####
  plot2 = ggplot( weatherData ) +
    geom_point( aes(avgTemp, relHum) );
  plot(plot2);
  
  #### Part 3: Adding components to the scatterplot ####
  plot3 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          x = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) );
  plot(plot3);
  
  #### Part 4: Changing the theme ####
  plot4 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          xlab = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) );
  plot(plot4);
  
  #### Part 5: Changing the theme --- oops, undoes theme ####
  plot5 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          x = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) ) +
    theme_bw();
  plot(plot5);
  
  #### Part 6: Adding a regression line ####
  plot6 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
    geom_smooth( mapping=aes(x=avgTemp, y=relHum), 
                 method="lm" ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          xlab = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) );
  plot(plot6);
  
  #### Part 7: Reversing the overlapping plots ####
  plot7 = ggplot( data=weatherData ) +
    geom_smooth( mapping=aes(x=avgTemp, y=relHum), 
                 method="lm" ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          xlab = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) );
  plot(plot7);
}