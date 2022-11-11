{
  # the next two lines should be at the top of all your scripts
  rm(list=ls());
  options(show.error.locations = TRUE);

  randomNum1 = sample(20:100, size=1); 
  randomNum2 = sample(-100:-50, size=1);
  
  randomNorm1 = rnorm(n=1, mean=10, sd=3);
  randomNorm2 = rnorm(n=1, mean=-7.5, sd=0.5);
}