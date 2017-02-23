
# This script is the solution for the Week 4 - Getting and Cleaning Data project.
# The script will read in data sets, merge them, tidy up the data set, provide decriptive
# column names, and then summarize the data set.  The summary data set will be written
# to a file.  
# Install packages

install.packages("dplyr")
library(dplyr)

# Set working directory to where the zip file has been downloaded and unzipped.

setwd("~/Desktop/R Files/Cleaning Data")

# 1. Merge the training and the test sets to create one data set.

# Read in data

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",stringsAsFactors = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",stringsAsFactors = FALSE)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",stringsAsFactors = FALSE)

x_test <-  read.table("./UCI HAR Dataset/test/X_test.txt",stringsAsFactors = FALSE)
y_test <-  read.table("./UCI HAR Dataset/test/y_test.txt",stringsAsFactors = FALSE)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",stringsAsFactors = FALSE)

# Merge data and create column headings

train_data <- cbind(train_subject,y_train,x_train)
test_data <- cbind(test_subject,y_test,x_test)

all_data <- rbind(train_data,test_data)

# Remove unneeded data sets
rm(train_data)
rm(test_data)
rm(x_train)
rm(y_train)
rm(train_subject)
rm(x_test)
rm(y_test)
rm(test_subject)

# Add column names. Read features data set which contains column names for measurements.  
# Make the 2nd column of the features data set the column names for the merged data set.

features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
names(all_data) <- c("Subject","Activity",tolower(features$V2))

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_data <- all_data[,c(1,2,grep("mean|std",names(all_data)))]

# Remove full data set

rm(all_data)


# 3. Uses descriptive activity names to name the activities in the data set

# Read in the table which contains the description of what activity each index corresponds to
activity_info <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)

# Substitute descriptive names for each activity
mean_std_data$Activity <- activity_info[mean_std_data$Activity,2]

# 4. Appropriately labels the data set with descriptive variable names.

## Use a series of gsub commands to clean up column labels and make descriptive

names(mean_std_data) <- gsub("[(][])]","",names(mean_std_data))
names(mean_std_data) <- gsub("^t","Time",names(mean_std_data))
names(mean_std_data) <- gsub("^f","Frequency",names(mean_std_data))
names(mean_std_data) <- gsub("freq","Frequency",names(mean_std_data))
names(mean_std_data) <- gsub("gravity","Gravity",names(mean_std_data))
names(mean_std_data) <- gsub("body","Body",names(mean_std_data))
names(mean_std_data) <- gsub("acc","Accelerometer",names(mean_std_data))
names(mean_std_data) <- gsub("jerk","Jerk",names(mean_std_data))
names(mean_std_data) <- gsub("gyro","Gyroscope",names(mean_std_data))
names(mean_std_data) <- gsub("mag","Magnitude",names(mean_std_data))
names(mean_std_data) <- gsub("angle","Angle",names(mean_std_data))
names(mean_std_data) <- gsub("-mean-","Mean",names(mean_std_data))
names(mean_std_data) <- gsub("-std-","Std",names(mean_std_data))
names(mean_std_data) <- gsub("-mean","Mean",names(mean_std_data))
names(mean_std_data) <- gsub("-std","Std",names(mean_std_data))
names(mean_std_data) <- gsub("-","",names(mean_std_data))

# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

tidy_data_set <-group_by(mean_std_data,Activity,Subject)%>% summarize_each(funs(mean))

# Save the data set to a file

write.table(tidy_data_set, file="tidy_data.txt", row.names= FALSE)

# Remove all data tables from workspace to free up memory
rm(activity_info)
rm(features)
rm(mean_std_data)
rm(tidy_data_set)
