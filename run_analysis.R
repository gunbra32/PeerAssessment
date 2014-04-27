#run_analysis.R
#this script does the following:
# (1) Merges the training and the test sets to create one data set.
# (2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# (3) Uses descriptive activity names to name the activities in the data set
# (4) Appropriately labels the data set with descriptive activity names. 
# (5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# load libraries
library(stringr)
library (plyr)

###### file names and variable names ########
fnames_test <- c("test/y_test.txt","test/subject_test.txt","test/X_test.txt")
frame_name_test <- "data_test"
fnames_train <- c("train/y_train.txt","train/subject_train.txt","train/X_train.txt")
frame_name_train <- "data_train"
fname_features <- "features.txt"
fname_activities <- "activity_labels.txt"
out_fname <- "data_all.txt"
out_fname2 <- "data_tidy.txt"

########## functions #############
merge_files <- function(fns){
  ttmp = list()
  for (i in 1:length(fns)){
    tmp <- read.table(fns[i])
    ttmp <- append(ttmp,tmp)
  }
  return(data.frame(ttmp))  
}
#####################################
###### body of the script ###########
#####################################

#####################
# task (1) loading data and merging it to one data.frame named data_all
#####################

# load the test files, if the respective data frame does not exist
# and merge the different data to one frame
if (!exists(frame_name_test)){
  out <- merge_files(fnames_test)
  assign(frame_name_test,out)
  rm(out)
}

# load the train files, if the respective data frame does not exist
# and merge the different data to one frame
if (!exists(frame_name_train)){
  out <- merge_files(fnames_train)
  assign(frame_name_train,out)
  rm(out)
}

# merge test and train data if both data fames exist
if(exists(frame_name_train) & exists(frame_name_test)){
  print("Adding test and training data....")
  data_all <- rbind(data_test,data_train)
  # delete frames no longer needed to save memory
  rm(data_test)
  rm(data_train) 
  } else
  print("Data missing")

#####################
# task (2) and (3) assign names to columns and extract mean and std values
#####################

# read feature names to appropriately name the columns of the data frame
features <- read.table(fname_features, header=FALSE, stringsAsFactors=FALSE, sep="")

# create index of variables containing the strings "mean()" and "std()"
i_mean <- str_detect(features[,2],"mean()")
i_std <- str_detect(features[,2],"std()")
# merge indices
i_stdmean <- (i_mean | i_std)
# also include the first two columns, subject and activity, of the data_all frame
i_all<- as.logical(c("T","T"))
i_all <-append(i_all,i_stdmean)

# assign proper names to the first two columns
names(data_all)[1] <-"activitylevel"
names(data_all)[2] <-"subject"

# rename column names for better readability
# see  features_info.txt for more details 

f2 <- tolower(features[,2])
f2 <- gsub("(","",f2,fixed="TRUE")
f2 <- gsub(")","",f2,fixed="TRUE")
f2 <- gsub(",","-",f2,fixed="TRUE")
#f2 <- gsub(")","",f2)
#f2 <- gsub("[:):]"","",f2)
f2 <- gsub("fbody","freq-body",f2)
f2 <- gsub("acc","-accelerometer-",f2)
f2 <- gsub("gyro","-gyroscope-",f2)
f2 <- gsub("tbody","temp-body",f2)
f2 <- gsub("bodybody","body",f2)
f2 <- gsub("--","-",f2,fixed="TRUE")

# assign the new column names
names(data_all)[3:(length(features[,2])+2)] <- f2


#####################
# task (4) descriptive activity labels
#####################

# read the activity labels from the file activity_labels.txt
activity_labels <- read.table(fname_activities)
# assign the actvity labels to the index for the activity labels
data_all$activitylevel <- as.factor(activity_labels[data_all$activitylevel,2])

# subset the full data set with the index i_all, selecting only the variables inclusing mean() and std()
data_meanstd <- data_all[,i_all]

####################
# task (5) create tidy data set with means of all variables sorted by subject and actitvity
####################

# calculate means for each subject and activity for all variables in the smaller data frame
# the result is the tidy data frame
data_tidy <- ddply(data_meanstd,.(subject,activitylevel),numcolwise(mean))

# write the data to text files
# all data
write.table(data_all,out_fname,sep=" ",row.names=FALSE)
# only means and std by subject and activity 
write.table(data_tidy,out_fname2,sep=" ",row.names=FALSE)
