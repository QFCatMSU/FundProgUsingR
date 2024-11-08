rm(list=ls());
# in this example, this code gives the line number of an error
options(show.error.locations = TRUE);  

# create three variables: d, t, and v
# give d and t values and use them to calculate v
d = 100;
20 = t;   # error!
v = d/t;  # this line will not be executed