#1. Merges the training and the test sets to create one data set

#Set working directory as needed
setwd("~/Desktop/Coursera/UCI_HAR_Dataset")

#load necessary R packages
library(dplyr)

#Import data from 6 .txt files into R
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

#What I see by looking at the dimensions and table() of
#each data set is that the x tables contain all the raw data measurements,
#the subject tables contain the subject ID numbers, and 
#the y tables contain the activity labels.

#Combine (cbind) the "subject", "y", and "x" tables all together
#into two data frames then rbind them into one single data frame
all_test <- cbind(subject_test, y_test, x_test)
all_train <- cbind(subject_train, y_train, x_train)
all_data <- rbind(all_test, all_train)

#Attach variable header names to the data frame (from features.txt)
headers <- read.table("./features.txt",  stringsAsFactors = FALSE)
headers = as.list(c("subject", "activity", headers$V2))
valid_labels <- make.names(headers, unique = TRUE)
names(all_data) <- valid_labels


#2. Extracts only the measurements on the mean and the std dev for each measurement
desired_data <- select(all_data, subject, activity, 
                       contains("mean"), 
                       contains("std"), 
                       -contains("meanFreq")
                       )


#3. Uses descriptive activity names to name the activities
#Create descriptive names and assign it to the appropriate number where 
#found in data set
activity_labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                     "SITTING", "STANDING", "LAYING")

for(i in 1:6)
        desired_data$activity[desired_data$activity == i] <- activity_labels[i]
        
desired_data$activity <- as.factor(desired_data$activity)


#4.  Appropriately labels the data set with descriptive variable names.
#    (This was already done in part 1)


#5. From the data set in step 4, create a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
final_table <- desired_data %>% group_by(activity, subject) %>%
        summarize_each(funs(mean))

arrange(final_table, activity, subject)

write.table(final_table, file = "finalTable.txt", row.names = FALSE)
