rm(list=ls());
source("scripts/2-14_myFunctions.R");

# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");

temps = high_and_low(weatherData$maxTemp, 
                     weatherData$minTemp, 
                     weatherData$dateYear);


## load the local version of the pracma package
pkgload::load_all("scripts/pracma")

## Call isprime 
isprime(c(1,2,4,71,88,2131, 3287, 7819));
