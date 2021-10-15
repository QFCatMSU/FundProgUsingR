{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console

  ### read in data from  twoWeekWeatherData.csv
  weatherData = read.csv(file="data/twoWeekWeatherData.csv", 
                         sep=",",
                         header=TRUE, 
                         stringsAsFactors = FALSE);  
  
  ### Extract the highTemps column from the data frame -- save it to a variable
  highTemps = weatherData$highTemp;
  noonCond = weatherData$noonCondition;
  
  # Note: In RStudio, putting at least 4 number signs on the right side 
  #       of a comment will place the line in a dropdown menu, allowing
  #       you to directly access the line.  This is very useful as
  #       code gets longer...
  
  #### Unicode #### 
  unicode = "\u424 \u18e \u2230 \u23f0 \u2615";
  cat(sep="~", unicode, file="a.txt");     # Does not work
  writeLines(unicode, con = "b.txt", 
             sep = "\n", useBytes = TRUE); # Works

  #### Shortcuts ####
  highTempMax = max(highTemps);
  highTempMeans = mean(highTemps);
  highTempSD = sd(highTemps);
  
  highTempsGT55 = which(highTemps > 55);
  highTempsLength = length(highTempsGT55);
  
  #### Activity 1: issues with if-else statements in R ####
  
  #### Issue 1: Conditions on an else ####
  # problem: else statements do not have conditions attached
  #          but, R, unlike other languages, does not give a warning
  #          of an error when you attach a condition to else
  
  # runif: pick a random decimal number between min and max
  # note: runif() stands for Random UNIForm distibution (not run if)
  randomNum = runif(n=1, min=0, max=10);  
  
  if(randomNum > 6)
  {
    cat("That's a high score\n");
  }
  else if(randomNum > 3)
  {
    cat("That's an OK score\n");
  }
  else(randomNum <= 3)
  {
    cat("Ooof, that's no good!\n"); 
  }
  
  ## Issue 1 to-do:
  #  a) Explain what is happening in this code.
  #  b) Give two ways to fix this code.
  #  c) Add error for negative numbers and numbers > 10 
  #     and test (i.e., change the runif() )
  
  #### Issue 2: codeblock not needed for a single command  ####
  # problem: if you are only executing one command on an if(), else if()
  #          or else, then you do not need curly brackets.  You will
  #          often see this done but there are issues.
  
  randomTemp = runif(n=1, min=20, max=80);
  
  # This code works but is very easy to mess up!
  if(randomTemp > 50) 
    cat("That's nice\n")
  else
    cat("That's cold\n")
  
  ## Issue 2 to-do: For each part, explain what happens
  #  a) Add semicolons to the end of the 1st cat(). 
  #  b) Remove semicolon from 1st cat(). Add semicolon to second cat()
  #  c) Remove semicolon from 2nd cat(). Add second command to the if().  
  #  d) Remove second command from if(). Add second command to the else.  

  #### Issue 3: If-else statements in R have inconsistent spacing requirements ####
  # problem: If-else statement will behave differently depending upon how
  #          the else is placed and  
  
  randomCond = sample(c("Sun", "Rain", "Clouds"), size=1);

#{  # this places the if-else below in a codeblock
  if(randomCond == "Sun")
  {
    cat("Nice day out\n"); 
  } else if(randomCond == "Rain")
  {
    cat("Not so nice\n"); 
  } else if(randomCond == "Clouds")
  {
    cat("Not bad\n"); 
  }
#}
  
  ## Issue 3 to-do:
  #  a) Move the else-if to the next line and try Source and Run
  #  b) Comment out the { on line 1 and the } on the last line and
  #     try Source and Run on the code
  #  c) Uncomment lines 89 and 100, Run lines 889-100 
  
  #### Activity 2: ####
  ## To-do:
  #  a) Create an embedded if-else structure (if-else within if-else) that
  #     outputs something different for these 6 situations (note: order 
  #     does not matter!):
  #     1) Sunny, less than 55
  #     2) Sunny, more than or equal to 55
  #     3) Rain, more than or equal to 55
  #     4) Rain, less than 55
  #     5) Cloudy, more than or equal to 55
  #     6) Cloudy, less than 55
  #  b) Redo the embedded if-else reversing the inner and outer if-else
  #  c) For part (b), add an error statement to the weather condition
  #  d) For part (b), add an error  statement to the temperature 
  #  e) Redo with && operators

  #### Add error to highTemps:
  highTemps[14] = 750;
  
  #### part (e) -- using &&:
  # if(noonCond == "Sunny" && highTemps < 55)
  
  #### Activity 3: ####
  # Redo App 1-7A with a for loop
}

