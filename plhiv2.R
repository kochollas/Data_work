# plhiv data processing
#url : 

library(ruODK)
ruODK::ru_setup(
  svc = "https://plhiv.dataseniors.com/v1/projects/2/forms/smart_survey_final_6.svc",
  un = "kochollamikes@gmail.com",
  pw = "admin@O1989",
  tz = "EAT/Nairobi",
  verbose = TRUE # great for demo or debugging
)

proj <- ruODK::project_list()
proj %>% head() %>% knitr::kable(.)

frms <- ruODK::form_list()
frms %>% head() %>% knitr::kable(.)

# Form details of default form
frmd <- ruODK::form_detail()
frmd %>% knitr::kable(.)


# Form schema: defaults to version 0.8
meta <- ruODK::form_schema(odkc_version = get_test_odkc_version())
#> ℹ Form schema v1
meta %>% knitr::kable(.)

# Part 2: Data access ---------------------------------------------------------#
# Form tables
srv <- ruODK::odata_service_get()
srv %>% knitr::kable(.)

# Form submissions
data <- ruODK::odata_submission_get(local_dir = fs::path("vignettes/media"),
                                    odkc_version = get_test_odkc_version())


data %>% dplyr::select(-"odata_context") %>% knitr::kable(.)
View(data)

# MORE SCRIPTS FOR THE SURVEY ON PLHIV

#Finding time in minutes to complete the survey on average.
mean((data$end-data$start)/60)





# People to payed by ids
library(dplyr)
setwd("~/Documents/upwork/Georges")
data_today = read.csv("smart_survey_final_6.csv")
data_today2 = data_today %>% filter(today2 >= '2021-03-08')
interviewer_ids = data.frame(table(data_today2$Main.secA.interviewer_id))
colnames(interviewer_ids) <- c("Interviewer_ID", "Completed Interviews")
write.csv(interviewer_ids, "interviewer performance.csv")


# Read spss data
library(foreign)
library(spss)
base_data <- read.spss("data/data.sav", use.value.labels = T, to.data.frame = T)

# Processing data in readiness for merging
#base_data1 <- base_data[,c(1:324)]

# Drop on the final dataset
data_today3 <- data_today2[,c(1:320)]
columns_to_drop = c("SubmissionDate","metadata_note_introduction","note1","Main.secG.note_secG",
                    "Main.secG.Q_62_group.noteq62","Main.secG.Q_65_group.noteq65","Main.secG.Q_70_group.noteq70",
                    "Main.secG.Q_75_group.noteq75")



final_data1 <- data_today3%>%select(-columns_to_drop)
print(ncol(data_today3) - ncol(final_data1))
print(length(columns_to_drop))

# WORKING ON A FUNCTION TO HANDLE RENAMING
















#Startint to rename the columns
colnames(final_data1)[1:10]<-colnames(base_data)[1:10]
attr(final_data1,"variable.label")[1:10] <- attr(base_data,"variable.label")[1:10]

factor(final_data1$consent_given)
levels(final_data1$consent_given)<-levels(base_data$consent_given)

table(final_data1$consent_given)

# Testing appending data 
data_labeler <- function(final_start, final_end, base_start,base_end){
  dataA = final_data1[,c(final_start:final_end)]
  dataB = base_data[,c(base_start:base_end)]
  colnames(dataA)<-colnames(dataB)
  
  i=1
  N = ncol(dataA)
  for (i in 1:N) {
    if(class(dataA[,i])==class(dataB[,i])){
      print("good")
    }else{
      if(class(dataB[,i])=="character"){
        print("RESET to Character")
      }else if(class(dataB[,i])=="integer"){
        print("RESET to integer")
      }else if(class(dataB[,i])=="numeric"){
        print("RESET to numeric")
      }else if(class(dataB[,i])=="factor"){
        class(dataA[,i])<-class(dataB[,i])
        levels(dataA[,i]) <- levels(dataB[,i])
      }else{
        print("No changes")
      }
      
    }
    
  }
  return(dataA)
}

dataA_01 <-data_labeler(final_start=1, final_end=20, base_start=1,base_end=20)
  


