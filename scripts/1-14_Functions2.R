#rm(list=ls()); 

# get the functions from the function script and put them in the Environment
debugSource("scripts/1-14_myFunctions.R");

# Modulus tests:
print(11 %% 4); 
print(12 %% 4); 
print(13 %% 4); 
print(14 %% 4); 

## testing the isDivisible() function in function script
div12_4 = isDivisible(12,4);
div12_5 = isDivisible(12,5);

# better to put in argument  names:
div12_4a = isDivisible(dividend=12, divisor=4);
div12_5a = isDivisible(dividend=12, divisor=5);

# the order does not matter when you use argument names:
div12_4b = isDivisible(divisor=4, dividend=12);
div12_5b = isDivisible(divisor=5, dividend=12);

## Checking for prime numbers using isPrime1()
p0 = isPrime1(13);
p1 = isPrime1(14);
p2 = isPrime1(81);
p3 = isPrime1(dividend=83);
p4 = isPrime1(dividend=87);
p5 = isPrime1(dividend=89);

# Testing modulus with decimal numbers
print(5.5 %% 1); 
print(8.333 %% 1); 
print(10 %% 1); 
print(12.99 %% 1);

# Testing the error checking in isPrime2():
e1 = isPrime2(c(10,34)); # too many values 
e2 = isPrime2("hello");  # not numeric 
e3 = isPrime2(FALSE);    # not numeric 
e4 = isPrime2(-35);      # negative numeric 
e5 = isPrime2(74.24);    # decimal numeric 
e6 = isPrime1(13);       # valid -- and prime 
e7 = isPrime1(14);       # valid -- and not prime 
e8 = isPrime1(81);       # valid -- and not prime

# Testing the findFactor() function:
f0 = findFactors(dividend=13);
f1 = findFactors(14);
f2 = findFactors(dividend=81);
f3 = findFactors(83);
f4 = findFactors(dividend=87);
f5 = findFactors(72);
