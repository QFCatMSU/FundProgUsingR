rm(list=ls());        # clear out the Environment  

randomTemp = sample(30:80, size=1);  # pick a random number between 30 and 80

if (randomTemp > 50)   # if randomTemp is greater than 50...
{ 
  # ...execute the commands inside this codeblock
  cat("\nThe temperature is", randomTemp);
  cat(" warm enough to go outside\n");
}

### read in data from  twoWeekWeatherData.csv
weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                       sep=",",
                       header=TRUE);  

### Extract the highTemps column from the data frame -- save it to a variable
highTemps = weatherData$highTemp;
noonCond = weatherData$noonCondition;

cat("---------\nChecking highTemps 3, 4, and 5 to see which are > 50:\n");

if(highTemps[3] > 50)
{
  cat("  high temp 3 is greater than 50\n");
}
if(highTemps[4] > 50)
{
  cat("  high temp 4 is greater than 50\n");
} 
if(highTemps[5] > 50)
{
  cat("  high temp 5 is greater than 50\n");
}

cat("\n---------\nChecking high temp 2 using all 6 conditional operators:\n");

if(highTemps[2] >= 50)
{
  cat("  high temp is greater than or equal to 50\n");
}
if(highTemps[2] <= 50)
{
  cat("  high temp is less than or equal to 50\n");
}
if(highTemps[2] > 50)
{
  cat("  high temp is greater than 50\n");
}
if(highTemps[2] < 50)
{
  cat("  high temp is less than 50\n");
}
if(highTemps[2] == 50)
{
  cat("  high temp is equal to 50\n");
}
if(highTemps[2] != 50)
{
  cat("  high temp is not equal to 50\n");
}

cat("\n---------\nCheck to see the noon condition on the day 2:\n");

# checking the second noonCond, which is "Cloudy"
if(noonCond[2] == "Cloudy")  # noonCond[2] is "Cloudy"
{
  cat("  Day was Cloudy\n");
}
if(noonCond[2] != "Sunny")   # noonCond[2] is not "Sunny"
{
  cat("  Day was not Sunny\n")
}

cat("\n---------\nChecking same condition but changed 'Cloudy' to 'cloudy':\n");

if(noonCond[2] == "cloudy")  # This is FALSE because of the lowercase c
{
  cat("  Day was cloudy\n");
}
if(noonCond[2] != "cloudy")  # This is TRUE 
{
  cat("  Day was NOT cloudy\n"); 
}

cat("\n---------\nOutputting information from another column:\n");

if(noonCond[2] == "Cloudy")   # back to correct spelling of Cloudy
{
  cat("  Day was Cloudy");
  cat(" and the high temperature that day was", highTemps[2], "\n");
}

cat("\n---------\nUsing Embedded if() statements:\n");

if(noonCond[2] == "Cloudy")   # checking if the day was cloudy
{
  # the following if statement are only checked if conditions are cloudy
  if( highTemps[2] > 60 )
  {
    cat("Still nice enough to go out!");
  }
  if( highTemps[2] < 60 )
  {
    cat("Best to stay indoors");
  }
}