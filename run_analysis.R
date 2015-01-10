###########################################################################

#1.Merges the training and the test sets to create one data set.

# Read in 3 test files and combine them into one test data frame
df_x_test<-read.table(file=".//UCI HAR Dataset//test//X_test.txt")
df_y_test<-read.table(file=".//UCI HAR Dataset//test//y_test.txt")
df_sub_test<-read.table(file=".//UCI HAR Dataset//test//subject_test.txt")
df_test<-cbind(df_x_test,df_y_test,df_sub_test)

# Read in 3 train files and combine them into one train data frame
df_x_train<-read.table(file=".//UCI HAR Dataset//train//X_train.txt")
df_y_train<-read.table(file=".//UCI HAR Dataset//train//y_train.txt")
df_sub_train<-read.table(file=".//UCI HAR Dataset//train//subject_train.txt")
df_train<-cbind(df_x_train,df_y_train,df_sub_train)

# Merge train and test data frames into one combined data frame
df_combined<-rbind(df_train,df_test)

############################################################################

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

# Read in the header labels from a "features.txt" file
df_features<-read.table(file=".//UCI HAR Dataset//features.txt",stringsAsFactors=FALSE)

# assign the labels just read to the combined data frame (train+test) from step 1
# the combined data frame has 2 extra last columns on top of what's in the features file:
# ActivityCode & Subject originating from y_xxx.txt and subject_xxx.txt files correspondingly
names(df_combined)<-c(df_features[[2]],c("ActvityCode","Subject"))

# keep only columns containing "-mean()" and "-std()" in their name
# also keep ActvityCode and Subject columns - they will be used for grouping later
df_combined<-df_combined[,grepl("-mean\\(\\)|-std()\\(\\)|ActvityCode|Subject",names(df_combined))]

############################################################################

#3.Uses descriptive activity names to name the activities in the data set

# Read in activity labels file containing a map between activity code and the activity label
df_activity<-read.table(file=".//UCI HAR Dataset//activity_labels.txt",stringsAsFactors=FALSE)
names(df_activity)<-c("ActvityCode","ActvityLabel")

# merge the activity labels into the combined dataset 
# this operation results in the ActivityLabel column added to the combined dataset
# with values corresponding to the ActivityCode column
# ActivityCode column is then removed as it's no longer required
df_combined<-merge(df_combined,df_activity,by="ActvityCode")
df_combined$ActvityCode <- NULL

############################################################################

#4.Appropriately labels the data set with descriptive variable names

# Replace all the shorthands in patterns vector with a corresponding value in replacements vector
# all words in the header are capitalized for better readability (matter of personal preference)
# dashes or brackets are removed as well
require(stringi)
patterns<- c("^t","^f","Gyro","Acc","-Y","-X","-Z","-mean\\(\\)","-std\\(\\)","Mag")
replacements<- c("Time","Frequency","Gyroscope","Acceleration","Ydirection","Xdirection","Zdirection","Mean","Std","Magnitude")
names(df_combined)<-stri_replace_all_regex(names(df_combined),patterns , replacements, vectorize_all=FALSE)

############################################################################

#5. From the data set in step 4, creates a second, independent tidy data set with the average 
#   of each variable for each activity and each subject.

# Group the data in the combined data frame by subject & activity and calculate mean value for
# all the columns in every such group and then write out the aggregated data frame to a file
require(reshape2)
df_tidy<-aggregate(.~Subject+ActvityLabel, df_combined,mean)
write.table(df_tidy,file=".//tidy_set.txt",row.name=FALSE) 