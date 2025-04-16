# Getting and Cleaning Data Course Project

This repository contains the code for the course project of the Getting and Cleaning Data course on Coursera.

## Files

- `run_analysis.R`: R script that performs the following:
  - Merges the training and the test sets to create one data set.
  - Extracts only the measurements on the mean and standard deviation.
  - Uses descriptive activity names.
  - Labels the data set with descriptive variable names.
  - Creates a second, tidy dataset with the average of each variable for each activity and subject.

- `tidy_data.txt`: The final tidy dataset created by `run_analysis.R`.

- `CodeBook.md`: Describes the variables and transformations.

## Instructions

1. Download the [UCI HAR Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones).
2. Unzip the dataset and place the `UCI HAR Dataset` folder in your R working directory.
3. Run the script with:

```r
source("run_analysis.R")
