rm(list=ls());  # cleans out the Environment 

### read in data from  twoWeekWeatherData.csv
weatherData = read.csv(file="data/twoWeekWeatherData2.csv", 
                        sep=",",
                        header=TRUE);  

# get length of vector
numDays  = nrow(weatherData);  # length of the vectors is number of rows (14)

### Extract the highTemps column from the data frame -- save it to a variable
highTemps = weatherData$highTemp;
noonCond = weatherData$noonCondition;

#### From last lesson 
sunnyDays = 0; # state variable -- will hold the count of sunny days
rainyDays = 0; # state variable -- will hold the count of sunny days

for(i in 1:numDays)
{
  if(noonCond[i] == "Sunny")
  {
    sunnyDays = sunnyDays +1;   # increases sunnyDays by 1
  # We use else if here because we know "Sunny" and "Rain" are mutually exclusive
  }else if(noonCond[i] == "Rain")
  {
    rainyDays = rainyDays +1;   # increases rainyDays by 1
  }
}

# Combine two conditional statements using the OR operator
sunnyOrRainyDays = 0; 

for(i in 1:numDays)
{
  if(noonCond[i] == "Sunny" | noonCond[i] == "Rain")
  {
    sunnyOrRainyDays = sunnyOrRainyDays +1;   
  }
}

### This codeblock will cause an error
# sunnyOrRainyDays2 = 0;
# for(i in 1:numDays)
# {
#   if(noonCond[i] == "Sunny" | "Rain")  # conditions needs to be explicit
#   {
#     sunnyOrRainyDays2 = sunnyOrRainyDays2 +1;   
#   }
# }


### Using OR to check for multiple spellings 
noonCondMess = weatherData$noonCondMessy

sunnyDays1 = 0; 

for(i in 1:numDays)
{
  if(noonCondMess[i] == "Sunny" | noonCondMess[i] == "sunny" | 
      noonCondMess[i] == "sun" | noonCondMess[i] == "SUN")
  {
    sunnyDays1 = sunnyDays1 +1; # increases sunnyDays by 1
  }
}

### Using AND to check for conditions on two different variables
goOutDay = 0;

for(i in 1:numDays)
{
  if(highTemps[i] > 60 & noonCond[i] == "Sunny")
  {
    goOutDay = goOutDay +1;
  }
}

### Reversing the conditions from above
stayInDay = 0;

for(i in 1:numDays)
{
  if(highTemps[i] <= 50 & noonCond[i] != "Sunny")
  {
    stayInDay = stayInDay +1;
  }
}

cat("\n------\n");

### Combining the last two conditional statements, which are mutually exclusive
for(i in 1:numDays)
{
  if(highTemps[i] > 60 & noonCond[i] == "Sunny")
  {
    cat("day", i, " good day to go out\n");
  }else if(highTemps[i] <= 50 & noonCond[i] != "Sunny")
  {
    cat("day", i, " good day to stay in\n");     
  }
}

cat("\n------\n");
  
### Using AND to bound numbers on both sides
for(i in 1:numDays)
{
  if(highTemps[i] >= 50 & highTemps[i] < 60)
  {
    cat("It was ", highTemps[i], "degrees on day ", i, "\n");
  }
}

cat("\n------\n");

### Using OR to check extreme values on both sides 
precipBad = weatherData$precipBad;
for(i in 1:numDays)
{
  if(precipBad[i] < 0 | precipBad[i] > 10)
  {
    cat("Day", i, "has a value of" , precipBad[i], "\n");
  }
}

### Creating Boolean vector 
sunnyDayBool = (noonCond == "Sunny");
niceDayBool = (highTemps > 60 & noonCond == "Sunny");
precipBool = (noonCond == "Rain" | noonCond == "Snow");

### Using a Boolean vector to "mask" a dataframe
sunnyDayWD = weatherData[sunnyDayBool,];  # subset rows where sunnyDayBool is TRUE

### Masking rows and columns
sunnyDayWD2 = weatherData[sunnyDayBool, c(-4)];  # remove precipitation column (4)