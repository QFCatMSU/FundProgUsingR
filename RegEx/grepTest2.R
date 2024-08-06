{
   rm(list=ls());                         # clean out the Environment variables
   options(show.error.locations = TRUE);  # Show lines numbers for errors
   options(error = function(){traceback(x=3); });            # often gives you the previous traceback

   #### Jean's Comments
   # Here's one for you.   Check out column D - "chemopt" - chemical option. 
   # In the bracket is a letter for one of the Great Lakes and a number for 
   # the stream code.  Those with 10,000 added are US streams, those < 10,000
   # are Canadian.  After the bracket is the stream name with a variety of 
   # capitalizations.  After the stream name there may be a tributary or 
   # reach name in parentheses.  Or there may be an indication that the 
   # chemopt is in a lentic area (as opposed to lotic).
   ####

   # Libraries used in this script -- stringr is hugely useful for regex
   library(package = stringr);            
   
   #### Using grep (in the pattern parameter) to get the file name
   #    This is unneccessarily ineffecient, but I am testing it out.
   csvFile = list.files( pattern = ".*_Rank_.*\\.csv"); 

   
   ## If list.files returned no matching files --
   #  I let this include negative numbers to be complete
   if(length(csvFile) <= 0)  
   {
      ## break out of script with this message
      stop("No matching file name");
   }
   else
   {
      ## Warn that there was more than one match and that we are 
      #  taking the first file to match the pattern
      if (length(csvFile) > 1)
      {
         ## But warning messages come at the end of the script --
         #  probably best to just put a regular message here
         warning(paste("More than one file matching the pattern",
                       "-- defaulting to first file to match pattern."));  
      }
      
      ## read 68 rows from row 123 -- only present columns 1-8 
      data = read.csv(file = csvFile[1], skip=122, nrows=68, header=TRUE,
                      stringsAsFactors = FALSE)[1:8];
   }

   ## Create a vector of the values in the Stream column
   stream = data$Stream;

   #### Search for the term 'lentic' in the stream vector
   #    Three different method -- all produce the same results for this data
   
   # 1) the standard way to look for case insensitive words
   lentic1 = str_detect(string=stream, 
                       pattern=regex("lentic", ignore_case = TRUE));

   # 2) This checks for 'lentic' only within parentheses
   #    (?i) means everything after is case-insensitive 
   lentic2 = str_detect(string=stream, 
                       pattern="(.*(?i)lentic.*)"); 
   
   # 3) Functionally same as #2 but it directly checks both cases 
   lentic3 = str_detect(string=stream, 
                      #  pattern="(.*(?i)[L|l][E|e][N|n][T|t][I|i][C|c].*)"); 
                        pattern="([^\\)*[L|l][E|e][N|n][T|t][I|i][C|c].*)"); 
   #
   ####  End search for lentic
   
   #### Extract the letter used to represent the Great Lake
   #    The letter is appears right after the '['
   #    Easiest way is to take 2nd character -- but that is no fun!
   
   # 1) Finds the '[' and grab the next character:
   #    \\ is the escape character because '[' has a functional meaning in grep
   #    (...) encloses the grouping referred to in replacement
   #    For str_replace to work, the pattern must include the whole string 
   #       -- hence the .*
   lakeInfo1 = str_replace(string=stream, 
                          pattern="\\[(.).*",
                          replacement = "\\1");

   # 2) Extract '[X' and then removes the first character '[' by piping
   #    the results into str_sub()
   lakeInfo2 = str_extract(string=stream, 
                          pattern="\\[.") %>% str_sub(-1);
   
   # 3) Finds the first '[' and splits the strings there
   #    Then, get the second column and extract the first character
   #    This is not effecient!!
   lakeInfo3 = str_split_fixed(string=stream, pattern="\\[.", n=2)[,2] %>% 
                              str_sub(1,1);
   #
   #### End search for Great Lake
   
   #### Extract the number used to represent the stream
   #    Number >= 10000 are in the US, <10000 in Canada
   
   # 1) Extract first number in string -- then pipes the characters
   #    to as.numeric() to change it into a number 
   countryNum1 = str_extract(string=stream,
                             pattern="[0-9]+") %>% as.numeric();
  
   # 2) Looks for numbers only inside the first '[ ]'.  
   #    Replacement is the pattern in '(...)'
   #    Pipe the results to as.numeric
   countryNum2 = str_replace(string=stream, 
                         pattern="\\[. ([0-9]+)\\].*",
                         replacement = "\\1") %>% as.numeric();
   #
   #### End search for stream number

   
   #### Get the stream name: 
   #    Assumes the Stream name comes after ']' and before '('
   
   # 1) Extract everything from the ']' to the '('
   #    then remove the ']' and '(' using str_sub()
   #    then remove leading and trailing whitespaces using trimws()
   streamName1 = str_extract(string=stream,
                            pattern="\\][^\\(]+\\(") %>% 
                     str_sub(start=2, end=-2) %>% trimws();
         # issue: what if there is no parenthesis at the end?
   
   # 2) Separate the string into 3 sections
   #    pattern is: [ section 1 ] section 2 ( section 3) 
   #    replacement is section 2 -- then remove white spaces
   streamName2 = str_replace(string=stream,
                             pattern="(\\[.*\\])([^\\(]+)(\\(.*$)",
                             replacement = "\\2") %>% trimws();
   #
   #### End get stream name
   
   #### Extract the content from the first parentheses
   #    
   
   # 1) Same as streamName2 but take the 3rd section
   inParens1 = str_replace(string=stream,
                           pattern="(\\[.*\\])([^\\(]+)(\\(.*$)",
                           replacement = "\\3") %>% trimws();
   
   # 2) Extract everything between the first '(' and end of string
   #    which should be the corresponding ')'
   inParens2 = str_extract(string=stream,
                             pattern="\\([.*]*.*");
   #
   #### End first parentheses
   
   #### Extract the content from the second parentheses
   #     whether it is embedded in the first parenthesis or not
   #    

   # 1) Extract the string from the first 'parenthesis'('
   #    then remove the '('
   #    then extract from the next '(' to the following ')'
   #    then remove the '(' and ')' from the extracted string 
   inSecondParen1 = str_extract(string=stream,
                                pattern="\\(.*$") %>% 
                     str_sub(start=2) %>%
                     str_extract(pattern = "\\([^\\)]*\\)") %>%
                     str_sub(start=2, end=-2);
   
   # 2) Pattern is:
   #     [^\\(]* -- >=0 non '('
   #        \\(? -- 0 or 1 '('
   #     [^\\(]* -- >=0 non '('
   #        \\(? -- 0 or 1 '('
   #     [^\\)]* -- >=0 non ')'
   #        \\)? -- 0 or 1 ')'
   #          .* -- >=0 anything
   # note: there is an extra set of (...) used for grouping and referred to
   #       in replacement
   inSecondParen2 = str_replace(string=stream,
                                pattern="[^\\(]*\\(?[^\\(]*\\(?([^\\)]*)\\)?.*",
                                replacement= "\\1");

   ## The above is seriously ugly and I am still trying to figure out how to
   #  explain it -- but it can be generically applied to a 
   #  pattern where you have multiple patterns that follow each other but
   #  you do not know where they are in the string or what is in betwen them
   
   #### More tests...
   # 1) the standard way to look for case insensitive words
 #  z = str_detect(string=stream, perl=TRUE,
  #                      pattern="?([L|l][E|e][N|n][T|t][I|i][C|c]?)");
 #  z=  str_extract(string=stream, 
  #                 pattern = "?([L|l][E|e][N|n][T|t][I|i][C|c])1");
}

