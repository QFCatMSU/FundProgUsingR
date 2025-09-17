rm(list=ls());  # cleans out the Environment 
options(show.error.locations = TRUE);  

### read in data from  twoWeekWeatherData.csv
weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                        sep=",",
                        header=TRUE);  

### Extract the highTemps column from the data frame -- save it to a variable
highTemps = weatherData$highTemp;
noonCond = weatherData$noonCondition;
precip = weatherData$precipitation;

# get length of vector
numDays  = nrow(weatherData);  # length of the vectors is number of rows (14)

# Using two state variables
sunnyDays = 0; # state variable -- will hold the count of sunny days
rainyDays = 0; # state variable -- will hold the count of sunny days

for(i in 1:numDays)
{
  if(noonCond[i] == "Sunny")
  {
    sunnyDays = sunnyDays +1;   # increases sunnyDays by 1
  }
  # We use else if here because we know "Sunny" and "Rain" are mutually exclusive
  else if(noonCond[i] == "Rain")
  {
    rainyDays = rainyDays +1;   # increases rainyDays by 1
  }
}

### Finding the highest temperature in a vector
highestTemp = 0;  # initialize the state variable

for (i in 1:numDays)
{
  if(highTemps[i] > highestTemp) # is this day's value grater than the current high
  {
    # this day's value is higher -- set highestTemp to this value
    highestTemp = highTemps[i];
  }
}

tempGT60 = 0; # days with temperatures greater than 60
tempLT50 = 0; # days with temperatures less than 50

for(i in 1:numDays)
{
  if(highTemps[i] > 60)
  {
    tempGT60 = tempGT60 +1;  
  }
  else if(highTemps[i] < 50)
  {
    tempLT50 = tempLT50 +1;
  }
}

tempGT60odd = 0; # odd days with temperatures greater than 60
tempLT50odd = 0; # odd days with temperatures less than 50

for(i in seq(from=1, to=numDays, by=2))
{
  if(highTemps[i] > 60)
  {
    tempGT60odd = tempGT60odd +1;  
  }
  else if(highTemps[i] < 50)
  {
    tempLT50odd = tempLT50odd +1;
  }
}

totalPrecip = 0;
for(i in 1:numDays)
{
  totalPrecip = totalPrecip + precip[i];
}

# Find the average precipitation using the total and the number of days
avgPrecip = totalPrecip/numDays;

# Check if any value in highTemps is less than 40
anyDayLT40 = FALSE;     # initialize state variable to FALSE
for(i in 1:numDays) 
{
  if(highTemps[i] < 40)
  {
    anyDayLT40 = TRUE;  # found a value -- change state variable to TRUE
    # break;            # not needed -- makes code more efficient
  }
}

# Find the highest value in a vector
highestTemp = 0;  # initialize the high temp to 0 (this will be surpassed!)
for(i in 1:numDays)  
{
  if(highTemps[i] > highestTemp) # is this day's value grater than the current high
  {
    # this day's value is higher -- set highestTemp to this value
    highestTemp = highTemps[i];
    # browser(); # uncomment to pause the script's execution at this point
  }
}

# A better way to do the above for loop 
highestTemp2 = highTemps[1];
for(i in 1:numDays)  # could be 2:numDays
{
  if(highTemps[i] > highestTemp2)
  {
    highestTemp2 = highTemps[i];
  }
}