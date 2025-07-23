# CodeBook

## Data was downloaded from UCI Machine Learning Repository

## Following steps are Taken

- Loaded training and test datasets
- Merged them into one data set
- Extracted only mean and standard deviation measurements
- Replaced activity IDs with descriptive names
- Renamed variables for clarity
- Created a new tidy dataset with the average of each variable for each subject and activity

## Variables

- `subjectID`: ID of the participant (1–30)
- `activity`: Activity performed (e.g., WALKING, STANDING)
- Sensor measurement variables like:
  - `TimeBodyAccelerometerMeanX`
  - `FrequencyBodyGyroscopeStdZ`
  - etc.

