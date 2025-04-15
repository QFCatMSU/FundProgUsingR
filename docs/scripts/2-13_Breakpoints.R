{ 
  rm(list=ls());  options(show.error.locations = TRUE);
  source("scripts/debugTest.r");

  weatherData = read.csv(file = "data/lansing2016Noaa-3.csv");
  highTemps = weatherData$maxTemp;
  lowTemps = weatherData$minTemp;
  
  diffTemp = highTemps - lowTemps;
  
  weatherData$diffTemp = diffTemp;
  
  highDiff = which(diffTemp > 30);
  
  sunsetTimes = weatherData$sunset;
  sunriseTimes = weatherData$sunrise;
  
  sunsetTimes_12Hour = c();
  sunriseTimes_12Hour = c();
  
  testCommand1=1; testCommand2=2; testCommand3=3;
  
  for(i in 1:length(sunsetTimes))
  {
    sunsetTimes_12Hour[i] = convertTime(sunsetTimes[i]);
    sunriseTimes_12Hour[i] = convertTime(sunriseTimes[i]);
    
    if(i == 200)  # acts as conditional breakpoint
    {
      NULL;   # this line functionally does nothing
    }
    if(sunsetTimes[i] == 2000)
    {
      NULL;
    }
  }
  
  # First check the conditional statements...
  if(testCommand3 == 1)       # FALSE
  {
    cat(1); 
  }
  else if(testCommand3 == 2)  # FALSE
  {
    cat(2);
  }
  else if(testCommand3 == 3)  # TRUE
  {
    cat(3);                   # only codeblock executed
  }
  else if(testCommand3 == 4)  # FALSE, will not be checked
  {
    cat(4);
  }
  else   
  {
    cat(5); 
  }
  
  library(package=ggplot2);
  plot1 = ggplot( data=weatherData ) +
    geom_point( mapping=aes(x=avgTemp, y=relHum) ) +
    geom_smooth( mapping=aes(x=avgTemp, y=relHum), 
                 method="lm" ) +
    labs( title="Humidity vs Temperature",
          subtitle="Lansing, MI -- 2016",
          xlab = "Average Temperatures (Fahrenheit)",
          y = "Relative Humidity") +
    scale_x_continuous( breaks = seq(from=10, to=80, by=10) ) +
    theme_bw() +
    theme( axis.text.x=element_text(angle=90, vjust=0.5) );
  plot(plot1);
}

