rm(list=ls());
source("scripts/2-14_myFunctions.R");
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

# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");
temps = high_and_low(weatherData$maxTemp, weatherData$minTemp, weatherData$dateYear);

set.seed(1000);
nums = rnorm(1000000, mean=14, sd=3);

#doThis(num)

final = 0;
for(i in 1: length(nums))
{ 
  final = final + nums[i]^(1/2);
  
  # if(is.na(final))  is.infinite(final)
  # {
  #   browser()
  #   print(nums[(i-10):(i+10)])
  # }
}

neg = which(nums < 0)
nums[(i-10):(i+10)]

nums2 = rnorm(10, mean=14, sd=3);
final2 = 0;
for(i in 1: length(nums))
{
  ### infinite will not cause an error
  ### also note that R goes to many decimal places... have to truncate
  final2 = final2 + (nums2[i]) / (round(nums2[i], 5) - 14.70091);
  
  if(is.infinite(final2))
  {
  #  browser()
    print(nums[(i-10):(i+10)])
  }
}



