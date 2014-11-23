samsung_data_analyses
=====================

This repo contains my Course Project for Getting and Cleaning Data course.

There are two important files:

- _**run_analysis.R**_, which contains R code reading some input files (as course project instructions require) and producing a tidy data set as result file;
- _**code_book.txt**_, describing the variables.

### How the script works

The data needed is read from a number of files. All files should be downloaded as zip file, as described in the course project instructions, and their file structure should be extracted in the same folder as the script run_analysis.R. 

First the training and test data is read and merged. Then the column names are read from features.txt. For a detailed description see [this link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

R package **dplyr** is used to convert the loaded data in a dplyr table. Since there are duplicated column names and we don't need these columns, we drop them out. Only columns with mean() and std() in the name are left.

Then, activity labels are read from y_train and y-test sets and attached to the data.

In a similar way, subject's ids are read and attached to the data.

Finaly, the data is grouped by activity and subject and the average of each variable for each activity and each subject is calculated. The result is output as text file tidy_step5.txt.
