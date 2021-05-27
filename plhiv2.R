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
interviewer_ids = data.frame(table(data_today2$Main.secA.interviewer_id))
colnames(interviewer_ids) <- c("Interviewer_ID", "Completed Interviews")
write.csv(interviewer_ids, "interviewer performance.csv")


#-----------------------------------------------------------------------------------
#START DATA LABELING AND PROCESSING HERE
# Data Processing in prep for analysis
library(dplyr)
setwd("~/Documents/upwork/Georges")
data_today = read.csv("smart_survey_final_6.csv")
data_today2 = data_today %>% filter(today2 >= '2021-03-08')



# Read spss data
library(foreign)
base_data1 <- read.spss("data/data.sav", use.value.labels = T, to.data.frame = T)
#columns_to_dropB = c()
#base_data <- base_data1%>%select(-columns_to_dropB)
base_data <- base_data1

# Processing data in readiness for merging
#base_data1 <- base_data[,c(1:324)]

# Drop on the final dataset
data_today3 <- data_today2[,c(1:320)]
columns_to_dropA = c("SubmissionDate","metadata_note_introduction","note1","Main.secG.note_secG",
                    "Main.secG.Q_62_group.noteq62","Main.secG.Q_65_group.noteq65","Main.secG.Q_70_group.noteq70",
                    "Main.secG.Q_75_group.noteq75","Main.secH.subsecH.note_subsecH", "Main.note12"  )



final_data1 <- data_today3%>%select(-columns_to_dropA)
print(ncol(data_today3) - ncol(final_data1))
print(length(columns_to_dropA))

# WORKING ON A FUNCTION TO HANDLE RENAMING

data_labeler <- function(final_start, final_end, base_start,base_end){
  dataA = final_data1[,c(final_start:final_end)]
  dataB = base_data[,c(base_start:base_end)]
  colnames(dataA)<-colnames(dataB)
  
  i=1
  N = ncol(dataA)
  for (i in 1:N) {
    if(class(dataA[,c(i)])==class(dataB[,c(i)])){
      print("good")
    }else{
      if(class(dataB[,c(i)])=="character"){
        print("RESET to Character")
      }else if(class(dataB[,c(i)])=="integer"){
        print("RESET to integer")
      }else if(class(dataB[,c(i)])=="numeric"){
        print("RESET to numeric")
      }else if(class(dataB[,c(i)])=="factor"){
        print(i)
        #class(dataA[,i]) <- class(dataB[,i])
        dataA[,i] = factor(dataA[,i])
        levels(dataA[,i]) <- levels(dataB[,i])
        
      }else{
        print("No changes")
      }
      
    }
    
  }
  return(dataA)
}

dataA_01 <-data_labeler(final_start=1, final_end=135, base_start=1,base_end=135)

#Creating additional 7 variables
dataA_01$Q40_1 <- 0
dataA_01$Q40_2 <- 0
dataA_01$Q40_3 <- 0
dataA_01$Q40_4 <- 0
dataA_01$Q40_5 <- 0
dataA_01$Q40_6 <- 0
dataA_01$Q40_7 <- 0

# Part B of data pulling 

dataA_02 <-data_labeler(final_start=136, final_end=235, base_start=143,base_end=242) #Q60

dataA_03 <-data_labeler(final_start=236, final_end=304, base_start=243,base_end=311) #Q60

dataA_03$referal_2_1 <- 0
dataA_03$referal_2_2 <- 0
dataA_03$referal_2_3 <- 0
dataA_03$referal_2_4 <- 0

dataA_04 <-data_labeler(final_start=305, final_end=306, base_start=316,base_end=317)

dataA_04$referal_followup_3.1 <-0
dataA_04$referal_followup_3.2 <-0
dataA_04$referal_followup_3.3 <-0

dataA_05 <-data_labeler(final_start=307, final_end=310, base_start=321,base_end=324)

# To column bind the data to have final data
final_survey_data <- cbind(dataA_01,dataA_02,dataA_03,dataA_04,dataA_05)
print(ncol(final_survey_data))


# Working on levels for counties 47
county_vals=c('26',
  '36',
  '29',
  '2',
  '34',
  '37',
  '23',
  '15',
  '22',
  '47h',
  '47f',
  '28',
  '47b',
  '25',
  '10',
  '12',
  '31',
  '19',
  '42',
  '3',
  '30',
  '20',
  '47a',
  '4',
  '11',
  '43',
  '7',
  '47g',
  '41',
  '38',
  '18',
  '45',
  '47d',
  '8',
  '9',
  '1',
  '27',
  '47c',
  '5',
  '47e',
  '21',
  '39',
  '33',
  '6',
  '46',
  '13',
  '40',
  '44',
  '32',
  '16',
  '14',
  '17',
  '24',
  '35')

county_labs = c('Trans-Nzoia',
                 'Bomet',
                 'Nandi',
                 'Kwale',
                 'Kajiado',
                 'Kakamega',
                 'Turkana',
                 'Kitui',
                 'Kiambu',
                 'Starehe',
                 'Makadara',
                 'Elgeyo-Marakwet',
                 'Westlands',
                 'Samburu',
                 'Marsabit',
                 'Meru',
                 'Laikipia',
                 'Nyeri',
                 'Kisumu',
                 'Kilifi',
                 'Baringo',
                 'Kirinyaga',
                 'Embakasi',
                 'Tana River',
                 'Isiolo',
                 'Homa Bay',
                 'Garissa',
                 'Kamkunji',
                 'Siaya',
                 'Vihiga',
                 'Nyandarua',
                 'Kisii',
                 'Langata',
                 'Wajir',
                 'Mandera',
                 'Mombasa',
                 'Uasin Gishu',
                 'Dagoretti',
                 'Lamu',
                 'Kasarani',
                 'Muranga',
                 'Bungoma',
                 'Narok',
                 'Taita–Taveta',
                 'Nyamira',
                 'Tharaka-Nithi',
                 'Busia',
                 'Migori',
                 'Nakuru',
                 'Machakos',
                 'Embu',
                 'Makueni',
                 'West Pokot',
                 'Kericho')

final_survey_data$selected_county <- factor(final_survey_data$selected_county,
                   levels = county_vals,
                   labels = county_labs) 

colnames(final_survey_data)[5] <- c("network")

final_survey_data = final_survey_data %>% filter(consent_given == 'Yes')

# Change venue_code to networks
colnames(final_survey_data)[5] <- c("network")
print(ncol(final_survey_data))
print(ncol(base_data))


#Data Export Section
library(foreign)
write.dta(final_survey_data, "c:/mydata.dta") 
write.csv(final_survey_data, "final_plhiv.csv")
final_survey_data <- read.csv("final_plhiv.csv")
# Splitting multiple response columns

N = nrow(final_survey_data)
row_count = 1
while (row_count <= N) {
  if(row_count > 1900){
    print(final_survey_data[row_count,c('referal_followup_3')])
  } 
  row_count = row_count+1
}



# Add variable labels


library(sqldf)
work1 = final_survey_data%>%select(interviewer_id,selected_region,selected_county)
work1$interviewer_id = as.integer(work1$interviewer_id)
worked = sqldf("SELECT  selected_region, selected_county,interviewer_id, count(*) 
      FROM work1
      GROUP BY selected_region, selected_county, interviewer_id
      ORDER BY selected_region")
colnames(worked)<-c("Region","County","Interviewer ID","Completed Surveys")

write.csv(worked, "RAs_Data.csv")

maleSP = data.frame(table(final_survey_data$Q56))

