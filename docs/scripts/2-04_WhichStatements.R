rm(list=ls());  # cleans out the Environment every time the code is executed
options(show.error.locations = TRUE);  # show the line number of errors in the Console
library(package=ggplot2);

ages = c(25,47,13,59,76,33,45);
animalNames = c("llama", "alpaca", "goat", "llama", "guanaco");

### use which() on the vectors above -- save the indexes to a variable
index1 = which(ages > 40);   # index of ages greater than 40
index2 = which(ages <= 33);  # index of ages less than or equal to 33
index3 = which(animalNames == "llama"); # index of animals named "llama"
index4 = which(animalNames != "llama"); # index of animals not named "llama"

### Get weatherData from the CSV file created last lesson
weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");

precip = weatherData$precip;      # save the precip column to a vector
precip2 = as.numeric(precip);     # convert the precip column to a numeric column -- save to precip2
naValues = which(is.na(precip2)); # find which values in precip2 are NA

precip3 = precip2;
precip3[naValues] = 0.005;

daysNoPrecip = which(weatherData$precipNum == 0.00);  # days where precip is 0
daysHighPrecip = which(weatherData$precipNum > 1.00); # days where precip is > 1

# correct code: days where precip is > 0.25 and < 0.50
daysModPrecip = which(weatherData$precipNum > 0.25 & 
                      weatherData$precipNum < 0.50);

# this code is not explicit and will not produce the correct results
# daysModPrecip = which(weatherData$precipNum > 0.25 & < 0.50);

rainyDates = weatherData$dateYear[daysHighPrecip];
rainyDayWindSpeed = weatherData$windSpeed[daysHighPrecip];

plot1 = ggplot(data=weatherData) +
  geom_point( mapping=aes(x=avgTemp,
                          y=relHum),
              color = "blue") +
  labs( title="Humidity vs. Temperature",
        subtitle="Lansing, 2016",
        x = "Temperature (F)",
        y = "Humidity (%)") +
  theme_bw();
plot(plot1);



### Create a subset of weatherData that contain the first 10 rows rows
subset1 = weatherData[1:10,];
### Create a subset of weatherData that contain just the 8 high precip rows
subset2 = weatherData[daysHighPrecip,];

plot2 = ggplot(data=subset2) + # could also use weatherData[daysHighPrecip]
  geom_point( mapping=aes(x=avgTemp, y=relHum),
              color = "blue") +
  labs( title="Humidity vs. Temperature",
        subtitle="Precipitation greater than 1 inch",
        x = "Temperature (F)",
        y = "Humidity (%)") +
  theme_bw();
plot(plot2);

# Create blank plot first (no points)
plot(x = subset2$avgTemp,
     y = subset2$relHum,
     main = "Humidity vs Temperature\nLansing, MI -- 2016",
     xlab = "Average Temperatures (Fahrenheit)", 
     ylab = "Relative Humidity")


plot3 = ggplot() +
  geom_point( mapping=aes(x=weatherData$avgTemp[daysHighPrecip],
                          y=weatherData$relHum[daysHighPrecip]),
              color = "blue") +
  labs( title="Humidity vs. Temperature",
        subtitle="Precipitation greater than 1 inch",
        x = "Temperature (F)",
        y = "Humidity (%)") +
  theme_bw();
plot(plot3);

# Create blank plot first (no points)
plot(x = weatherData$avgTemp[daysHighPrecip],
     y = weatherData$relHum[daysHighPrecip],
     main = "Humidity vs Temperature\nLansing, MI -- 2016",
     xlab = "Average Temperatures (Fahrenheit)", 
     ylab = "Relative Humidity")

### Explicit manual mapping:
plot4 = ggplot() +
  geom_point( mapping=aes(x=c(46,53,82,72,76,58,65,58),
                          y=c(85,85,82,78,77,90,88,83)),
              color = "blue") +
  labs( title="Humidity vs. Temperature",
        subtitle="Precipitation greater than 1 inch",
        x = "Temperature (F)",
        y = "Humidity (%)") +
  theme_bw();
plot(plot4);
