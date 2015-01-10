##getdata project##

This project takes the following set of raw data files produced by taking measurements off 30 volunteers performing various activities while wearing their smartphones

###The raw dataset included the following files:###
- 'features.txt': List of all measurements.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

###The following processing steps have been performed by running run_analysis.R on the raw datasets:###
* Merging the training and the test sets to create one data set:
* Extracting only the measurements on the mean and standard deviation for each measurement.
* Using descriptive activity names to name the activities in the data set
* Appropriately labeling the data set with descriptive variable names
* From the data set in step 4, creating a second, independent tidy data set with the average 
   of each variable for each activity and each subject.

###Tidy Dataset:###
The resulting tidy dataset is stored in tidy_set.txt file. It contains 180 records corresponding to 6 types of activities performed by 30 people with each individual record representing an average value across all 66 measurements produced by 1 person for 1 particular activity