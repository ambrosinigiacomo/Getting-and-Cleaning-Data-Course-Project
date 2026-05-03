# Getting and Cleaning Data - Course Project

This repository is the submission for the Getting and Cleaning Data course project on Coursera.

## Dataset
Human Activity Recognition Using Smartphones

## Files in this repository
* `run_analysis.R`: The R script that downloads, merges, and cleans the dataset to produce a tidy data output.
* `FinalData.txt`: The exported final tidy dataset containing the averages of the mean and standard deviation variables for each subject and activity.
* `CodeBook.md`: A code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
* `README.md`: This file, explaining how all of the scripts work and how they are connected.

## How to run the script
1. Ensure the `UCI HAR Dataset` folder is in your current working directory.
2. Open the `run_analysis.R` script in R or RStudio.
3. Install the `dplyr` package if you haven't already (`install.packages("dplyr")`).
4. Run the entire script. It will automatically read the data, process it, and generate the `FinalData.txt` file in your working directory.