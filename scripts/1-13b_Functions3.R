{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  source(file="scripts/temperature.r");
  
  cat1a = tempCategory(45);
  cat1b = tempCategory(tempValue=85);
  cat1c = tempCategory(tempValue=17);
  cat1d = tempCategory(-2);
  
  cat2a = tempCategory2(45);
  cat2b = tempCategory2(15, "F");
  cat2c = tempCategory2(15, "C");
  cat2d = tempCategory2(tempValue=35, unit="C");
  cat2e = tempCategory2(tempValue=45, unit="C");  # NULL because 45C > 100F
  
  
  cat3a = tempCategory3(45);
  cat3b = tempCategory3(15, TRUE);
  cat3c = tempCategory3(15, FALSE);
  cat3d = tempCategory3(tempValue=35, isFahr=FALSE);
  cat3e = tempCategory3(tempValue=45, isFahr=FALSE);
  
  cat4a = tempCategory4(305, "K");
  cat4b = tempCategory4(270, "K");  
  cat4c = tempCategory4(285, "K");
  cat4d = tempCategory4(tempValue=325, unit="K");
  
  cat5a = tempCategory5(45);
  cat5b = tempCategory5(tempVector=85);
  cat5c = tempCategory5(tempVector=17);
  cat5d = tempCategory5(-2);
  
  cat5e = tempCategory5(c(10,30,50,70,90));
  cat5f = tempCategory5(seq(from=5, to=90, by=20));
  cat5g = tempCategory5(tempVector=c(30,25,20,15,10), unit="C");
  cat5h = tempCategory5(tempVector=seq(from=25, to=-5, by=-5), unit="C");
  
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  

  cat5i = tempCategory5(weatherData$maxTemp);
  cat5j = tempCategory5(weatherData$minTemp);
  
  # add the vectors to the data frame
  weatherData$maxTempCat = cat5i;
  weatherData$minTempCat = cat5j;
  
  # double-click on weatherData in the Environment to see these vectors
  #   they will be the last two columns
  
  #### Create a factor (categorical) vector:
  factorVector = as.factor(cat5i);
  
  reorderedFactor = factor(factorVector, 
                           levels=c("freezing", "cold", "moderate", 
                                    "warm", "hot"));
}