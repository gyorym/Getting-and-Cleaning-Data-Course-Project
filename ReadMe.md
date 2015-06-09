For the Data Scientist Certificate Getting and Cleaning Data Course Project
Last updated 6/8/2015

Contents:
***********
-----------
Data Source
Activities
Features
Scripts
-----------
***********

Data Source:
===========
The data used are from the following source:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

The data are made up of 6 separate data tables sources (per the guide provided by Reyes-Ortiz, et. al.):

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- The data are kept in their original sub-folders found in the .zip file for this assignment

For more information about this dataset contact: activityrecognition@smartlab.ws

Each of these data tables are imported and joined to create the final data table. 

Activities:
===========
The activity_labels are used to identify the specific activity from the list below:

WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING

Each of these activities has a code number assigned to it (Walking=1 through Laying=6). These activity numbers are applied to the data as are their labels.

Features (variable names):
==========================
The features (used as column headers) are defined as described below (courtesy of Reyes-Ortiz, et. al.):

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

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

The set of variables that were estimated from these signals and used in this assignment are: 

mean(): Mean value
std(): Standard deviation

A complete list of feature variables can be found in features.txt, however only variables related to mean and standard deviation are included in this dataset.

An example variable is described below:
tBodyAcc-mean()-X: is the average of the time for Body Acceleration in the X-dimension for the given subject and activity

Script:
========
A single script, run_analysis.R, is used to import, merge and define the data as described below.

Importing Data:
---------------
The first part of the script is devoted to importing the data and applying the feature names to the columns. The data are imported from the appropriate sub-folder or overall folder, depending on their usage. Train and Test data are kept in separate sub-folders.

The activity labels are imported and saved for future merging.
The feature names are imported and the table is transformed using the t() function to create a single row of feature names.

The final steps of the importing process read in the training and test data, the activity header data and the subject data. The features column names are used to apply variable names to the columns. The activity and subject codes are applied to train/test data using the cbind() function.

The resulting test and train datasets contain all 561 original measurement variables, an activity indicator and a subject indicator. These datasets are the basis for further analysis.

Extracting Columns:
-------------------

The next part of the script creates a list of the mean and standard deviation (std) variables from the Test and Train data, using the grep() function, the subject and activity indicator values.

These lists are used to subset the data so only the relevant variables remain.

Appending Data:
---------------

Next, the Train and Test data frames created in the previous step are appended to each other using rbind().

Merging Activity Names:
-----------------------

The script then merges on the activity names previously imported and removes the activity code numbers from the project dataset.

Creating Tidy Dataset:
----------------------

The final step in the script is to create the tidy dataset. The tidy dataset contains a mean value for the mean and std variables kept, grouped by subject and activity. The means are calculated using the aggregate() function, with a suppressWarnings wrapper to hide the warnings generated when R attempts to summarize the activity name field (as it is a character field).

The original subject and activity name fields are removed from the dataset during the creation of the tidy dataset and the grouping variables created are renamed appropriately. The resulting tidy dataset contains one observation for each subject, for each activity, or 180 records and 79 averaged mean and std variables plus a column for the activity and subject. 

