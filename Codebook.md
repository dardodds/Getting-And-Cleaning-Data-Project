# Code Book
---
title: "Code Book"
author: "Darlene Dodds"
date: "June 19, 2016"
---

## Getting and Cleanning Data Assignment
The assignment was to get signal data from UCI using this url https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and tidy it according to the criteria based below.  To accomplish this goal, the tidying activites listed below were required so that the tidy data could support modeling and visualization.

## TIDY Data Criteria ##
  1. Each variable is one column
  2. Each observation is a different row
  3. One table per one "kind" of variable
  4. Multiple tables have one join column
  
## Most Common Tidying Activities ##
  1. Tidy column headers ar values not varible namse
  2. Tidy multiple variables stored in one column
  3. Tidy varibles are stored in both rows and columns
  4. Tidy multiple observational units are stored in the same table
  5. Tidy a single observational unit is stored in multiple tables
  
## Identifiers
These are the identfiers that I used to link the raw data, activity data and the subject data. This complies to Tidy Data #3 and #4 criteria.

sample_id - identifies the sample measurement and numbers each row in the test data and the train data.  It is used to maintain integrity when linking X, Y and subject files, that is, the sample(row) in X is linked to the same sample in Y and subject files.

activityid - identifies the activity and can link it to an english description

subjectid - identifies the subjects in the test and train and is used to link the subject to the raw data

## Variables
There were 561 variables in the raw data set.  These broke the tidy data rule #1.  The data was melted into 5 variables: sample_id, activityid, subjectid, varialbe and value. The variable column was then split 4 columns as follows: Tidy data requires one variable per column. This complies to Tidy Data #1 criteria.

####domain
Is the domain for the signals and can be time (t) or frequence (f)

####measurement 
Is the type of device measurement that was taken during the experiment.  THese measurements are from the accelerometer and gyroscope.  These time domain signals were captured at a constate rate of 50Hz.  The following are the signals that wee used to capture readings:
  
  "bodyacc"
  
  "gravityacc"
  
  "bodyaccjerk"
  
  "bodygyro"
  
  "bodygyrojerk"
  
  "bodyaccmag"
  
  "gravityaccmag"
  
  "bodyaccjerkmag"
  
  "bodygyromag"
  
  "bodygyrojerkmag"
  
  "bodybodyaccjerkmag"
  
  "bodybodygyromag"
  
  "bodybodygyrojerkmag"
  
  
####stat
Is the statiscal calculation that was performed on the measurement
 
  "mean" - mean value
  
  "std" - standard deviation 
  
  "mad" - median absolute deviation
  
  "max" - largest value in the array
  
  "min" - smallest value in the array
  
  "sma" - signal magnitude area
  
  "energy" - energy measure
  
  "iqr" - interquartile range
  
  "entropy" - signal entropy
  
  "arcoeff" - autoregression coefficients with Burg order equal to 4
  
  "correlation" - correlation coefficient between two signals 
  
  "meanfreq" - weighted average of the frequency components to obtain a mean frequency
  
  "skewness" - skewness of the frequency domain signal
  
  "kurtosis" - kurtosis of the frequency domain signal
  
  "bandsenergy" - energy of a frequency interval within the 64 bins of the FFT of each window
  
  "angle" - angle between two vectors
  

####axis
Is the axial direction of the measurement and can be x, y, z or overall.


####value
Is the actually reading for that subject, activity, domain, measurement, stat and axis.

## Activity Levels
The codes for activity levels are as follows:

1            WALKING

2   WALKING_UPSTAIRS

3 WALKING_DOWNSTAIRS

4            SITTING

5           STANDING

6             LAYING

## Scripts

####A. run_analysis()

This is the main script that performs the 5 steps in the assignment to complete

1. Merges the training and the test sets to create on data set.  Calls the functions tidy_test() ad tidy_train() to ensure that the dataset meets the tidy data criteria.

2. Extracts only the measurements on the mean and data standard deviation for each measurement

3. Use descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names

5. From the dataset in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

####B. tidy_test()

This script takes the raw test data and performs the following

1. creates a identifier to link the data that belongs together in a unit

2. splits out multiple variables that are in one column into 4 columns

3. joins the data that is in multiple tables into one table

####C. tidy_train()

This script does exactly the same tidying for the train data.

## Libraries

  library(reshape2)
  
  library(stringr)
  
  library(dplyr)
