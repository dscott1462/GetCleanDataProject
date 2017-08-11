

## Check if the UCI HAR Dataset folder exists
if (!file.exists("UCI HAR Dataset")) {
  #If it doesn't exist, download the zip file and unzip it
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, "DatZip.zip")
  unzip("DatZip.zip") 
}


# Load the training data
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainY <- read.table("UCI HAR Dataset/train/y_train.txt")
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- cbind(trainSubject, trainY, trainX)

#Load the testing data
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testY <- read.table("UCI HAR Dataset/test/y_test.txt")
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- cbind(testSubject, testY, testX)
 
#Merge Test and Training Data
TrainTest <- rbind(train, test)

#Pull in Features / Column Names
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
nameCol <- c("subject", "activity", features[,2])
colnames(TrainTest) <- nameCol

#Limit the data to features wanted
limitedColumns <- grep(".*mean*|.*std*",nameCol)
TrainTest <- TrainTest[,c(1,2,limitedColumns)]
str(TrainTest)


# Pull in the Activity Labels
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
activity[,2] <- as.character(activity[,2])

#Create a Factor Variable that Uses Descriptive Activity Names
TrainTest$activity <- factor(TrainTest$activity, levels = activity[,1], labels = activity[,2])

#Create average by subject by activity
TrainTest <- TrainTest %>% group_by(subject,activity) %>% summarise_all(funs(mean))

write.table(TrainTest, "tidy.txt", row.names = FALSE, quote = FALSE)
