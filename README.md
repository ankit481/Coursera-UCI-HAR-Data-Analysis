# Coursera-UCI-HAR-Data-Analysis
The repository contains R code and detailed information on variables and how the script works to meet the project requirements.

1. The script starts with the setting the current working directory and importing dplyr package for data manipulation required during the later stage.

2. "feature" variable is created store features.txt data for column variable names for test and training data.

3. The script will then extract data from subject_test.txt, X_test.txt, Y_test.txt and subsequently from respective Training data files and place the extracted data in variables.

4. The columns names of newly created data frames for test and training data are then assigned variables names - Subject, Activity and using V2 column of feature data frame.

5. "test" and "train" data frames are created to store data by combining columns of sets of 3 data frames (sub_, x_, y_), each for train and test data.  

6. test and train data frames are then merged to form a single data frame "har.data".

7. Since the variable names initially stored in features.txt contained parentheses (), it is imperative to convert the variable names in a form understandable by R code using make.name and reassign the converted names back to har.data.

8. A sub data set of har.data is created by extracting Subject, Activity and all the columns having ".mean." and ".std.". Please note that there are several other columns containing the words "mean" and "std" which will not get included in the sub data frame. It has been left to the interpretation of the student only selecting columns representing mean and standard deviation.

9 activity data frame will store data from activity_label.txt.

10. har.sub and activity data frames are merged together by Activity column of har.sub and V1 columns of activity representing activity code. V2 column of activity data frame will joined with har.sub represeting activity lables. V2 column is renamed to "Activity.Type"

11. har.sub.tidy data frame is created as the required independent tidy data set with the average of each variable for each activity and each subject using group_by function to group the data frame by Subject and Activity Type, followed by summarise_each funtion which performs a stated function (mean in this case) on multiple columns.

12. The output of independent data set is stored in "HAR Tidy.txt" file.

