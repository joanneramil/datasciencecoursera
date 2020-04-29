#Variables
The final dataset includes the means and standard deviations of the following variables for each activity and each subject:

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

#Creating the final dataset
The data was first downloaded and the different datasets were loaded into R. Column names were then assigned to the datasets.

The train and test datasets were then merged together by the subject ID variable.

The next step consisted of extracting the columns that measured means and standard deviations. 

The activity labels were then changed into descriptive names (i.e., characters instead of numeric).

Finally, a tidy dataset was created by aggregating the means for each activity by subject ID and the resulting table was saved as a .txt file.