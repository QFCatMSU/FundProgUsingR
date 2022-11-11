{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  source(file="scripts/Class7Functions.r");
  
  #### Class 7 topics: ####
  # - what is a programming language
  #   - text commands that manipulate electronics 
  #     (software -> hardware is the hardest part)
  #   - high-level vs low-level
  # - breaks (for loops) and returns (functions)
  # - Boolean objects
  # - function handshaking
  # - vectors and single values

  ### read in weather data for all of 2016 in Lansing 
  weatherYear = read.csv(file="data/Lansing2016NOAA.csv",
                         sep=",",
                         header=TRUE,               
                         stringsAsFactors = FALSE);
  
  # get the columns from the data frame -- save to vectors
  precip = weatherYear$precip;
  weatherType = weatherYear$weatherType; 
  avgTemp = weatherYear$avgTemp;
 
  
  #### Using breaks -- simple example
  for(i in 1:10)
  {
    cat("i=", i, " ");
    if(i == 4)
    {
      break; 
    }
  }
  
  cat("\n\n");

  #### Using breaks to stop when a condition is met (e.g., temp <= 15):
  for(i in 1:length(avgTemp))
  {
    # cat() is a good debugging tool
    cat("day", i, ":", avgTemp[i], "\n");  
    
    if(avgTemp[i] <= 15)
    {
      cat("\nOn day", i, "the average was", avgTemp[i], "\n");
      break;  # don't check the rest of the temperature values!
    }
  }

  #### Using grepl to find a condition:
  condition = "TS"
  
  for(i in 1:length(weatherType))
  {
    conditionMet = grepl(condition, weatherType[i]);  # returns 1 Boolean value
    
    if(conditionMet == TRUE)  # or, could just be if(conditionMet)
    {
      cat("\nOn day", i, "there were thunderstorms\n");
      break; # comment and uncomment this
    }
  }
  
  ### Why use breaks?
  # 1) More Efficient
  # 2) Only want to process the first time a condition happens
  
  
  #### ACT 1 -- convert the above weather type check code to a function where:
  ## The caller passes in:
  ##       1) The weatherType column
  ##       2) A weather condition 
  ## The function returns the day the weather condition first occurred

  ### ACT 1 Challenges:
  ##       1) Call the function using the date column and a date to check
  ##       2) Have the user pass in two weather conditions (so, 3 arguments total)
  ##          -- return the day that BOTH conditions first occurred
  ##          -- if(condition1Met & condition2Met)

  ## Testing the challenge function
  act1a = weatherCheck(weatherYear$weatherType, "TS", "BR");
  act1b = weatherCheck(weatherYear$dateTime, "02", "09");  
  
  ##### Part 2:  #####
  # Handshaking with functions...
  # note that it does not matter if the function is in the same script
  part2a = convert1(tempVector=avgTemp, unit="F");
  part2b = convert2(tempVector=avgTemp, unit="F");
  
  part2c = compare1(vector=avgTemp, compareVal=55, conditionalOp="==");
  part2d = compare2(vector=avgTemp, compareVal=55, conditionalOp="==");
 
  
  #### Part 3: ####
  # Create (and test) a function that finds the average of 
  #    all the value in a vector that are between 2 given values.  
  #    The 2 values are chosen by the caller.
  # In other words, the function ignores outlier values when averaging.
  

  
  ### Example:
    # A vector has the values c(2,5,8,1,7,10,2)
    # The user want to average values between 4 and 9
    # So, the average is: (5+8+7)/3 = 20/3  = 6.66
  testVals = c(2,5,8,1,7,10,2);
  part3a = outlierAverage1(testVals, 4, 9);  # averaging the non-outliers

  # Questions:
  #   1) What are the arguments?
  #   2) What is the return value?
  #   3) Will a for loop be used?  If so, how?  
  #      What does the for loop iterate through?
  #   4) What are the state variables?  
  #      Or, what values get updated as the for loop iterates?
  #   5) Will an if-else statement be used?  If so, how?
  #      What are the conditions being checked?
  
  #### Challenge: 
  #    Average both the outliers and non-outliers and return both averages
  part3b = outlierAverage2(testVals, 4, 9);  # averaging both
}
