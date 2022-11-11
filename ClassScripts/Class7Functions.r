# These are like any other functions you call in R (means, sd, ...)
# the arguments to the function are variables set by the caller
# A function can only see the script within the function
#  That is the function's world!


#### Conversion functions ####
# more efficient conversion function
convert1 = function(tempVector, unit = "F")
{
  if(unit == "C")
  {
    tempValue = (9/5)*(tempVector) + 32;
  }
  else if(unit == "F")
  {
    tempValue = (5/9) * (tempVector - 32);
  }
  return(tempValue);  
}

# more robust conversion function
convert2 = function(tempVector, unit = "F")
{
  tempValue = c();
  
  for(i in 1:length(tempVector))
  {
    if(unit == "C")
    {
      tempValue[i] = (9/5)*(tempVector[i]) + 32;
    }
    else if(unit == "F")
    {
      tempValue[i] = (5/9) * (tempVector[i] - 32);
    }
  }
  return(tempValue);
}


#### Comparison Functions #####
# more efficient comparison function (returns end the function)
compare1 = function(vector, compareVal, conditionalOp=">")
{
  vecLength = length(vector);  # get the length of the vector

  for(i in 1:vecLength)        # go through each value in vector
  {
    if(conditionalOp == ">" & vector[i] > compareVal)
    {
      return(TRUE);
    }
    else if(conditionalOp == "<" & vector[i] < compareVal) 
    {
      return(TRUE);
    }
    else if(conditionalOp == "==" & vector[i] == compareVal)
    {
      return(TRUE);
    }
  }
  return(FALSE);
}

# more robust conversion function 
compare2 = function(vector, compareVal, conditionalOp=">")
{
  vecLength = length(vector);  # get the length of the vector
  found = FALSE;               # found is a state variable
  
  for(i in 1:vecLength)        # go through each value in vector
  {
    if(conditionalOp == ">" & vector[i] > compareVal)
    {
      found = TRUE; 
    }
    else if(conditionalOp == "<" & vector[i] < compareVal) 
    {
      found = TRUE; 
    }
    else if(conditionalOp == "==" & vector[i] == compareVal)
    {
      found = TRUE; 
    }
  }
  return(found);
}

















































































weatherCheck = function(vector, cond1, cond2)
{
  for(i in 1: length(vector))
  {
    cond1Met = grepl(cond1, vector[i]);   
    cond2Met = grepl(cond2, vector[i]);
    
    if(cond1Met & cond2Met == TRUE)
    {
      # returns the index value where the condition was met
      return(i);
    }
  }
}


outlierAverage1 = function(vector, low, high)
{
  ## These are both state variables
  addedValues = 0;   # running total of the added values
  numValues = 0;     # running total of the number of values 
  
  for(i in 1:length(vector))
  {
    if(vector[i] > low & vector[i] < high)
    {
      # add the current value in the vector to the running total
      addedValues = addedValues + vector[i]; 
      # increase the number of values added by 1
      numValues = numValues + 1;
    }
  }
  avgValue = addedValues/numValues;
  
  return(avgValue);
}

# return the average of both the outliers and non-outliers
outlierAverage2 = function(vector, low, high)
{
  ## These are all state variables
  addedValues = 0;    # running total of the added values
  addedOutValues = 0; # running total of the outlier values
  numValues = 0;      # running total of the number of values 
  
  for(i in 1:length(vector))
  {
    if(vector[i] > low & vector[i] < high)
    {
      # add the current value in the vector to the running total
      addedValues = addedValues + vector[i]; 
      # increase the number of values added by 1
      numValues = numValues + 1;
    }
    else
    {
      addedOutValues = addedOutValues + vector[i]; 
    }
  }
  avgValue = addedValues/numValues;
  avgOutValue = addedOutValues/(length(vector) - numValues);
  
  # return both values in a vector
  return(c(avgValue, avgOutValue));
}
