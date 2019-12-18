# Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project

This repository is designed for an assignment for the "Getting and Cleaning Data" course, part of the "Data Science" specialization offered by Johns Hopkins University at Coursera.

The dataset can be downloaded at the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

More information about the data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

### Files
The files that can be found within this Repo are as follows:  

1. README.md - this document, which provides a general overview of repository files, as well as a general description of coding commands and overall strategy to accomplish the assignment aims.  
2. Codebook - codebook that describes the variables, the data, and any transformations or work that you performed to clean up the data.  
3. run_analysis.R - R code to complete the criteria as described in the assignment.
4. features.txt - list of accelerometer data variables collected for the dataset.

### Run_analysis.R - Description
Our instructions were to create an R code (titled "run_analysis.R") that can accomplish the following tasks:  

1. Merges the training and the test sets to create one data set.    
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
    
##### Task 1. Merge the training and the test sets to create one data set. 
To achieve this, the R working directory was set and the dataset was downloaded and unzipped. After identifying the files of interest, these were made into their own respective variables with the following names:  

1. "activity_labels": 6 observations of 2 variables  
2. "features": 561 observations of 2 variables  
3. "subject_test": 2947 observations of 1 variable  
4. "subject_train": 7352 observations of 1 variable  
5. "x_test": 2947 observations of 561 variable  
6. "y_test": 2947 observations of 1 variable  
7. "x_train": 7352 observations of 561 variable  
8. "y_train": 7352 observations of 1 variable  

The "x_" data is the various accelerometer data, and the "y_" data is the various activity state during the measurements. Along with the subjectid variables, these data were split into testing and training subgroups, so our first task was to combine the respective test and train pairs, which was completed with the *rbind* function (see "Codebook.md" for more complete variable description.)

Next, as I identified that the "features" variable would be the header for the "x" data, I had to get the form reshaped from "long" to "wide", which was accomplished with the *t()* (for transpose) function. I then used the *setNames* function to use this list as the headers for my new variable, "x_w_header" (now with 10299 combined observations.)

Finally, all that was left was to include the "y" and "subjectid" into the final data (accomplished with *cbind*) and then remove any duplicate columns (which was frustratingly NOT mentioned anywhere in the assignment!) leaving us with the variable alldata_c (10299 observations of 563 variables)

##### Task 2. Extract only the measurements on the mean and standard deviation for each measurement.
While task 2 initially seemed like it would be difficult to accomplish, it ended up being a piece of cake with *dplyr* and the related *select* function for only those columns that contained "mean" or "std". These were stored in their own variable "mean_std_data" (10299 observations of 88 variables)
 
##### Task 3. Use descriptive activity names to name the activities in the data set
As with the previous task, though it intially seemed REALLY difficult to accomplish, eventually I found a way to use the activity column as a linker to the data, while allowed for me to specify the transfer of the factor leveling related to activity to the appropriate column. I decided to store this transformation in its own variable "alldata_coded" (10299 observations of 88 variables)

##### Task 4. Appropriately label the data set with descriptive variable names.
As I discuss directly in the "run_analysis.R"" command, I found this one a little frustrating, since the current labeling layout seems reasonable and well described ("features_info.txt" does a great job of delineating each abbreviation.) Sure, if everything was spelled out explicitly, it might be a bit more readable, but doesn't parsimony have anything going for it? Ultimately, I decided that the course instructors were probably wanting to assess my ability to use R functions to find and change text in columns, so I acquiesed and begrudgingly wrote a couple *gsub* codes to show that I know what's being asked of me! These changes were saved in the variable "alldata_namechanges"

##### Task 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
Last but not least, this task was also relatively straightforward. I first created a new variable, appropriately named "Tidy_Dataset". Using pipe operators, I constructed a function that first subgrouped the larger dataset by subject and activity, and then proceeded to only calculated means with the *summarize* and *list* nested command on this "tidier" dataset. I then used the *write.table* function to export this dataset to a .txt file, which can be used and analyzed with other programs. The final dataset, "Tidy Dataset.txt", is 180 observations of 563 variables. 
