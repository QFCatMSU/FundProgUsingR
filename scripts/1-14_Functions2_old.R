{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  source(file="scripts/toolbox.r");  # load script with isDivisible() function
  
  ## from last lesson
  div12_4 = isDivisible(12,4);
  div12_5 = isDivisible(12,5);
  
  # better to put in parameter names:
  div12_4a = isDivisible(div1=12, div2=4);
  div12_5a = isDivisible(div1=12, div2=5);
  
  # the order does not matter when you use parameter names:
  div12_4b = isDivisible(div2=4, div1=12);
  div12_5b = isDivisible(div2=5, div1=12);
  
  ### Get the weather data
  weatherData = read.csv("data/twoWeekWeatherData.csv");
  highTemps = weatherData$highTemp;
  lowTemps = weatherData$lowTemp;
  
  ### Calling counter()
  count1 = counter(vector = highTemps, compareVal = 45);
  count2 = counter(vector = highTemps, compareVal = 55);
  count3 = counter(lowTemps, 40);
  
  ### Calling counter2()
  count1a = counter2(vector = highTemps, compareVal = 45);
  count2a = counter2(vector = highTemps, compareVal = 55);
  count3a = counter2(lowTemps, 40);
  
  count4 = counter2(vector = lowTemps, compareVal = 40, conditionalOp = "<");
  count5 = counter2(vector = highTemps, compareVal = 54, conditionalOp = "==");
  count6 = counter2(lowTemps, 38, "==");
  count7 = counter2(highTemps, 60, ">");
}