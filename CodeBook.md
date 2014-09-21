# CodeBook

This document describes the data within [tidy_data.txt](Tidy Data) file derived from the [Human Activity Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from UCI's Machine Learning Repository.

From the original dataset:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

This document describes the means of a subset of 66 variables from the original datasets, merged together and averaged by both subject and activity.

The subset of data includes the mean and the standard deviations of the following measurements.

For brevity, the variable names are constructed in an orderly fashion (unless noted below) as follows:

* First character: t for timed interval, f for frequency interval

Following the first character, the three elements described are:
* bodyacc: Measurement taken from the accelerometer, associated with body accelaration
* gravityacc: Measurement taken from the accelerometer, associated with gravitational acceleration
* gyro: Angular velocity, measurment taken from the gyroscope

Some of those elements have additional measurements

* jerk: Describes the Jerk acceleration or 
* mag: Describes a transformation that gives the magnitude of the variable

All variables are averages of either means or standard deviations:

* std: Standard Deviation
* mean: Mean

Finally, the last character taken from the timed intervals gives the coordinates in a 3-dimensional space:

* x
* y
* z

1              subject: The subject who performed the activity
2             activity: the activity performed, listed above
3        tbodyaccmeanx
4        tbodyaccmeany
5        tbodyaccmeanz
6         tbodyaccstdx
7         tbodyaccstdy
8         tbodyaccstdz
9     tgravityaccmeanx
10    tgravityaccmeany
11    tgravityaccmeanz
12     tgravityaccstdx
13     tgravityaccstdy
14     tgravityaccstdz
15   tbodyaccjerkmeanx
16   tbodyaccjerkmeany
17   tbodyaccjerkmeanz
18    tbodyaccjerkstdx
19    tbodyaccjerkstdy
20    tbodyaccjerkstdz
21          tgyromeanx
22          tgyromeany
23          tgyromeanz
24           tgyrostdx
25           tgyrostdy
26           tgyrostdz
27      tgyrojerkmeanx
28      tgyrojerkmeany
29      tgyrojerkmeanz
30       tgyrojerkstdx
31       tgyrojerkstdy
32       tgyrojerkstdz
33     tbodyaccmagmean
34      tbodyaccmagstd
35  tgravityaccmagmean
36   tgravityaccmagstd
37 tbodyaccjerkmagmean
38  tbodyaccjerkmagstd
39        tgyromagmean
40         tgyromagstd
41    tgyrojerkmagmean
42     tgyrojerkmagstd
43       fbodyaccmeanx
44       fbodyaccmeany
45       fbodyaccmeanz
46        fbodyaccstdx
47        fbodyaccstdy
48        fbodyaccstdz
49   fbodyaccjerkmeanx
50   fbodyaccjerkmeany
51   fbodyaccjerkmeanz
52    fbodyaccjerkstdx
53    fbodyaccjerkstdy
54    fbodyaccjerkstdz
55          fgyromeanx
56          fgyromeany
57          fgyromeanz
58           fgyrostdx
59           fgyrostdy
60           fgyrostdz
61     fbodyaccmagmean
62      fbodyaccmagstd
63 fbodyaccjerkmagmean
64  fbodyaccjerkmagstd
65        fgyromagmean
66         fgyromagstd
67    fgyrojerkmagmean
68     fgyrojerkmagstd
