Code Book for `run_analysis.R`
==============================

The script follows 5 tasks described in the project explanation.

### Steps:

**Initially** it will download the "*Human Activity Recognition Using Smartphones Dataset*" data, then unzip the ZIP file. (More explanation about the data is inside the downloaded ZIP file). Note that, you can skip the downloading code by commenting the corresponding line in the script. 
 
##### *Variables*: 
- `dataFile`: to store ZIP file name.
- `fileUrl`: to store URL to the downloaded data. 
- `dataPath`: path to the extracted data. 
- `dataPathTrain`: path to the training data. 
- `dataPathTest`: path to the test data. 
 

----------
**First task**, to merge training and test data, this is done by reading three kind of training and test data (features, activities, subjects) into a `data.frame`, then use `rbind()` to merge each of them. Use `file.path` to create OS independent path (Windows uses `\\`, Linux and Mac uses `/`).

"Features" data comes from accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. Time domain data has `t` prefix, while frequency domain data has `f` prefix (obtained by applying Fast Fourier Transform). "Activities" data represents 6 activities performed by human. "Subjects" represents 30 volunteers (human) to be measured.  

Column names for features data is set according to `features.txt` data. Column name for activities data is `Activities`. Column name for subjects data is `Subjects`. The three data: dataX, dataY, dataSubject is merged by `cbind()`. 

##### *Variables*:
- `dataXTrain`: data read from `train/x_train.txt` 
- `dataXTest`: data read from `test/x_test.txt` 
- `dataX`: rbind of both train and test X (features) data
- `featuresColumnName`: data read from `features.txt`, that is column names of features data. 
- `dataYTrain`: data read from `train/y_train.txt` 
- `dataYTest`: data read from `test/y_test.txt` 
- `dataY`: rbind of both train and test Y (activities) data 
- `dataSTrain`: data read from `train/subject_train.txt` 
- `dataSTest`: data read from `test/subject_test.txt` 
- `dataSubject`: rbind of both train and test subjects data
- `oneData`: cbind (by-column merge) of dataX, dataY and dataSubject. 

----------

**Second task**, to extract data having only measurements on *mean* and *standard deviation*. This can be done with the help of `grep` for pattern-matching only columns with "`mean()`" and "`std()`". 

##### *Variables*:
- `filter`: store the vector returned by `grep`, that is *indices* of matched columns. 
- `featuresMeanStd`: extracted column names.
- `filteredColumns`: add `Subjects` and `Activities` to the column names.  
- `oneData`: new subset of data contains only measurements of mean and standard deviation.

----------

**Third task**, to replace activities number with descriptive activity names, based on `activity_labels.txt` data. That's `1_WALKING, 2_WALKING_UPSTAIRS, 3_WALKING_DOWNSTAIRS, 4_SITTING, 5_STANDING, 6_LAYING`. Number is attached as prefix to maintain the order of data's rows.  

##### *Variables*:
- `activityNames`: data read from `activity_labels.txt` to be applied into `oneData$Activities`

----------

**Fourth task**, to appropriately labels the data set with descriptive variable names. This can be done with the help of `gsub` pattern matching and replacement. E.g. change "`fBodyGyro-mean()-X`" to "`Frequency.Body.Gyroscope.Mean.X`"  
 
##### *Variables*: 
- `changes`: list of characters to be replaced and its replacement. 

----------

**Fifth task**, to create independent tidy data set, by taking average of each variable grouped by activity and subject. This can be done with the help of `plyr.aggregate` function. There are 30 subjects and 6 activities, there is 66 features, produce a 180 rows by 66 columns tidy data frame.  

##### *Variables*:
- `tidyData`: output of `aggregate's mean()` to be saved into the `tidy_data.txt` file. 

----------
