setwd("C:\\R Studio\\Coursera\\Getting and Cleaning Data\\Assignment")
fileZip <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(fileZip, destfile="C:\\R Studio\\Coursera\\Getting and Cleaning Data\\Assignment\\Accelerometers.zip")
unzip("Accelerometers.zip")

## Part 1. Merge the training and the test sets to create one data set.

list.files("C:\\R Studio\\Coursera\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset")
activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt", col.names=c("activity", "activitylabel"))
features <- read.table("UCI HAR Dataset\\features.txt")
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
x_test <- read.table("UCI HAR Dataset\\test\\x_test.txt")
y_test <- read.table("UCI HAR Dataset\\test\\y_test.txt", col.names=c("activity"))
x_train <- read.table("UCI HAR Dataset\\train\\x_train.txt")
y_train <- read.table("UCI HAR Dataset\\train\\y_train.txt",col.names=c("activity"))

x <- rbind(x_train, x_test)
y<- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

library(dplyr)
library(reshape2)
features_header <- t(features$V2)
x_w_header <- setNames(x, features_header)

subjectid <- transmute(subject, subjectid=V1)

alldata <- cbind(subjectid,y,x_w_header)
alldata_c <- data.frame(alldata, check.names=T) ##This function removes duplicate columns

##Part 2. Extract only the measurements on the mean and standard deviation for each measurement. 
mean_std_data <- alldata_c %>% select(subjectid, activity, contains("mean"), contains("std"))

##Part 3. Use descriptive activity names to name the activities in the data set
alldata_coded <- alldata_c
alldata_coded$activity <- activity_labels[alldata_coded$activity, 2]

##Part 4. Appropriately label the data set with descriptive variable names.
## This question is rather vague and subjective. For example, after reading the "features_info.txt" provided with the dataset, their choice of column titles seems reasonable. However, I believe that the purpose of this question is to show compentency in both retrieving and changing column names with the "gsub" function, and so for the purposes of satisfying this goal I will perform a couple of changes below.

alldata_namechanges <- alldata_c
alldata_namechanges<- gsub("^t", "time", alldata_namechanges)
alldata_namechanges<- gsub("^f", "frequency", alldata_namechanges)
##These functions take a REALLY long time, so I will refrain from adding any more.

##Part 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
Tidy_Dataset <- alldata_c %>% group_by(subjectid, activity) %>% summarize_all(list(mean)) 
write.table(Tidy_Dataset, "C:\\R Studio\\Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project\\Tidy Dataset.csv", row.name=FALSE)