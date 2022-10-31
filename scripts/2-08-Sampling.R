{
  #### get a Boolean vector?  Save for another lesson...
  
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package="ggplot2");
  
  ### Read data from CSV file and save to a variable
  lansJanTempsDF = read.csv(file = "data/lansingJanTempsFixed.csv"); 
  lansJanTemps2017DF = read.csv(file = "data/lansingJan2017Temps.csv"); 
  
  ### Combine the data
  colnames(lansJanTemps2017DF) = "Jan2017";   # only one column to name
  lansJanTempsDF2 = cbind(lansJanTempsDF, lansJanTemps2017DF);

  ### Binding vectors of the same size together:
  vectorA = 20:1;                        # 20 values 20, 19, 18, ..., 1
  vectorB = seq(from=100, to=195, by=5); # 20 values: 100, 105, 110, ..., 195
  matrixAB = cbind(vectorA, vectorB);    # matrix with 2 columns
  
  vectorC = seq(from=-20, to=18, by=2);  # 20 values -20, -18,..., 18
  matrixABC = cbind(matrixAB, vectorC);  # matrix with 3 columns
  
  ### A Line plot of every column in the data frame
  
  ## Since every line plot is mapped to the same x values (1-31) --
  #  We can put the x mapping in the ggplot initialization
  plot1 = ggplot( data=(lansJanTempsDF2), 
                  mapping = aes(x=1:31)) +  # init x mapping

    ## We set the color for the first four lines by treating color as a subcomponent
    geom_line( mapping=aes(y=Jan2011),
               color = "red") +
    geom_line( mapping=aes(y=Jan2012),
               color = "green") +
    geom_line( mapping=aes(y=Jan2013),
               color = "orange") +
    geom_line( mapping=aes(y=Jan2014),
               color = "blue") +
    
    ## We put the last four lines in the legend by treating color as a mapping
    geom_line( mapping=aes(y=Jan2015, color="2015")) +
    geom_line( mapping=aes(y=Jan2016, color="2016")) +
    geom_line( mapping=aes(y=Jan2017, color="2017")) +
    
    labs( title="January Temperature",
          subtitle="Lansing, MI -- 2011-2017",
          x = "January Days",
          y = "temperature (F)") +
    theme_bw();
  plot(plot1);

  #### set.seed() is creates "random" values that are always the same
  #### set.seed() is a session variable... like the working directory
  #### need to set to NULL to remove it
  set.seed(seed=NULL);  # remove seed value
  
  #### Sampling from a vector
  randomSample1 = sample( 1:10, size=8, replace=TRUE);
  randomSample2 = sample( 1:10, size=8, replace=FALSE);

  #### Sample size larger than vector
  # randomSample3 = sample( 1:10, size=12, replace=FALSE); # will cause error
  randomSample4 = sample( 1:10, size=12, replace=TRUE);  # will work
 
  #### Convert into matrix
  lansJanTempsMat = as.matrix(x=lansJanTempsDF2);
  
  ### Sample 80 value -- will be different every time the code is sourced
  randomTemps = sample(lansJanTempsMat, size=80, replace=TRUE);
  
  #### set.seed() -- get the same "random" values every time
  set.seed(54321);
  randomTempsSeeded = sample(lansJanTempsMat, size=80, replace=TRUE);

  
  #### get mean and sd of seeded random sample
  meanRandom = mean(randomTempsSeeded);  # 28.58875
  sdRandom = sd(randomTempsSeeded);      # ~ 10.82
  
  #### Plot a histogram with the mean value
  plot1 = ggplot() +
    geom_histogram(mapping=aes(x=randomTempsSeeded),
                   fill="gray50",
                   color="blue") +
    geom_vline(xintercept = mean(randomTempsSeeded),
               color="red") +
    theme_bw();
  plot(plot1);
  
  #### Create a normal distribution with mean=20, sd =4 and 200 sampled values
  normalDist1 = rnorm(n=200, mean=20, sd=2);
  
  #### Get random values from a normal distribution
  ## The normal distribution will have the mean and sd of the randomly sampled values
  normalDist2 = rnorm(n=200, 
                      mean=mean(randomTempsSeeded), 
                      sd=sd(randomTempsSeeded));
  
  #### Plot a histogram of these normal dist values 
  plot2 = ggplot() +
    geom_histogram(mapping=aes(x=normalDist2),
                   fill="gray50",
                   color="blue") +
    geom_vline(xintercept = mean(normalDist2),
               color="red") +
    theme_bw();
  plot(plot2);
 
  ## Create a list of the four different random vectors created in this lesson:
  listOfTemps = list("Random_Temps" = randomTemps,
                     "Random_Seeded_Temps" = randomTempsSeeded,
                     "Normal_Dist1" = normalDist1,
                     "Normal_Dist2" = normalDist2);
  
  #### save the information in a list to an rdata file
  save(listOfTemps, file = "data/tempList.rdata");
  
  ### Load information from an rdata file -- and put in the Environment
  ##  This line needs to be executed in a different script
  ##  Or, clear the Environment and Run just this line
  load("data/tempList.rdata");
}
  