#include <Rcpp.h>  
using namespace Rcpp;

/* Some notes about C++...
  -  This is a comment block (there is no equivalent in R)
  -  // is an inline comment -- like # in R
  -  C++ requires that you define the variable type both for variable and
        arguments in a function call
  - The first value in a vector is the 0th value in C,
    So, if a = c(5,4,3,6), then a[0] = 5, a[1] = 4...
  - #include is like a library call in R
*/

// [[Rcpp::export]]
/* get a vector from the caller, add up all the values,
   and return the answer to the caller */
int getTotal(NumericVector x)
{
  int total = 0;
  int size = x.size(); 
  
  for(int i=0; i<size; i++)
  {
    total = total + x[i];
  }
  return total;
}

// [[Rcpp::export]]
/* Get a vector from the caller and return the highest number in the vector */
int findHighVal(NumericVector x)
{
  int highVal = x[0];
  int size = x.size(); 
  
  for(int i=1; i<size; i++)
  {
    if(x[i] > highVal)
    {
      highVal = x[i];
    }
  }
  return highVal;
}

// [[Rcpp::export]]
/* Get a vector from the caller, an integer, and an operator
   Go through all the values in the vector and find if any meet
   the condition given by the integer and operator */
bool checkVals(NumericVector x, int val, String op = "=") 
{
  int size = x.size();
  bool isAny = false;

  for(int i=0; i<size; i++)
  {
    if(x[i] == val && op == "=")
    {
      isAny = true;
      break;
    }
    else if(x[i] > val && op == ">")
    {
      isAny = true;
      break;
    }
    else if(x[i] < val && op == "<")
    {
      isAny = true;
      break;
    }
  }
  // output to Console -- used here for debugging
  std::cout << "From checkVals(): " << isAny << "\n";  
  
  return isAny;
}

// [[Rcpp::export]]
/* Get a vector from the caller, an integer, and an operator
   Go through all the values in the vector and count how many values
   meet the condition given by the integer and operator */
int countVals(NumericVector x, int val, String op = "=") 
{
  int size = x.size();
  int numVals = 0;

  for(int i=0; i<size; i++)
  {
    if(x[i] == val && op == "=")
    {
      numVals++;
    }
    else if(x[i] > val && op == ">")
    {
      numVals++;
    }
    else if(x[i] < val && op == "<")
    {
      numVals++;
    }
  }
  // output to Console -- used here for debugging
  std::cout << "From countVals(): " << numVals << "\n";  
  
  return numVals;
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R

*/
