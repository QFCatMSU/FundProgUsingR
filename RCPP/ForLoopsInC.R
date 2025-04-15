{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  library(package="Rcpp");
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="twoWeekWeatherData.csv",
                         sep=",",
                         header=TRUE,
                         stringsAsFactors = FALSE);
  
  ### This will bring in the four functions inside the .cpp file
  sourceCpp("ForLoopsInC.cpp");
  

  ### Using the functions inside the .cpp file
  d = countVals(c(1,2,3,4,5,5,5,5,6,7,11), val=5, op=">");
  e = countVals(weatherData$highTemp, 582, op=">");
  
  f = checkVals(c(1,2,3,4,5,5,5,5,5,6,7,11), val=5, op="=");
  g = checkVals(weatherData$highTemp, 582, op=">");
  
  testVector = c(5,2,8,12,53,-46,74,63,10,2);
  h = getTotal(testVector);
  h = findHighVal(testVector);
  
}