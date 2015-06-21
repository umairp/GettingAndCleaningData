# Introduction

The script `run_analysis.R` performs the 5 steps described in the course project's definition. It uses dplyr library for some of it's tasks.

## Variables
`features`: Holds Measure names.  Data from features.txt. 

`activityType`: Holds Activity Types. Data from activity_labels.txt.

`subjectTrain`: Holds Subject Ids for Training Subjects.

`xTrain`: Holds Values for Measures for Training Subjects. 

`yTrain`: Holds Activity Ids for Training Subjects. 

`subjectTest`:  Holds Subject Ids for Test Subjects.

`xTest`:  Holds Values for Measures for Test Subjects.     

`yTest`:  Holds Activity Ids for Test Subjects.      

`testDataset`: Holds Training Data

`trainingDataset`: Holds Test Data

`completeDataset`: Holds Combination of Training and Test Data

`tempDataset`: Holds completeDataset without Activity Types

`summarizeDataset`: Holds Data with Averages 

