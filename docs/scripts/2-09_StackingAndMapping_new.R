rm(list=ls());  
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

# # Set up a blank plot with appropriate axes (R-base)
# plot(1:31, lansJanTempsDF$Jan2011,
#      type = "n",                      # Don't plot points yet
#      main = "January Temperature",
#      sub = "Lansing, MI -- 2011-2016",
#      xlab = "January Days",
#      ylab = "temperature (F)")
# 
# # Add lines for each year with specified colors
# lines(1:31, lansJanTempsDF$Jan2011, col = "red")
# lines(1:31, lansJanTempsDF$Jan2012, col = "green")
# lines(1:31, lansJanTempsDF$Jan2013, col = "orange")
# lines(1:31, lansJanTempsDF$Jan2014, col = "blue")
# lines(1:31, lansJanTempsDF$Jan2015, col = "purple")
# lines(1:31, lansJanTempsDF$Jan2016, col = "black")


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
  geom_line( mapping=aes(y=Jan2015, color = "Jan2015") ) +
  geom_line( mapping=aes(y=Jan2016, color = "Jan2016") ) +
  labs( title="January Temperature",
        subtitle="Lansing, MI -- 2011-2016",
        x = "January Days",
        y = "temperature (F)") +
  theme_bw();
plot(plot2);

# # Set up a blank plot with appropriate axes (R-base)
# plot(1:31, lansJanTempsDF$Jan2011,
#      type = "n",                      # Don't plot points yet
#      main = "January Temperature",
#      sub = "Lansing, MI -- 2011-2016",
#      xlab = "January Days",
#      ylab = "temperature (F)")
# 
# # Add lines for each year with specified colors
# lines(1:31, lansJanTempsDF$Jan2011, col = "red")
# lines(1:31, lansJanTempsDF$Jan2012, col = "green")
# lines(1:31, lansJanTempsDF$Jan2013, col = "orange")
# lines(1:31, lansJanTempsDF$Jan2014, col = "blue")
# lines(1:31, lansJanTempsDF$Jan2015, col = "purple")
# lines(1:31, lansJanTempsDF$Jan2016, col = "black")

# # Add a legend
# legend("topright",                             # Position
#        legend = c("2011", "2012", "2013", "2014", "2015", "2016"),
#        col = c("red", "green", "orange", "blue", "purple", "black"),
#        lty = 1,                                 # Line type
#        cex = 0.8,                               # Text size
#        title = "Years")

## Another plotting solution -- stack the data frame
stackedDF = stack(lansJanTempsDF);  


## Use the stacked data frame to plot the lines
plot3 = ggplot( data=(stackedDF)) +  
  # We want to repeat 1-31 6 times...
  geom_line( mapping=aes(x=rep(1:31, times=6), y=values, color=ind) ) +
  labs( title="January Temperature",
        subtitle="Lansing, MI -- 2011-2016",
        x = "January Days",
        y = "temperature (F)") +
  theme_bw();
plot(plot3);

# # Set up blank plot area (R-base)
# plot(1:31, stackedDF$values[1:31],  # Use first chunk to define axis limits
#      type = "n",                    # No actual points yet
#      main = "January Temperature",
#      sub = "Lansing, MI -- 2011-2016",
#      xlab = "January Days",
#      ylab = "temperature (F)")
# 
# # Define colors for each group
# colors <- c("red", "green", "orange", "blue", "purple", "black")
# 
# # Loop through each group in stackedDF$ind
# unique_years <- unique(stackedDF$ind)
# 
# for (i in seq_along(unique_years)) {
#   # Get the subset of data for this group
#   group_data <- stackedDF$values[stackedDF$ind == unique_years[i]]
#   
#   # Draw the line for this group
#   lines(1:31, group_data, col = colors[i])
# }
# 
# # Add legend
# legend("topright",
#        legend = unique_years,
#        col = colors,
#        lty = 1,
#        cex = 0.8,
#        title = "Years")

## Most robust method -- use for loops to plot each column
plot4 = ggplot( data=(lansJanTempsDF));  # create a canvas
for(i in 1:ncol(lansJanTempsDF))         # add plots to canvas one at a time
{
  # replace i by with !!(i) -- avoids Lazy Evaluation
  plot4 = plot4 + geom_line( mapping=aes(x=1:nrow(lansJanTempsDF), 
                                         y=lansJanTempsDF[,!!(i)], 
                                         color=colnames(lansJanTempsDF)[!!(i)]) )
}
# add the labels and theme to the canvas
plot4 = plot4 + labs( title="January Temperature",
        subtitle="Lansing, MI -- 2011-2016",
        x = "January Days",
        y = "temperature (F)",
        color = "Years") +
