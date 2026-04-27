rm(list=ls());  # cleans out the Environment every time the code is executed
library(package=ggplot2);

### First let's read in the bad csv file:
badData = read.csv(file="data/Lansing2016Noaa-2-bad.csv",
                       sep=",",
                       header=TRUE);

### Keep writing with row.names then you can have multiple X columns

### Adding/modifying columns with incorrect number of values
# badData$test1 = c(1:400); 
# badData$test2 = c(1:10);
# The above lines will give an error


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
                       header=TRUE);

### Let's grab the precip column 
precip = weatherData$precip;

### Mathematical operations on a string column will return an error
#  totalPrecip = sum(precip);
### Statistical operations on a string column will return NA
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

### Save the precip3 vector as the column precipNum in weatherData
weatherData$precipNum = precip3;

### Write the current data frame to a new CSV file -- this will be used next lesson
write.csv(weatherData, file="data/Lansing2016Noaa-3.csv",
          row.names = FALSE);

## Scatterplot of precipitation vs date number
plot1 = ggplot(data=weatherData ) +
  geom_point( mapping=aes(x=1:nrow(weatherData),  # 366
                          y=precipNum),
              color = "red") +
  labs( title="plot1: Daily Precipitation",
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
  labs( title="plot2: Daily Precipitation",
        subtitle="Lansing, MI -- 2016",
        x = "Day Number",
        y = "Precipitation (inches)") +
  theme_bw();
plot(plot2);


##### base-R plots
# # NAs introduced by coercion... (NA values not plotted)
# plot(x=1:nrow(weatherData),  # 366
#      y=weatherData$precip,
#      #   type = "n",  # don't draw points
#      main = "Humidity vs Temperature\nLansing, MI -- 2016",
#      col.main = "red",
#      xlab = "Average Temperatures (Fahrenheit)", 
#      ylab = "Relative Humidity",
#      col.lab="green",
#      xaxt = 'n');
# 
# # 
# plot(x=1:nrow(weatherData),  # 366
#      y=weatherData$precipNum,
#      #   type = "n",  # don't draw points
#      main = "Humidity vs Temperature\nLansing, MI -- 2016",
#      col.main = "red",
#      xlab = "Average Temperatures (Fahrenheit)", 
#      ylab = "Relative Humidity",
#      col.lab="green",
#      xaxt = 'n');
