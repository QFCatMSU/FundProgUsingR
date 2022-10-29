{
  rm(list=ls());  options(show.error.locations = TRUE);
  
  ### Read data from CSV file and save to a variable
  lansJanTempsDF = read.csv(file = "data/lansingJanTemps2.csv"); 
  
  # Default variable is data frame -- convert the variable to a matrix
  lansJanTempsMat = as.matrix(x=lansJanTempsDF);
  
  # Creating a boxplot of each of the six year's worth of January temperatures (the columns)
  boxplot(x=lansJanTempsMat, use.cols = TRUE);
  
  # Add labels and names to the plots to the boxplot
  boxplot(x=lansJanTempsMat, use.cols = TRUE,
          names = c(2011,2012,2013,2014,2015,2016),
          main="January 2011 through January 2016",
          xlab="Temperature (Fahrenheit)",
          ylab="Years");

  ##### 1st t-test #####
  # compare the means from Jan 2013 and Jan 2016 using a t-test
  tTest1 = t.test(x=lansJanTempsMat[,3], 
                  y=lansJanTempsMat[,6]);
  tTest1b = t.test(x=lansJanTempsMat[,"Jan2013"], 
                  y=lansJanTempsMat[,"Jan2016"]);
  tTest1c = t.test(x=lansJanTempsDF$Jan2013, 
                   y=lansJanTempsDF[,6]);
  tTest1d = t.test(x=lansJanTempsDF[["Jan2013"]], 
                   y=lansJanTempsDF["Jan2016"]);
  tTest1e = t.test(x=lansJanTempsDF[,"Jan2013"], 
                   y=lansJanTempsDF[3]);
  
  a = lansJanTempsDF[,"Jan2013"];
  b = lansJanTempsDF["Jan2013"];
  c = lansJanTempsDF[["Jan2013"]];
  d = lansJanTempsDF$Jan2013;
  
  # print out a summary of the t-test
  print(tTest1);

  ##### 2nd t-test #####
  #compare the means from Jan 2012 and Jan 2014 using a t-test
  tTest2 = t.test(x=lansJanTempsMat[,2], y=lansJanTempsMat[,4]);

  # print out a summary of the t-test
  print(x=tTest2);

  #### Structure data into data and categories
  # Data -- a vector with temperature values from 2012 and 2014
  JanTemps1 = c(lansJanTempsMat[,2], lansJanTempsMat[,4]);

  # Categories -- a vector with 31 2012 and 31 2014
  JanYears1 = c(rep(2012,31), rep(2014,31));

  # Combine the data and category vectors in a data frame
  JanDataFrame1 = data.frame(JanTemps1, JanYears1);

  # Show a boxplot of the two categories (2012 and 2014)
  boxplot(formula=JanTemps1~JanYears1, data=JanDataFrame1);

  # Performs an ANOVA (data: temperatures, category: years)
  JanAnova1 = aov(formula=JanTemps1~JanYears1, data=JanDataFrame1);

  # Summarize the ANOVA in the Console Window
  cat("Anova Results:\n");
  print(summary(JanAnova1));

  #### Do a second ANOVA with four years
  # Data -- a vector with temperature values from 2011,2012,2015,and 2016
  JanTemps2 = c(lansJanTempsMat[,1], lansJanTempsMat[,2],
                lansJanTempsMat[,5], lansJanTempsMat[,6]);

  # Categories -- a vector with 31 2011s, 2012s, 2015s, and 2016s
  JanYears2 = c(rep(2011,31), rep(2012,31),
                rep(2015,31), rep(2016,31));

  # Combine the data and category vectors in a data frame
  JanDataFrame2 = data.frame(JanTemps2, JanYears2);

  # Performs a second ANOVA (data: temperatures, category: years)
  JanAnova2 = aov(JanTemps2~JanYears2, data=JanDataFrame2);

  # Summarize the second ANOVA in the Console Window
  cat("\nSecond ANOVA results:\n");
  print(summary(JanAnova2));

  # test the normality assumption using a histogram
  hist(x=residuals(JanAnova2));
}