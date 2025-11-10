rm(list=ls());                         # clear the Environment tab
options(show.error.locations = TRUE);  # show line numbers on error
library(package=ggplot2);              # include all GGPlot2 functions

# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA.csv");

#### Part 1: Create a scatterplot ####
plot1 = gplot2::ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) );
plot(plot1);

plot(x=weatherData$avgTemp,
     y=weatherData$relHum);

#### Part 2: Same scatterplot without argument names ####
plot2 = ggplot( weatherData ) +
  geom_point( aes(avgTemp, relHum) );
plot(plot2);

plot(weatherData$avgTemp,
     weatherData$relHum);

#### Part 3: Adding components to the plot ####
plot3 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  labs( title="Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
        y = "Relative Humidity") +
  scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
  theme( axis.text.x=element_text(angle=90, vjust=0.5) );
plot(plot3);

plot(x=weatherData$avgTemp,
     y=weatherData$relHum,
     type="n",
     main="Humidity vs Temperature\nLansing, MI -- 2016",
     col.main = "red",
     xlab="Average Temperatures (Fahrenheit)", 
     ylab="Relative Humidity",
     col = "blue",
     col.lab="green",
     cex = 2,
     pch = 23,
     xaxt='n');
axis(side = 1, at=seq(from=10, to=80, by=10), col.axis="brown");
axis(side = 2, at=seq(from=40, to=90, by=5), col.axis="purple");
abline(lm(weatherData$avgTemp ~ weatherData$relHum), lwd=3);

# title("Humidity vs Temperature\nLansing, MI -- 2016",
#       col.main="red");

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

#### Part 4: Changing the theme ####
plot4 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  labs( title="Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
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
  theme_bw();  # this complete theme change will remove the theme change above
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