rm(list=ls()); 

babyNameData = read.csv(file="data/Popular_Baby_Names.csv");
babyNames = babyNameData$Name;

weatherData = read.csv(file="data/Lansing2016Noaa-3.csv");

### Look for the substring "beth", don't worry if its uppercase/lowercase
has_Beth = grep("beth", babyNameData$Name, ignore.case=TRUE);
has_Liz = grep("liz", babyNameData$Name, ignore.case=TRUE);

beth_name =  babyNameData$Name[has_Beth];
liz_name =  babyNameData$Name[has_Liz];

### Starts with
start_liz = grep("^liz", babyNameData$Name, ignore.case=TRUE);
start_beth = grep("^beth", babyNameData$Name, ignore.case=TRUE);

### Ends with
end_liz = grep("liz$", babyNameData$Name, ignore.case=TRUE);
end_beth = grep("beth$", babyNameData$Name, ignore.case=TRUE);

### Vector with special characters in Regex:
testVector = c("^aaa", "bbb", "ccc", "d^\\d", "e\\ee");

### Testing for the special chracters using escape characters (\\)
has_carrot = grep("\\^", testVector);

### Testing for the backslash (the special character that precedes special characters)
has_backslash = grep("\\\\", testVector);

### Check for one character in many
layla = grep("la[iy]la", babyNameData$Name, ignore.case=TRUE);
layla_names = unique(babyNameData$Name[layla]);

### Do not allow for uppercase/lowercase (ignore.case=FALSE by default)
layla2 = grep("La[iy]la", babyNameData$Name, ignore.case=FALSE);
layla2_names = unique(babyNameData$Name[layla2]);

### Allow for uppercase/lowercase using brackets
layla3 = grep("L[aA][iIyY][lL][aA]", babyNameData$Name, ignore.case=FALSE);
layla3_names = unique(babyNameData$Name[layla3]);

### Check twice for one character in many
layla2 = grep("l[ae][iy]la", babyNameData$Name, ignore.case=TRUE);
layla_name2 = unique(babyNameData$Name[layla2]);   ### act: get rid of Leilani

### Looking through larger groups of characters:
fourVowelStart = grep("^[aeiouy][aeiouy][aeiouy][aeiouy]", babyNameData$Name, ignore.case=TRUE);
fourVowelStart_names = babyNameData$Name[fourVowelStart]

### Another way to say this: use range
fourVowelStart = grep("^[aeiouy]{4}", babyNameData$Name, ignore.case=TRUE);
fourVowelStart_names = babyNameData$Name[fourVowelStart]

### Only uppercase letters
longNames = grep("^[A-Z]{11}$", babyNameData$Name);
cat(c("11 character names:", unique(babyNameData$Name[longNames], "\n")));

### Any letter
longNames2 = grep("^[A-Za-z]{11}$", babyNameData$Name);
cat(c("11 character names (any case):", unique(babyNameData$Name[longNames2]), "\n"));

### App Q: Why do I need to put ^ and $ (check 11 character names or check with smaller names)?
longNames3 = grep("^[A-Z]{9,11}$", babyNameData$Name);
cat(c("9-11 character names:", unique(babyNameData$Name[longNames3]), "\n"));


# Starts and ends with Z, Z (any characters in between)
starts_with_Z = grep("^Z[A-Z]*I", babyNameData$Name);
cat(c(unique(babyNameData$Name[starts_with_Z])), "\n");
  
starts_with_Z2 = grep("^Z.*I", babyNameData$Name);
cat(c(unique(babyNameData$Name[starts_with_Z2])), "\n");


aa = c("mababik", "abksab", "gerpapa", "dadawef");

repeat_group = grep("(.{2})\\1", babyNameData$Name);
be_names = unique(babyNames[repeat_group]);
# lili, vivi, isis, nana, mama
#  Then give others
#  .?  
#  .

# ### Temp departures 
# high_temp_dept = grep("^\\-{0,1}[1-9][0-9]", weatherData$tempDept);
# high_temp_dept2 = grep("^-?[0-9][0-9]", weatherData$tempDept);
# 
# td = weatherData$tempDept
# zero_dot = grep("^{0,1}[0-2].", weatherData$tempDept);
# td[zero_dot]
### Go back to weatherdata and look at numbers


