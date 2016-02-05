This is the README for the course project in Getting and Cleaning Data.

As stated in the project description:
The purpose of this project is to demonstrate your ability to collect, 
work with, and clean a data set. The goal is to prepare a tidy data that 
can be used for later analysis.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S II smartphone. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

The Script:
1.  The first objective is to extract the data from the files and compile into one data set.

#Set working directory to folder that contains files
setwd("~/Desktop/Coursera/UCI_HAR_Dataset")

#Load necessary R packages
library(dplyr)

#Import data from six .txt files into R
subject_train <- as.numeric(read.table("./train/subject_train.txt"))
subject_test <- as.numeric(read.table("./test/subject_test.txt"))
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

What I gather by looking at the dimensions and table() of each data set is that the “subject” tables contain the subject ID numbers of the volunteers, the “y” tables contain the six activity labels, and the “x” tables contain all the raw data measurements.

Now I will cbind the subjects, activities, and measurement data into two data tables — one for the test subjects and another for the train subjects.  Then bind those two tables into one data set.

#Combine (cbind) the "subject", "y", and "x" tables all together
#into two data frames then rbind them into one single data frame
all_test <- cbind(subject_test, y_test, x_test)
all_train <- cbind(subject_train, y_train, x_train)
all_data <- rbind(all_test, all_train)

Finally, I will import the names of the measurement data variables and assign variable names to all the columns.

#Attach variable header names to the data frame (from features.txt)
headers <- read.table("./features.txt",  stringsAsFactors = FALSE)
headers = as.list(c("subject", "activity", headers$V2))
valid_labels <- make.names(headers, unique = TRUE)
names(all_data) <- valid_labels

2.  Extracts only the measurements on the mean and standard deviation for each measurement.

desired_data <- select(all_data, subject, activity, 
                       contains("mean"), 
                       contains("std"), 
                       -contains("meanFreq")
			)

3. Uses descriptive activity names to name the activities in the data set 

#Create descriptive names and assign it to the appropriate number where 
#found in data set
activity_labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                     "SITTING", "STANDING", "LAYING")

for(i in 1:6)
        desired_data$activity[desired_data$activity == i] <- activity_labels[i]
        
desired_data$activity <- as.factor(desired_data$activity)


4.  Appropriately labels the data set with descriptive variable names.  

This was already done previously at the end of step one. 

5. From the data set in step 4, create a second, independent tidy data set with the #average of each variable for each activity and each subject.

#Create final table that displays the average of each variable and each subject. 
final_table <- desired_data %>% group_by(activity, subject) %>%
        summarize_each(funs(mean))

#Write tidy data table out to a .txt file
write.table(final_table, file = "finalTable.txt", row.names = FALSE)


