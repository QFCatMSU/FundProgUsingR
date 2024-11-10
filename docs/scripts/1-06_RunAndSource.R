rm(list=ls());        # clear out the Environment  

### Output a text message
cat("Hello"); 

### Multiple commands on one line
a=3; b=7; cat("a+b=", a+b);
  
### Outputting multiple text messages (\n means go to next line)                    
cat("Hello, World.\n");
cat("How are you?\n");
cat("I am fine?\n");
  
### read in data from  twoWeekWeatherData.csv
weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                       sep=",",
                       header=TRUE);  
  
### same command as above on one line (a little harder to read)
weatherData2 = read.csv(file="data/twoWeekWeatherData.csv", sep=",", header=TRUE);
