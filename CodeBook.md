# Code Book: Getting and Cleaning Data Course Project

This code book describes the variables, the data, and any transformations or work that was performed to clean up the data.

## 1. The Data Source
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## 2. Identifiers
The `FinalData.txt` contains 180 rows and 88 columns. The first two columns are identifiers:
* `subject`: The ID of the test subject (an integer from 1 to 30).
* `activity`: The type of activity performed when the corresponding measurements were taken. 

## 3. Activity Labels
The `activity` column contains one of the following 6 labels:
* `WALKING`
* `WALKING_UPSTAIRS`
* `WALKING_DOWNSTAIRS`
* `SITTING`
* `STANDING`
* `LAYING`

## 4. Transformations (The 5 Steps)
The `run_analysis.R` script performs the data preparation and then followed by the 5 steps required as described in the course project's definition:
1. **Merges the training and the test sets** to create one data set using `rbind()` and `cbind()`.
2. **Extracts only the measurements on the mean and standard deviation** for each measurement using the `dplyr` package (`select` function).
3. **Uses descriptive activity names** to name the activities in the data set by replacing numbers with the strings from `activity_labels.txt`.
4. **Appropriately labels the data set with descriptive variable names**. All abbreviations were replaced to make them human-readable (e.g., `Acc` replaced with `Accelerometer`, `Gyro` with `Gyroscope`, `f` with `Frequency`, `t` with `Time`).
5. **Creates a second, independent tidy data set** with the average of each variable for each activity and each subject. This was done using `group_by` and `summarise_all`, exporting the result to `FinalData.txt`.