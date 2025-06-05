rm(list=ls());        # clear out the Environment  

# create 5 separate variables for 5 temperature values
tempHigh1 = 65;
tempHigh2 = 57;
tempHigh3 = 61;
tempHigh4 = 64;
tempHigh5 = 59;

# find the average of the 5 temperatures:
tempAvg = (tempHigh1 + tempHigh2 + tempHigh3 +
           tempHigh4 + tempHigh5) / 5;

# create one temperature vector with 5 values:
tempHigh = c(65, 57, 61, 64, 59);

# Convert all the values from Fahrenheit to Celsius:
tempHighCel = (5/9) * (tempHigh - 32);  
  
# Find the mean of the the vector of temperature values:
tempMean = mean(tempHigh);

# create a low temperature vector
tempLow = c(45, 40, 55, 37, 42);

# find the difference between the high and low temperatures:
tempDiff = tempHigh - tempLow;

# find the difference between individual high and low temperatures:
tempDiff_3 = tempHigh[3] - tempLow[3];
tempDiff_5 = tempHigh[5] - tempLow[5];


# Get the data from the twoWeekWeatherData CSV file
weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                       sep=",",
                       header=TRUE);  

# Extract the highTemps column from the data frame -- save it to a variable
highTemps = weatherData$highTemp;

# Three different ways to get the high temperature from the 7th day (April 2)
highTempDay7a = highTemps[7];
highTempDay7b = weatherData$highTemp[7];
highTempDay7c = weatherData[7, "highTemp"];  # think of this as [X,Y] notation

# Get 3 values from highTemp individually and all at once 
val_01 = highTemps[1];
val_05 = highTemps[5];
val_12 = highTemps[12];
valComb = highTemps[c(1,5,12)];  

# Use the sequence operator to get consecutive values
consecVals = highTemps[3:11];    # same as highTemps[c(3,4,5,6,7,8,9,10,11)]
consecValsRev = highTemps[11:3]; # in reverse

# Create a vector with sequenced numbers 
seq1 = seq(from=1, to=14, by=2);   # 1,3,5,7,9,11,13
seq2 = seq(from=14, to=1, by=-2);  # 14,12,10,8,6,4,2
seq3 = seq(from=1, to=10, by=3);   # 1,4,7,10

# Use the sequenced indexes to subset the highTemps
highTempSeq1 = highTemps[seq1];   # values 1,3,5,7,9,11,13
highTempSeq2 = highTemps[seq2];   # values 14,12,10,8,6,4,2
highTempSeq3 = highTemps[seq3];   # values 1,4,7,10

# You could combine the two previous steps into 1 step:
highTempSeq1b = highTemps[seq(from=1, to=14, by=2)];  
highTempSeq2b = highTemps[seq(from=14, to=1, by=-2)];  
highTempSeq3b = highTemps[seq(from=1, to=10, by=3)];