# Variables for URL, directory, and files
FileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFile="data.zip"
mainDir = "UCI HAR Dataset"
featuresFile = paste0(mainDir, "/", "features.txt")
xTrainFile = paste0(mainDir, "/", "train/X_train.txt")
xTestFile = paste0(mainDir, "/", "test/X_test.txt")
activityTrainFile = paste0(mainDir, "/", "train/y_train.txt")
activityTestFile = paste0(mainDir, "/", "test/y_test.txt")
subjectTrainFile = paste0(mainDir, "/", "train/subject_train.txt")
subjectTestFile = paste0(mainDir, "/", "test/subject_test.txt")
activityNamesFile = paste0(mainDir, "/", "activity_labels.txt")


# Downloads the URL if its chosen destination file doesn't exist
# Extracts the destination file if the internal main directory doesn't exist
extractFile <- function(){
        if(!file.exists(dataFile))
                download.file(FileURL,destfile = dataFile, mode = "wb")
        if(!file.exists(mainDir))
                unzip(dataFile)
}

readData <- function(){
        extractFile()
        xData = do.call("rbind",lapply(c(xTrainFile,xTestFile),function(x) 
                data.frame( read.table(x))))
        activityData = do.call("rbind",lapply(
                c(activityTrainFile,activityTestFile),
                function(x) data.frame( read.table(x))))[,1]
        subjectData = do.call("rbind",lapply(
                c(subjectTrainFile,subjectTestFile),
                function(x) data.frame( read.table(x))))
# Only the names of the features are important, so I only read the second column
# And I only care about the vector of the names themselves, so I subset them out.
        myFeatures = read.table(featuresFile,
                                colClasses = c("NULL",NA),
                                stringsAsFactors = FALSE)[,1]
        activityNames = read.table(activityNamesFile,
                                   stringsAsFactors = FALSE,
                                   colClasses = c("NULL",NA))[,1]
#1c) Set the column names of the x data table to be equal to the features vector
        colnames(xData) = myFeatures
        colnames(subjectData) = "Subject"
        subjectData$Subject = as.factor(subjectData$Subject)
#1d) Create vector of actual activity names instead of numbers
# blank vector for storing activities
        activityVector = c()
        for(i in 1:length(activityData)){
                activityVector[i] = activityNames[activityData[i]]
        }
#1e) Create data frame of these activities
        activity = as.data.frame(activityVector)
        colnames(activity) = "Activity"
#1f) Combine subject and activity into its own data frame just to keep it separated
        subActivity = cbind(subjectData,activity)
        cbind(subjectData,activity,xData)
}

#2) Extracts only the measurements on the mean and standard deviation for each measurement.
extractData = function(df){
        extractedData = df[grep("Subject|Activity|mean\\(\\)$|std\\(\\)$|mean\\(\\)-[XYZ]$|std\\(\\)-[XYZ]$",names(df))]
        names(extractedData) = setGoodNames(extractedData)
        extractedData
}
#3) Uses descriptive activity names to name the activities in the data set
setGoodNames = function(df){
        # Extract the bad names.
        extractedNames = names(df)
        # If the name begins with t, replace that with "timeDomain"
        extractedNames = sub("^t","timeDomain",extractedNames)
        # If the name begins with f, replace that with "frequencyDomain"
        extractedNames = sub("^f","frequencyDomain",extractedNames)
        # Replace Acc with Acceleration
        extractedNames = sub("Acc","Acceleration",extractedNames)
        # Replace Gyro with Gyroscope
        extractedNames = sub("Gyro","Gyroscope",extractedNames)
        # Replace Mag with Magnitude (note: this is merely a presumption that 
        # it should stand for magnitude as the original README doesn't 
        # directly reference it)
        extractedNames = sub("Mag","Magnitude",extractedNames)
        # BodyBody appears to be a typographical error; replace with Body
        extractedNames = sub("BodyBody","Body",extractedNames)
        # Remove "()" that isn't necessary
        extractedNames = sub("\\(\\)","",extractedNames)
        # Replace std at the end of the line with StandardDeviation
        extractedNames = sub("\\-std\\-","-StandardDeviation-",extractedNames)
        extractedNames = sub("std$","StandardDeviation",extractedNames)
        # Replace with X/Y/Z that are in the end of the name with 
        # "in[X/Y/Z]Direction"
        extractedNames = sub("X$","inXDirection",extractedNames)
        extractedNames = sub("Y$","inYDirection",extractedNames)
        extractedNames = sub("Z$","inZDirection",extractedNames)
        extractedNames
}

getMeanData = function(df){
        newdf = df[ , -which(names(df) %in% c("Subject","Activity"))]
        newdf = aggregate(newdf, by=list(df$Subject,df$Activity),
                          FUN=mean, na.rm=TRUE)
        colnames(newdf)[1] = "Subject"
        colnames(newdf)[2] = "Activity"
        newdf
}

extractFile()
myOriginalData = readData()
extractedData = extractData(myOriginalData)
meanCalculationsData = getMeanSDData(extractedData)
