CodeBook for the tidy datasets
=============================

Data source
-----------
These datasets were derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and which is now available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Selection of Features 
-----------------
You may learn more about the original dataset through the README and features.txt files in the original dataset and to learn about choices of features for these sets.  

In the assignment, it states that it "Extracts only the measurements on the mean and standard deviation for each measurement."
To be complete, I included all variables having to do with mean or standard deviation.

In short, for the second derived dataset, each of the following were used.

* tBodyAcc-[XYZ]
* tGravityAcc-[XYZ]
* tBodyAccJerk-[XYZ]
* tBodyGyro-[XYZ]
* tBodyGyroJerk-[XYZ]
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-[XYZ]
* fBodyAccJerk-[XYZ]
* fBodyGyro-[XYZ]
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

From the above, the set that were utilized for the assignment are: 

* mean(): Mean value
* std(): Standard deviation

I have excluded the estimates of that use a mean calculation inside the angle function as these are not a mean calculation signal itself.
I have also excluded all that pertain to mean frequency calculations, as they were not related directly to a mean calculation itself either.

All other estimates/calculations were removed for this activity.

In each of the feature names, my datasets' columns were renamed such that:
* The t at the beginning of the line is replaced by "timeDomain"
* The f at the beginning of the line is replaced by "frequencyDomain"
* Gyro is replaced by "Gyroscrope"
* Acc is replaced by "Acceleration"
* Mag is replaced by "Magnitude"
* BodyBody is replaced by "Body" as it was a typographical error in the original dataset
* std is replaced by StandardDeviation
* Any () is removed
* X, Y, or Z occuring at the end of the line are replaced by "in[XYZ]Direction"
