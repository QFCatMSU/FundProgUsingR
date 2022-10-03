{
  rm(list=ls());  options(show.error.locations = TRUE);
  debugSource("scripts/debugTest.r");

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
    
    if(i == 200)
    {
      NULL; 
    }
    if(sunsetTimes[i] == 2000)
    {
      NULL; 
    }
  }
  

  if(testCommand3 == 1)
  {
    cat(1); 
  }
  else if(testCommand3 == 2)
  {
    cat(2);
  }
  else if(testCommand3 == 3)
  {
    cat(3);
  }
  else if(testCommand3 == 4)  
  {
    cat(4);
  }
  else
  {
    cat(5); 
  }

  # Red dots: breakpoints that you set
  # Green arrow: in debug, it is the command you are about to execute
  # Debug controls:
  #    Next: go to next command
  #    Continue: go to next breakpoint (or end of script)
  #    Stop: force end the script
  #    Step Into: go to the function (if there is one) 
  #       - only "Steps" into functions that you have created (not packages)
  #    Step Out: completes the function you are in
  #       - Step Out acts like Continue if you are in the main script
  
  #### To do:
  #    1) Put breakpoint on line 28, demo Next, Continue, Stop
  #    2) Put breakpoint in for loops, demo Next, Continue, Stop, Step Into
  #    3) Put in both breakpoints, demo Continue, Step Out
  #    4) Demo breaking a for loop at a specific iteration.
  
}

