library(dplyr)
library(plyr)

### 1.0 Download the folder containing separate data sets:
  if(!file.exists("./cleaningDataWeek4")){dir.create("./cleaningDataWeek4")}
  if(!file.exists("./cleaningDataWeek4/data.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, destfile = "./cleaningDataWeek4/data.zip")
    unzip(zipfile = "./cleaningDataWeek4/data.zip", exdir = "./cleaningDataWeek4")
}


### 2.0 Merge training and testing set

  # 2.1 Read "train" and "test" files
    x_train <- read.table("./cleaningDataWeek4/UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./cleaningDataWeek4/UCI HAR Dataset/train/y_train.txt")
    subject_train <- read.table("./cleaningDataWeek4/UCI HAR Dataset/train/subject_train.txt")
  
    x_test <- read.table("./cleaningDataWeek4/UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./cleaningDataWeek4/UCI HAR Dataset/test/y_test.txt")
    subject_test <- read.table("./cleaningDataWeek4/UCI HAR Dataset/test/subject_test.txt")
  
  # 2.2 Read the feature vector and activity labels
    features <- read.table("./cleaningDataWeek4/UCI HAR Dataset/features.txt")
    activity_labels <- read.table("./cleaningDataWeek4/UCI HAR Dataset/activity_labels.txt")
  
  # 2.3 Assign column names to train and test data set 
    colnames(x_train) <- features[,2]
    colnames(y_train) <- "activity_id"
    colnames(subject_train) <- "subject_id"
  
    colnames(x_test) <- features[,2]
    colnames(y_test) <- "activity_id"
    colnames(subject_test) <- "subject_id"
  
    colnames(activity_labels) <- c("activity_id", "activity")
    
  # 2.4 Column bind distinct train data, and test data
    train_merged <- cbind(y_train, subject_train, x_train)
    test_merged <- cbind(y_test, subject_test, x_test)
  
  #2.5 Row bind all train and test data together 
    merged_data <- rbind(train_merged, test_merged)


### 3.0 List the standard deviation and mean for each measurement 
  
  # 3.1 Create a character vector of column names using the colnames() function
    colNames <- colnames(merged_data)
  
  # 3.2 Create a logical vector selecting all columns from the merged data set using column names refering to "mean" or "std" along with the activity and subject IDs   
    mean_std <- (grepl("activity_id", colNames) |
                  grepl("subject_id", colNames) |
                  grepl("mean...", colNames) |
                  grepl("std...", colNames))
  
  # 3.3 Subset the merged data using the logical vector created in the last step
    subset_mean_std <- merged_data[ , mean_std == TRUE]  
  
  # 3.4 Add the activity names in lieu of the numeric factor levels
    descriptive_subset_mean_std <- merge(subset_mean_std, activity_labels, by = "activity_id", all.x = TRUE)
    descriptive_subset_mean_std$activity_id <- as.factor(descriptive_subset_mean_std$activity_id)
    descriptive_subset_mean_std$activity_id<- revalue(descriptive_subset_mean_std$activity_id, c("1" = "Walking", 
                                                       "2" = "Walking Upstairs", 
                                                       "3" = "Walking Downstairs", 
                                                       "4" = "Sitting", 
                                                       "5" ="Standing", 
                                                       "6" = "Laying"))
    
### 4.0 Create an additional independant data set conatining the average of each variable for each activity and each subject
    
  # 4.1 Use the aggregate() function to create the new data set and collate rows using order() in terms of both subject and activity 
    tidy_data_set <- aggregate(. ~subject_id + activity_id, descriptive_subset_mean_std, mean)
    tidy_data_set <- tidy_data_set[order(tidy_data_set$subject_id, 
                                         tidy_data_set$activity_id), ]
  # 4.2 Save this new tidy data set
    if(!file.exists("./cleaningDataWeek4/tidy_data_set.txt")){write.table(tidy_data_set, "./cleaningDataWeek4/tidy_data_set.txt", row.names = FALSE)} 
    
