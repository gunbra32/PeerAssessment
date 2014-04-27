This is the code book explaining noteworthy decisions and assumptions in the 'run_analysis.R' script, which is also part of this repository and performs the analysis of the
Human Activity Recognition Using Smartphones Dataset, Version 1.0.

Please also note the README.md and the more detailed information in the explanatory files of the original data set for more information.
Main steps are explained below, but also note the comments in the R script.

# Main steps of the analysis and the resulting strucutre of the tidy data set:

1. in addition to the base package, the two libraries stringr and plyr are required and loaded at start
2. the working directory has to be in the folder created by unzipping the original data set, as the 
file names in run_analyis.R use relative paths.
3. first, y, subject, and X are appended along the columns for the test and the train data. second, the test and the train data are merged
 along the rows. the final data set then has the dimension 10299x563.
4. variables names for the columsn are taken from the features.txt file provided in the original data set. 
5. then, only variables containing the strings 'mean()' OR 'std()' and the first column for the subject and the second column for the activitylevel are kept to construct a subset of the entire data set.6. the original column names are manipulated for better readability. More specifically, all letters are changed to lower case, parenthesis are removed, commas are replaced by dahes and some abbreviations are replaced by better understandbale term.s
7. the numeric activity index is replaced by the descriptive term of the activities given in the file activity_labels.txt
8. averages for all variables are calculated by subject and activity resulting in 180 rows, each for a unique combination of a subject and an activity, and 81 columns, two for the subject and the activity and further 79 for the variables. this is also the dimension of the final data frame, which is then saved to 'data_tidy.txt'. for completeness, the enitre data set is also saved into 'data_all.txt'.         

  .
