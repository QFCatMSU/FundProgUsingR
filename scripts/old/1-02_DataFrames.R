{ # all scripts will start and end with a curly bracket
  rm(list=ls());                        # Clean the Environment tab
  options(show.error.locations = TRUE); # Show line # on errors
  
  # read in the data from the file LansingNOAA2016.csv and save
  # it to the variable named weatherData
  weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  # weatherData2 will be equivalent to weatherData if you are using R version 4
  weatherData2 = read.csv(file = "data/LansingNOAA2016.csv");
  
  # weatherData3 is how weatherData2 looks for people using R version 3 
  # Uncomment the next two lines, execute, and expand in the Environment to
  # see the difference -- we will talk more about this in future lessons.
  # weatherData3 = read.csv(file = "data/LansingNOAA2016.csv",
  #                         stringsAsFactors = TRUE);
  
  # Pull out the maxTemp column from weatherData and save it to a 
  # variable named highTemps
  highTemps = weatherData$maxTemp;
  
  # Three different ways to get the 137th value from highTemps 
  highTempDay137a = highTemps[137];
  highTempDay137b = weatherData$maxTemp[137];
  highTempDay137c = weatherData[137, "maxTemp"];
  
  # grabbing indivudal values from the highTemps vector
  val25 = highTemps[25];
  val158 = highTemps[158];
  val273 = highTemps[273];
  
  # getting all the values at once using c()
  valComb = highTemps[c(25,158,273)];
  
  # Getting consecutive values (131 throuugh 147) from the highTemps vector
  consecVals = highTemps[131:147];
  
  # Getting the consecutive value in reverse
  consecValsRev = highTemps[147:131];
  
  # Get every other value (by=2) from highTemps between 131 and 147
  seq1 = highTemps[seq(from=131, to=147, by=2)];
  
  # Get every other value in reverse
  seq2 = highTemps[seq(from=147, to=131, by=-2)];
  
  # Get every seventh value from the highTemps
  seq3 = highTemps[seq(from=1, to=366, by=7)];
  
}   # matches curly bracket on first line