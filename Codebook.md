Codebook for Assignment: Getting and Cleaning Data ( Account: Primumnonnocere)
================


###Datasets
As mentioned in the "README" file, these data come from experiments that collected accelerometer data from Samsung Galaxy S smartphones from a group of participants.
8 .txt files were identified as being salient for the purposes of this assignment. 

1. "activity_labels": 6 observations of 2 variables, essentially a "codebook" for the activity factors (with six levels corresponding to integers in column V1: 1=WALKING, 2=WALKING_UPSTAIRS, 3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, and 6=LAYING.  
2. "features": 561 observations of 2 variables (each row representing a component of the accelerometer data, which were subsequently used as column headers for the "x" data.)  
*see accompanying features.txt file for the complete list of column names*
3. "subject_test": 2947 observations of 1 variable (subject id)  
4. "subject_train": 7352 observations of 1 variable (subject id)  
5. "x_test": 2947 observations of 561 variable (data collected from participants based on accelerometer data described in "features")  
6. "y_test": 2947 observations of 1 variable (activity level corresponding to measurement data collect for "y_test")  
7. "x_train": 7352 observations of 561 variable (same as "x_test" but in larger training sample)  
8. "y_train": 7352 observations of 1 variable (same as "y_test but in larger training sample")  

Transformations that were performed included merging variables 3-6 into a unified, continuous data.frame, with "activity_labels" being coded as its column headers. Notably, "activity_labels" had to be reshaped from "long" to "wide" in order to accomplish this.

Further dataset extractions and "tidying" for assignment aims were completed as described in "README.md"