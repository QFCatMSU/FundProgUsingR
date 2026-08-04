rm(list=ls());                         # clear the Environment tab
library(package=ggplot2);              # include all GGPlot2 functions

#### Creating three objects to put in a List
someAnimals = c("llama", "guanaco", "alpaca", "goat");
someNumbers = matrix(nrow=2, ncol=3, seq(from=30, to=4, length.out=6));
weatherData = read.csv(file="data/Lansing2016NOAA.csv");

#### Create a new List with the three objects above 
list1 = list(someAnimals, someNumbers, weatherData);

#### Same List but give a name to each of the objects
list2 = list(animals = someAnimals,
             numbers = someNumbers, 
             weather = weatherData);

#### Create a new (and empty) List
list3 = list();

### Create an object named animal and save someAnimals to the List
list3[["animals"]] = someAnimals;  

### Add the other two objects to the list with names 
list3[["numbers"]] = someNumbers;
list3[["weather"]] = weatherData;

#### To put objects in a list by index:
list4 = list()
list4[[1]] = someAnimals; 
list4[[2]] = someNumbers; 
list4[[3]] = weatherData; 

#### To automate the numbering of objects in a list
list5 = list()
list5[[length(list5)+1]] = someAnimals; 
list5[[length(list5)+1]] = someNumbers; 
list5[[length(list5)+1]] = weatherData; 

#### Add random data to a list
set.seed(123);

list6 = list();
for (i in 1:5)
{
  sampleData = sample(1:100, size=10);    # pick 10 random numbers
  list6[[length(list6)+1]] = sampleData;  # at to list in next spot
}

#### Subsetting a List
anim1 = list5[["animal"]];
anim2 = list5$animal;

dewPoint1 = list5$weather$dewPoint;
dewPoint2 = list5[["weather"]][["dewPoint"]];
dewPoint3 = list5[["weather"]]$dewPoint;

#### Subsetting by numeric placement
anim3 = list5[[1]];
dewPoint4 = list5[[3]][[7]];

#### Subsetting using [ ] -- this returns a List, which is not very useful:
anim4 = list5["animal"];

#### lm() creates a List
model1 = lm(formula=weatherData$avgTemp~weatherData$relHum);    

#### Subsetting model1 
intercept = model1$coefficients["(Intercept)"];
first10Residuals = model1$residuals[1:10];
every20thFitted = model1$fitted.values[seq(from=1, to=366, by=20)];


