{
  rm(list=ls());                         # clear the Environment tab
  options(show.error.locations = TRUE);  # show line numbers on error
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
  print(summary(model1));
  
  
  avgTemp_SB = weatherData["avgTemp"];
  avgTemp_DO = weatherData[,"avgTemp"];
  avgTemp_DB = weatherData[["avgTemp"]];
  avgTemp_DS = weatherData$avgTemp;
  
  avgTemp2_DO = weatherData[1:10,"avgTemp"];
  avgTemp2_DB = weatherData[["avgTemp"]][1:10];
  avgTemp2_DS = weatherData$avgTemp[1:10];
  
  #### Part 1: Humidity vs. Temperature with linear regression ####
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

  #### Part 2: Dewpoint vs. Temperature with linear regression ####
  plot2 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=dewPoint) ) +
    geom_smooth( mapping=aes(x=avgTemp, y=dewPoint), 
                 method="lm" ) +
    labs( title="Dewpoint vs Temperature",
          subtitle="Lansing, MI -- 2016",
          x = "Average Temperatures (Fahrenheit)",
          y = "Dewpoint") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) );
  plot(plot2);
  
  
  model1 = lm(formula=weatherData$avgTemp~weatherData$relHum);    
  model2 = lm(formula=weatherData$relHum~weatherData$dewPoint);    
  
  print(summary(model1));
  print(summary(model2));
  
  names(model1);  # yeah, the names are the names...
  names(weatherData);
  class(model1);
  class(weatherData);
  dim(model1);
  dim(weatherData);
  
  ### Use either $ (named objects) or [[ ]] (named or unamed) to subset Lists
  
  ### Subsetting object (help in RStudio Viewer)
  ### all three methods (and when you cannot use the $)
  
  ### The attributes...
  # Add attribute to the data frame and a column and a value (latter will not work)
  
  
  ### Environments in plots
  
  
  ### Cannot give names to column values...
}
  
