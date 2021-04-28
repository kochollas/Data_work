library(dplyr)
var = data.frame(table(final_survey_data$selected_region))
colnames(var)[1]<-c("Region")
var$Freq = round(var$Freq/sum(var$Freq)*100,2)
var %>% arrange(Freq)

freq_gen <- function(data,colname){
  var = 
  var = data.frame(table(data[,c(colname)]))
  colnames(var)[1]<-c(colname)
  var$Percentage = round(var$Freq/sum(var$Freq)*100,2)
  var %>% arrange(Percentage)
  var_header = cbind.data.frame(colname,"Freq","Percentage") 
  names(var_header) <- colnames(var)
  var_final <- rbind(var_header,var)
  var_footer <- cbind.data.frame("***** "," *****"," *****") 
  names(var_footer) <- colnames(var)
  var_final2 <- rbind(var_final,var_footer)
  return(var_final2)
  
}

reg = freq_gen(final_survey_data,"selected_region")
reg2 = freq_gen(final_survey_data,"network")
gender = freq_gen(final_survey_data,"secA_q2")
gender2 = freq_gen(final_survey_data,"secA_q3")

write.table(reg, "myDF.csv", sep = ",", col.names = !file.exists("myDF.csv"), append = T)
write.table(gender2, "myDF.csv", sep = ",", col.names = !file.exists("myDF.csv"), append = T)


dataB = final_survey_data[,c(1:70)]
Batch <- function(dataB){
  i=1
  N = ncol(dataB)
  for (i in 1:N) {
      if(class(dataB[,c(i)])=="character"){
        print("RESET to Character")
      }else if(class(dataB[,c(i)])=="integer"){
        print("RESET to integer")
      }else if(class(dataB[,c(i)])=="numeric"){
        print("RESET to numeric")
      }else if(class(dataB[,c(i)])=="factor"){
        print(i)
        reg = freq_gen(final_survey_data,colnames(final_survey_data)[i])
        write.table(reg, "myDF3.csv", sep = ",", col.names = !file.exists("myDF3.csv"), append = T)
        
      }else{
        print("No changes")
      }
      
    }
    
  }

Batch(dataB)


# Batch cross tabulation

freq_gen <- function(data,colname){
  var = 
    var = data.frame(table(data[,c(colname)]))
  colnames(var)[1]<-c(colname)
  var$Percentage = round(var$Freq/sum(var$Freq)*100,2)
  var %>% arrange(Percentage)
  var_header = cbind.data.frame(colname,"Freq","Percentage") 
  names(var_header) <- colnames(var)
  var_final <- rbind(var_header,var)
  var_footer <- cbind.data.frame("***** "," *****"," *****") 
  names(var_footer) <- colnames(var)
  var_final2 <- rbind(var_final,var_footer)
  return(var_final2)
  
}


