# Introduction

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

First we read the data into R:

    testSet  <- read.table("./test/X_test.txt", header=FALSE); trainSet <- read.table("./train/X_train.txt", header=FALSE)
    
## Algorithm for Renaming Features:

    if (starts with t) then
      "Time signal" (T)
    else 
      "Frequency signal" (F)
    
BodyAcc:    Body Acceleration (-BA)
BodyGyro:   Linear Velocity   (-LV)
GravityAcc  Gravity Acceleration (-GA)
Jerk        Jerk (-J)
Mag         Magnitude (-M)
X,Y,Z       Axis (-X, -Y, -Z)
-mean(), 
-std()      Measure (-mean, -std)

Example:
T-BA-J-M-mean: Time signal Body acceleration Jerk, Magnitude, mean
T-LV-J-Y-std: Time signal linear velocity Jer, Y Axis, standard deviation
