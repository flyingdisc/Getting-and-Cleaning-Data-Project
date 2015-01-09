Coursera - Data Science - Getting and Cleaning Data 
=================================================== 

This is repository for **Getting and Cleaning Data** course project. 
The purpose of the project is to learn how to read, work with, and cleaning data set, thus finally to create an independent tidy data set. 

### Notes:  

* `project.pdf` is explanation of the course project printed into PDF.

* `run_analysis.R` is R code as requirement of the project. The code contains 5 steps described in the rubric to collect data, work with and clean the data. Expected output is a tidy data set for further analysis. Load and run this script in RStudio: source("run_analysis.R") 

* `CodeBook.md` explains variables used in code, as well steps to be performed. 

* `tidy_data.txt` is the output data file. 

* `UCI HAR Dataset.zip` is data file to be downloaded from 
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
. The data has big size (61 MB). To skip downloading the data, do commenting `file.download()` line in the script. 

### Scripts:
It will download the "*Human Activity Recognition Using Smartphones Dataset*" data, then unzip the ZIP file.  

There are 2 types of data: training and test. Both are merged. Each type consists of 3 set of data: features (X, there are hundreds), activities (Y, there are 6 activities), and subjects (there are 30 people). Features-train is merged with features-test, activities-train is merged with activities-test, subjects-train is merged with subjects-test. 

Column names also be set, for the features data set the names is read from available "features.txt" data set. While activities and subjects has only one column. 

Three set of data are further merged to produce single data set. Merging are simply done by using `rbind` and `cbind`. 

Then the single data set is filtered (extracted), to pass only data with `mean()` and `std()` (mean and standard deviation). 

Activities data is represented as number (1..6). Make it more descriptive, the script replace the number with character (string). E.g. cell `2` is replaced by `2_WALKING_UPSTAIRS`. The prefix `2` is kept to maintain the order of the data's rows.  

The data set's remaining labels (the features' column names) are also be replaced to make it more descriptive. E.g. replace "`fBodyGyro-mean()-X`" by "`Frequency.Body.Gyroscope.Mean.X`" 

Now that the data has been cleaned, the script finally create the independent tidy data set. This is done by taking average of each variable grouped by "activity" and "subject". The output data frame has 30 subjects and 6 activities, with 66 features. That's 180 rows by 66 columns. 

More details on how the script works and the code variables, is available in the "CodeBook.md". 

----------
