convertTime = function(time_24Hour)
{
  # break the 4 digit number into hours and minutes
  hour = floor(time_24Hour/100); 
  minutes = time_24Hour %% 100;
  ampm = NULL;
  
  if(hour == 0)
  {
    hour = 12;
    ampm = "am"
  }
  else if(hour < 12)
  {
    ampm = "am"
  }
  else if(hour == 12)
  {
    ampm = "pm" 
  }
  else if(hour > 12)
  {
    hour = hour - 12; 
    ampm = "pm";
  }


  if (minutes < 10)
  {
    minutes = paste("0", minutes, sep=""); 
  }
  time_12Hour = paste(hour, ":", minutes, ampm, sep="");
  return(time_12Hour)
}

