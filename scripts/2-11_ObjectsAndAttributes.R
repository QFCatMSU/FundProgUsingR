{
  rm(list=ls());  options(show.error.locations = TRUE);
  
  ### A numeric vector with one value
  temperature = 80;  # a vector, temperature, with one value, 80

  ### A numeric vector with eight values
  JulyTemps = c(90, 88, 86, 77,81, 83, 80, 80);  
  
  ### An integer vector
  intValues = as.integer(c(3,4,5));
  
  ### Adding 1 to integers creates a numeric vector
  intValues2 = intValues + 1;
  
  ### You need to be explicit and declare 1 as an integer
  intValues3 = intValues + as.integer(1);

  ### A Boolean vector given whether there was rain  
  rainyDaysInJuly = c(FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE);

  ### the conditional statements in if() creates a Boolean value:
  for(i in 1:length(JulyTemps))
  {
    # Output Boolean value instead of executing the if() statement
    #  if(JulyTemps[i] > 85)
    cat("day", i, (JulyTemps[i] > 85), "\n");
  }     
  
  ### Using a conditional statement to create a Boolean vector
  hotterThan85 = (JulyTemps > 85);
  
  ### Create a copy of JulyTemps and add names to the values
  JulyTempsNamed = JulyTemps;
  names(JulyTempsNamed) = c("July22", "July23", "July24", "July25",
                            "July26", "July27", "July28", "July29");
  
  ### Create a 2D vector (matrix/2D array) using dim()
  JulyTemps2D = JulyTemps;
  dim(JulyTemps2D) = c(4,2);

  ### Create a 3D vector (3D array)
  JulyTemps3D = JulyTemps;
  dim(JulyTemps3D) = c(2,2,2); # each dimension has length of 2
  
  ### Create a 1D object (is there a reason to do this?)
  JulyTemps1D = JulyTemps;
  dim(JulyTemps1D) = c(8);
  
  ### Name the rows and columns of the 2D object:
  JulyTemps2DNamed = JulyTemps2D;
  rownames(JulyTemps2DNamed) = paste("date", 1:4, sep="");
  colnames(JulyTemps2DNamed) = c("location1", "location2");
  
  ### Make a copy of JulyTemps -- add two attributes to it
  JulyTemps2DNamed_2 = JulyTemps2DNamed;
  attr(JulyTemps2DNamed_2, "timeChecked") = "noon";
  attr(JulyTemps2DNamed_2, "unit") = "Fahrenheit";
}
  