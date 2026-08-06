rm(list=ls());                         # clear the Environment tab
library(package=ggplot2);              # include all GGPlot2 functions

#### Creating three objects to put in a List
someAnimals = c("llama", "guanaco", "alpaca", "goat");
someNumbers = matrix(nrow=2, ncol=3, seq(from=30, to=4, length.out=6));
weatherData = read.csv(file="data/Lansing2016NOAA.csv");

#### Reduced the data to make it easier to read in Variables
weatherData_reduced = weatherData[150:169, seq(from=1, to=10, by=2)];

#### Note: the rownames for weatherData_reduces are "150" - "169" (characters)

#### Create a new List with the three objects above 
list1 = list(someAnimals, someNumbers, weatherData_reduced);

#### Same List but give a name to each of the objects
list2 = list(animals = someAnimals,
             numbers = someNumbers, 
             weather = weatherData_reduced);

#### Create a new (and empty) List
list3 = list();

### Create an object named animal and save someAnimals to the List
list3[["animals"]] = someAnimals;  

### Add the other two objects to the list with names 
list3[["numbers"]] = someNumbers;
list3[["weather"]] = weatherData_reduced;

#### To put objects in a list by index:
list4 = list()
list4[[1]] = someAnimals; 
list4[[2]] = someNumbers; 
list4[[3]] = weatherData_reduced; 

#### To automate the numbering of objects in a list
list5 = list()
list5[[length(list5)+1]] = someAnimals; 
list5[[length(list5)+1]] = someNumbers; 
list5[[length(list5)+1]] = weatherData_reduced; 

#### Add random data to a list
set.seed(123);

list6 = list();
for (i in 1:5)
{
  sampleData = sample(1:100, size=10);    # pick 10 random numbers
  list6[[length(list6)+1]] = sampleData;  # at to list in next spot
}

#### Various ways to subset a List using $ and [[  ]], names and index numbers
#    All produce the same results
minTemp1 = list3$weather$dewPoint;
minTemp2 = list3[["weather"]][["minTemp"]];
minTemp3 = list3[["weather"]]$minTemp;
minTemp4 = list3[[3]][[2]];
minTemp5 = list3[[3]]$minTemp;
minTemp6 = list3[["weather"]][[2]];

#### Have to use index number for list5 
animal1 = list5[[1]];                  # 1st level is index only
dewPoint1 = list5[[3]][["dewPoint"]];  # 2nd level, in this case, does have a name 

#### Subsetting using [ ] -- this returns a List, which is not very useful:
animal2 = list5[1];

#### lm() creates a List
model1 = lm(formula=weatherData$avgTemp~weatherData$relHum);    

#### Subsetting model1 
intercept = model1$coefficients["(Intercept)"];
first10Residuals = model1$residuals[1:10];
every20thFitted = model1$fitted.values[seq(from=1, to=366, by=20)];


