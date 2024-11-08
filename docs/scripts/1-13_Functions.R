{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  #### functions need to go at the top of your script
  # function to convert Fahrenheit temperatures to Celsius
  convertFtoC = function(fTemp)     # argument: values given by the caller to convert
  {
    celTemp = (5/9) * (fTemp - 32); # the argument is used as part of the calculation
    return(celTemp);   # the results of the calculation are sent back to the caller           
  }
  
  # function to see if the first number is divisible by the second
  #   using the modulus operation ( %% )
  isDivisible = function(div1, div2)  # arguments given by caller
  {
    remainder = div1 %% div2;  # calculating the modulus
    if(remainder == 0)         # div2 divides div1 evenly (no remainder)
    {
      return(TRUE);
    } 
    else                       # div2 does not divide div1 (there is a remainder)
    {
      return(FALSE);
    }
  }
  
  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData3.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  # single value conversions:
  F1 = 50;     C1 = (5/9)*(F1 - 32);
  F2 = 212;    C2 = (5/9)*(F2 - 32);
  
  # multiple value conversion:
  F3 = c(0,50,100,150);               # has 4 values
  C3 = (5/9)*(F3 - 32);
  F4 = seq(from=100, to=10, by=-10);  # has 10 values
  C4 = (5/9)*(F4 - 32);
 
  # convert column from data frame
  F5 = weatherData$highTemp;
  C5 = (5/9)*(F5 - 32);      # has 14 values
  F6 = weatherData$lowTemp;
  C6 = (5/9)*(F6 - 32);      # has 14 values
  # the 2 lines above can be combined:  
  #    C6 = (5/9)*(weatherData$lowTemp - 32);
  

  
  # calling the conversion function with argument names
  C2b = convertFtoC(fTemp=F2);
  C4b = convertFtoC(fTemp=F4);
  C6b = convertFtoC(fTemp=F6);
 
  # calling the conversion function without argument names 
  C2c = convertFtoC(F2);
  C4c = convertFtoC(F4);
  C6c = convertFtoC(F6);
  

  
  # testing the modulus function above
  div12_4 = isDivisible(12,4);   # does 4 divide evenly into 12?
  div12_5 = isDivisible(12,5);   # does 5 divide evenly into 12?
  
  
  # Extension: Same function but uses for loops
  convertFtoC2 = function(fTemp)
  {
    celTemp = c();  # create a vector for the Celsius values
    
    for(i in 1:length(fTemp))  # go through each value in fTemp vector
    { 
      # convert the indexed fTemp -- save to the celTemp vector
      celTemp[i] = (5/9) * (fTemp[i] - 32); 
    }
    return(celTemp);  # return the celsius temp vector to the caller
  }
  
  # Test the conversion function that uses for loops
  C2d = convertFtoC2(fTemp=F2);
  C4d = convertFtoC2(fTemp=F4);
  C6d = convertFtoC2(fTemp=F6);
}