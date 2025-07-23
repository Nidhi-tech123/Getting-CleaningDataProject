##Downloading the dataset
setwd("/Users/nidhi/Desktop/UCI HAR Dataset")
getwd()
unzip("getdata_projectfiles_UCI HAR Dataset.zip")

##Loading dplyr package
install.packages("dplyr")
library(dplyr)

# Load required library
library(dplyr)

# Read training datasets
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Read test datasets
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read features and activity labels
features <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("activityID", "activity")

# Assign column names
colnames(x_train) <- features[, 2]
colnames(x_test) <- features[, 2]
colnames(y_train) <- "activityID"
colnames(y_test) <- "activityID"
colnames(subject_train) <- "subjectID"
colnames(subject_test) <- "subjectID"

# Merge training and test datasets
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
finaldataset <- rbind(train, test)

# Extract mean and standard deviation columns
mean_std_cols <- grepl("activityID|subjectID|mean\\(\\)|std\\(\\)", colnames(finaldataset))
set_mean_std <- finaldataset[, mean_std_cols]

# Merge with activity names
mergedSet <- merge(set_mean_std, activityLabels, by = "activityID", all.x = TRUE)

# Clean variable names
colnames(mergedSet) <- gsub("^t", "Time", colnames(mergedSet))
colnames(mergedSet) <- gsub("^f", "Frequency", colnames(mergedSet))
colnames(mergedSet) <- gsub("Acc", "Accelerometer", colnames(mergedSet))
colnames(mergedSet) <- gsub("Gyro", "Gyroscope", colnames(mergedSet))
colnames(mergedSet) <- gsub("Mag", "Magnitude", colnames(mergedSet))
colnames(mergedSet) <- gsub("BodyBody", "Body", colnames(mergedSet))

# Create final tidy dataset with averages
tidy_data <- mergedSet %>%
  select(-activityID) %>%
  group_by(subjectID, activity) %>%
  summarise(across(everything(), mean))

# Write tidy dataset to a text file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)



