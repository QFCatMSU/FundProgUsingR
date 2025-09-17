rm(list=ls()); 

babyNameData = read.csv(file="data/Popular_Baby_Names.csv");



####  [...]: Pick one from
####  {X, Y}: min, max of preceding 
####  (...): grouping (only makes sense with min/max (for this lesson)
### Names are both in all caps and mixed...
test1 = grep("J[oO][hH][nN]", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
### Karen and Caryn

test1 = grep("^Liz$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"

test1 = grep("beth$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"

# Miriam and Maryam
test1 = grep("mary", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"

# Anything starting with Aaron vs aron
test1 = grep("^(a){1,2}ron", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
test1 = grep("^(a){0,2}ron", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
test1 = grep("^(a){2,2}ron", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
test1 = grep("^[abcde]{4,4}", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
test1 = grep("^[a-e]{4,4}", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"



### But, this would also include names that start with numbers or symbols
test1 = grep("^[^f-z]{4}", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
test1 = grep("^.{11}$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
test1 = grep("^A.{8,9}$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
test1 = grep("(al){2}$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"

print(babyNameData$Child.s.First.Name[test1])


testString = c("llama", "alpaca", "some^thing", "some$thing");
test1 = grep("[\\$\\^]", testString);

testString = c("ababab", "abbbbbb", "abab", "abababab", "abababababababababab");
test1 = grep("(ab){4}", testString);
test1 = grep("ab{4}", testString);
print(testString[test1])

testString = c("llama10", "llama9", "llamaZ", "llama");
test1 = grep("[0-9]{2}", testString);

#### hard way to exclude values!
test2 = grep("^[^aeiou]*$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
print(babyNameData$Child.s.First.Name[test2])
###


# # from last lesson -- use which to find high precip values
# highPrecip = which(weatherData$precipNum > 1);
# 
# 
# snowyDays = which(weatherData$weatherType == "SN");
# 
# snowyDayTemps = weatherData$avgTemp[snowyDays];
# snowyDayWinds = weatherData$windSpeed[snowyDays];
# 
# rainOrSnow = which(weatherData$weatherType == "SN" |
#                      weatherData$weatherType == "RA");
# 
# noRainNorSnow = which(!(weatherData$weatherType == "SN" |
#                           weatherData$weatherType == "RA"));
# 
# noRainNorSnow2 = which(weatherData$weatherType != "SN" &
#                          weatherData$weatherType != "RA");
# 
# noRainNorSnow_bad = which(weatherData$weatherType != "SN" |
#                             weatherData$weatherType != "RA");
# 
# rainAndHighTemps = which(weatherData$weatherType == "RA" &
#                            weatherData$avgTemp >= 70);
# 
# complexCond = which( (weatherData$weatherType == "RA" | 
#                         weatherData$weatherType == "SN") &
#                        (weatherData$avgTemp >= 25 &
#                           weatherData$avgTemp <= 40) );
# 
# 
# snowyDaysGrep = grep(weatherData$weatherType, pattern="SN");
# 
# ### Testing grep() out
# grepTestVec = c("one fish", "two fish", "one llama", "two llama",
#                 "red fish", "blue fish");
# 
# test1 = grep("two", grepTestVec);  # values that have the substring "two"
# test2 = grep("lla", grepTestVec);  # values that have the substring "lla"
# test3 = grep("fish", grepTestVec); # values that have the substring "fish"
# 
# snowDaysGrepTemp = weatherData$avgTemp[snowyDaysGrep];
# snowDaysGrepWind = weatherData$windSpeed[snowyDaysGrep];
# 
# daysWithPrecipGrep = grep(weatherData$weatherType, pattern="RA|SN");
# 
# rainyDaysGrep = grep(weatherData$weatherType, pattern="RA");
# snowyDaysGrep = grep(weatherData$weatherType, pattern="SN");
# daysWithPrecipUnion = union(rainyDaysGrep, snowyDaysGrep);
# 
# hazyDays = grep(weatherData$weatherType, pattern="RA");
# hotDays = which(weatherData$maxTemp > 90);
# hazyOrHotDays = union(hazyDays, hotDays);
# 
# # daysWithRainAndSnow = grep("RN&SN", weatherData$weatherType);  # this does not work!
# daysWithRainAndSnow = intersect(rainyDaysGrep, snowyDaysGrep);
# 
# meetsCondition = c(3,5,6,9);
# invertCondition = setdiff(1:10, meetsCondition);
# 
# daysWithoutPrecip = setdiff(1:366, daysWithPrecipGrep);