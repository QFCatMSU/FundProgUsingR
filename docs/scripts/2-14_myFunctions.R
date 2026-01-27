
high_and_low = function(highs, lows, dates)
{
  # initialize all to the first value
  highest_high = highest_low = list();
  highest_high$temp = highest_low$temp = highs[1];  
  highest_high$date = highest_low$date = dates[1];  

  lowest_high = lowest_low = list();
  lowest_high$temp = lowest_low$temp = highs[1];  
  lowest_high$date = lowest_low$date = dates[1];  
  browser()
  ### Add code to handle multiple dates that have the same extreme temp
  for(i in 2:length(highs))
  { 
    if(highs[i] > highest_high$temp)
    {
      highest_high$temp = highs[i];
      highest_high$date = dates[i];
    }
    else if(highs[i] < lowest_high$temp)
    {
      lowest_high$temp = highs[i];
      lowest_high$date = dates[i];
    }
    else if(lows[i] > highest_low$temp)
    {
      highest_low$temp = lows[i];
      highest_low$date = dates[i];
    }
    else if(lows[i] < lowest_low$temp)
    {
      lowest_low$temp = lows[i];
      lowest_low$date = dates[i];
    }
  }

  ## Compile all the information into one list
  extreme_temp = list();
  extreme_temp$highest_high = highest_high;
  extreme_temp$highest_low = highest_low;
  extreme_temp$lowest_high = lowest_high;
  extreme_temp$lowest_low = lowest_low;

  return(extreme_temp)
}
