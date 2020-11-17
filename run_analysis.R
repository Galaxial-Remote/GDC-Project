## Run Analysis
## Script to do the following:
## 1. Merge the training and test sets into a single data set.
## 2. Extract only the measurements on the mean and standard deviation
##    for each measurement.
## 3. Use descriptive activity names for the activities in the data set.
## 4. Label data set with appropriate variable names.
## 5. Create a second, independent, tidy data set with the average of
##    each variable for each activity and each subject.

run_analysis <- function() {
  ##
  #### (1) Merge the training and test sets into a single data set.
  
  ## Read in the files for the test set
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  
  ## Merge the columns of the test data into a single table
  test <- cbind(X_test, y_test)
  
  ## Read in the files for the training set
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  
  ## Merge the columns of the training data into a single table
  train <- cbind(X_train, y_train)
  
  ## Merge the test and training sets into a single table
  observations <- rbind(train, test)
  
  ## Rename y column
  names(observations)[562] <- "Y"
  
  ## Clean up the tables no longer needed
  rm("X_test", "y_test", "test", "X_train", "y_train", "train")

  ##
  #### (2) Extract only the mean & standard deviation variables
  
  ## Read in the feature descriptions
  features <- read.table("./UCI HAR Dataset/features.txt")
  
  ## Create a vector of mean & standard deviation features, including activity
  m_s_feat <- c(grep("(mean|std)\\(", features[, 2]), "activity")
  
  ## Convert the observations table to a tibble for easier manipulation
  library(dplyr)
  observations <- as_tibble(observations)
  
  ## Rename variables to descriptive feature names
  names(observations) <- c(features[,2], "activity")
  
  ## Select only columns matching desired feature names
  observations <- select(observations, grep("(mean|std)\\(", colnames(observations)) | "activity")
  
  ##
  #### (3) Use descriptive activity names for the activities in the data set.
  
  ## Read the activity label reference table
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  ## Apply it to the activity column of the observation data
  observations$activity <- factor(observations$activity, 
                                  levels = activities[,1],
                                  labels = activities[,2])
  
  ##
  #### (4) Label data set with appropriate variable names.
  ## This was completed in a previous step; see line 52
  
  ##
  #### (5) Tidy data set with averages for each variable, subject
  
  ## Read vector of subject IDs
  subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  subjects <- rbind(subjects, read.table("./UCI HAR Dataset/test/subject_test.txt"))
  
  ## Combine vector with observation table
  observations <- cbind(subjects, observations)
  
  ## Rename subject column
  names(observations)[1] <- "subject"
  
  ## Reorder columns to put activity as #2 for grouping
  observations <- select(observations, subject, activity, 2:67)
  
  ## Group data for summarizing
  observations <- group_by(observations, subject, activity)
  
  ## Summarize observations by groups
  ## Comment out the line below to write this dataset to file
  ## write.table(summarize_all(observations, mean), file = "./tidy_dataset.txt")

  summarize_all(observations, mean)
}