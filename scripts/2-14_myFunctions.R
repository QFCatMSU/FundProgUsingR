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
  
  highest_high = 0;  
  highest_low = 0;
  lowest_high = 0;
  lowest_low = 0;
  
  for(i in 1:length(highs))
  {
    if(highs[i] > highest_high)
    {
      highest_high = highs[i];
      attr(highest_high, "date") = dates[i];
    }
    else if(highs[i] < lowest_high)
    {
     lowest_high = highs[i];
     attr(lowest_high, "date") = dates[i];
    }
    else if(lows[i] > highest_low)
    {
      lowest_high = lows[i];
      attr(lowest_high, "date") = dates[i];
    }
    else if(lows[i] < lowest_low)
    {
      lowest_low = lows[i];
      attr(lowest_low, "date") = dates[i];
    }
  }
  
  vals = c(highest_high, highest_low, lowest_high, lowest_low);
  
  names(vals) = c("highest high", "highest low", "lowest high", "lowest low");
  
  #### return a list instead??
  return(vals)

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