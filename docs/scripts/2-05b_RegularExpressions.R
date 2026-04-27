rm(list=ls()); 

### to-do:
#  - make files a little more randomly ordered
#  - more example where name has something not in beginning or end
#  - caret, dollar examples with more text and//^, 

### read in the file names -- the file only has 1 column
file_names = read.csv(file="data/filenames.csv")[[1]];

#### 1)Substrings
reading = grep(file_names, pattern="reading")
reading_names = file_names[reading]

reading_status = grep(file_names, pattern="reading|status")
reading_status_names = file_names[reading_status]

#### 2) Starts and Ends with
start_station = grep(file_names, pattern="^station")  # other names with backup elsewhere
start_station_names = file_names[start_station]

end_txt = grep("txt$", file_names)   
end_txt_names = file_names[end_txt]


#### 3) Combine start and end
# No AND operator in Regex -- this will find nothing
start_end_bad = grep(file_names, pattern="^station&txt$")

# station followed by any number of any characters then txt
start_end = grep(file_names, pattern="^station.{0,}txt$") 

# In the middle, there needs to be B3
start_middle_end = grep(file_names, pattern="^station.{0,}B3.{0,}txt$") 

#### 3) Special character ^, $, .
has_caret = grep(file_names, pattern="\\^") 


has_caret2 = grep(file_names, pattern="^backup.*\\^ba") 

dot_dat = grep(file_names, pattern=".dat") 
has_dot_dat = file_names[dot_dat] 

dot_dat2 = grep(file_names, pattern="\\.dat") 
has_dot_dat2 = file_names[dot_dat] 

#### 5) Finding a range of characters
year_2016_2019a = grep(file_names, pattern="201[6789]") 
year_2016_2019b = grep(file_names, pattern="201[7986]") 
year_2016_2019c = grep(file_names, pattern="201[6-9]") 

has_year_2016_2019 = file_names[year_2016_2019a]

### List all special characters and their meanings
#   note that not all special characters are special all the time

letter_number = grep(file_names, pattern="_[aAbB][123]")

all_letter_number = grep(file_names, pattern="_[a-zA-Z][a-zA-Z][0-9]")


eight_number1 = grep(file_names, pattern="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]");
eight_number2 = grep(file_names, pattern="[0-9]{8}");

four_numbers = grep(file_names, pattern="[0-9]{4}");
four_numbers_exact = grep(file_names, pattern="[^0-9][0-9]{4}[^0-9]");

letter_numbers = grep(file_names, pattern="[a-zA-Z][0-9]{2,3}");

##### GRoupings
repeat_vals = c("A", "AA", "AAA", "AAAA", "AAAAAA",
                "AB", "ABAB", "ABABAB", "ABABABAB", "ABABABABABA")


repeat_A = grep(repeat_vals, pattern="A{4}");

repeat_AorB = grep(repeat_vals, pattern="[AB]{4}");

repeat_AB = grep(repeat_vals, pattern="(AB){4}");

repeat_AAB = grep(repeat_vals, pattern="(A[AB]){3}");

