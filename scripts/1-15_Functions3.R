rm(list=ls()); 

### Examples of named objects
namedObj1 = "Hello";      # string variable
namedObj2 = c(4,7,1);     # numeric vector
namedObj3 = TRUE;         # Boolean variable
namedObj4 = function(who) 
{
  text = paste("Hello,", who, ", how are you?", sep="");
  return(text)
}

### Can use the function namedObj4() after it has been declared 
print( namedObj4("llama") );

### Find which numbers in a vector are prime
## name: isPrime3()
## argument: dividends
## return value: a named vector that is the same size as dividends
isPrime3 = function(dividends)
{
  isPrime = c(rep(TRUE, length(dividends)));
  names(isPrime) = dividends; 
  
  for(i in 1:length(dividends))   # outer loop
  {
    for(j in 2:(dividends[i]-1))  # inner loop
    {
      if(dividends[i] %% j == 0)  # i from outer loop indexing dividends
      {
        isPrime[i] = FALSE;
      }
    }
  }
  return(isPrime);
}

primeTest1 = isPrime3(c(12,13,14,15,16,17));


### Create a table of wind chill values from temperatures and windspeeds
## name: windChillTable()
## argument: a vector of temperatures and wind speeds
## return value: a matrix of wind chills
windChillTable = function(temperatures, windSpeeds)
{
  windChillMatrix = matrix(nrow=length(temperatures), 
                           ncol=length(windSpeeds));
  
  rownames(windChillMatrix) = temperatures;
  colnames(windChillMatrix) = windSpeeds;
  
  for(i in 1:length(temperatures))  # i is the rows
  {
    for(j in 1:length(windSpeeds))  # j is the columns
    {
      windChillMatrix[i,j] = 35.74 + 
        0.6215*temperatures[i] - 
        35.75*(windSpeeds[j]^0.16) + 
        0.4275*temperatures[i]*(windSpeeds[j]^0.16);
    }
  }

  return(windChillMatrix);
}

temps = seq(from=30, to=-20, by=-10);
speeds = seq(from=10, to=90, by=10);

windChillTest1 = windChillTable(temps, speeds);

### Matrix: mult table

mult_table = function(first, second)
{
  multMatrix = matrix(nrow=length(first), 
                      ncol=length(second));
  
  rownames(multMatrix) = first;
  colnames(multMatrix) = second;
  
  for(i in 1:length(first))  # i is the rows
  {
    for(j in 1:length(second))  # j is the columns
    {
      multMatrix[i,j] = first[i] * second[j];
    }
  }
  
  return(multMatrix);
}

mult1 = mult_table(4:9,  12:14);
