rm(list=ls());
source("scripts/2-14_myFunctions.R");


# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");

temps = high_and_low(weatherData$maxTemp, 
                     weatherData$minTemp, 
                     weatherData$dateYear);


#### Debugging package functions ####

## 1) download the package to your computer (once -- change the destdir)
#  download.packages("pracma", destdir = "C:/Users/Charlie/Desktop", type = "source")

## 2) Unzip the package (once)
#  Save pracma folder to your project's script folder

## 3) Install pkgload (once)
# install.packages("pkgload")

## 4) load library - make sure you have the folder path correct
pkgload::load_all("scripts/pracma")

## 5) add a browser() to isprime() in isprime.R

## 6) Now you can use (and debug) functions in pracma
isprime(c(1,2,4,71,88,2131, 3287, 7819));
