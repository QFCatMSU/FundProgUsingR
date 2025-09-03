{
  rm(list=ls()); 
  options(show.error.locations = TRUE);  

  weatherData = read.csv(file="data/Lansing2016NOAA-3.csv");
  
  ### Testing grep() out
  grepTestVec = c("one fish", "two fish", "one llama", "two llama",
                  "red fish", "blue fish");
  
  test1 = grep("two", grepTestVec);  # values that have the substring "two"
  test2 = grep("lla", grepTestVec);  # values that have the substring "lla"
  test3 = grep("fish", grepTestVec); # values that have the substring "fish"

  ### Only SN days:
  SN_only = grep(weatherData$weatherType, pattern="[,]{0,1}SN")
  SN_only2 = grep(weatherData$weatherType, pattern="(^a-zA-Z)SN")
  
  
  ### Testing NOT :
  notTest = c("a1", "a2", "a3",
              "1a", "2a", "3a",
              "1 a", "2 a", "3 a",
              "1$a", "2^a", "3!a")
  grep(notTest, pattern="^3")   # starts with 3
  grep(notTest, pattern="3$")   # ends with 3
  grep(notTest, pattern="^[(a2)]") # starts with a or 2
  grep(notTest, pattern="^[a2]") # starts with a or 2
  grep(notTest, pattern="^(a2)") # starts with a2
  grep(notTest, pattern="^a2") # starts with a2

  sub(notTest, pattern="a$", replacement="z")  # replace final a with z
  sub(notTest, pattern=".", replacement="z")   # replace first character with z
  gsub(notTest, pattern=".", replacement="z")  # replace all characters with z
  
  grep(notTest, pattern=" ")   # has a space
  grep(notTest, pattern="\\^")   # escape chars
  
  grep(notTest, pattern="[1|2][ |$|^]") # starts with a or 2
  
  
  test2 = c("a1rr", "a2rr", "a3ss",
            "1agg", "2asdfjgg", "3add",
            "1 abb", "2 cww", "3 udd",
            "1$htt", "2^urr", "3!ama1rm")
  
  grep(test2, pattern="([1-9][[:punct:]| ][a|u])")   # don't need |
  grep(test2, pattern="[[:space:]]")   # has a space
  grep(test2, pattern="[h!j][tcks]")   # 
  grep(test2, pattern="(.a)|(gg)")   # .a or gg
  grep(test2, pattern="(.a)(gg)")   # .a followed immediately by gg
  
  
  grep(test2, pattern="[^1]a")   # has "a" not preceded by "1"
  grep(test2, pattern="[^1-4]a") # has "a" not preceded by "1-4"
  grep(test2, pattern="(^1)a")   # starts with "1a"
  
  grep(test2, pattern="[^a][^1][^r]")   # fails a2rr
  
  # anything more complex requires a lookaround
  # groups
  
  # frequency
  
  ### Using grep() on the dataframe to find snowy days
  snowyDaysGrep = grep(weatherData$weatherType, pattern="SN");
  
  snowDaysGrepTemp = weatherData$avgTemp[snowyDaysGrep];
  snowDaysGrepWind = weatherData$windSpeed[snowyDaysGrep];
  
  daysWithPrecipGrep = grep(weatherData$weatherType, pattern="RA|SN");
  
  rainyDaysGrep = grep(weatherData$weatherType, pattern="RA");
  snowyDaysGrep = grep(weatherData$weatherType, pattern="SN");
  daysWithPrecipUnion = union(rainyDaysGrep, snowyDaysGrep);
  
  hazyDays = grep(weatherData$weatherType, pattern="RA");
  hotDays = which(weatherData$maxTemp > 90);
  hazyOrHotDays = union(hazyDays, hotDays);
  
  # daysWithRainAndSnow = grep("RN&SN", weatherData$weatherType);  # this does not work!
  daysWithRainAndSnow = intersect(rainyDaysGrep, snowyDaysGrep);
  
  meetsCondition = c(3,5,6,9);
  invertCondition = setdiff(1:10, meetsCondition);
  
  daysWithoutPrecip = setdiff(1:366, daysWithPrecipGrep);
  
}