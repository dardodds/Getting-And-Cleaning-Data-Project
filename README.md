# Getting-And-Cleaning-Data-Project

author: "Darlene Dodds"

The purpose of this project is to demonstrate an ability to collect, work with and clean a data set.  The goal is to prepare tidy data that can be used for later analysis.  This is a list of submissions for this project

1. tidy data set

2. a link to GITHUB repository with the required scripts

3. a code book that describes the variables, the data and any transformations. 

4. README.md explaining data and scripts and how the scripts work.

5. The work submitted for this project is the work of the student who submitted it.

## Input Data

All the input data is from the UCI and can be downloaded using this url https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The files are in a UCI HAR Dataset.zip file and are as follows

Test Data Files

1.  activity_labels.txt
2.  features_info.txt
3.  features.txt
4.  README.txt
5.  test/subject_test.txt
6.  x_test.txt
7.  y_test.txt
8.  Inertial Signals

Train Data Files

1.  activity_labels.txt
2.  features_info.txt
3.  features.txt
4.  README.txt
5.  train/subject_test.txt
6.  x_train.txt
7.  y_train.txt
8.  Inertial Signals


## Output Data Files

1.  tidy.txt - merged training and test data set meets tidy data requirements

2.  tidy2.txt - second tidy data with with the average of each variable for each activity and each subject

## Code Book Link

Please find the code book for this project at 


## Scripts

####A. run_analysis()

This is the main script that performs the 5 steps in the assignment to complete

1. Merges the training and the test sets to create on data set.  Calls the functions tidy_test() ad tidy_train() to ensure that the dataset meets the tidy data criteria.

2. Extracts only the measurements on the mean and data standard deviation for each measurement

3. Use descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names

5. From the dataset in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

####B. tidy_test()

This script takes the raw test data and performs the following to achieve a tidy dataset

1. creates a identifier to link the data that belongs together in a unit

2. splits out multiple variables that are in one column into 4 columns

3. joins the data that is in multiple tables into one table

####C. tidy_train()

This script does exactly the same tidying for the train data.

####D. Running Scripts

In RStudio, change the working directory with the setwd(dir="path") where all your data is.  Once this has been saved, just call the function run_analysis() and it will call tidy_test() and tidy_train() and then writeout all the tidy data sets to the working directory.


