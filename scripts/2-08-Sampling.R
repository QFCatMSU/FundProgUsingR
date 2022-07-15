{
  #### get a Boolean vector?  Save for another lesson...
  
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package="ggplot2");
  
  #### set.seed() is a session variable that helps with random values
  set.seed(NULL);  #remove session variable -- explain this later
  
  ### Read data from CSV file and save to a variable
  lansJanTempsDF = read.csv(file = "data/lansingJanTemps.csv"); 
  lansJanTemps2017DF = read.csv(file = "data/lansingJan2017Temps.csv"); 
  
  ### Combine the data
  lansJanTempsDF2 = cbind(lansJanTempsDF, lansJanTemps2017DF);
  colnames(lansJanTempsDF2) = paste("Jan", 2011:2017, sep=""); # would work with space but...
  
  #### Convert into matrix
  lansJanTempsMat = as.matrix(x=lansJanTempsDF2);

  #### Convert the values to 2-sig digits and Fahr
  lansJanTempsMat = lansJanTempsMat / 10;
  lansJanTempsMat = (9/5) * lansJanTempsMat + 32;
  lansJanTempsMat = signif(x=lansJanTempsMat, digits=2);

  #### Sampling from a vector
  randomSample1 = sample( c(1:10), size=8, replace=TRUE);
  randomSample2 = sample( c(1:10), size=8, replace=FALSE);

  #### Sample size larger than vector
  # randomSample2 = sample( c(1:10), size=12, replace=FALSE); # will cause error
  randomSample3 = sample( c(1:10), size=12, replace=TRUE);  # will work

  #### Sampling from a matrix (which is a 2D vector)
  randomSample4 = sample( lansJanTempsMat, size=80, replace=TRUE);
  
  #### You can sample from a data frame but the results are not quite what you expect
  randomSample5 = sample( lansJanTempsDF, size=80, replace=TRUE);
  
  #### up until this point, every time you Source the code, different random values appear

  #### set.seed() -- get the same "random" values every time
  set.seed(12345);
  randomSampleSeeded = sample(lansJanTempsMat, size=200, replace=TRUE);
 
  #### set.seed() is a session variable...
  #### need to set to NULL to remove it!
  #### working directory is also a session variable!
  
  #### get mean and sd of seeded random sample
  meanRandom = mean(randomSampleSeeded);  # 37.175
  sdRandom = sd(randomSampleSeeded);      # ~ 4.46
  
  #### Plot a histogram with the mean value
  plot1 = ggplot() +
    geom_histogram(mapping=aes(x=randomSampleSeeded),
                   fill="gray50",
                   color="blue") +
    geom_vline(xintercept = meanRandom,
               color="red") +
    theme_bw();
  plot(plot1);
  
  #### Get random values from a normal distribution
  ## The normal distributioon will have the mean and sd of the randomly sampled values
  normalDist = rnorm(n=200, 
                     mean=meanRandom, 
                     sd=sdRandom);
  
  #### Plot a histogram of these normal dist values 
  plot2 = ggplot() +
    geom_histogram(mapping=aes(x=normalDist),
                   fill="gray50",
                   color="blue") +
    geom_vline(xintercept = mean(normalDist),
               color="red") +
    theme_bw();
  plot(plot2);
  
  ### If you want to save objects with different sizes to one place, you need a List
  #### Make sure they are of different size (otherwise, could be a DF)
  listOfTemps = list("Random_Pre_Seed" = randomSample4,
                     "Random_Post_Seed" = randomSampleSeeded,
                     "Normal_Temps" = normalDist);
  
  #### Accessing List values
  random = listOfTemps$Random_Temps;
  random2 = listOfTemps[["Random_Temps"]];
    
  random3 = listOfTemps["Random_Temps"];

  #### save and load a list
  save(listOfTemps, file = "data/tempList.rdata");
  load("data/tempList.rdata");
  
  # If you set.seed(12345) at the top of the script, will 
  # randomSampleSeeded have the same values (test it!)?  
  #   Why or why not?
  #   
  # Bind 2018 to the matrix
  # 
  # Bind 2 rows to the end --
  # 
  # Using weatherData -- get 50 samples of AWND
  #   30 of PRCP 
  #   
  # Make of List of all the above results -- save as app2-8-List
  
  
  
}