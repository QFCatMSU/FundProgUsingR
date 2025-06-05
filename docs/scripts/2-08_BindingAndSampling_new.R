rm(list=ls());  
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
meanRandom = mean(randomTempsSeeded);  
sdRandom = sd(randomTempsSeeded);      

#### Plot a histogram with the mean value
plot1 = ggplot() +
  geom_histogram(mapping=aes(x=randomTempsSeeded),
                 fill="gray50",
                 color="blue") +
  geom_vline(xintercept = mean(randomTempsSeeded),
             color="red") +
  theme_bw();
plot(plot1);

# # Generate the histogram
# hist(randomTempsSeeded,
#      col = "gray50",         # Fill color
#      border = "blue",        # Border color
#      main = "",              # No main title
#      xlab = "",              # No x-axis label
#      ylab = "",              # No y-axis label
#      las = 1)                # Axis label orientation
# 
# # Add vertical line at the mean
# abline(v = mean(randomTempsSeeded),
#        col = "red",
#        lwd = 2)

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

# # Generate the histogram
# hist(normalDist2,
#      col = "gray50",         # Fill color
#      border = "blue",        # Border color
#      main = "",              # No main title
#      xlab = "",              # No x-axis label
#      ylab = "",              # No y-axis label
#      las = 1)                # Axis label orientation
# 
# # Add vertical line at the mean
# abline(v = mean(normalDist2),
#        col = "red",
#        lwd = 2)