theme_bw();
plot(plot4);

## And, FYI, you can also unstack the data frame
origDF = unstack(stackedDF);

## Boxplots naively -- puts boxplots on top of each other (just do 2...)
plot5 = ggplot(data=lansJanTempsDF) +
  geom_boxplot(mapping=aes(x=2011, y=Jan2011)) +
  geom_boxplot(mapping=aes(x=2012, y=Jan2012)) +
  theme_bw();
plot(plot5);  

# # Create side-by-side boxplots for Jan2011 and Jan2012 (R-base)
# boxplot(lansJanTempsDF$Jan2011, lansJanTempsDF$Jan2012,
#         names = c(2011, 2012),       # X-axis labels (quotes do not matter...)
#         main = "",                       # No main title
#         xlab = "",                       # No x-axis label
#         ylab = "",                       # No y-axis label
#         col = "lightgray",               # Box fill color
#         border = "black")                # Border color

## Boxplot -- give a discrete (string) value to the x mapping 
plot6 = ggplot(data=lansJanTempsDF) +
  geom_boxplot(mapping=aes(x="2011", y=Jan2011)) +
  geom_boxplot(mapping=aes(x="2012", y=Jan2012)) +
  theme_bw();
plot(plot6);  # same as plot5 in base-R

#### Plotting the stacked dataframe (all 6 columns)
plot7 = ggplot(data=stackedDF) +
  geom_boxplot(mapping=aes(x=ind, y=values)) +
  theme_bw();
plot(plot7);    

# # Boxplot of values grouped by ind (R-base)
# boxplot(values ~ ind,
#         data = stackedDF,
#         main = "",                # No main title
#         xlab = "",                # No x-axis label
#         ylab = "",                # No y-axis label
#         col = "lightgray",        # Box fill color
#         border = "black")         # Border color

#### Create stacked dataframe that are subsetted
stackedDF2 = stack(lansJanTempsDF[,c(3,6)]);
stackedDF3 = stack(lansJanTempsDF[,c(1,2,5,6)]);  

### Plotting the subsetted stacked dataframe
plot8 = ggplot(data=stackedDF3) +
  geom_boxplot(mapping=aes(x=ind, y=values)) +
  theme_bw();
plot(plot8);

# # Boxplot of values grouped by ind (R-base)
# boxplot(values ~ ind,
#         data = stackedDF3,
#         main = "",                # No main title
#         xlab = "",                # No x-axis label
#         ylab = "",                # No y-axis label
#         col = "lightgray",        # Box fill color
#         border = "black")         # Border color

### Creating the boxplot using the original data frame and for loops 
plot9 = ggplot( data=(lansJanTempsDF)); 
for(i in c(1,2,5,6))  # cycle through the four columns we want to plot
{
  ## map the column names to x and the column values to y
  plot9 = plot9 + geom_boxplot(mapping=aes(x=colnames(lansJanTempsDF)[!!(i)], 
                                           y=lansJanTempsDF[,!!(i)] ))
}
plot9 = plot9 + theme_bw();
plot(plot9);

# Select the columns you want to plot
selected_cols <- lansJanTempsDF[, c(1, 2, 5, 6)]

# # Create the boxplot (R-base)
# boxplot(selected_cols,
#         names = colnames(selected_cols),  # Use column names as x labels
#         main = "",                        # No main title
#         xlab = "",                        # No x-axis label
#         ylab = "",                        # No y-axis label
#         col = "lightgray",                # Box fill color
#         border = "black")                 # Border color

## Create a list of the four different data frames in this lesson
## The format inside list() is:  "name_of_object" = object
temperatureDFs = list("origDF" = lansJanTempsDF,
                      "stackedDF" = stackedDF,
                      "stackDF_3_6" = stackedDF2,
                      "stackedDF_1_2_5_6" = stackedDF3);

## save the list to an rdata and RDS file to be used next lesson:
save(temperatureDFs, file = "data/tempDFs.rdata");
saveRDS(temperatureDFs, file = "data/tempDFs.rds");