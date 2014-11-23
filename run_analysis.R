# load necessary packages

library(reshape2)
library(dplyr)

# Read the data into R.

features <- read.table("features.txt")
subject.test<- read.table("subject_test.txt")
subject.train <- read.table("subject_train.txt")
X.test <- read.table("X_test.txt")
X.train <- read.table("X_train.txt")
y.test <- read.table("y_test.txt")
y.train <- read.table("y_train.txt")
actlabels <- read.table("activity_labels.txt")

# Clip the data together into one dataset, using cbind when clipping
# together along the columns
# of each data object, and rbind to clip together along the rows.

XtrainXtest <- rbind(X.train, X.test)
colnames(XtrainXtest) <- features$V2
subject.traintest <- rbind(subject.train, subject.test)
XtrainXtestsubject <- cbind(XtrainXtest, subject.traintest)
ytraintest <- rbind(y.train, y.test)

# Clipping yields the final raw data set, train.

train <- cbind(XtrainXtestsubject, ytraintest)

# Creates column names for the (unnamed) Subject and Activity columns.

colnames(train)[562:563] <- c("Subject", "Activity")

# Encodes the Activity column as a factor, with levels given by the actlabels file.

train[563] <- factor(train[[563]], labels = actlabels$V2)

# Extracts only the measurements on the mean and standard deviation.

meanandstd <- c(grep("mean()", names(train), fixed = TRUE), 
                grep("std()", names(train), fixed = TRUE))

# train is modified to include only those variables indicated in the previous step,
# as well as the Subject and Activity columns.

train <- train[c(meanandstd, 562:563)]

index <- seq_along(colnames(train)) # index will be used to iterate over the column names 
                                    # in a for loop.

# The for loop modifies the column names of train so that abbreviations are replaced
# with the full word they represent.

for (i in index){
  colnames(train)[i] <- paste(gsub("t", "time", substring(colnames(train)[i], 1, 1)), 
                               substring(colnames(train)[i],2), sep = "")
  #replaces first letter, if it is 't,' with  'time.'
  
  colnames(train)[i] <- paste(gsub("f", "frequency", substring(colnames(train)[i], 1, 1)), 
                               substring(colnames(train)[i],2), sep = "")
  
  #replaces first letter, if it is 'f,' with  'frequency,'
  
  colnames(train)[i] <- gsub("Gyro", "Gyroscope", colnames(train)[i])
  
  # replaces any instances of the abbreviation "Gyro" with the word "Gyroscope",
  # etc.
  
  colnames(train)[i] <- gsub("Acc", "Accelerometer", colnames(train)[i])
  colnames(train)[i] <- gsub("Mag", "Magnitude", colnames(train)[i])
}
# Melting is then performed, yielding a tidy data set.

melted <- tbl_df(melt(train, id = c("Subject", "Activity"), 
                      measure.vars = colnames(train)[1:66]))

# The data is then grouped, to facilitate calculation of the mean of the measurements of
# each variable for each Subject and Activity.

grouped <- group_by(melted, Subject, Activity, variable)

# The means of each measurement are then calculated using summarise,
# yielding the final tidy data set.

final <- summarise(grouped, means = mean(value))


# Write the text file.

write.table(final, "final.txt", row.names = FALSE, sep = "\t")
