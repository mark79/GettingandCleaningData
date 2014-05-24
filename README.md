##run_analysis.R

This R script performs some basic cleaning and simplification of the 
Human Activity Recognition(HAR) Using Smartphones Data Set. From the UCI Machine
Learning Repository. In order to run this script you must download the HAR dataset
and unzip it into R's current working directory.  Link to dataset and description
is below.

__Abstract:__ Human Activity Recognition database built from the recordings of 
30 subjects performing activities of daily living (ADL) while carrying a waist
mounted smartphone with embedded inertial sensors.

More detail can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and download [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

This script does 5 things:

1.    Merges the training and the test sets to create one data set.
  *  First R reads in the files X\_test.txt, y\_test.txt, x\_train.txt,y\_train.txt, features.txt, 
  subject\_test.txt and subject\_train.txt then merges them into one dataset. run_analysis.R lines 1-28
  
2.    Extracts only the measurements on the mean and standard deviation for each measurement.
  *  Regular expresions are then used to extract all collumns with mean or std in the name as 
  well as to retain the Subject and Activity collumn. Line 32.<br><br>
  *  Regular expressions are further used to rename activity names in accordance with tidy data 
  principles and more importantly to make sure the names are friendly to R ie. no () characters
  Lines 34-38.

3.    Uses descriptive activity names to name the activities in the data set
4.    Appropriately labels the data set with descriptive activity names.  
  *  The file activities\_lables.txt is read into R and then the numeric activities column is
  replaced by the appropriate descriptive activity label. Lines 42-46.

5.    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  *  The data is reshaped to include mean averages of all feature by subject and activity
  Each row will now consist of mean averages for all features for each subject during each activity
  An important not is that all STD measures are mean STD's this is not reflected in the variable name
  in order to prevent names of unweildly length. Lines 53-55.<br><br>
  *  Finally, the transformed dataset is written to the disk in the current working directory as
  tidydataset.txt and ready for upload.
