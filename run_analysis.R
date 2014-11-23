run_analysis <- function () {
        
        library(data.table)
        library(reshape2)
        
        
        # load all necessary files names and paths
        all.files <- list.files("C:\\Users\\Automation\\Documents\\R\\Class 3\\Course Project\\class3_CourseProject\\UCI HAR Dataset", full.names = TRUE, recursive = TRUE)  
        test.and.train.files <- all.files[-grep("Inertial|README|features_info", all.files)]
        test.files <- test.and.train.files[-grep("test|labels|features", test.and.train.files)]
        train.files <- test.and.train.files[-grep("train|labels|features", test.and.train.files)]
        doc.files <- test.and.train.files[-grep("test|train", test.and.train.files)]
        
        
        # read all files
        subject.train <- read.table(train.files[1])
        data.train <- read.table(train.files[2])
        activity.train <- read.table(train.files[3])        
        subject.test <- read.table(test.files[1])
        data.test <- read.table(test.files[2])
        activity.test <- read.table(test.files[3])
        activity.labels <- read.table(doc.files[1])
        features <- read.table(doc.files[2])
        features2 <- features[,2]
        
        
        # name columns and merge all files
        names(data.train) <- features2
        names(data.test) <- features2
        names(subject.train) <- "subject"
        names(subject.test) <- "subject"
        names(activity.train) <- "activity"
        names(activity.test) <- "activity"

        all.train <- subject.train
        all.train <- cbind(all.train, activity.train)
        all.train <- cbind(all.train, data.train)
        
        all.test <- subject.test
        all.test <- cbind(all.test, activity.test)
        all.test <- cbind(all.test, data.test)
        
        test.train.data <- rbind(all.test, all.train)
        
        
        # Extracts the measurements on the mean and standard deviation for each measurement
        mean.std <<- test.train.data[,grep("subject|activity|mean|std|Mean", colnames(test.train.data))]
        
        # Use descriptive activity names to name the activities in the data set
        mean.std$activity <- as.factor(sapply(mean.std$activity, gsub, pattern = "1", replacement = "Walking"))
        mean.std$activity <- as.factor(sapply(mean.std$activity, gsub, pattern = "2", replacement = "Walking Upstairs"))
        mean.std$activity <- as.factor(sapply(mean.std$activity, gsub, pattern = "3", replacement = "Walking Downstairs"))
        mean.std$activity <- as.factor(sapply(mean.std$activity, gsub, pattern = "4", replacement = "Sitting"))
        mean.std$activity <- as.factor(sapply(mean.std$activity, gsub, pattern = "5", replacement = "Standing"))
        mean.std$activity <- as.factor(sapply(mean.std$activity, gsub, pattern = "6", replacement = "Laying"))
        # print(names(mean.std))


        # Appropriately labels the data set with descriptive variable names. 
        names(mean.std) <- gsub(pattern = "fBody", replacement = "Freq.Body", names(mean.std))
        names(mean.std) <- gsub(pattern = "tBody", replacement = "Time.Body", names(mean.std))
        names(mean.std) <- gsub(pattern = "tGravity", replacement = "Time.Gravity", names(mean.std))
        names(mean.std) <- gsub(pattern = "Acc", replacement = ".Accel", names(mean.std))
        names(mean.std) <- gsub(pattern = "-std", replacement = ".StDev", names(mean.std))
        names(mean.std) <- gsub(pattern = "\\(\\)", replacement = "", names(mean.std))
        names(mean.std) <- gsub(pattern = "\\-", replacement = ".", names(mean.std))
        names(mean.std) <- gsub(pattern = "Gyro", replacement = ".Gyroscopic", names(mean.std))
        names(mean.std) <- gsub(pattern = "meanFreq", replacement = "Mean.Freq", names(mean.std))
        names(mean.std) <- gsub(pattern = "Jerk", replacement = ".Jerk", names(mean.std))
        names(mean.std) <- gsub(pattern = "Mag", replacement = "Mag", names(mean.std))
        names(mean.std) <- gsub(pattern = "BodyBody", replacement = "Body", names(mean.std))
        names(mean.std) <- gsub(pattern = "mean", replacement = "Mean", names(mean.std))
        names(mean.std) <- gsub(pattern = "GyroscopicMag", replacement = "Gyroscopic.Mag", names(mean.std))
        names(mean.std) <- gsub(pattern = "AccelMag", replacement = "Accel.Mag", names(mean.std))
        names(mean.std) <- gsub(pattern = "JerkMag", replacement = "Jerk.Mag", names(mean.std))
        names(mean.std) <- gsub(pattern = "JerkMean", replacement = "Jerk.Mean", names(mean.std))
        names(mean.std) <- gsub(pattern = "gravityMean", replacement = "Gravity.Mean", names(mean.std))
        names(mean.std) <- gsub(pattern = "GyroscopicMean", replacement = "Gyroscopic.Mean", names(mean.std))
        names(mean.std) <- gsub(pattern = "Jerk.Mean\\)", replacement = "Jerk.Mean", names(mean.std))
        mean.std$subject <- as.factor(mean.std$subject)

        # Average of each variable for each activity and each subject
        data.longform <- melt(mean.std, id.vars = c("subject", "activity"))
        activities.avg <- dcast(data.longform, subject + activity ~ variable, mean)
        write.table(activities.avg, file = "activities_averages.txt", row.names = FALSE)

}       