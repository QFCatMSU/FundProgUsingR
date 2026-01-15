##### Main script
#rm(list=ls());
#source("scripts/test.R");
### 1) download the package to your computer (once)
# Note: on Windows, "~" is probably your Documents directory
#download.packages("pracma", destdir = "C:/Users/Charlie/Desktop", type = "source")

### 2) Unzip the package (once)

### 3) Install pkgload (once)
# install.packages("pkgload")

### 4) load library (make sure you are not calling library(pracma))
### Make sure you do not load using library(), that will override the local copy
# pkgload::load_all("C:/Users/Charlie/Desktop/pracma")
#### Need to load library every time you change the code (e.g., add/remove browser()) 
pkgload::load_all("~/pracma")

### 5) Now you can use functions in pracma
isprime(c(1,2,4,71,88,2131, 3287, 7819));

### need to use browser() if using Source, can use breakpoints if using Run 
### Loading the functions removes all breakpoints.

#bits(12);
#source("scripts/2-14_myFunctions.R");

####################################


#### Switch to named list
#### Where to put breakpoints??

high_and_low = function(highs, lows, dates)
{
  # initialize all to the first value
  highest_high = highest_low = list();
  highest_high$temp = highest_low$temp = highs[1];  
  highest_high$date = highest_low$date = dates[1];  

  lowest_high = lowest_low = list();
  lowest_high$temp = lowest_low$temp = highs[1];  
  lowest_high$date = lowest_low$date = dates[1];  
  

  
  ### Add code to handle multiple dates that have the same extreme temp
  for(i in 2:length(highs))
  {
    if(highs[i] > highest_high$temp)
    {
      highest_high$temp = highs[i];
      highest_high$date = dates[i];
      attr(highest_high, "date") = dates[i];
    }
    else if(highs[i] < lowest_high$temp)
    {
      lowest_high$temp = highs[i];
      lowest_high$date = dates[i];
      attr(lowest_high, "date") = dates[i];
    }
    else if(lows[i] > highest_low$temp)
    {
      highest_low$temp = lows[i];
      highest_low$date = dates[i];
      attr(highest_low, "date") = dates[i];
    }
    else if(lows[i] < lowest_low$temp)
    {
      lowest_low$temp = lows[i];
      lowest_low$date = dates[i];
      attr(lowest_low, "date") = dates[i];
    }
  }

  extreme_temp = list();
  extreme_temp[["highest_high"]] = highest_high;
  extreme_temp[["highest_low"]] = highest_low;
  extreme_temp$lowest_high = lowest_high;
  extreme_temp$lowest_low = lowest_low;

  return(extreme_temp)

}

# read in CSV file and save the content to weatherData
# weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");
# temps = high_and_low(weatherData$maxTemp, weatherData$minTemp, weatherData$dateYear);


findFactors = function(dividend)
{
  ### Store the factors here
  factors = c();
  
  for(i in 2:(dividend-1))
  {
    if(dividend %% i == 0)
    {
      ## number can be divided evenly by another number 
      ## insert this number as a factor
      factors = c(factors, i);
    }
  }
  ## number cannot be divided evenly by another number -- return TRUE
  return(factors);
}