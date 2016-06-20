tidy_train <- function(x1,y1,s1,f,a) {
  
  ## TRAIN DATA ##
  ## First read in all the train data
  ##s <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, strip.white = TRUE)
  ##f <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
  ##a <- read.delim("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
  ##x1 <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, strip.white = TRUE)
  ##y1 <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, strip.white = TRUE)
  
  x_train_raw <- x1
  y_train_raw <- y1 
  subject_train_raw <- s1 
  features_raw <- f 
  activities <- a 
  
  ## TIDY DATA ##
  ## 1. Each variable is one column
  ## 2. Each observation is a different row
  ## 3. One table per one "kind" of variable
  ## 4. Multiple tables have one join column
  
  ## MOST COMMON TIDYING ACTIVITIES ##
  ## 1. Tidy column headers ar values not varible namse
  ## 2. Tidy multiple variables stored in one column
  ## 3. Tidy varibles are stored in both rows and columns
  ## 4. Tidy ultiple observational units are stored in the same table
  ## 5. Tidy a single observational unit is stored in multiple tables
  
  ## Add features to raw X data and 
  ## and create variable "sample_id" to link to 
  ## y data and subject data
  fv <- as.vector(features_raw$V2)
  x_train_names <- x_train_raw
  names(x_train_names) <- fv
  x_train_names ["sample_id"] <- NULL
  x_train_names$sample_id <- (1:7352)
  
  ## Add features to subject_train data
  ## and create variable sample_id and subjectid to link to 
  ## y data and x data
  subject_train_names <- subject_train_raw
  subject_train_names$sample_id <- NULL
  subject_train_names$sample_id <- (1:7352)
  names(subject_train_names) <- c("subjectid", "sample_id")
  
  ## Add headers to Y raw data
  ## and create variable sample_id and activityid to link to 
  ## subject data and x data
  y_train_names <- y_train_raw
  y_train_names ["sample_id"] <- NULL
  y_train_names$sample_id <- (1:7352)
  names(y_train_names) <- c("activityid", "sample_id")
  
  ## Merge all subject, activity and raw data together
  ## Link all on sample_id
  x_y_data <- merge(x_train_names, y_train_names, by.x="sample_id", by.y="sample_id", all=TRUE)
  xy_sub_data <- merge(x_y_data, subject_train_names, by.x="sample_id", by.y="sample_id", all=TRUE)
  
  ## 1. Tidy column headers ar values not varible namse
  ## melt the data for column headers that are values 
  ## and not variable names
  ## so now we have 5 variables instead of 561
  ## and 4,124,472 rows instead of 7352
  idvars <- c("sample_id", "activityid", "subjectid")
  sc2 <- melt(xy_sub_data, idvars)
  
  ## all the variables are merged into one
  ## in a column called "variable"
  ## create the new variables that will 
  ## be split out of the  "variable" column
  ## the variables are: domain, measurement, stat, axis
  sc2$domain <- NULL
  sc2$measurement <- NULL
  sc2$stat <- NULL
  sc2$axis <- NULL
  
  ## Split out domain
  domain_sub <- str_sub(sc2$variable, 1,1)
  sc2$domain <- domain_sub
  
  ## Split out measurement
  mvar_v <- str_locate(sc2$variable,"-")
  sc2$measurement <- str_sub(sc2$variable,2,mvar_v[,1]-1)
  
  ## split out stat
  mvar2 <- str_locate(sc2$variable,"\\(")
  sc2$stat <- str_sub(sc2$variable,((mvar_v[,1])+1),(mvar2[,1]-1))
  
  ## split out axis
  axisv <- str_sub(sc2$variable,str_length(sc2$variable))
  sc2$axis <- axisv
  
  ## Make constantly lower case
  sc2$axis <- tolower(sc2$axis)
  sc2$stat <- tolower(sc2$stat)
  sc2$measurement <- tolower(sc2$measurement)
  sc2$domain <- tolower(sc2$domain)
  
  ## Remove "variable" column now that we have all the single 
  sc3 <- sc2
  sc3$variable <- NULL
  
  ## Check new variables
  unique(sc3$domain)
  ## [1] "t" "f" "a"
  
  unique(sc3$measurement)
  ##[1] "bodyacc"             "gravityacc"          "bodyaccjerk"        
  ##[4] "bodygyro"            "bodygyrojerk"        "bodyaccmag"         
  ##[7] "gravityaccmag"       "bodyaccjerkmag"      "bodygyromag"        
  ##[10] "bodygyrojerkmag"     "bodybodyaccjerkmag"  "bodybodygyromag"    
  ##[13] "bodybodygyrojerkmag" NA 
  
  unique(sc3$stat)
  ##[1] "mean"        "std"         "mad"         "max"         "min"        
  ##[6] "sma"         "energy"      "iqr"         "entropy"     "arcoeff"    
  ##[11] "correlation" NA            "meanfreq"    "skewness"    "kurtosis"   
  ##[16] "bandsenergy"
  
  unique(sc3$axis)
  #[1] "x" "y" "z" ")" "1" "2" "3" "4" "8" "6" "0" "s"
  
  ## As we can see there are invalid data that needs cleaing up
  ## clean domain
  valid_domain <- c("f","t")
  sc3[,5][!(sc3[,5] %in% valid_domain)] <- ""
  unique(sc3$domain)
  ## [1] "t" "f" ""
  
  ## clean axis
  valid_axis <- c("x","y","z",")")
  sc3[,8][!(sc3[,8] %in% valid_axis)] <- ""
  sc3$axis <- str_replace(sc3$axis, "\\)", "o")
  valid_axis <- c("x","y","z","o")
  unique(sc3$axis)
  ## [1] "x" "y" "z" "o" "" 
  
  
  ## Split the different observation types into different units
  ## Unit 1 is measurement data via accelorator and gyro
  utr1_data <- subset(sc3, axis %in% valid_axis)
  
  
  return(utr1_data)

  
}