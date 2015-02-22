features <- read.table("./features.txt", na.strings=c(""))

testSubject <- read.table("./test/subject_test.txt", na.strings=c(""))
testActivity <- read.table("./test/y_test.txt", na.strings=c(""))
testX <- read.table("./test/X_test.txt", na.strings=c(""))
names(testX) <- features$V2
testData <- data.frame("Subject"=testSubject$V1, "Act"=testActivity$V1, testX)

trainX <- read.table("./train/X_train.txt", na.strings=c(""))
names(trainX) <- features$V2
trainSubject <- read.table("./train/subject_train.txt", na.strings=c(""))
trainActivity <- read.table("./train/y_train.txt", na.strings=c(""))
trainData <- data.frame("Subject"=trainSubject$V1, "Act"=trainActivity$V1, trainX)

totalData <- rbind(testData, trainData)

colnums <- grep ("mean", names(totalData), ignore.case=FALSE)
colnums <- append(colnums, grep ("std", names(totalData), ignore.case=TRUE))
colnums <- sort(append(colnums, which(colnames(totalData)=="Act" | colnames(totalData)=="Subject")))

someData <- totalData[,colnums]

activityLabels <- read.table("./activity_labels.txt", col.names=c("Id", "Activity"), na.strings=c(""))
dataActivity <- merge(someData, activityLabels, by.x="Act", by.y="Id", sort=FALSE)
dataActivity <- dataActivity[, c(82,2:81)]

resultat <- aggregate(dataActivity[,3:81],  by=dataActivity[c("Subject","Activity")], FUN=mean)
final <- resultat[, c(2,1,3:81)]
write.table(final,file = "project.txt", row.names=FALSE ) 
