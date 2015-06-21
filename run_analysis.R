##########################################################################################################

## Coursera Getting and Cleaning Data Course Project By Umair Habib (2015-06-21)

# This script is developed to perform steps required for 
# Coursera's "Getting and Cleaning Data" Course Project
#
# This script is written for data obtained from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##########################################################################################################

# Loading dplyr 
library(dplyr)

# Clean up workspace
rm(list=ls())

# Getting current working directory
currentWD <- getwd()


# Change working directory to the location where the data was unzipped
# TODO: change the following path before running the script 
setwd('./UCI HAR Dataset/');

# Read in Meta Data
features     <- read.table('./features.txt',header=FALSE); 
activityType <- read.table('./activity_labels.txt',header=FALSE); 

# Read in Train Data
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE); 
xTrain       <- read.table('./train/x_train.txt',header=FALSE); 
yTrain       <- read.table('./train/y_train.txt',header=FALSE); 

# Read in Test data
subjectTest <- read.table('./test/subject_test.txt',header=FALSE); 
xTest       <- read.table('./test/x_test.txt',header=FALSE);
yTest       <- read.table('./test/y_test.txt',header=FALSE);


# Assigning column names to the data imported above
colnames(activityType)  <- c('activityId','activityType');

colnames(subjectTrain)  <- "subjectId";
colnames(subjectTest)   <- "subjectId";

colnames(xTrain)        <- features[,2]; 
colnames(xTest)         <- features[,2]; 

colnames(yTrain)        <- "activityId";
colnames(yTest)         <- "activityId";



################################################################
# 1. Merge the training and the test sets to create one Dataset.
################################################################

# Creating Test Dataset
testDataset <- cbind(yTest,subjectTest,xTest);

# Creating Train Dataset
trainingDataset <- cbind(yTrain,subjectTrain,xTrain);

# Creating Complete Dataset
completeDataset <- rbind(trainingDataset,testDataset);



###########################################################################################
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
###########################################################################################

# Columns names with mean / std  / activityId & subjectId in them
colIndeces <- grep("(activityId|subjectId)", colnames(completeDataset))
colIndeces <- c(colIndeces, grep("-(mean|std)\\(\\)", colnames(completeDataset)))

# Selecting only required columns from completeDataset
completeDataset <- completeDataset[, colIndeces]



##########################################################################
# 3. Use descriptive activity names to name the activities in the data set
##########################################################################

# Merging the completeDataset set with the acitivityType table 
completeDataset <- merge(completeDataset, activityType, by='activityId', all.x=TRUE);

######################################################################
# 4. Appropriately label the data set with descriptive activity names. 
######################################################################

# Removing parentheses
names(completeDataset) <- gsub('\\(|\\)',"",names(completeDataset), perl = TRUE)
# Make syntactically valid names
names(completeDataset) <- make.names(names(completeDataset))
# Replace Abbreviations with real words
names(completeDataset) <- gsub('Acc',"Acceleration",names(completeDataset))
names(completeDataset) <- gsub('GyroJerk',"AngularAcceleration",names(completeDataset))
names(completeDataset) <- gsub('Gyro',"AngularSpeed",names(completeDataset))
names(completeDataset) <- gsub('Mag',"Magnitude",names(completeDataset))
names(completeDataset) <- gsub('^t',"TimeDomain.",names(completeDataset))
names(completeDataset) <- gsub('^f',"FrequencyDomain.",names(completeDataset))
names(completeDataset) <- gsub('\\.mean',".Mean",names(completeDataset))
names(completeDataset) <- gsub('\\.std',".StandardDeviation",names(completeDataset))
names(completeDataset) <- gsub('Freq\\.',"Frequency.",names(completeDataset))
names(completeDataset) <- gsub('Freq$',"Frequency",names(completeDataset))


####################################################################################################################
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
####################################################################################################################

# Creating temporary dataset to hold records without activityType
tempDataset <- select(completeDataset, -(activityType))

# Summarizing tempDataset to find mean of all the measures by activityId and then by subjectId
summarizeDataset <- summarise_each(group_by(tempDataset, activityId, subjectId), funs(mean))

# Merging the summarizeDataset with activityType to include descriptive activity names
summarizeDataset    <- merge(summarizeDataset, activityType, by='activityId',all.x=TRUE);

# Writing  summarizeDataset
write.table(summarizeDataset, './tidyData.txt',row.names=TRUE,sep='\t');

# Setting back original working directory
setwd(currentWD)