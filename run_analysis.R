
#Read in the test and train data
xtest<-read.table("test/X_test.txt")
ytest<-read.table("test/y_test.txt")
xtrain<-read.table("train//X_train.txt")
ytrain<-read.table("train//y_train.txt")



#Merge the test and train data
df<-rbind(xtest,xtrain)
df2<-rbind(ytest,ytrain)

#add in the activity collumn
df3<-cbind(df2,df)
colnames<-read.table("./features.txt",stringsAsFactors=FALSE)

#Add in the collumn names
names(df3)<-c("Activity",colnames$V2)

#Add in the subject ID
subtest=read.table("test/subject_test.txt")
subtrain=read.table("train//subject_train.txt")
sub=rbind(subtest,subtrain)
names(sub)<-"Subject"
#Merge it all together
dfall=cbind(sub,df3)



#extract only the collumns with mean or std in their names
dfall<-dfall[,grep("std|mean|activity|subject",tolower(names(dfall)))]#Make sure to keep the activity and subj cols
#Use gsub() to rename them IAW tidy data principles
a<-names(dfall)
a<-gsub("-",".",a)
a<-gsub("[()]","",a)
a<-gsub(",",".",a)
names(dfall)<-a

#Replace the row names with descriptive activities
#This solution is ineficient to say the least but it works
rownames<-read.table("activity_labels.txt",stringsAsFactors=FALSE)
for(i in 1:length(dfall$Activity)){
  #print(i)
  dfall$Activity[i]<-rownames$V2[as.numeric(dfall$Activity[i])]
}


#Reshape the daya to include mean averages of all feature by subject and activity
#Each row will now consist of mean averages for all features for each subject during each activity
#An important not is that all STD measures are mean STD's this is not reflected in the variable name
#in order to prevent names of unweildly length
library(reshape2)
dfmelt=melt(dfall,id=c("Subject","Activity"),measure.vars=names(dfall)[3:length(names(dfall))])
dc=dcast(dfmelt, Subject+Activity ~variable,fun.aggregate=mean)

#write the tidy data set to the current working directory
write.table(dc,"tidydataset.txt")