Make sure there is a sub-dir named "data" which contains the following txt data:

* data\features.txt
* data\activity_labels.txt

* data\train\X_train.txt
* data\train\Y_train.txt
* data\train\subject_train.txt
 
* data\test\X_train.txt
* data\test\Y_train.txt
* data\test\subject_train.txt

The R script "run_analysis.R" will read all of the above dataset into the memory,
then it merge the train dataset and test dataset separately, including adding the 
subject id, dataset purpose(test/train), action id for each record;
after that, the script will merge the train and test into one big dataset.

As required by assignment, we filter the common key columns like subject, purpose,
actionid and all of the measurements related to mean and std into 
one dataset, also add the descriptive column for the action id, and store as 
a variable called mean_std_features_with_actionname.
Finally, this variable will be wrote as an txt file named "mean_std_all.txt" 
under the current directory.

A second, independent tidy data set with the average of all of the variables 
for each activity and each subject will be accessiable by 
a R dataframe avg_per_sub_act, which will be wrote 
as an txt file named "avg_per_sub_act.txt"
