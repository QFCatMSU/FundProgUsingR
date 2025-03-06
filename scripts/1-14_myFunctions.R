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

#### Find if one number divides another number:
### name: isDivisible()
### arguments: dividend, divisor 
### return value: a Boolean (TRUE/FALSE) value 
isDivisible2 = function(dividend, divisor)
{
  ### Go through all of the divisors:
  for(i in 1:length(divisor))
  {
    ### get the remainder of the division using modulus
    remainder = dividend %% divisor[i];
    
    ### Check if the remainder is 0
    divBy0 = (remainder == 0);  # TRUE if 0, FALSE otherwise
    
    if(divBy0 == TRUE) 
    {
      return(TRUE);
    }
  }
  
  ### return whether the modulus was 0 (TRUE) or more than zero (FALSE)
  return(FALSE);
}

isPrime1 = function(dividend)
{
  for(i in 2:(dividend-1))
  {
    if(dividend %% i == 0)
    {
      ## number can be divided evenly by another number -- return FALSE
      return(FALSE);  # dividend is not prime
    }
  }
  ## number cannot be divided evenly by another number -- return TRUE
  return(TRUE);   # dividend is prime
}

isPrime2 = function(dividend)
{
  ### Error checking the argument value
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
  
  for(i in 2:(dividend-1))
  {
    if(val %% i == 0)
    {
      ## number can be divided evenly by another number -- return FALSE
      return(FALSE);
    }
  }
  ## number cannot be divided evenly by another number -- return TRUE
  return(TRUE);
}

findFactors = function(val)
{
  ### Store the factors here (starts as a NULL vector)
  factors = c();
  
  for(i in 2:(val-1))
  {
    if(val %% i == 0)
    {
      ## number can be divided evenly by another number 
      ## insert this number as a factor
      factors = c(factors, i);
    }
  }
  ## number cannot be divided evenly by another number -- return TRUE
  return(factors);
}