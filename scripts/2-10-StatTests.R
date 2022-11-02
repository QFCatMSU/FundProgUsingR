{
  #### get a Boolean vector
  
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package="ggplot2");
  
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
  