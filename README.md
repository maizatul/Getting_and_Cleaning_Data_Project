============================================================================
This README.md file is part of the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

[1] Set working directory
[2] Download the dataset from url : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to the working directory
[3]Load the activity labels and feature information
[4] Load both the training and test datasets, extract only the data on mean and standard deviation
[5]Loads the activity and subject data for each dataset, and merges those columns with the dataset
[6]Merges the two datasets
[7]Converts the activity and subject columns into factors
[8]Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
[9]The end result is shown in the file tidy.txt.
==============================================================================
