rm(list=ls()); 

### Find which numbers in a vector are prime
## name: isPrime3()
## argument: dividends
## return value: a named vector that is the same size as dividends
isPrime3 = function(dividends)
{
  primeNum = c();
  
  for(i in 1:length(dividends))   # outer loop
  {
    primeNum[i] = TRUE;  # default is that dividend is prime
    
    for(j in 2:(dividends[i]-1))  # inner loop
    {
      if(dividends[i] %% j == 0)  # i from outer loop indexing dividends
      {
        primeNum[i] = FALSE;  # dividend proven to not be prime
      }
    }
  }
  names(primeNum) = dividends;
  return(primeNum);
}

primeTest1 = isPrime3(c(12,13,14,15,16,17));

### Simple matrix: multiplication table

### Factors for multiplication table
mult1 = 2:6;
mult2 = 8:10;

### Create a matrix that will contain the calculations
multTable = matrix(nrow=length(mult1),
                   ncol=length(mult2));

### Using for loops to cycle though every possible 
##  combination of factors -- in this case, mult1 and mult2
for(i in 1:length(mult1))   # outer loop (for each mult1)
{
  for(j in 1:length(mult2)) # inner loop (for each mult2)
  {
    multTable[i,j] = mult1[i] * mult2[j];  
  }
}

### Name the rows and columns
rownames(multTable) = mult1;
colnames(multTable) = mult2;

### Second matrix: wind chill table
temps = seq(from=40, to=-20, by=-10); # 40, 30, 20...
speeds = seq(from=5, to=45, by=10);   # 5, 15, 25 ...

windChillTable = matrix(nrow=length(temps),
                        ncol=length(speeds));

rownames(windChillTable) = temps;
colnames(windChillTable) = speeds;

for(row in 1:length(temps))     # cycle thru temps for each row
{
  for(col in 1:length(speeds))  # cycle thru speeds for each column
  {
    windChillTable[row,col] = 35.74 +
                              0.6215*temps[row] -
                              35.75*(speeds[col]^0.16) +
                              0.4275*temps[row]*(speeds[col]^0.16);
  }
}
