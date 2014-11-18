
This repo contains an R script, run_analysis.R, which takes the "features.txt", "subject_test.txt", "subject_train.txt", "X_test.txt", "X_train.txt", "y_test.txt", "y_train.txt", and "activity_labels.txt" files in the "Human Activity Recognition Using Smartphones" dataset as input, and outputs a tidy data set, "final.txt", that contains only the mean of those measurements that are the mean and standard deviation of each measurement.

All of the files named as input must be present in the same working directory as the script.

A full description of the code is contained in the code comments.

To view the the "final.txt" file in R, type the following:

final_file <- read.table("final.txt", header = TRUE)
View(final_file)
