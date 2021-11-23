tempCategory = function(tempValue)
{
  if(tempValue >= 1 & tempValue <= 20)
  {
    return("freezing");
  }
  else if(tempValue >= 21 & tempValue <= 40)
  {
    return("cold");
  }
  else if(tempValue >= 41 & tempValue <= 60)
  {
    return("moderate");
  }
  else if(tempValue >= 61 & tempValue <= 80)
  {
    return("warm");
  }
  else if(tempValue >= 81 & tempValue <= 100)
  {
    return("hot");
  }
}


tempCategory2 = function(tempValue, unit="F")
{
  if(unit == "C")  # if the unit is Celsius
  {
    # Convert tempValue to Fahrenheit
    tempValue = (9/5)*tempValue + 32;
  }
  # note: the if statement above is completely independent from the
  #       if-else-if structure below
  if(tempValue >= 1 & tempValue <= 20)
  {
    return("freezing");
  }
  else if(tempValue >= 21 & tempValue <= 40)
  {
    return("cold");
  }
  else if(tempValue >= 41 & tempValue <= 60)
  {
    return("moderate");
  }
  else if(tempValue >= 61 & tempValue <= 80)
  {
    return("warm");
  }
  else if(tempValue >= 81 & tempValue <= 100)
  {
    return("hot");
  }
}


tempCategory3 = function(tempValue, isFahr=TRUE)
{
  # Do not put TRUE and FALSE in quotes. They are variables in R -- not strings.
  if(isFahr == FALSE)  # the tempValue is Celsius
  {
    # convert tempValue to Fahrenheit
    tempValue = (9/5)*tempValue + 32;
  }
  
  if(tempValue >= 1 & tempValue <= 20)
  {
    return("freezing");
  }
  else if(tempValue >= 21 & tempValue <= 40)
  {
    return("cold");
  }
  else if(tempValue >= 41 & tempValue <= 60)
  {
    return("moderate");
  }
  else if(tempValue >= 61 & tempValue <= 80)
  {
    return("warm");
  }
  else if(tempValue >= 81 & tempValue <= 100)
  {
    return("hot");
  }
}

tempCategory4 = function(tempValue, unit="F")
{
  if(unit == "C")
  {
    tempValue = (9/5)*tempValue + 32;
  }
  else if(unit == "K")
  {
    tempValue = tempValue - 273;      # convert K to C
    tempValue = (9/5)*tempValue + 32; # convert C to F
  }
  
  if(tempValue >= 1 & tempValue <= 20)
  {
    return("freezing");
  }
  else if(tempValue >= 21 & tempValue <= 40)
  {
    return("cold");
  }
  else if(tempValue >= 41 & tempValue <= 60)
  {
    return("moderate");
  }
  else if(tempValue >= 61 & tempValue <= 80)
  {
    return("warm");
  }
  else if(tempValue >= 81 & tempValue <= 100)
  {
    return("hot");
  }
}


tempCategory5 = function(tempVector, unit="F")
{
  # This part stays the same
  if(unit == "C") 
  {
    tempVector = (9/5)*tempVector + 32;
  }
  else if(unit == "K")
  {
    tempValue = tempValue - 273;      # convert K to C
    tempValue = (9/5)*tempValue + 32; # convert C to F
  }
  
  # step 1: create a return vector
  retVector = c();   # c() means this is a vector
  
  # go through each value in tempVector
  for(i in 1:length(tempVector))
  {
    if(tempVector[i] >= 1 & tempVector[i] <= 20)
    {
      # step 2: populate the return value inside the for loop
      retVector[i] = "freezing";  
    }
    else if(tempVector[i] >= 21 & tempVector[i] <= 40)
    {
      retVector[i] = "cold";  
    }
    else if(tempVector[i] >= 41 & tempVector[i] <= 60)
    {
      retVector[i] = "moderate";  
    }
    else if(tempVector[i] >= 61 & tempVector[i] <= 80)
    {
      retVector[i] = "warm";  
    }
    else if(tempVector[i] >= 81 & tempVector[i] <= 100)
    {
      retVector[i] = "hot";  
    }
  }
  # step 3: return the populated vector to the caller:
  return(retVector);
}

