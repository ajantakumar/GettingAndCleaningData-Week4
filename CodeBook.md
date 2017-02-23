# This Code Book describes the  variables, the data, and the steps taken to clean up the data.

## 1. Merges the training and the test sets to create one data set.

There were two sets of data provided for this project: training and test.  
The subject for whom each row of the data and the activity measured were provided separately.
These data sets all needed to be combined together.

### Variables:

x_train - Measurements from the training data set

y_train - The activity measured for the training data set (e.g. WALKING, LAYING)

train_subject - The subject doing the activity and being measured

x_test - Measurements from the test data set

y_test - The activity measured for the test data set (e.g. WALKING, LAYING)

test_subject - The subject doing the activity and being measured

#### To combine the data sets
  1. First use column bind to create the full training and test data sets separately. The columns are in the order:  
  Subject,Activity,Measurements
  
  train_data - The full set of training data...cbind(train_subject,y_train,x_train)
  
  test_data - The full set of test data... cbind(test_subject,y_test,x_test)
  
  2. Next use row bind to combine the training and test data sets into one data set.
  
  all_data - The full set of training and test data...rbind(train_data,test_data)

#### The names of each of the columns in the test and training data set was provided separately.  This was added to the merged data set.

  
  features - Table which contains the descriptive names for measurements conducted
  
  assign all_data the names from column named 'V2' in the features data set...names(all_data) <- c("Subject","Activity",tolower(features$V2))    

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_data - The resulting data set of using the 'grep' command to select only the columns which contain 'mean' or 'std' in their names. 
  
  mean_std_data <- all_data[,c(1,2,grep("mean|std",names(all_data)))]

## 3. Uses descriptive activity names to name the activities in the data set

Read in the activity descriptions data set and replace activity numbers in the data set with descriptive names
  
  activity_info - is the data table containing the activity number and its corresponding description
  
  mean_std_data$Activity <- activity_info[mean_std_data$Activity,2]
  
## 4. Appropriately labels the data set with descriptive variable names.  

Use a series of gsub commands to clean up the data.  The following transformations were done:

Replace '()' with nothing

Replace 't' at the beginning of a name with 'Time'

Replace 'f' at the beginning of a name with 'Frequency'

Replace 'freq' at any part of the name with 'Frequency'

Replace 'gravity' at any part of the name with 'Gravity'

Replace 'body' at any part of the name with 'Body'

Replace 'acc' at any part of the name with 'Accelerometer'

Replace 'jerk' at any part of the name with 'Jerk'

Replace 'gyro' at any part of the name with 'Gyroscope'

Replace 'mag' at any part of the name with 'Magnitude'

Replace 'angle' at any part of the name with 'Angle'

Replace '-mean-' at any part of the name with 'Mean'

Replace '-std-' at any part of the name with 'Std'

Replace '-mean' at any part of the name with 'Mean'

Replace '-std' at any part of the name with 'Std'

Replace '-' at any part of the name with nothing

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data_set is the result of grouping mean_std_data by Activity and Subject and then averaging the measurements

tidy_data_set <-group_by(mean_std_data,Activity,Subject)%>% summarize_each(funs(mean))
  
The data is then written to a file tidy_data.txt.  The file has been uploaded to the repository.

Throught the program, tables are removed once they are no longer needed to release memory being used.
  

