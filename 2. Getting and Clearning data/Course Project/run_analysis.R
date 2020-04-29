# 0. creating the different datasets
## creating a file path to the data folder
mydata <- file.path("./UCI HAR Dataset")
list.files(mydata)

## train datasets
X_train <- read.table(file.path(mydata, "train", "X_train.txt"), header = FALSE)
Y_train <- read.table(file.path(mydata, "train", "Y_train.txt"), header = FALSE)
subject_train <- read.table(file.path(mydata, "train", "subject_train.txt"))

##test datasets
X_test <- read.table(file.path(mydata, "test", "X_test.txt"), header = FALSE)
Y_test <- read.table(file.path(mydata, "test", "Y_test.txt"), header = FALSE)
subject_test <- read.table(file.path(mydata, "test", "subject_test.txt"))


##features
features <- read.table(file.path(mydata, "features.txt"), header = FALSE)

##activity
activity_labels <- read.table(file.path(mydata, "activity_labels.txt"), header = FALSE)
                     
##Column names
colnames(X_train) <- features[,2]
colnames(Y_train) <- "activityID"
colnames(subject_train) <- "subjectID"
colnames(X_test) <- features[,2]
colnames(Y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

# 1. Merging the datasets
##merging all train datasets
train_merged <- cbind(Y_train, subject_train, X_train)
##merging all test datasets
test_merged <- cbind(Y_test, subject_test, X_test)
##merging train and test datasets
train_test <- rbind(train_merged, test_merged)

# 2. Extracting means and SD (std) for each measurement
##extracting relevant columns from merged dataset
colna <- colnames(train_test)
select_md_std <- (grepl("activityID", colna) | grepl("subjectID", colna) | grepl("mean..", colna) | grepl("std..", colna))
##creating a dataset with just means and SD
mean_sd <- train_test[,select_md_std ==TRUE]

# 3. Creating descriptive activity names
colnames(activity_labels) <- c("activityID", "activityType")
act <- merge(mean_sd, activity_labels, by = "activityID")
summary(act$activityType)

# 4. Labeling the dataset with descriptive variable names
## Code from previous section (0. creating the different datasets)  
colnames(X_train) <- features[,2]
colnames(Y_train) <- "activityID"
colnames(subject_train) <- "subjectID"
colnames(X_test) <- features[,2]
colnames(Y_test) <- "activityID"
colnames(subject_test) <- "subjectID"
##resulting dataset
View(act)

# 5. Creating a tidy dataset with the mean of each variable for each activity and each subject
##aggregating means for each variable
act_tidy <- aggregate(. ~subjectID + activityID, act, mean)
##reordering the columns to put subjectID and activity ID at the beginning of the dataset
act_tidy <- act_tidy[order(act_tidy$subjectID, act_tidy$activityID), ]
##writing final dataset into a .txt file
write.table(act_tidy, "act_tidy.txt", row.names = FALSE)
