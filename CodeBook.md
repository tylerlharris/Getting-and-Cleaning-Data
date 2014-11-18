The training and test sets were merged together using the cbind and rbind commands.

The Activity and Subject columns were assembled from their constituent parts using rbind, and then attached to the above merged set using cbind.  They were also manually labelled "Subject" and "Activity".

The Activity column was transformed to a factor, Activity (levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The columns were labelled with with names given in the "features.txt" file.  

The measurements on mean and standard deviation for each measurement were then extracted, yielding a total of 66 measurement columns.  The measurement type names were transformed so that abbreviations were replaced with full words.  The letter "f" was transformed to the word "frequency", the letter "t" to the word "time", "Gyro" to "Gyroscope", "Acc" to "Accelerometer", and "Mag" to "Magnitude".  Camel case was retained for readability.

The data was melted, with Subject and Activity the id variables and the measurement types and values in key-value pairs. The mean of each measurement type for each Subject and Activity was then taken, yielding the final tidy data set which has four variables: Subject, Activity, Measurement Type, and Mean.  
