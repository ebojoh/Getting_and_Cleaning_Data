## Course Project - Getting and Cleaning Data

This repository explains how the script, run_analysis.R, works to achieve the goal of the course project to prepare tidy data which can be used for later analysis.  

The run_analysis.R script perform the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable  
   for each activity and each subject.
   
The file created as a result of running the run_analysis.R script is called "averages_tidy_dataset.txt"

The data input into the script can be found by accesing the following url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The description of the data can be found by accesing the following url:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones # Getting_and_Cleaning_Data
