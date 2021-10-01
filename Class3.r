{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  #### Next two weeks:
  #  1-8 (if-else statements) -- due Thurs 10/14 at 9am
  #  I am gone Oct 2-Oct 9
  #
  
  ### Text and binary files:
  #  Text files can be read and editted by a text editor (RStudio, notepad++...)
  #  CSV is a text file, XLSX is binary
  
  ### cat()
  #   ( ... ): any number of R objects (variables are saved Objects) 
  #   have to use argument names (sep, file)... why?
  
    ###### Unicode and escape characters
  # 1) Instruction (go to next line)
  cat("first line\n\nsecond line\n");
  
  # 2) Output operator characters (" ", \, many more in other languages)
  cat(sep="~", "The llama says \"muenster cheese is the greatest\"", 
      file="llama.ll");
  
  # 3) Output Unicode characters:
  # https://en.wikipedia.org/wiki/List_of_Unicode_characters
  cat("Unicode characters \u424 \u18e \u2230 \u23f0 \u2615 \n");

  # Activity:
  # Write to the Console and a file:
  #  two backslashes in a row (\\), 3 non-latin characters, 3 arrows, 3 emoji
  
  
  ###### If-else structures
  
  # pick a number from 20 to 90, save to randomTemp
  randomTemp = sample(20:90, size=1);
  
  if(randomTemp > 60)
  {
    climate = "Warm"; 
  }
  else
  {
    climate = "Cold"; 
  }

  # condition is a vector with 4 string/chr values
  conditions = c("Sun", "Fog", "Rain", "Snow");
  # chances is a vector with 4 numeric value 
  chances = c(5,1,1,1);
  
  # choose a random condition that has been weighted based on chances
  randomCond = sample(x=conditions, size=1, prob = chances);
  
  if(randomCond == "Sun")
  {
    cat("Good day to go out\n");
  }
  else 
  {
    cat("Good day to stay in\n");
  }
  
  ##### Activity:
  #   1) Randomly pick from 4 weather conditions with 
  #      probabilities of 10%, 20%, 30%, and 40%
  #   2) Randomly sample numbers from 45-55 with higher
  #      probabilities in the middle (like a normal curve)
  #   3) Create an if-else structure using both variables
  
}
