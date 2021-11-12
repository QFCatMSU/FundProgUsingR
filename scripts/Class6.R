{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  #### Class 6 topics: ####
  #    - conditions on else statements
  #    - which statements
  #    - data frame issues/manipulation 
  #    - Regular Expressions (grep)
  
  ### read in weather data for all of 2016 in Lansing
  weather2Week = read.csv(file="data/twoWeekWeatherData3.csv",
                          sep=",",
                          header=TRUE,               
                          stringsAsFactors = FALSE); 
  
  ### read in weather data for all of 2016 in Lansing 
  weatherYear = read.csv(file="data/Lansing2016NOAA.csv",
                         sep=",",
                         header=TRUE,               
                         stringsAsFactors = FALSE);
  
  # get the precip column from the data frame -- save to vector
  precip = weatherYear$precip;
  
  precipHighDays = 0;
  precipMedDays = 0;
  precipLowDays = 0;
  ph = c();   pm = c();  pl = c();
  
  for(i in 1:length(precip))
  {
    if(precip[i] >= 1)  
    {
      precipHighDays = precipHighDays + 1;
      ph[length(ph)+1] = i;
    }
    else if (precip[i] >= 0.1 && precip[i] < 1.0)
    {
      precipMedDays = precipMedDays + 1;     
      pm[length(pm)+1] = i;
    }
    else # this is a bug!
    {
      precipLowDays = precipLowDays + 1;  # this line will always execute
      pl[length(pl)+1] = i;
    }
  }
  
  ### Using which() to get the same information...
  highIndex = which(precip >= 1);
  medIndex = which(precip >= 0.1 & precip < 1.0);
  lowIndex = which(precip < 0.1);
  
  ### Can capture the count by using length:
  precipHighDays2 = length(highIndex);
  precipMedDays2 = length(medIndex);
  precipLowDays2 = length(lowIndex);
  
  ### Create a new vector for precip 
  precipNew = c();
  precipNew[highIndex] = "High";
  precipNew[medIndex] = "Medium";
  precipNew[lowIndex] = "Low";
  
  ### Add the vector to the data frame:
  weatherYear$precipLevels = precipNew;
  
  ### Save the new data frame to a CSV file 
  # write.csv(weatherYear, file="data/newWeather.csv",
  #           row.names = FALSE);
   
   
  #### ACT 1:
  # Using the yearly weather data:
  # A) Find the cardinal direction the windPeakDir comes from:
  #   - the north (315-360, 0-45 degrees)
  # B) Create a vector that gives wind peak direction for each
  #    day in terms of the cardinal directions (E, S, W, N)
  #   - use either for loops or which statements to create the vector
  #   - challenge: use both
  # C) Add the new vector the data frame as windCardinal
    
  
  ### Back to precip, which is a chr vector
  # If there is one string value in a vector in this case "T", then 
  # the whole vector is considered a string (of characters)
  
  # Force precip to be numeric:
  precip2 = as.numeric(precip);  # still have issues... NA is not the correct answer
  
  precip3 = precip;  # make a copy so we see the difference
  
  # Change T values in precip3 into a number
  for(i in 1:length(precip3))
  {
    if(precip3[i] == "T")  # find the "T" values
    {
      precip3[i] = 0.005;  # change to a numeric value
    }
  }
  
  ### But, precip3 is still a string 
  
  # Show how <, > work differently on string than numbers ###
  
  ### force precip3 to become numeric
  precip4 = as.numeric(precip3);
  
  #### ACT 2:
  # A) Change precip to a numeric vector with "T" = 0.005 using which() 
  #    In other words, repeat what was done with for loops above using which()
  # B) Add the new vector to the data frame as precip_num
  
  
  ### Regular Expressions: grep() 
  grepPrecip = grep(pattern="T", x=precip); # get index of all "T" values
  precip5 = precip;                         # make copy of precip
  precip5[grepPrecip] = 0.005;              # change "T" to 0.005
  
  
  ### More complex -- 
  grepClouds = grep(pattern="[C|c][L|l][o|O|u|U]", 
                    x=weather2Week$noonCondition);
  
  grepClouds2 = grep(pattern="cloudy", ignore.case = TRUE,
                     x=weather2Week$noonCondition);
  
  grepClouds3 = grep(pattern="cl?[o|u][u|o]d", ignore.case = TRUE,
                     x=weather2Week$noonCondition);
  
  #### ACT 3
  # In the yearly weather data
  # Find the days that had:
  #  - rain 
  #  - fog
  #  - freezing fog 
  #  - fog but not freezing fog
  #     note: [^abc] means that the letters a,b, and c do not occur here
  #  - rain and fog
  #     intersect() is sort of the AND (&&) for vectors
  #  - rain or fog
  #     union() is sort of the AND (&&) for vectors
}
