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
    geom_boxplot(mapping=aes(x="2011", y=Jan2011)) +
    geom_boxplot(mapping=aes(x="2012", y=Jan2012)) +
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
  
  JanAnova1 = aov(data=stackedDF2, formula=values~ind);
  print(summary(JanAnova1));
  
  JanAnova2 = aov(formula=values~ind, data=stackedDF3);
  print(summary(JanAnova2));
  
  residuals = residuals(JanAnova2);
  resid2 = JanAnova2$residuals;
  
  # $ can reference everything but vectors
  # dropdown arrow means list??
   #  otherwise, you need [[ ]] or [ ]  
  
  #### Find residuals in List
  
  #### Only one "third-level: JanAnova2$call$formula
  
  
}
  