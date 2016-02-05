
Samsung Data Project
===================


This is the README for the course project in Getting and Cleaning Data.


####Project description:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare a tidy data that can be used for later analysis.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S II smartphone. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 


####Method:
The R code in the script "run_analysis.R" does the following:

1.  First, reads in all the data from the files and merge it into one data set.

2. Extracts only the measurements on the mean and the std dev for each measurement

3. Uses the descriptive activity names "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING" and assigns them to the appropriate number in the data set

4. Appropriately labels the data set with descriptive variable names
5. Creates an independent tidy data set with the average of each variable for each activity and subject.

The final independent tidy data set has been printed out to the file "finalTable.txt"