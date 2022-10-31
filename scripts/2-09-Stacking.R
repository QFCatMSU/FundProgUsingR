{
  #### get a Boolean vector
  
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package="ggplot2");
  
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
  
  ### Read data from CSV file and save to a variable
  lansJanTempsDF = read.csv(file = "data/lansingJanTemps2.csv"); 
  
  #### Convert into matrix
  lansJanTempsMat = as.matrix(x=lansJanTempsDF);

  plot1 = ggplot(data=lansJanTempsDF) +
    geom_boxplot(mapping=aes(x=2011, y=Jan2011)) +
    geom_boxplot(mapping=aes(x=2012, y=Jan2012)) +
    theme_bw();
  plot(plot1);
    
  #### For GGPlot we need to use the data frame
  #### We can plot a box for two of the columns
  #### x = discrete value, y = data from column
  plot2 = ggplot(data=lansJanTempsDF) +
    geom_boxplot(mapping=aes(y=Jan2011)) +
    geom_boxplot(mapping=aes(y=Jan2012)) +
    theme_bw();
  plot(plot2);
  
  stackedDF = stack(lansJanTempsDF);  # use(d) in 2-7 Extension
   
  #### Plotting the stacked dataframe
  plot3 = ggplot(data=stackedDF) +
    geom_boxplot(mapping=aes(x=ind, y=values)) +
    theme_bw();
  plot(plot3);
  
  stackedDF2 = stack(lansJanTempsDF[,c(2,4)]);
  stackedDF3 = stack(lansJanTempsDF[,c(1,2,5,6)]);
  
  origDF = unstack(stackedDF);     
  
  tTest1 = t.test(x=lansJanTempsMat[,3], y=lansJanTempsMat[,6]);
  print(tTest1);
  
  tTest2 = t.test(x=lansJanTempsDF[,2], y=lansJanTempsDF[,4]);
  print(x=tTest2);
  
  tVal = tTest1$statistic;
  dfVal = tTest1$parameter;
  pVal = tTest1$p.value;
  
  stdErr = tTest1$stderr;  ## What does this mean?
  
  
  #### Second t-test as assignment
  
  Jan12_14_Anova = aov(data=stackedDF2, formula=values~ind);
  print(summary(Jan12_14_Anova));
  
  stackedDF4 = stack(lansJanTempsDF[,c(3,5,6)]);
  Jan4MonthAnova = aov(formula=values~ind, data=stackedDF4);
  print(summary(Jan4MonthAnova));

  residuals = residuals(Jan4MonthAnova);

  plot3 = ggplot() +
    geom_histogram(mapping=aes(x=residuals)) +
    theme_bw();
  plot(plot3);
  
  
  plot4 = ggplot(data=lansJanTempsDF) +
    theme_bw();
  for(i in 1:ncol(lansJanTempsDF))
  {
    xVal = paste("201", i, sep="");
    yVal = lansJanTempsDF[,i];
    newBox = geom_boxplot(mapping=aes_(x=xVal, y=yVal));
    plot4 = plot4 + newBox;
  }
  plot(plot4);
}
  