{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  #### Class 5 topics: ####
  #    - breaks and breakpoints (breakpoints only work on Source -- not Run )
  #    - generalizations (what makes a programming language a programming language!)
  #    - shortcuts (which() statements)
  #    - subsetting data frames
  
  ### read in weather data for all of 2016 in Lansing (new data!) 
  weatherData = read.csv(file="data/Lansing2016NOAA.csv",
                         sep=",",
                         header=TRUE,               # don't use T
                         stringsAsFactors = FALSE); # don't use F
  
  # get the maxTemp column from the data frame -- save to vector
  maxTemps = weatherData$maxTemp;
  
  #### breaks and breakpoints #### 
  anyDayGT40 = FALSE;     # default state is FALSE
 
  for(i in 1:366)
  {
    if(maxTemps[i] > 40)  # is the a temp greater than 40
    {
      # put a breakpoint on the next line
      anyDayGT40 = TRUE; 
      break;    
    }
  }
  
  ## A breakpoint pauses the code so you can look around:
  #  - Continue: unpauses code (e.g., Play)
  #  - Next: executes next command only (e.g., Play only next frame)
  #  - Stop: ends script
  
  dates = weatherData$dateTime;
  minTemps = weatherData$minTemp;

  # finding the highest high temperature
  highestTemp = maxTemps[1];  # generalize: best to use value from vector
  higestTempDate = dates[1];
  highestTempMin = minTemps[1];
  
  for(i in 1:length(maxTemps))   # generalize: replace 366 with something more generic  
  {
    if(maxTemps[i] > highestTemp)
    {
      highestTemp = maxTemps[i];
      highestTempDate = dates[i];
      highestTempMin = minTemps[i]; 
    }
  }
  #### Activity 1 ####
  # a) Generalize the code above
  # b) Output to the Console (no hardcoded values!):
  #    - the highest temperature (maxTemp column)
  #    - the day is occurred (dateTime column)
  #    - the low temperature for that day (minTemp)
  # c) Part b) can be done using 3 state variables:
  #    - one for each of dateTime, maxTemp, and minTemp
  #    Or, better, with only 1 state variable
  #    - for the index 
  
  
  #### which() statements ####
  ## The shorter (simpler?) way to do it...
  htIndex = which.max(maxTemps);   # get the index for the max temp
  htMax = max(maxTemps);           # use max() to find the maximum
  htMax2 = maxTemps[htIndex];      # or, use the index
  htDate = weatherData$dateTime[htIndex];   # use index to find date
  htMinTemp = weatherData$minTemp[htIndex]; # use index to find min
  
  #### Subsetting data frame ####
  # Generally, we want to subset a data frame based on a condition
  # In this case: subsetting for days that are greater than 70 degrees
  gt70Index = c();   # state variable -- initially an empty vector (i.e., default in no values)
  
  for(i in 1:nrow(weatherData)) # same as number of values in vector: length(maxTemps)
  {
    if(maxTemps[i] > 70)               # if the temperature is > 70
    {
      gt70Index = append(gt70Index, i);  # append (add) index to the vector
    }
  }
  
  # Using which statements
  gt70Index2 = which(maxTemps > 70);  # same as gt70Index
  
  # Get the date for the index values:
  gt70Dates = weatherData$dateTime[gt70Index];
  
  # Get the actual maxTemp for the index values:
  gt70Temps = maxTemps[gt70Index];
  
  #### Activity 2 ####
  #    Using for and which()
  #    - Find days with no precipitation
  #    - Find days with precip > 1
  
  #### Create new Data Frame ####
  
  # Use [row,column] operator to subset original data frame
  reducedDF = weatherData[gt70Index,];          # all columns with rows GT 70
  reducedDF2 = weatherData[gt70Index, 1:5];     # cols 1-5 with rows GT 70
  reducedDF3 = weatherData[gt70Index, c(2,4,7)];# cols 2,4,7 with rows GT 70
  
  # Note: best not to mess with original data frame -- always save to a new data frame
  
  #### Activity 3 ####
  # A) Create a data frame that has 
  #    - all the temperature and precipitation column
  #    - for columns with precipitation greater than 1
  # B) using write.csv(), write the data frame to a csv file
  #    -= look at Help for write.csv()
  #    - don't want row names
  #    - want commas separating values
}