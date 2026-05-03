# Load the required package
library(dplyr)

# ==============================================================================
# PREPARATION: Download and read the dataset
# ==============================================================================

# Read features (the column names) and activity labels (the dictionary)
# Paths are set assuming your working directory is ALREADY "UCI HAR Dataset"
features <- read.table("features.txt", col.names = c("n", "functions"))
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))

# Read Test data
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = features$functions)
y_test <- read.table("test/y_test.txt", col.names = "code")

# Read Train data
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features$functions)
y_train <- read.table("train/y_train.txt", col.names = "code")


# ==============================================================================
# STEP 1: Merges the training and the test sets to create one data set.
# ==============================================================================

# Bind rows to merge train and test datasets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)

# Bind columns to create the final merged dataset
Merged_Data <- cbind(Subject, Y, X)


# ==============================================================================
# STEP 2: Extracts only the measurements on the mean and standard deviation 
#         for each measurement.
# ==============================================================================

# Use dplyr to select only subject, code, and columns containing 'mean' or 'std'
TidyData <- Merged_Data %>% 
  select(subject, code, contains("mean"), contains("std"))


# ==============================================================================
# STEP 3: Uses descriptive activity names to name the activities in the data set.
# ==============================================================================

# Replace the numeric codes (1 to 6) with corresponding text labels
TidyData$code <- activities[TidyData$code, 2]

# Rename the column from 'code' to 'activity' for better readability
names(TidyData)[2] <- "activity"


# ==============================================================================
# STEP 4: Appropriately labels the data set with descriptive variable names.
# ==============================================================================

# Clean up column names using regular expressions (gsub)
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))
# Remove dots introduced by R when reading column names with special characters
names(TidyData) <- gsub("\\.", "", names(TidyData))


# ==============================================================================
# STEP 5: From the data set in step 4, creates a second, independent tidy data 
#         set with the average of each variable for each activity and each subject.
# ==============================================================================

# Group data by subject and activity, then calculate the mean for all columns
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))

# Write the final tidy dataset into a text file
write.table(FinalData, "FinalData.txt", row.name = FALSE)