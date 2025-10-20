rm(list=ls());                         # clear the Environment tab
library(package=ggplot2);              # include all GGPlot2 functions

# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA.csv");

#### Part 1: Create a scatterplot ####
plot1 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) );
plot(plot1);

#### Part 2: Same scatterplot without argument names ####
plot2 = ggplot( weatherData ) +
  geom_point( aes(avgTemp, relHum) );
plot(plot2);  # same as plot1

#### Part 3: Adding components to the plot ####
plot3 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  labs( title="plot3: Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
        y = "Relative Humidity") +
  scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
  theme( axis.text.x=element_text(angle=90, vjust=0.5) );
plot(plot3);

#### Part 4: Changing the theme ####
plot4 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  labs( title="plot4: Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
        y = "Relative Humidity") +
  scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
  theme_bw() +
  theme( axis.text.x=element_text(angle=90, vjust=0.5) );
plot(plot4);

#### Part 5: Changing the complete theme --- oops, undoes theme ####
plot5 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  labs( title="plot5: Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
        y = "Relative Humidity") +
  scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
  theme( axis.text.x=element_text(angle=90, vjust=0.5) ) +
  theme_bw();  # this complete theme change will remove the theme change above
plot(plot5);

#### Part 6: Adding a regression line ####
plot6 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  geom_smooth( mapping=aes(x=avgTemp, y=relHum), 
               method="lm" ) +
  labs( title="plot6: Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
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
  labs( title="plot7: Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
        y = "Relative Humidity") +
  scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
  theme_bw() +
  theme( axis.text.x=element_text(angle=90, vjust=0.5) );
print(plot7);

#### Trap: Putting ( + ) is the wrong place ####
# plotA = ggplot( data=weatherData )
# + geom_point( mapping=aes(x=avgTemp, y=relHum) )
# + labs( title="plotA: Humidity vs Temperature",
#       subtitle="Lansing, MI -- 2016",
#       x = "Average Temperatures (Fahrenheit)",
#       y = "Relative Humidity")
# + scale_x_continuous( breaks = seq(from=10, to=80, by=10) )
# + theme( axis.text.x=element_text(angle=90, vjust=0.5) );
# plot(plotA);
