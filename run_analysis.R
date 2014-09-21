# We are going to use the plyr library for joining columns
library(plyr)

# We'll use the reshape2 library to melt to tidy data in step 5
library(reshape2)

# Step 1: 
# Merge the training and test sets to create one dataset

# Read the data from the dataset files:
testSet  <- read.table("./test/X_test.txt", header=FALSE); trainSet <- read.table("./train/X_train.txt", header=FALSE)

# Read the labels from the label files
testLabels <- scan("./test/Y_test.txt"); trainLabels <- scan("./train/Y_train.txt")

# Read the subjects from the subject files
testSubjects <- scan("./test/subject_test.txt"); trainSubjects <- scan("./train/subject_train.txt")

# Before merging the rows together from the two datasets, we'll add in the label factors and subject factors
testSet <- cbind(subject = testSubjects, activity = testLabels, testSet); trainSet <- cbind(subject = trainSubjects, activity = trainLabels, trainSet)

# The final combined dataset is created by merging by row:
DF <- rbind(testSet,trainSet)

# Step 2:
# Extracts only the measurements on the mean and standard deviation for each measurement. 

# Read in the measurement names as a vector of 561 variables:
measurementLabels  <- read.table("./features.txt", stringsAsFactors = FALSE)

# Read in activities
activityLabels <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)

# Create a vector that includes the column names, and use it to rename the columns in a descriptive format
colNames <- c("subject", "activity", measurementLabels[,2])

# We're going to reduce the dataset by only including mean and standard deviation.
# To do so, we're find the measurements that include either -mean() or -std() in the column name.
# NOTE: I'm purposefully not including freqMean(), etc. in subset
usecols <- grepl("[[:punct:]-](mean|std)[[:punct:](][[:punct:])]", colNames)

# We still want the first two columns for subject and activity, so we flip them to true
usecols[1:2] <- TRUE

# Using the logical vector, we subset the columns appropriately
DF <- DF[,usecols]

# Step 3:
# Uses descriptive activity names to name the activities in the data set

# Use the lookup table for activity to transform the activity column in the dataset to its relevant description
DF$activity <- sapply(DF$activity, function(a) {a <- activityLabels[a,2]})

# Step 4:
# Appropriately labels the data set with descriptive variable names.

# Using the same binary vector, subset the column names to only the ones we need
colNames <- colNames[usecols]

# Replace std() and mean() with -std and -mean
colNames <- sub("std[[:punct:](][[:punct:])]", "std", colNames)
colNames <- sub("mean[[:punct:](][[:punct:])]", "mean", colNames)
colNames <- sub("BodyBody","Body", colNames) # remove the extra "Body" in some columns
colNames <- sub("BodyGyro","Gyro", colNames)
colNames <- gsub("[[:punct:]-]","", colNames)
colNames <- tolower(colNames) # Make all lowercase

colnames(DF) <- colNames

# Step 5:
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Make subject and activity factors
DF$subject <- factor(DF$subject)
DF$activity <- factor(DF$activity)

# In order to get a tidy dataset with the averages of each variable, we first need to melt the dataset using the ID variables, which in this case are the subject and the activity.
DFmelt <- melt(DF, id=c("subject","activity"))

# Once we get that, we build a new, tidy dataset using the subject AND activity, taking the mean of each variable
tidyData <- dcast(DFmelt, subject + activity ~ variable, mean)
write.table(tidyData,"./tidy_data.txt")


