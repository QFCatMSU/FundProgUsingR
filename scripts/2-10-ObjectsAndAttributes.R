{
  rm(list=ls());  options(show.error.locations = TRUE);
  
  ### A numeric vector with one value
  temperature = 80;
  a = c(5,6,7,8,9,10);
  
  ### A numeric vector with eight values
  JulyTemps = c(90, 88, 86, 77,81, 83, 80, 80);
  
  ### An integer vector
  intValues = as.integer(c(3,4,5));
  
  ### Adding 1 to integers creates a numeric vector
  intValues2 = intValues + 1;
  
  ### You need to be explicit and declare 1 as an integer
  intValues3 = intValues + as.numeric(1);

  ### A Boolean vector given whether there was rain  
  rainyDaysInJuly = c(FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE);

  ### Using a conditional statement to create a Boolean
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
  rownames(JulyTemps2DNamed) = paste("row", 1:4, sep="");
  colnames(JulyTemps2DNamed) = c("col1", "col2");
  
  ### Make a copy of JulyTemps -- add two attributes to it
  JulyTemps2DNamed2 = JulyTemps2DNamed;
  attr(JulyTemps2DNamed2, "timeChecked") = "noon";
  attr(JulyTemps2DNamed2, "unit") = "Fahrenheit";
}
  