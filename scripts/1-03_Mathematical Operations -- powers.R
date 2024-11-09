rm(list=ls());

kineticEnergy = 50;
mass = 5;

test1 = (2*kineticEnergy / mass)^(1/3);  # third root
test2 = (2*kineticEnergy / mass)^(5);    # fifth power
test3 = (2*kineticEnergy / mass)^(5/3);  # mixed root and power
test4 = (2*kineticEnergy / mass)^(3.17)  # decimal power