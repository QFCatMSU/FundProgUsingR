### You do not want to put this code in a function script
# rm(list=ls());  # cleans out the Environment 

#### Find if one number divides another number:
### name: isDivisible()
### arguments: dividend, divisor 
### return value: a Boolean (TRUE/FALSE) value 
isDivisible = function(dividend, divisor)
{
  ### get the remainder of the division using modulus
  remainder = dividend %% divisor;
	
  ### Check if the remainder is 0
  divBy0 = (remainder == 0);  # TRUE if 0, FALSE otherwise
  
  ### return whether the modulus was 0 (TRUE) or more than zero (FALSE)
  return(divBy0);
}

isPrime1 = function(dividend)
{
  # check all numbers between 2 and one less that dividend
  for(i in 2:(dividend-1))
  {
    if(dividend %% i == 0)
    {
      ## number can be divided evenly by another number -- return FALSE
      return(FALSE);
    }
  }
  ## number cannot be divided evenly by another number -- return TRUE
  return(TRUE);
}

isPrime2 = function(dividend)
{
  ### Error checks on the argument value
  if(length(dividend) > 1)         # error check 1: too many values
  {
    return("Error: too many values");
  }
  else if (!is.numeric(dividend))  # error check 2: value not numeric
  {
    return("Error: value is not numeric");
  }
  else if (dividend < 0)           # error check 3: value is negative
  {
    return("Error: value must be positive");
  }
  else if (dividend %% 1 != 0)     # error check 4: value is a decimal
  {
    return("Error: value must be an integer");
  }
  
  # check all numbers between 2 and one less that dividend
  for(i in 2:(dividend-1))
  {
    if(dividend %% i == 0)
    {
      ## number can be divided evenly by another number -- return FALSE
      return(FALSE);
    }
  }
  ## number cannot be divided evenly by another number -- return TRUE
  return(TRUE);
}

findFactors = function(dividend)
{
  ### Store the factors here
  factors = c();
  
  for(i in 2:(dividend-1))
  {
    if(dividend %% i == 0)
    {
      ## number can be divided evenly by another number 
      ## insert this number as a factor
      factors = c(factors, i);
    }
  }
  ## number cannot be divided evenly by another number -- return TRUE
  return(factors);
}