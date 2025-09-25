### You do not want to put this code in a function script
## rm(list=ls());  # cleans out the Environment 



#### Say hello to someone
##   name: hello_you()
##   argument: who, feeling
##   return: message to person
hello_you = function(who, feeling_good=TRUE)
{ 
  msg = paste0("Hello, ", who); 
  
  if(feeling_good == FALSE)
  {
    msg = paste0(msg, ", I'm sorry you are not feeling well today!");
  }
  
  return(msg);
} 



#### Find the mean of a vector of values:
##   name: mean_simple()
##   arguments: vec 
##   return value: a single numeric value
mean_simple = function(vec)
{ 
  vecAdded = 0; ### state variable -- starts at 0

  ### Use the for loop to cycle through all the values in vec and add them to vecAdded
  for(i in 1:length(vec))
  {
    ### Adds the next value in vec
    vecAdded = vecAdded + vec[i];
  }

  ### Divide the total value by the number of values to get the mean
  meanVal = vecAdded / length(vec);

  ### return the mean value to the caller
  return(meanVal);
} 

#### Find the mean of a vector of values:
### name: mean_advanced()
### arguments: vec, removeNA
### return value: a single numeric value or NA
mean_advanced = function(vec, removeNA = FALSE)
{
  vecAdded = 0; ### state variable -- starts at 0
  numNA = 0;    ### second state variable that counts the number of NA values

  ### Use the for loop to cycle through all the values in vec and add them to vecAdded
  for(i in 1:length(vec))
  {
    if(is.na(vec[i]) == FALSE)  ### If the value is not NA
    {
      ### Adds the next value in vec
      vecAdded = vecAdded + vec[i];

    }else if (removeNA == TRUE)   ## we have a NA value and want to remove it
    {
      ### Don't add the value, instead increase the number of NA by 1
      numNA = numNA +1;
    
    }else if (removeNA == FALSE)  ## we have a NA value and don't want to remove it
    {
      ### We cannot solve for a mean with an NA so the return value has to be NA
      return(NA_real_);  # return() ends the function -- just like break() ends a for loop
    }
  }

  ### Divide the total value by the number of values that are not NA to get the mean
  meanVal = vecAdded / ( length(vec) - numNA);

  ### return the mean value to the caller
  return(meanVal);
}
