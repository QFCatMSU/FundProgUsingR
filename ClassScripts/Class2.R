{
  # Challenge of a 2-credit class...
  # Run All != Source (line 24)
  # Console (temp), Environment (stored -- keeps information)
  
  # these lines should only occur once in the script
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ###Note:
  # I use { }, ;, and try to keep lines to 85 characters (even comments)
  
  # save stuff to a variable so you know where they are...
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", # path to file
                         sep=",",                   # values are separated by commas
                         header=TRUE,               # there is a header row
                         stringsAsFactors = FALSE); # for people using R 3.X
  
  # Save highTemp and precipitation columns to a (vector) variable
  highTemps = weatherData$highTemp;
  precip = weatherData$precipitation;
  
  # putting variables without context -- sends to Console if Run but not Source
  seq(from=1, to=14, by=3);   # Run and Source this
  
  #### SHORTCUTS ####
  # Create an index vector with sequenced numbers 
  seq1 = seq(from=1, to=14, by=3);   # 1,4,7,10,13

  # Use the index vector to subset the highTemps vector
  highTempSeq1a = highTemps[seq1];   # values 1,4,7,10,13
  
  # You could combine the two previous steps into 1 step -- info is lost here:
  highTempSeq1b = highTemps[seq(from=1, to=14, by=3)]; 

  # Skip the argument names -- but you need to keep the arguments in order:
  highTempSeq1c = highTemps[seq(1, 14, 3)]; 
  # figuring out which is better is more of an art... but most instruction goes too far 
  
  ### Reorder rows in weatherData
  # BAD: https://stackoverflow.com/questions/26548495/reorder-rows-using-custom-order/26548692
  # Rube Goldberg -- %>%, dplyr, shortcuts to ??
  
  # FAR BETTER (and easier to understand...):
  order = c(4,3,2,1,5:14);   # order you want the 14 rows
  
  # [X,Y] or [row,col] notation and col does not change so it is blank
  weatherData2 = weatherData[order,]; 
  
  # make row names = index values --not needed but some want it for aesthetics
  rownames(weatherData2) = 1:14; 
  
  ### Show boxplot in the search
  ### x is only argument where name is rarely used (goes in order)
  
  ### ACTIVITY 1 (draw normal dist on board):
  # Create 300 random temperature using a NORMAL distribution
  #   - Average temp is 50 and standard deviation is 3
  # Create a HISTOGRAM with the 300 random numbers
  #   - add a title and label the x-axis
  # Note: GGPlot class
  
  ### show 300 temps without saving:

  ### Pick 300 random numbers (do in Console and script)
  #randomTemp = sample(x=20:80, size=365);  # error: sample too large
  #sample(x=20:80, size=365);  # will display in Console on Run
  randomTemp = sample(x=20:80, size=365, replace=TRUE);  # allow repeat values!
  randomTempa = sample(x=20:80, size=1, replace=TRUE);  # allow repeat values!
  # mention: NA, NULL
  
  randomTempDiv10 = randomTemp/10;
  meanRandomTemp = mean(randomTemp);
  
  # relating values horizontally and vertically 
  # (you will learn this in the next lesson)
  day= 12;   # only need to edit variables once...
  cat("On day ", day, " the high temp was: ", highTemps[day], 
      " and the precip was ", precip[day], "\n", sep="");
  
  ### ACTIVITY 2
  # Convert precipitation from inches to centimeters
  # Convert highTemps from Fahrenheit to Celsius 
  # Challenge: Add converted columns to weatherData
  
  ### Teams
  # Move Project Folder to OneDrive 
  # Start Chat with me
  # Check Forum
  # I will put updates here
  # Note: week of Oct 4-8: no assignment
  
}