run_analysis <- function() {
  
  ## Setup
  
  setwd("~/Projects/tidydata")
  library(reshape2)
  library(stringr)
  library(dplyr)
  
  ## Read in all the data
  x <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, strip.white = TRUE)
  y <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, strip.white = TRUE)
  s <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, strip.white = TRUE)
  f <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
  a <- read.delim("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
  x1 <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, strip.white = TRUE)
  y1 <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, strip.white = TRUE)
  s1 <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, strip.white = TRUE)
  activities <- a
  
  ## ASSIGNMENT STEP 1
  ## TIDY DATA            
  ## 1. Each variable is one column
  ## 2. Each observation is a different row
  ## 3. One table per one "kind" of variable
  ## 4. Multiple tables have one join column
  
  ## 1. Merges the training and test sets to create on data set
  ##    First tidy the test data
  ##    Next tidy the train data
  ##    Merge the tidy test and train data
  ##    Write the tidy data out to files

    test_df <- tidy_test (x,y,s,f,a)
    train_df <- tidy_train (x1,y1,s1,f,a)
    all_df <- merge(test_df,train_df,all.x = TRUE, all.y= TRUE)
    
  ## ASSIGNMENT STEP 2
  ## 2. Extract only the measurements on mean and standard deviation
  ##    for each measurement
    
    stat_var <- c("mean","std")
    mean_std_sub_data <- subset(all_df, stat %in% stat_var)
    
  ## ASSIGNMENT STEP 3   
  ## 3. Use descriptive activity names to name the 
  ##    activites in the dataset
    
    activty_lvs <- activities[,2]
    mean_std_sub_data$activity<- NULL
    mean_std_sub_data$activity<- factor(activty_lvs[mean_std_sub_data$activityid], levels = activty_lvs)
    write.table(mean_std_sub_data, file = "./data/tidy.txt",row.names = FALSE)
  
  ## ASSIGNMENT STEP 4   
  ## 4. Appropriately labels the data set with descriptive variable names 
    
    names(mean_std_sub_data)

  ## [1] "sample_id"   "activityid"  "subjectid"  
  ## [4] "value"       "domain"      "measurement"
  ## [7] "stat"        "axis"        "activity"  

  ## ASSIGNMENT STEP 5 
  ## 5. From data set in step 4, creates a second, independent tidy data
  ##    set with the average of each variable for each activity and each
  ##    subject
    
  ## tidy2 is a tidy subset with only subjectid, activity, 
  ## measurement and mean    
    
    sub2 <- subset(mean_std_sub_data[,c(3,4,6,9)])
    grp1 <- group_by(sub2, subjectid, activity, measurement)
    tidy2 <- summarize(grp1, mean = mean(value) )
    write.table(tidy2, file = "./data/tidy2.txt",row.names = FALSE)
    return(tidy2)
}
