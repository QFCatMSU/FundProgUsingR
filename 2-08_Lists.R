{
  rm(list=ls()); 
  library(package=reshape2)
  options(show.error.locations = TRUE);  
  
  #### how should attr() be used?
  # Is attr() how meta values are set in R?
  
  
  lansingJanDF = read.csv(file = "data/LansingJanTemps.csv");

  ### EXplain why we add a letter at the beginning...
  colnames(lansingJanDF) = paste("c", 2011:2016, sep="");
  tempMat = as.matrix(lansingJanDF);  
  
  tTest1 = t.test(x=tempMat[,3], y=tempMat[,6]);
  print(tTest1);
  
  tTest2 = t.test(x=tempMat[,2], y=tempMat[,4]);
  print(tTest2);
  
  #### Create an ANova ... need to make data frame long ####
  tempMat_long = melt(tempMat);
  
  anova1 = aov(data=tempMat_long, formula = value~Var2);
  print(anova1); 
  
}