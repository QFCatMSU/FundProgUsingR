rm(list=ls());                         # clear the Environment tab
library(package=ggplot2);              # include all GGPlot2 functions

#### Creating three objects to put in a List
someAnimals = c("llama", "guanaco", "alpaca", "goat");  
someNumbers = matrix(nrow=2, ncol=3, seq(from=30, to=4, length.out=6))
weatherData = read.csv(file="data/Lansing2016NOAA.csv");

#### Create a new List with the three objects above 
listAtOnce = list(someAnimals, someNumbers, weatherData);

#### Same List but give a name to each of the objects
listAtOnce2 = list(animals = someAnimals,
                   numbers = someNumbers, 
                   weather = weatherData);

#### Create a new (and empty) List
listDynamic = list();

### Append an object to the List -- this will append each value within the objects as a separate object
listDynamic2  = append(listDynamic, someAnimals);  

### Append an object to the List as a whole object
listDynamic3 = append(listDynamic, list(someAnimals));

### Give a name to the appended object 
listDynamic4 = append(listDynamic, list(animal = someAnimals));

### Add the other two objects to the list with names 
listDynamic5 = append(listDynamic4, list(numbers=someNumbers));
listDynamic5 = append(listDynamic5, list(weather=weatherData));

#### Subsetting a List
anim1 = listDynamic5[["animal"]];
anim2 = listDynamic5$animal;

dewPoint1 = listDynamic5$weather$dewPoint;
dewPoint2 = listDynamic5[["weather"]][["dewPoint"]];
dewPoint3 = listDynamic5[["weather"]]$dewPoint;

#### Subsetting by numeric placement
anim3 = listDynamic5[[1]];
dewPoint4 = listDynamic5[[3]][[7]];

#### Subsetting using [ ] -- this returns a List, which is not very useful:
anim4 = listDynamic5["animal"];

#### A Humidity vs. Temperature plot with linear regression ####
### <have a base-R version of this... but does not work with list below ###
plot1 = ggplot( data=weatherData ) +
  geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
  geom_smooth( mapping=aes(x=avgTemp, y=relHum), 
               method="lm" ) +
  labs( title="Humidity vs Temperature",
        subtitle="Lansing, MI -- 2016",
        x = "Average Temperatures (Fahrenheit)",
        y = "Relative Humidity") +
  scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
  theme_bw() +
  theme( axis.text.x=element_text(angle=90, vjust=0.5) );
plot(plot1);

model1 = lm(formula=weatherData$avgTemp~weatherData$relHum);    

#### Subsetting model1 
intercept = model1$coefficients["(Intercept)"];
first10Residuals = model1$residuals[1:10];
every20thFitted = model1$fitted.values[seq(from=1, to=366, by=20)];

#### Changing values in the plot
plot2 = plot1;

plot2$theme$text$colour = "red";
plot2$labels$x = "Average Temperature (\u00B0F)"; # \u00B0 is Unicode for the degree symbol
plot2$theme$line$linetype = 2;
plot2$theme$line$size = 0.8;
plot(plot2);