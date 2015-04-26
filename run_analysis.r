## Program run_analysis.r
## Objetive : Prepare tidy data for future analysis. 
## Data : UCI Data - Human Activity Recognition Using Smartphones
## URL  : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Notes: Download the zip file, extract the contents and copy the related files to the working directoryt


## Read auxiliary data files.
activityLabels <- read.csv("./activity_labels.txt", header = FALSE, sep= " ", col.names=c("id","activityName"))
featureLabels <- read.csv("./features.txt", header = FALSE, sep= " ", col.names=c("id","featureName"))

## Read training data files.
trainXData <- read.csv("./X_train.txt", header = FALSE, sep= "")
trainYData <- read.csv("./y_train.txt", header = FALSE, sep= "",col.names="Activity")
subjectTrain <- read.csv("./subject_train.txt", header = FALSE, sep= "",col.names="SubjectId")

## Read test data files.
testXData <- read.csv("./X_test.txt", header = FALSE, sep= "")
testYData <- read.csv("./y_test.txt", header = FALSE, sep= "",col.names="Activity")
subjectTest <- read.csv("./subject_test.txt", header = FALSE, sep= "",col.names="SubjectId")


## Merget the data
trainData <- cbind(subjectTrain,trainYData,trainXData)
testData <- cbind(subjectTest,testYData,testXData)
tidyData <- rbind(trainData,testData)

## Extract mean and std
tidyData <- tidyData[,c(1:2,grep("mean.*\\(\\)",featureLabels[,2],ignore.case=T)+3,
                  grep("std\\(\\)",featureLabels[,2],ignore.case=T)+3)]

## Replace activity with descriptive names
ActivityIdx = 1
for (currentActivityLabel in activityLabels$activityName) {
    tidyData[,2] <- gsub(ActivityIdx, currentActivityLabel, tidyData[,2])
    ActivityIdx <- ActivityIdx + 1
}


## Create a second Tidy data set with average of each variable for each activity and each subject
tidyData$Activity <- as.factor(tidyData$Activity)
tidyData$SubjectId <- as.factor(tidyData$SubjectId)
tidyAverage = aggregate(tidyData, by=list(Subject = tidyData$SubjectId, ActivityName = tidyData$Activity), mean)
# Remove extra columns .
tidyAverage$SubjectId <- NULL
tidyAverage$Activity <- NULL

write.table(tidyAverage, "./tidyData.txt", row.name=FALSE )
#write.csv(tidyAverage, "./tidyData.csv")
