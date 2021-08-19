{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData3.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  precip = weatherData$precipitation;
  
  precipMax = max(precip);
  precipMean = mean(precip);
  precipMed = median(precip);
  precipSD = sd(precip);
  
  # see if the first number is divisible by the second
  isDivisible = function(div1, div2)
  {
    remainder = div1 %% div2;
    if(remainder == 0)
    {
      return(TRUE);
    } 
    else
    {
      return (FALSE);
    }
  }
  
  div12_4 = isDivisible(12,4);
  div12_5 = isDivisible(12,5);
  
  # better to put in parameter names:
  div12_4a = isDivisible(div1=12, div2=4);
  div12_5a = isDivisible(div1=12, div2=5);
  
  # the order does not matter when you use parameter names:
  div12_4b = isDivisible(div2=4, div1=12);
  div12_5b = isDivisible(div2=5, div1=12);
}