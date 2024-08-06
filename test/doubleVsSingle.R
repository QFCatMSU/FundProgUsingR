temps = c(5,15,25,35,45,55,65,75,85,95);

# will produce a TRUE/FALSE vector of 10 values (the same number of values in temps)
temps10To30 = temps > 10 & temps < 30;
tempsExtreme = temps < 10 | temps > 90;

# will produce one TRUE/FALSE values based on only the first value in each vector
temps10To30_2 = temps > 10 && temps < 30;
tempsExtreme_2 = temps < 10 || temps > 90;

# So, the double is really just doing this:
temps10To30_3 = temps[1] > 10 & temps[1] < 30;
tempsExtreme_3 = temps[1] < 10 | temps[1] > 90;

# I have no idea what the point of using doubles(&&, ||) on vectors is...
# This is why I have moved to using singles on everything
# But, in most other programming languages && and || do what & and | do in R