# ####  [...]: Pick one from
# ####  {X, Y}: min, max of preceding 
# ####  (...): grouping (only makes sense with min/max (for this lesson)
# ### Names are both in all caps and mixed...
# test1 = grep("J[oO][hH][nN]", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# ### Karen and Caryn
# 
# test1 = grep("^Liz$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# 
# test1 = grep("beth$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# 
# # Miriam and Maryam
# test1 = grep("mary", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# 
# # Anything starting with Aaron vs aron
# test1 = grep("^(a){1,2}ron", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# test1 = grep("^(a){0,2}ron", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# test1 = grep("^(a){2,2}ron", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# test1 = grep("^[abcde]{4,4}", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# test1 = grep("^[a-e]{4,4}", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# 
# 
# 
# ### But, this would also include names that start with numbers or symbols
# test1 = grep("^[^f-z]{4}", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# test1 = grep("^.{11}$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# test1 = grep("^A.{8,9}$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# test1 = grep("(al){2}$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# 
# print(babyNameData$Child.s.First.Name[test1])
# 
# 
# testString = c("llama", "alpaca", "some^thing", "some$thing");
# test1 = grep("[\\$\\^]", testString);
# 
# testString = c("ababab", "abbbbbb", "abab", "abababab", "abababababababababab");
# test1 = grep("(ab){4}", testString);
# test1 = grep("ab{4}", testString);
# print(testString[test1])
# 
# testString = c("llama10", "llama9", "llamaZ", "llama");
# test1 = grep("[0-9]{2}", testString);
# 
# #### hard way to exclude values!
# test2 = grep("^[^aeiou]*$", babyNameData$Child.s.First.Name, ignore.case=TRUE);  # values that have the substring "John"
# print(babyNameData$Child.s.First.Name[test2])
# ###
# 
# 
# # # from last lesson -- use which to find high precip values
# # highPrecip = which(weatherData$precipNum > 1);
# # 
# # 
# # snowyDays = which(weatherData$weatherType == "SN");
# # 
# # snowyDayTemps = weatherData$avgTemp[snowyDays];
# # snowyDayWinds = weatherData$windSpeed[snowyDays];
# # 
# # rainOrSnow = which(weatherData$weatherType == "SN" |
# #                      weatherData$weatherType == "RA");
# # 
# # noRainNorSnow = which(!(weatherData$weatherType == "SN" |
# #                           weatherData$weatherType == "RA"));
# # 
# # noRainNorSnow2 = which(weatherData$weatherType != "SN" &
# #                          weatherData$weatherType != "RA");
# # 
# # noRainNorSnow_bad = which(weatherData$weatherType != "SN" |
# #                             weatherData$weatherType != "RA");
# # 
# # rainAndHighTemps = which(weatherData$weatherType == "RA" &
# #                            weatherData$avgTemp >= 70);
# # 
# # complexCond = which( (weatherData$weatherType == "RA" | 
# #                         weatherData$weatherType == "SN") &
# #                        (weatherData$avgTemp >= 25 &
# #                           weatherData$avgTemp <= 40) );
# # 
# # 
# # snowyDaysGrep = grep(weatherData$weatherType, pattern="SN");
# # 
# # ### Testing grep() out
# # grepTestVec = c("one fish", "two fish", "one llama", "two llama",
# #                 "red fish", "blue fish");
# # 
# # test1 = grep("two", grepTestVec);  # values that have the substring "two"
# # test2 = grep("lla", grepTestVec);  # values that have the substring "lla"
# # test3 = grep("fish", grepTestVec); # values that have the substring "fish"
# # 
# # snowDaysGrepTemp = weatherData$avgTemp[snowyDaysGrep];
# # snowDaysGrepWind = weatherData$windSpeed[snowyDaysGrep];
# # 
# # daysWithPrecipGrep = grep(weatherData$weatherType, pattern="RA|SN");
# # 
# # rainyDaysGrep = grep(weatherData$weatherType, pattern="RA");
# # snowyDaysGrep = grep(weatherData$weatherType, pattern="SN");
# # daysWithPrecipUnion = union(rainyDaysGrep, snowyDaysGrep);
# # 
# # hazyDays = grep(weatherData$weatherType, pattern="RA");
# # hotDays = which(weatherData$maxTemp > 90);
# # hazyOrHotDays = union(hazyDays, hotDays);
# # 
# # # daysWithRainAndSnow = grep("RN&SN", weatherData$weatherType);  # this does not work!
# # daysWithRainAndSnow = intersect(rainyDaysGrep, snowyDaysGrep);
# # 
# # meetsCondition = c(3,5,6,9);
# # invertCondition = setdiff(1:10, meetsCondition);
# # 
# # daysWithoutPrecip = setdiff(1:366, daysWithPrecipGrep);