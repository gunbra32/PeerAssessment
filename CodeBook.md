This is the code book explaining the analysis performed by the 'run_analysis.R' script, which is also part of this repository and performs the analysis of the
Human Activity Recognition Using Smartphones Dataset, Version 1.0.

Please also note the README.md and the more detailed information in the explanatory files of the original data set for more information.
Main steps are explained below, but also note the comments in the R script.

## Main steps of the analysis and the resulting strucutre of the tidy data set:

1. In addition to the base package, the two libraries stringr and plyr are required and loaded at start.
2. The working directory has to be in the folder created by unzipping the original data set, as the 
file names in run_analyis.R use relative paths.
3. First, y, subject, and X are appended along the columns for the test and the train data. Second, the test and the train data are merged
 along the rows. The final data set then has the dimension 10299x563.
4. Variables name for the columsn are taken from the features.txt file provided in the original data set. 
5. Then, only variables containing the strings 'mean()' OR 'std()' and the first column for the subject and the second column for the activity are kept to construct a subset of the entire data set.
6. The original column names are manipulated for better readability. 
More specifically, all letters are changed to lower case, parenthesis are removed, commas are replaced by dashes, and some abbreviations are replaced by better understandable terms.
7. The numeric activity index is replaced by the descriptive term of the activities given in the file 'activity_labels.txt'.
8. Averages for all variables are calculated by subject and activity resulting in 180 rows, each row for a unique combination of a subject and an activity, and 81 columns, two for the subject and the activity and further 79 for the variables. This is also the dimension of the final data frame, which is then saved with blanks as separators to 'data_tidy.txt'. 
For completeness, the much bigger, entire data set holding the original data is also saved into 'data_all.txt'.         

