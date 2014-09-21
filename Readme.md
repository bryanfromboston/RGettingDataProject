# Getting and Cleaning Data: Course Project

## Introduction

This is an explanation of my project submission, which is very straightforward. There is only one script, [run_analysis.R](run_analysis.R).

## Code Review

### Step 1: Merging the data

#### Reading the data

Reading the data is straightforward: I read in the test and training sets:

    testSet  <- read.table("./test/X_test.txt", header=FALSE); trainSet <- read.table("./train/X_train.txt", header=FALSE)
    
And I read in the activity labels and subjects as vectors

    testLabels <- scan("./test/Y_test.txt"); trainLabels <- scan("./train/Y_train.txt")
    testSubjects <- scan("./test/subject_test.txt"); trainSubjects <- scan("./train/subject_train.txt")

#### Merging the data

I add the subjects and activities as the *first two columns*:

    testSet <- cbind(subject = testSubjects, activity = testLabels, testSet); 
    trainSet <- cbind(subject = trainSubjects, activity = trainLabels, trainSet)
    
And then I take the two completed tables and stack them on top of each other with `rbind`:

  DF <- rbind(testSet,trainSet)

### Step 2:

Now we need to extract only the columns that are relevant. In this case, we want all variables that are the mean or the standard deviation for each element. For the purposes of this exercise, I define that as any variable with either a `std()` or a `mean()` in the name.

> Note: There are other variables that are angle means. I could have included them in the set of labels without any alteration of the rest of the code, but chose to reduce the dataset to the above to learn how to use regular expressions to search for parenthesis. :)

Read in the measurement names:

    measurementLabels  <- read.table("./features.txt", stringsAsFactors = FALSE)

Read in activitiesk (for later):

    activityLabels <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)

Create a vector that includes subject and activity to match the above tables, and then create a binary vector called `usecols` that will determine whether or not we should include the label in the final dataset:

    colNames <- c("subject", "activity", measurementLabels[,2])

I'm using `grep` to find the `mean()` or `std()` variables here.

    usecols <- grepl("[[:punct:]-](mean|std)[[:punct:](][[:punct:])]", colNames)

We always want to use the first two, since they are the IDs of the observations:

    usecols[1:2] <- TRUE

Finally, we subset the columns of our dataset:

    DF <- DF[,usecols]

### Step 3:

We'll change the `activity` column to use the real activity names from the activty table loaded in earlier. This is a simple matter of applying a short function to the activity that looks up the `activityLabel` by its corresponding number:

    DF$activity <- sapply(DF$activity, function(a) {a <- activityLabels[a,2]})

### Step 4:

Appropriately label the variable names.

> It's important to know how I defined "appopriately" in this case: I define it as the lecture notes specified: so that a human can read it but a machine can process it as well. Therefore, it's important that the labels have:
  * No white space, underscores, or periods
  * All lowercase
  * Are short enough to support spreadsheets like Excel, etc.
  * Are human readable.
Refer to the [codebook](CodeBook.md) on how to read the variables.

First, we'll subset the `colNames` used above the same way we did the table.

    colNames <- colNames[usecols]

And then we clean it up by doing the following:

* Remove the parentheses on `std()` and `mean()`
* Replace the occasional duplicate `Body` in some of the frequency variables
* Replace `BodyGyro` with `Gyro` (it's redundant)
* Globally remove all dashes
* Make them all lowercase

    colNames <- sub("std[[:punct:](][[:punct:])]", "std", colNames)
    colNames <- sub("mean[[:punct:](][[:punct:])]", "mean", colNames)
    colNames <- sub("BodyBody","Body", colNames) # remove the extra "Body" in some columns
    colNames <- sub("BodyGyro","Gyro", colNames)
    colNames <- gsub("[[:punct:]-]","", colNames)
    colNames <- tolower(colNames) # Make all lowercase

Finally, apply the column names to the dataset

    colnames(DF) <- colNames

### Step 5:

Create a new, tidy dataset of the mean by subject and activity.

Creating factors out of the subject and activity isn't necessary, but it helps when you want to summarize the data to be sure you're doing it right.

    DF$subject <- factor(DF$subject); DF$activity <- factor(DF$activity)

In order to get a tidy dataset with the averages of each variable, we first need to melt the dataset using the ID variables, which in this case are the `subject` and the `activity` to make a narrow table.

    DFmelt <- melt(DF, id=c("subject","activity"))

Then we build the new, tidy dataset using the `subject` AND `activity`, taking the mean of each variable (note: the `subject + activity` is important):

    tidyData <- dcast(DFmelt, subject + activity ~ variable, mean)

Then we write it to a file and we go have a drink:

    write.table(tidyData,"./tidy_data.txt")




