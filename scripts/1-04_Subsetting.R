{
  # all scripts for this class will contain the following 2 lines
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  weatherData = read.csv(file="data/LansingNOAA2016b.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  # mention R v3 vs 4
  
  # use sunrise and sunset times....
  
  # ways to sequence the data
  
  
  # ways to substring the data
  sunset = weatherData$sunset;
 # sunset2 = sunset[1];
  sunsetStr = as.character(sunset);
  hour = substr(sunsetStr, start=1, stop=2);
  partialHour = substr(sunsetStr, start=3, stop=4);
  
  hour = as.numeric(hour);
  partialHour = as.numeric(partialHour)/60;
  complete = hour + partialHour;
  
  
  # a second way... show round(), floor(), top()
  hour2 = floor(sunset/100);
  partialHour2 = (sunset/100 - hour2) / 60 * 100;  # there could be an order of ops issue here: 60*100 = 60000
  
 # Do we have a way to do more complex math??? Yes, 
  
  
  
  ### Sequences:
  sunset200_250 = sunset[200:250];
  sunset200_250Rev = sunset[250:200];
  
  
  sunsetEvery10 = sunset[seq(from = 1, to=366, by = 10)];
  sunsetEvery10b = sunset[seq(from=1, to=length(sunset), by = 10)];
  
  #works as long as you maintain correct order!  But, I recommend you use param names
  sunsetEvery10c = sunset[seq(1, length(sunset), 10)];
  
  # and in reverse:
  sunsetEvery10cRev = sunset[seq(to=1, from=length(sunset), -10)];
}