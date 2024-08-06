{
  rm(list=ls());  options(show.error.locations = TRUE);

  weatherData = read.csv(file = "data/lansing2016Noaa-3.csv");
  maxTemps = weatherData$maxTemp;
  
  # give the order of temp -- this is giving you an index vector of the temperatures
  #   from lowest to highest
  maxTempsOrdered = order(maxTemps);  
  
  # We can then use the index vector to give the temperatures values from low to high
  maxTempsArranged = maxTemps[maxTempsOrdered];   
  
  # Or, rearrange the whole dang data frame so temperatures goes from low to high and 
  #  every other column follows.
  weatherDataArranged = weatherData[maxTempsOrdered, ];

  # The shortcut is:
  weatherDataArranged2 = weatherData[order(maxTemps), ];
  
}

