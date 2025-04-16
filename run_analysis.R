## You should create one R script called run_analysis.R 
# that does the following. 
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

# run_analysis.R

library(dplyr)

# 1. Load and merge training and test sets

# Read features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Read training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

# Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")

# Merge datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

merged_data <- cbind(subject_data, y_data, x_data)

# 2. Extract measurements on the mean and standard deviation
mean_std_data <- merged_data %>%
  select(subject, activity, contains("mean()"), contains("std()"))

# 3. Use descriptive activity names
mean_std_data$activity <- factor(mean_std_data$activity, 
                                 levels = activities$code, 
                                 labels = activities$activity)

# 4. Appropriately label the data set with descriptive variable names
names(mean_std_data) <- gsub("^t", "Time", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data) <- gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data) <- gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data) <- gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data) <- gsub("\\()", "", names(mean_std_data))
names(mean_std_data) <- gsub("-", "", names(mean_std_data))

# 5. Create tidy dataset with the average of each variable for each activity and subject
tidy_data <- mean_std_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Save tidy data
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

