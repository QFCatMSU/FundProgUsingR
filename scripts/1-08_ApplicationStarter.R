{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console

  # Picks a random number between -30 and 120
  temperature = sample(-30:120, size=1);
  
  # Picks a random grade from the vector
  grade = sample(c("A", "B", "C", "D", "E"), size=1);
}