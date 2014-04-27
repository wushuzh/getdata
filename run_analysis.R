setwd("D:\\wushuzh\\get_clean_data_cousera")

# meta data
features <- read.table("./data/features.txt")
actions <- read.table("./data/activity_labels.txt")
names(actions) <- c("actionid", "actionName")

# read train dataset
train_features <- read.table("./data/train/X_train.txt")
train_action   <- read.table("./data/train/Y_train.txt")
train_subjects <- read.table("./data/train/subject_train.txt")

names(train_features) <- features[,2]
train_features$subject <- train_subjects[,1]
train_features$actionid <- train_action[,1]
train_features$purpose <- rep("train", nrow(train_features))

# read test dataset
test_features <- read.table("./data/test/X_test.txt")
test_action   <- read.table("./data/test/Y_test.txt")
test_subjects <- read.table("./data/test/subject_test.txt")

names(test_features) <- features[,2]
test_features$subject <- test_subjects[,1]
test_features$actionid <- test_action[,1]
test_features$purpose <- rep("test", nrow(test_features))

# merge together as one dataset
all_features <- rbind(test_features, train_features)

# get the features by mean and std
all_columns <- names(all_features)

# use regex to get column index of all the interested measurements and key columns 
mean_std_keyid_colind <- c(grep("(mean|std)\\(\\)$|subject|actionid|purpose", all_columns))

# get the subset from all of the data
mean_std_features <- all_features[,mean_std_keyid_colind]

# add a column to indicate the meaningful action Name by merge
mean_std_features_with_actionname <- merge(mean_std_features, actions, 
                                           by.x='actionid', by.y="actionid", ALL=TRUE)

write.table(mean_std_features_with_actionname, file="./mean_std_all.txt", sep="\t", row.names=FALSE)

library(reshape2)

measMelt <- melt(all_features, 
                 id=c("subject", "actionid", "purpose") )
avg_per_sub_act <- dcast(measMelt, subject + actionid + purpose ~ variable, mean)

write.table(avg_per_sub_act, file="./avg_per_sub_act.txt", sep="\t", row.names=FALSE)