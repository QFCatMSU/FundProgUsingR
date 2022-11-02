{
  rm(list=ls());  options(show.error.locations = TRUE);
  library(package="ggplot2");
  
  ### Read data from CSV file and save to a variable
  lansJanTempsDF = read.csv(file = "data/lansingJanTempsFixed.csv"); 
  

  ### Create a line plot of every column in the data frame
  
  ## Since every line plot is mapped to the same x values (1-31) --
  #  We can put the x mapping in the ggplot initialization
  plot1 = ggplot( data=(lansJanTempsDF), 
                  mapping = aes(x=1:31)) +  # init x mapping
    
    ## Create a line plot component for each columns
    ## You can set the color subcomponent for each line
    geom_line( mapping=aes(y=Jan2011),
               color = "red") +
    geom_line( mapping=aes(y=Jan2012),
               color = "green") +
    geom_line( mapping=aes(y=Jan2013),
               color = "orange") +
    geom_line( mapping=aes(y=Jan2014),
               color = "blue") +
    geom_line( mapping=aes(y=Jan2015),
               color = "purple") +
    geom_line( mapping=aes(y=Jan2016),
               color = "black") +
    labs( title="January Temperature",
          subtitle="Lansing, MI -- 2011-2016",
          x = "January Days",
          y = "temperature (F)") +
    theme_bw();
  plot(plot1);
  
  ## A line plot that includes a legend --
  ## Legends are included whenever you map something other than x or y
  plot2 = ggplot( data=(lansJanTempsDF), 
                  mapping = aes(x=1:31)) +  
    
    ## Put color into the mapping -- this mapping also puts color in the legend
    ## But, the color of the lines is chosen by GGPlot
    geom_line( mapping=aes(y=Jan2011, color = "Jan2011") ) +
    geom_line( mapping=aes(y=Jan2012, color = "Jan2012") ) +
    geom_line( mapping=aes(y=Jan2013, color = "Jan2013") ) +
    geom_line( mapping=aes(y=Jan2014, color = "Jan2014") ) +
    geom_line( mapping=aes(y=Jan2014, color = "Jan2015") ) +
    geom_line( mapping=aes(y=Jan2014, color = "Jan2016") ) +
    labs( title="January Temperature",
          subtitle="Lansing, MI -- 2011-2016",
          x = "January Days",
          y = "temperature (F)") +
    theme_bw();
  plot(plot2);
  
  ## Another plotting solution -- stack the data frame
  stackedDF = stack(lansJanTempsDF);  
    
  ## And, FYI, you can also unstack the data frame
  origDF = unstack(stackedDF);   
  
  ## Use the stacked data frame to plot the lines
  plot3 = ggplot( data=(stackedDF)) +  
    # We want to repeat 1-31 for each line -- so, we need to mod the line number by 31
    # values and ind are the columns in the stacked data frame
    geom_line( mapping=aes(x=(1:186)%%31, y=values, color=ind) ) +
    labs( title="January Temperature",
          subtitle="Lansing, MI -- 2011-2016",
          x = "January Days",
          y = "temperature (F)") +
    theme_bw();
  plot(plot3);
  
  ## Most robust methds -- use for loops to plot each column
  plot4 = ggplot( data=(lansJanTempsDF));  # create a canvas
  for(i in 1:ncol(lansJanTempsDF))         # add plots to canvas one at a time
  {
    # need to use aes_() instead of aes() for the mapping
    plot4 = plot4 + geom_line( mapping=aes_(x=1:nrow(lansJanTempsDF), 
                                            y=lansJanTempsDF[,i], 
                                            color=colnames(lansJanTempsDF)[i]) )
  }
  # add the labels and theme to the canvas
  plot4 = plot4 + labs( title="January Temperature",
          subtitle="Lansing, MI -- 2011-2016",
          x = "January Days",
          y = "temperature (F)") +
  theme_bw();
  plot(plot4);
  
  ## Boxplots naively -- puts boxplots on top of each other (just do 2...)
  plot5 = ggplot(data=lansJanTempsDF) +
    geom_boxplot(mapping=aes(x=2011, y=Jan2011)) +
    geom_boxplot(mapping=aes(x=2012, y=Jan2012)) +
    theme_bw();
  plot(plot5);  
  
  ## Boxplot -- give a discrete (string) value to the x mapping 
  plot6 = ggplot(data=lansJanTempsDF) +
    geom_boxplot(mapping=aes(x="2011", y=Jan2011)) +
    geom_boxplot(mapping=aes(x="2012", y=Jan2012)) +
    theme_bw();
  plot(plot6);
  
  #### Plotting the stacked dataframe (all 6 columns)
  plot7 = ggplot(data=stackedDF) +
    geom_boxplot(mapping=aes(x=ind, y=values)) +
    theme_bw();
  plot(plot7);    

  #### Create stacked dataframe that are subsetted
  stackedDF2 = stack(lansJanTempsDF[,c(2,4)]);
  stackedDF3 = stack(lansJanTempsDF[,c(1,2,5,6)]);  

  ### Plotting the subsetted stacked dataframe
  plot8 = ggplot(data=stackedDF3) +
    geom_boxplot(mapping=aes(x=ind, y=values)) +
    theme_bw();
  plot(plot8);

  ### Creating the boxplot using the original data frame and for loops 
  plot9 = ggplot( data=(lansJanTempsDF)); 
  for(i in c(1,2,5,6))  # cycle through the four columns we want to plot
  {
    ## map the column names to x and the column values to y
    plot9 = plot9 + geom_boxplot(mapping=aes_(x=colnames(lansJanTempsDF)[i], 
                                              y=lansJanTempsDF[,i] ))
  }
  plot9 = plot9 + theme_bw();
  plot(plot9);
  
  ## Create a list of the four different data frames in this lesson
  ## The format inside list() is:  "name_of_object" = object
  temperatureDFs = list("origDF" = lansJanTempsDF,
                        "stackedDF" = stackedDF,
                        "stackDF_2_4" = stackedDF2,
                        "stackedDF_1_2_5_6" = stackedDF3);
  
  ## save the list to an rdata file to be used next lesson:
  save(temperatureDFs, file = "data/tempDFs.rdata");
}
  