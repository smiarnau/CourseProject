# CourseProject
Getting and Cleaning Data Course Project

#### Script used
# CourseProject
Getting and Cleaning Data Course Project

#### Script used

Reading features file

``` 
features <- read.table("./features.txt", na.strings=c(""))
```
Reading TEST Subject file

```
testSubject <- read.table("./test/subject_test.txt", na.strings=c(""))
``` 
Reading TEST Activity file

```
testActivity <- read.table("./test/y_test.txt", na.strings=c(""))
``` 
Reading TEST Data file

```
testX <- read.table("./test/X_test.txt", na.strings=c(""))
```
Renaming the column names of the TEST data frame with the names from the features file.

```
names(testX) <- features$V2
```
Adding two columns to the TEST data frame with the subject and the activity information

```
testData <- data.frame("Subject"=testSubject$V1, "Act"=testActivity$V1, testX)
```
Reading TRAIN Data file

```
trainX <- read.table("./train/X_train.txt", na.strings=c(""))
```
Renaming the columns of the TRAIN data frame with the names from the features file.

```
names(trainX) <- features$V2
```
Reading TRAIN Subject file

```
trainSubject <- read.table("./train/subject_train.txt", na.strings=c(""))
```
Reading TRAIN Activity file

```
trainActivity <- read.table("./train/y_train.txt", na.strings=c(""))
```
Adding two columns to the TRAIN data frame with the subject and the activity information

```
trainData <- data.frame("Subject"=trainSubject$V1, "Act"=trainActivity$V1, trainX)
```
Union of the TEST dataframe and the TRAIN data frame

```
totalData <- rbind(testData, trainData)
```
Selection of the columns with MEAN information

```
colnums <- grep ("mean", names(totalData), ignore.case=FALSE)
```
Adding to the previous column names, the names of the columns with STD information

```
colnums <- append(colnums, grep ("std", names(totalData), ignore.case=TRUE))
```
Adding to the previous column names, the columns with the Subject and Activity Information

```
colnums <- sort(append(colnums, which(colnames(totalData)=="Act" | colnames(totalData)=="Subject")))
```
We select only the columns with the MEAN and STD information. And the Activity and Subject columns also.

```
someData <- totalData[,colnums]
```
Reading the Activity Labels file

```
activityLabels <- read.table("./activity_labels.txt", col.names=c("Id", "Activity"), na.strings=c(""))
```
We rename the Activity IDs with the correspondent label read from the Activity label file.

```
dataActivity <- merge(someData, activityLabels, by.x="Act", by.y="Id", sort=FALSE)
```
Reordering the columns in order to have the Activity and Subject before the other variables.

```
dataActivity <- dataActivity[, c(82,2:81)]
```
Final exercise with the average of the values of the variables (columns 3 to 81) grouped by Subject and Activity

```
resultat <- aggregate(dataActivity[,3:81],  by=dataActivity[c("Subject","Activity")], FUN=mean)
```
Reordering columns

```
final <- resultat[, c(2,1,3:81)]
```
Saving into a file

```
write.table(final,file = "project.txt", row.names=FALSE ) 
```




#### RAW Script used
```
## Reading features file
features <- read.table("./features.txt", na.strings=c(""))

## Reading TEST Subject file
testSubject <- read.table("./test/subject_test.txt", na.strings=c(""))
## Reading TEST Activity file
testActivity <- read.table("./test/y_test.txt", na.strings=c(""))
## Reading TEST Data file
testX <- read.table("./test/X_test.txt", na.strings=c(""))

## Renaming the column names of the TEST data frame with the names from the features file.
names(testX) <- features$V2

## Adding two columns to the TEST data frame with the subject and the activity information
testData <- data.frame("Subject"=testSubject$V1, "Act"=testActivity$V1, testX)

## Reading TRAIN Data file
trainX <- read.table("./train/X_train.txt", na.strings=c(""))

## Renaming the columns of the TRAIN data frame with the names from the features file.
names(trainX) <- features$V2
## Reading TRAIN Subject file
trainSubject <- read.table("./train/subject_train.txt", na.strings=c(""))
## Reading TRAIN Activity file
trainActivity <- read.table("./train/y_train.txt", na.strings=c(""))

## Adding two columns to the TRAIN data frame with the subject and the activity information
trainData <- data.frame("Subject"=trainSubject$V1, "Act"=trainActivity$V1, trainX)

#Union of the TEST dataframe and the TRAIN data frame
totalData <- rbind(testData, trainData)

#Selection of the columns with MEAN information
colnums <- grep ("mean", names(totalData), ignore.case=FALSE)
#Adding to the previous column names, the names of the columns with STD information
colnums <- append(colnums, grep ("std", names(totalData), ignore.case=TRUE))
#Adding to the previous column names, the columns with the Subject and Activity Information
colnums <- sort(append(colnums, which(colnames(totalData)=="Act" | colnames(totalData)=="Subject")))

#We select only the columns with the MEAN and STD information. And the Activity and Subject columns also.
someData <- totalData[,colnums]

#Reading the Activity Labels file
activityLabels <- read.table("./activity_labels.txt", col.names=c("Id", "Activity"), na.strings=c(""))

#We rename the Activity IDs with the correspondent label read from the Activity label file.
dataActivity <- merge(someData, activityLabels, by.x="Act", by.y="Id", sort=FALSE)

#Reordering the columns in order to have the Activity and Subject before the other variables.
dataActivity <- dataActivity[, c(82,2:81)]

#Final exercise with the average of the values of the variables (columns 3 to 81) grouped by Subject and Activity
resultat <- aggregate(dataActivity[,3:81],  by=dataActivity[c("Subject","Activity")], FUN=mean)

#Reordering columns
final <- resultat[, c(2,1,3:81)]
#Saving into a file
write.table(final,file = "project.txt", row.names=FALSE ) 
```
