## Reading and merging train and test data
tr_x<-read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
te_x<-read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
x<-rbind(tr_x,te_x)

## Column names
f<-read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
names(x)<-f[,2]
## Make a dplyr table data frame
library("dplyr")
xdf<-tbl_df(x)

## Since there are duplicated column names and we don't need these columns, we drop them out.
xdf_nodupl<-cbind(xdf[,1:302], xdf[,345:381], xdf[,424:460], xdf[,503:561])
## Only columns with mean() and std() in the name are left.
xdf2<-cbind(select(xdf_nodupl, contains("mean()")), select(xdf_nodupl, contains("std()")))

## Get activity code
tr_y<-read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
te_y<-read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
y<-rbind(tr_y,te_y)
names(y)<-c("Act")
ydf<-tbl_df(y)
## Get activity labels. Replace the code.
al<-read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
ydf2<-mutate(ydf, Activity = al[Act,2])

## Get the subjects
subj<-rbind(read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE), read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE))
names(subj)<-c("Subject")
## Add two more columns - Activity and Subject
xdf_final<-cbind(xdf2,ydf2[,"Activity"], subj)
## Group_by, summarise and write to file.
xdf_grouped<-group_by(xdf_final, Act2, Subject)
Average_on_Activity_and_Subject<-summarise_each(xdf_grouped, funs(mean))
write.table(Average_on_Activity_and_Subject, file="tidy_step5.txt", row.names=FALSE)
