{
  rm(list=ls()); 
  options(show.error.locations = TRUE);

  a = 1*pi; # pi is a built-in variable in R  
  pi = 3;   # but, R does allow you to change pi
  b = 1*pi; # and, this can cause problems
}