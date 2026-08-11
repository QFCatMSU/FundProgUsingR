rm(list=ls());
source("scripts/2-15_myFunctions.R");

# read in CSV file and save the content to weatherData
weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");

temps = high_and_low(weatherData$maxTemp, 
                     weatherData$minTemp, 
                     weatherData$dateYear);

#download.packages("pracma", destdir = ".", type = "source")
#untar("pracma_x.y.z.tar.gz")  # currently 2.4.6
pkgload::load_all("pracma")

p = pracma::isprime(c(1,2,4,71,88,2131, 3287, 7819))
