setwd("c:/Coursera/Data Science/Getting and Cleaning Data//assignments//course project//UCI HAR Dataset")
library(dplyr)

# Extract features data for column variable names for test and training data
feature <- read.table("features.txt", stringsAsFactors = F)


# Extract data for subjects, Activity, Tests
sub_test <- read.table("./test/subject_test.txt", stringsAsFactors = F)
x_test <- read.table("./test/X_test.txt", stringsAsFactors = F)
y_test <- read.table("./test/y_test.txt", stringsAsFactors = F)

# Rename column variables for Subject, Activity and Test
names(sub_test) <- "Subject"
names(y_test) <- "Activity"
names(x_test) <- feature$V2

# Create Test data frame by combining columns of subjects, activity and test data
test <- cbind(sub_test, y_test, x_test)

# Extract data for subjects, Activity, Training
sub_train <- read.table("./train//subject_train.txt", stringsAsFactors = F)
x_train <- read.table("./train//X_train.txt", stringsAsFactors = F)
y_train <- read.table("./train//y_train.txt", stringsAsFactors = F)

# Rename column variables for Subject, Activity and Training
names(sub_train) <- "Subject"
names(y_train) <- "Activity"
names(x_train) <- feature$V2

# Create Train data frame by combining columns of subjects, activity and training data
train <- cbind(sub_train, y_train, x_train)

# Merges the training and the test sets to create har.data data frame.
har.data <- rbind(train, test)

# Convert variable names of har.data to valid column names using make.name to remove parenthesis()
valid_col_names <- make.names(names =  names(har.data), unique = T, allow_ = T)
names(har.data) <- valid_col_names

# Create a subset har.sub with Subject, Activity and all columns having experessions ".mean." and ".std."
har.sub <- select(har.data, Subject, Activity, contains(".mean."), contains(".std.") )

# Read activity data from activity_label.txt
activity <- read.table("activity_labels.txt", stringsAsFactors = F)

# Merge har.sub and activity data frame by Activity column of har.sub and V1 columns of activity representing activity code.
har.sub <- merge(har.sub, activity, by.x = "Activity", by.y = "V1")

# Rename V2 column to Activity.Type
har.sub <- rename(har.sub, Activity.Type = V2)

# Create the required independent tidy data set with the average of each variable for each activity and each subject.
har.sub.tidy <- group_by(har.sub, Subject, Activity.Type) %>%
  summarise_each(funs(mean))

# Store the independent tidy data in a text
write.table(har.sub.tidy, file = "HAR Tidy.txt", row.names = F, sep  = "\t")