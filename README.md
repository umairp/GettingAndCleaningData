
#Course Project - Getting and Cleaning Data 
==========================================

This repository is for R code and documentation files for the Coursera's "Getting and Cleaning data" course.

The dataset being used here is obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Files

`CodeBook.md`: It describes variables, the data, and the steps performed to transform that data.

`readme.md`: This file contains important information regarding this repository

`run_analysis.R` This is a code file written in R that can be run in R console using `source("run_analysis.R")`

`ridyData.txt` This file contains data after transformation

## How to Run

* Download and unzip data
* Place the file `run_analysis.R` in current working directory
* Change the code file (line 25). Add path to location where the data is unzipped
* Run file `source("run_analysis.R")`

## Operations
It performs the following operations on Data Files:

1. Read all the meta data  in following variables:
	--* features 
	--* activityType
2. Read Training data in following variables:
	--* subjectTrain 
	--* xTrain 
	--* yTrain
3. Read Test data in following variables
	--* subjectTest
	--* xTest
	--* yTest
4. Assigns column names to the data 
5. Bind columns of Test datasets and assign to testDataset
6. Bind columns of Train datasets and assign to trainDataset
7. Bind both datasets and assign to completeDataset
8. Assign only the columns with mean and std to completeDataset
9. Merge completeDataset with activityType 
10. Rename columns to appropriate names
11. Create summarizeDataSet by taking means of all the measures
12. Write summarizeDataSet to file