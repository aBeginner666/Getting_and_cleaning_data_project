run_analysis<-function(dir){
  setwd(dir);
  library(dplyr);
  
  #================== read data =============================
  var_name<-read.table("./features.txt");
  act_name<-read.table("./activity_labels.txt");
  test_data<-read.table("./test/X_test.txt");
  test_sub<-read.table("./test/y_test.txt");   
  test_person<-read.table("./test/subject_test.txt");  
  train_data<-read.table("./train/X_train.txt");
  train_sub<-read.table("./train/y_train.txt");  
  train_person<-read.table("./train/subject_train.txt"); 
  
  #================ merge the training and test sets ================
  
  test_rawdata<-cbind(test_person,test_sub,test_data);
  train_rawdata<-cbind(train_person,train_sub,train_data);
  raw_data<-rbind(test_rawdata,train_rawdata);
  
  #================ rename the columns of raw data using descriptive variable names ====================
  
  name<-unlist(var_name$V2);
  name<-as.character(name);
  colnames(raw_data)<-c("subject","activity",name);
  
  #=============== select mean and sd measurement ===================
  index_mean<-grep("mean",names(raw_data));
  index_sd<-grep("std",names(raw_data));
  index<-sort(c(1,2,index_mean,index_sd));
  selected_data<-raw_data[,index];
  
  #============== uses descriptive activity names to name the activities in the data set ==================
  label<-as.character(act_name[,2]);
  selected_data$activity<-as.character(label[selected_data[,2]]);
  
  #============== creates a second data set with the average of each variable for each activity and each subject ======
  
  second_data<-data.frame(subject=rep(1:30,each=6),activity=rep(label,30));
  num_data<-selected_data[,-(1:2)]
  avg_data<-num_data;
  for(i in 1:30){
    for(j in 1:6){
      avg_data[6*(i-1)+j,]<-colMeans(num_data[raw_data[,1]==i&raw_data[,2]==j,]);
    }
  }
  second_data<-cbind(second_data,avg_data[1:180,]);
  
  #============== return the result========================
  
  return(list(selected_data,second_data))
  
}