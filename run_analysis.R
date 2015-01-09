library(plyr)


# download data file, attention: big file size of 61 MB! 
# once downloaded, commenting "download.file()" to avoid re-download! 
dataFile <- "UCI HAR Dataset.zip" 
#    in case trouble, change https to http
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#    for OS: linux & mac use curl
#download.file(fileUrl, destfile=dataFile, method="curl")
#    for OS: windows, 
download.file(fileUrl, destfile=dataFile)

# extract data by unzip
unzip(zipfile=dataFile)

# path to data
dataPath <- "UCI HAR Dataset"
dataPathTrain <- file.path(dataPath, "train")
dataPathTest <- file.path(dataPath, "test")

# ----------- task #1 ------------
# merges the training and the test sets to create one data set
#    features
dataXTrain <- read.table(file.path(dataPathTrain, "X_train.txt"))
dataXTest <- read.table(file.path(dataPathTest, "X_test.txt"))
dataX <- rbind(dataXTrain, dataXTest)  # row bind
#    names
featuresColumnName <- read.table(file.path(dataPath, "features.txt"))
# head(featuresColumnName)  # test, it has 2 columns V1, V2
names(dataX) <- featuresColumnName[, 2]

#    activities
dataYTrain <- read.table(file.path(dataPathTrain, "y_train.txt"))
dataYTest <- read.table(file.path(dataPathTest, "y_test.txt"))
dataY <- rbind(dataYTrain, dataYTest)  # row bind
names(dataY) <- c("Activities")

#    subjects
dataSTrain <- read.table(file.path(dataPathTrain, "subject_train.txt"))
dataSTest <- read.table(file.path(dataPathTest, "subject_test.txt"))
dataSubject <- rbind(dataSTrain, dataSTest)  # row bind
names(dataSubject) <- c("Subjects")

# test row length == 10299
#length(dataX[,1])
#length(dataY[,1])
#length(dataSubject[,1])

# one data set, bind columns
oneData <- cbind(dataX, dataY, dataSubject)

# ----------- task #2 ------------
# extracts only the measurements on the mean and standard deviation for each measurement
# filter, pass only data with 'mean()' and 'std()'
filter <- grep("mean\\(\\)|std\\(\\)", featuresColumnName[, 2])
featuresMeanStd <- featuresColumnName[filter, 2]
# selected columns
filteredColumns <- c("Activities", "Subjects", as.character(featuresMeanStd))
oneData <- subset(oneData, select=filteredColumns)

# ----------- task #3 ------------
# uses descriptive activity names to name the activities in the data set
# change index to name, based on the activity_labels.txt
# 1:WALKING, 2:WALKING_UPSTAIRS, 3:WALKING_DOWNSTAIRS, 4:SITTING, 5:STANDING, 6:LAYING
activityNames <- read.table(file.path(dataPath, "activity_labels.txt"))
activityNames[,2] <- paste(as.character(activityNames[,1]), as.character(activityNames[,2]), sep="_")
oneData$Activities <- activityNames[oneData$Activities, 2]

# ----------- task #4 ------------
# appropriately labels the data set with descriptive variable names
# change the labels, e.g. 
#   fBodyGyro-mean()-X to Frequency.Body.Gyroscope.Mean.X
#   tBodyAccJerkMag-std() to Time.Body.Accelerometer.Jerk.Magnitude.StandardDeviation
changes <- list(c("^t", "Time."), 
                c("^f", "Frequency."), 
                c("-mean\\(\\)", "Mean"), 
                c("-std\\(\\)", "StandardDeviation"), 
                c("-X", ".X"), 
                c("-Y", ".Y"), 
                c("-Z", ".Z"), 
                c("Acc", "Accelerometer."), 
                c("Mag", "Magnitude."), 
                c("Jerk", "Jerk."), 
                c("Gyro", "Gyroscope."), 
                c("Gravity", "Gravity."), 
                c("BodyBody", "Body"), 
                c("Body", "Body.") 
                )
for (change in changes) {
  names(oneData) <- gsub(change[1], change[2], names(oneData))
}

# ----------- task #5 ------------
# from the data set in step 4, creates a 2nd, 
#   independent tidy data set with the average of each variable for each activity and each subject
tidyData <- aggregate(formula=.~Subjects+Activities, data=oneData, FUN=mean)
write.table(tidyData, file="tidy_data.txt", row.name=FALSE)
