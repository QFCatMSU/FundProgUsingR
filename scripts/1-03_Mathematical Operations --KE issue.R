{
  # the next two lines should be at the top of all your scripts
  rm(list=ls());
  options(show.error.locations = TRUE);

  kineticEnergy = 50;
  mass = 5;
  velocity = (2*kineticEnergy / mass)^1/2; # still a problem here!
}