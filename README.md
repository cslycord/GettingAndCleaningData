# GettingAndCleaningData
### Overview

This is a simple R script for reading, merging, and cleaning up the data set located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
In particular, it:

-   Downloads/extracts the data set (assuming they haven't been downloaded/extracted already). This creates a directory named "UCI HAR Dataset" with the original data
-   Merges together the training and testing sub-datafiles
*	The main directory contains test and train subdirectories, activity_labels.txt, features.txt, features_info.txt, and a README at README.txt.
--	activity_labels.txt has each line with a number and a corresponding activity. During each observation/test, the individual is performing one of these activities.
--	features.txt contains the original names of the 561 calculations that were performed on each individual each time they were tested.
--	features_info.txt contains helpful descriptions pertaining to how the names of the variables used in features.txt were arrived at.
--	Training set is located inside the "train" directory and the testing set is located in the test data set.
--	Inside the directories, there are 3 files: subject_[train/test].txt, X_[train/test].txt, and y_[train/test].txt. The "Inertial Signals" subdirectory in each is not used in this analysis.
--	subject_[train/test].txt has a single number on each line corresponding to the indivual who was being tested. This is a subject number identifier.
--	X_[train/test].txt has each line being the set of numeric calculations performed. There are 561 separate calculations on each line corresponding to the names from features_info.txt
--	y_[train/test].txt has each line corresponding to the activity that was being performed each time. They are represented here by a number.
--	read.table is used to combine the X training and testing sets together, then the columns are changed to the values from features.txt
--	cbind is then used to combine this data together with the subject and activities for each test.
--	Performed inside readData function.
-	Extracts only the measurements on the mean and standard deviation for each measurement.
--	This is performed using grep inside extractData function.
-   Uses descriptive activity names to name the activities in the data set
--	Performed by setGoodNames function using R sub function to replace pertions of the activity names
-   Appropriately labels the data set with descriptive variable names.
--	Variable names chosen to describe them clearly as neccesary
-	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
--	Performed by getMeanData function using R aggregate function to generate the mean of each variable for each activity and subject.

### Installation

Installation is not neccesary, per se as this is a script.

If you are working within R/RStudio then you can simply download "run_analysis.R" and run

```r
source("run_analysis.R")
```

### Usage

```r
source("run_analysis.R")
```

#### Output
This will generate 3 values in the global environment: myOriginalData (original dataset), extractedData (the dataset with mean and standard deviation calculations extracted), and meanCalculationsData (the mean of each variable from the extracted data for each subject and activity).

#### Note
In the data set, I have excluded the features that mention meanFreq() as the description of how those were performed does not match a normal simple mean calculation.
