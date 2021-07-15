{
  # the next two lines should be at the top of all your scripts
  rm(list=ls());
  options(show.error.locations = TRUE);

  finalDistance = 100;
  initDistance = 50;
  finaltime = 20;       # error on this line
  initTime = 15;
  velocity = (finalDistance - initDistance) / (finalTime - initTime);
}