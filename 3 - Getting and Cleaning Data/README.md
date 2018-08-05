## Getting and Cleaning Data course project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

### This repository contains the following files:
* run_analysis.R
* tidy_data.txt
* README.md : explains the analysis files is clear and understandable.
* CodeBook.md : modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

###  Steps of the analysis files
* First, the dplyr package will be required.
* Download and unzip the Dataset
* Read in the list of all features and the class labels with activity name.
* Step 1: Extracts only the measurements on the mean and standard deviation for each measurement.
* Step 2: Merges the training and the test sets to create one data set.
* Step 3: Uses descriptive activity names to name the activities in the data set
* Step 4: Appropriately labels the data set with descriptive variable names.
* Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Saved as tidy_Data.txt