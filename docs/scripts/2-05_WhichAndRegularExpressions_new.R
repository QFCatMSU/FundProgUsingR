rm(list=ls()); 

weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");

# from last lesson -- use which to find high precip values
highPrecip = which(weatherData$precipNum > 1);


snowyDays = which(weatherData$weatherType == "SN");

snowyDayTemps = weatherData$avgTemp[snowyDays];
snowyDayWinds = weatherData$windSpeed[snowyDays];

rainOrSnow = which(weatherData$weatherType == "SN" |
                   weatherData$weatherType == "RA");

noRainNorSnow = which(!(weatherData$weatherType == "SN" |
                        weatherData$weatherType == "RA"));

noRainNorSnow2 = which(weatherData$weatherType != "SN" &
                       weatherData$weatherType != "RA");

noRainNorSnow_bad = which(weatherData$weatherType != "SN" |
                          weatherData$weatherType != "RA");

rainAndHighTemps = which(weatherData$weatherType == "RA" &
                         weatherData$avgTemp >= 70);

complexCond = which( (weatherData$weatherType == "RA" | 
                      weatherData$weatherType == "SN") &
                     (weatherData$avgTemp >= 25 &
                      weatherData$avgTemp <= 40) );

### Testing grep() out
grepTestVec = c("one fish", "two fish", "one llama", "two llama",
                "red fish", "blue fish");

test1 = grep(x=grepTestVec, pattern="two");  # values that have the substring "two"
test2 = grep(x=grepTestVec, pattern="lla");  # values that have the substring "lla"
test3 = grep(x=grepTestVec, pattern="fish"); # values that have the substring "fish"

### Using grep() on the dataframe to find snowy days
snowyDaysGrep = grep(x=weatherData$weatherType, pattern="SN");

snowDaysGrepTemp = weatherData$avgTemp[snowyDaysGrep];
snowDaysGrepWind = weatherData$windSpeed[snowyDaysGrep];

daysWithPrecipGrep = grep(x=weatherData$weatherType, pattern="RA|SN");

rainyDaysGrep = grep(x=weatherData$weatherType, pattern="RA");
snowyDaysGrep = grep(x=weatherData$weatherType, pattern="SN");
daysWithPrecipUnion = union(rainyDaysGrep, snowyDaysGrep);

hazyDays = grep(x=weatherData$weatherType, pattern="HZ");
hotDays = which(weatherData$maxTemp > 85);
hazyOrHotDays = union(hazyDays, hotDays);

## the and operator does not work in grep()
# daysWithRainAndSnow = grep("RN&SN", weatherData$weatherType);  # this does not work!
daysWithRainAndSnow = intersect(rainyDaysGrep, snowyDaysGrep);

meetsCondition = c(3,5,6,9);
invertCondition = setdiff(1:10, meetsCondition);

daysWithoutPrecip = setdiff(1:366, daysWithPrecipGrep);