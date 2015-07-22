getwd()

##########################################################################################################

## Coursera Getting and Cleaning Data Course Project

## 25th July 2015

# run_analysis.R File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################
setwd("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset")

# Load activity labels and features
activityLabels <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
Wantedfeatures <- grep(".*mean.*|.*std.*", features[,2])
Wantedfeatures.names <- features[Wantedfeatures,2]
Wantedfeatures.names = gsub('-mean', 'Mean', Wantedfeatures.names)
Wantedfeatures.names = gsub('-std', 'Std', Wantedfeatures.names)
Wantedfeatures.names <- gsub('[-()]', '', Wantedfeatures.names)


# Load train  dataset
train <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/train/X_train.txt")[Wantedfeatures]
trainActivities <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

#Load test dataset
test <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/test/X_test.txt")[Wantedfeatures]
testActivities <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("/Users/DELL 1/Documents/Module3_Project1/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge train and test datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", Wantedfeatures.names)

# turn activities and subjects labels into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

