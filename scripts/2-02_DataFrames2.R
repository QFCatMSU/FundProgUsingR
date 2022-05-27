{
  # first do plotting lesson??
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  ### First let's read in the bad csv file:
  badData = read.csv(file="data/Lansing2016Noaa-2-bad.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);
  
  ### Now let's read to good data frame
  weatherData = read.csv(file="data/Lansing2016Noaa-2.csv",
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);
  
  # Make a copy of the data frame
  weatherData2 = weatherData;

  ### Let's put the 
  precip = weatherData$precip;
  
  # typeof(precip) in Console [1] "character"
  
  ### Create a numeric version of precip -- NA induced by coercion
  precip2 = as.numeric(precip);

  # typeof(precip) in Console [1] "double" (explain this)
  
  ### Still
 # max(), min()
  meanPrecip = mean(precip2);
  
  ## One way to fix:
  meanPrecip2 = mean(precip2, na.rm = TRUE);
  
  ## Another way: remove the NAs
  precip3 = na.omit(precip2);
  
  # But, it might be better to assign values to NA, otherwise NA days are excluded
  

  ## Go through eve
  for(i in 1:length(precip3))
  { # is the value NA - note: if(precip[3] == NA) does not work
    if(is.na(precip3[i]))   
    {
      precip3[i] = 0.005;
    }
  }

  # Mean will be a bit lower because of the multiple NA days
  meanPrecip3 = mean(precip3);
  
  weatherData$precipNum = precip3;
  
  ## remove precip column?
  
  ## Do some plotting here...
  ## Could start the which lesson here...
  ## Or, do sampling
  which(precip3 %in% 0.005)
  
  write.csv(weatherData, file="data/Lansing2016Noaa-3.csv",
            row.names = FALSE);
}