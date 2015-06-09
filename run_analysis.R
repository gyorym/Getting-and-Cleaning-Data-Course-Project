#setwd("C:/Users/mgyory/Documents/Assignments/Data Science Cert/Getting and Cleaning Data/Class Project/UCI HAR Dataset")
##Prior to submitting, delete setwd above

##Import the activity lables and features

activity_labels<-read.table("activity_labels.txt",col.names=c("activity","activity_name"))

##Import and transpose the features to get column header names for the test and training data
features<-read.table("features.txt")
f2<-t(features)
f3<-f2[2,]

##Import the training data and add the activity label to the observations
##The col.names option adds descriptive titles to each column, described in the ReadMe.md file
train_data<-read.table("train/X_train.txt", col.names=f3)
hc<-"activity"
sub<-"subject"
train_header<-read.table("train/Y_train.txt",col.names=hc)
train_subjects<-read.table("train/subject_train.txt", col.names=sub)
train_data<-cbind(train_data,train_header,train_subjects)

##Import the testing data and add the activity label to the observations
##The col.names option adds descriptive titles to each column
test_data<-read.table("test/X_test.txt", col.names=f3)
test_header<-read.table("test/Y_test.txt",col.names=hc)
test_subjects<-read.table("test/subject_test.txt", col.names=sub)
test_data<-cbind(test_data,test_header,test_subjects)  

##Extract just the columns for means, standard deviations, subject numbers and activity numbers
#First, create a list of the column names containing mean and std and include the activity and subject numbers
train_vars<-c(grep("mean",names(train_data),value=TRUE),grep("std",names(train_data),value=TRUE),"activity","subject")
test_vars<-c(grep("mean",names(test_data),value=TRUE),grep("std",names(test_data),value=TRUE),"activity","subject")

#Next, subset the train and test datasets based on the list created above
train_subset<-subset(train_data,select=train_vars)
test_subset<-subset(test_data,select=test_vars)

##Append the Test and Train data together
project_data<-rbind(train_subset,test_subset)

##Merge on the activity names to the appended dataset
project_data_activity<-merge(project_data,activity_labels,by="activity")
project_data2<-subset(project_data_activity,select=-activity)

##Create a tidy data set of the average for each column by activity and subject
project_tidy<-subset(suppressWarnings(aggregate(project_data2,by=list(project_data2$activity_name,project_data2$subject),FUN=mean)),select=c(-activity_name, -subject))
names(project_tidy)[names(project_tidy)=="Group.1"]<-"activity_name"
names(project_tidy)[names(project_tidy)=="Group.2"]<-"subject"

#write.table(project_tidy,file="project_tidy_dataset.txt",row.names=FALSE)