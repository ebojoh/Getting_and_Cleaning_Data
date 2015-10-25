## Initialize directory and files
## ****************************************************************************************************

## Set working directory
setwd("~/Desktop/Coursera/Course3Project")

## Install and load the plyr package and library
install.packages("dplyr")
library(plyr)

## Name the destination file that will store the downloaded data
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

## Download and unzip the data from the url:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Question 1
## Merge the training and the test sets to create one data set.
## ****************************************************************************************************

## Load Training Data from supplied file
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
Subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Get Test Data from supplied file
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
Subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

## Merge Training and Test datasets
X_dataset <- rbind(X_train, X_test)
Y_dataset <- rbind(Y_train, Y_test)
Subject_dataset <- rbind(Subject_train, Subject_test)

## Question 2
## Extracts only the measurements on the mean and standard deviation for each measurement.
## ****************************************************************************************************

measures <- read.table("UCI HAR Dataset/features.txt")
measures[,2] <- as.character(measures[,2])
mean_and_std_measures <- grep(".*mean.*|.*std.*", measures[,2])
mean_and_std_measures.names <- measures[mean_and_std_measures,2]
mean_and_std_measures.names = gsub('-mean', 'Mean', mean_and_std_measures.names)
mean_and_std_measures.names = gsub('-std', 'Std', mean_and_std_measures.names)
mean_and_std_measures.names <- gsub('[-()]', '', mean_and_std_measures.names)

## Assign column names with mean and standard deviation to the X dataset
X_dataset <- X_dataset[, mean_and_std_measures]
names(X_dataset) <- mean_and_std_measures.names

## Question 3
## Use descriptive activity names to name the activities in the data set.
## ****************************************************************************************************

## Update the column name of the Y data set with proper activity names from the activity text file
activityNames <- read.table("UCI HAR Dataset/activity_labels.txt")
activityNames[,2] <- as.character(activityNames[,2])
Y_dataset[, 1] <- activityNames[Y_dataset[, 1], 2]
names(Y_dataset) <- "Activity"

## Question 4
## Appropriately label the data set with descriptive activity names.
## ****************************************************************************************************

## This piece of code completes the assignment of descriptive names by naming the column of the Subject
## data set to "Subject". It also merges all the Training and Test data sets into the variable, "Complete_dataset"
## by using the cbind function
names(Subject_dataset) <- "Subject"
Complete_dataset <- cbind(Subject_dataset,Y_dataset,X_dataset)

## Question 5
## From the data set in step 4, creates a second, independent tidy data set with the average of each
## variable for each activity and each subject.
## ****************************************************************************************************

## This piece of code uses the ddply function to compute the average (mean) for each group of "Subject" and
## "Activity". The length(X_dataset) returns the number of mean and standard deviation columns for which we need
## to calculate averages (mean).
averages_data <- ddply(Complete_dataset, .(Subject, Activity), function(x) colMeans(x[, 3:length(X_dataset)]))
write.table(averages_data, "averages_tidy_dataset.txt", row.name=FALSE)