var1 = freq_gen(final_survey_data,"Q73","secA_q2")
z <- generate_dummy_tabs(var1)

var1 = freq_gen(final_survey_data,"Q68","secA_q2")
z <- generate_dummy_tabs(var1)

var1 = freq_gen(final_survey_data,"Q69","secA_q2")
z <- generate_dummy_tabs(var1)

var1 = freq_gen(final_survey_data,"Q60","secA_q2")
z <- generate_dummy_tabs(var1)

var1 = freq_gen(final_survey_data,"Q61","secA_q2")
z <- generate_dummy_tabs(var1)

var1 = freq_gen(final_survey_data,"Q55","secA_q2")
z <- generate_dummy_tabs(var1)

var1 = freq_gen(final_survey_data,"Q56","secA_q2")
z <- generate_dummy_tabs(var1)

var1 = freq_gen(final_survey_data,"secA_q3","secA_q2")
z <- generate_dummy_tabs(var1)
# Tables 4
var1 = freq_gen(final_survey_data,"secA_q8","secA_q2")
var1 = freq_gen(final_survey_data,"secA_q9","secA_q2")
var1 = freq_gen(final_survey_data,"secA_q5","secA_q2")
var1 = freq_gen(final_survey_data,"secA_q6","secA_q2")
var1 = freq_gen(final_survey_data,"secA_q13","secA_q2")
var1 = freq_gen(final_survey_data,"secA_q10","secA_q2")
var1 = freq_gen(final_survey_data,"secA_q11","secA_q2")
#Table 6
var1 = freq_gen(final_survey_data,"secA_q12g","secA_q2")  #a-g
# Table 7
var1 = freq_gen(final_survey_data,"secB_q14j_sp","secA_q2") 



# Table 9
var1 = freq_gen(final_survey_data,"secB_q15e","secA_q2") 

#Table 10
var1 = freq_gen(final_survey_data,"secC_q16e","secA_q2") 

#Table 11
var1 = freq_gen(final_survey_data,"secC_q16k","secA_q2") 

# Table 12
var1 = freq_gen(final_survey_data,"secD_q17j","secA_q2") #a-j

# Table 15
var1 = freq_gen(final_survey_data,"secD_q19f","secA_q2") #a-f

# Table 16
var1 = freq_gen(final_survey_data,"secD_q20f","secA_q2") #a-f

# Table 17
var1 = freq_gen(final_survey_data,"secE_q22","secA_q2") #22 and other

# Figure
var1 = freq_gen(final_survey_data,"secE_q23","secA_q2") #22 and other

# Table 18
var1 = freq_gen(final_survey_data,"secD_q26e","secA_q2") #a-e


# Table 18
var1 = freq_gen(final_survey_data,"secE_q28","secA_q2") #a-e

# Figure
var1 = freq_gen(final_survey_data,"secE_q30","secA_q2") #22 and other

# Table 20
var1 = freq_gen(final_survey_data,"Q_43h","secA_q2") #a-h

# Table 21
var1 = freq_gen(final_survey_data,"q_41h","secA_q2") #a-g 

# Table 22
var1 = freq_gen(final_survey_data,"Q_46e","secA_q2") #a-g 

# Table 23
var1 = freq_gen(final_survey_data,"Q_47f","secA_q2") #a-f

# Table 24
var1 = freq_gen(final_survey_data,"Q_48a","secA_q2") #a-f

# Table 25
var1 = freq_gen(final_survey_data,"Q49b","secA_q2") #a-g
z <- generate_dummy_tabs(var1)

# Table 26
var1 = freq_gen(final_survey_data,"Q_51g","secA_q2") #a-g

# Table 27
var1 = freq_gen(final_survey_data,"Q_52g","secA_q2") #a-g

# Table 29
var1 = freq_gen(final_survey_data,"Q_57g","secA_q2") #a-g

# Table 30
var1 = freq_gen(final_survey_data,"Q_62g","secA_q2") #a-g


# Table 31
var1 = freq_gen(final_survey_data,"Q_70g","secA_q2") #a-g
z <- generate_dummy_tabs(var1)



# Table 31
var1 = freq_gen(final_survey_data,"Q_70g","secA_q2") #a-g
z <- generate_dummy_tabs(var1)

# Table 32
var1 = freq_gen(final_survey_data,"Q_75g","secA_q2") #a-g
z <- generate_dummy_tabs(var1)
write.table(z, "myDF3.csv", sep = ",", col.names = !file.exists("myDF3.csv"), append = T)

# Table 33
var1 = freq_gen(final_survey_data,"Q4_recode","secA_q2") #a-g

# Table 34
var1 = freq_gen(final_survey_data,"secA_q5","secA_q2") #a-g

# Table 35
var1 = freq_gen(final_survey_data,"Q7_recode","secA_q2") #a-g

# Table 36
var1 = freq_gen(final_survey_data,"q_36g","secA_q2") #a-g
z <- generate_dummy_tabs(var1)
write.table(z, "myDF3.csv", sep = ",", col.names = !file.exists("myDF3.csv"), append = T)








# Recoding for how long you have know your HIV status

final_survey_data$Q4_recode <- ifelse(final_survey_data$secA_q4 == 0, '1',
                                      ifelse(final_survey_data$secA_q4 >= 1 & final_survey_data$secA_q4 <= 3,'2',
                                             ifelse(final_survey_data$secA_q4 >= 4 & final_survey_data$secA_q4 <= 6,'3',
                                                    ifelse(final_survey_data$secA_q4 >= 7 & final_survey_data$secA_q4 <= 9,'4',
                                                           ifelse(final_survey_data$secA_q4 >= 10 & final_survey_data$secA_q4 <= 98,'5','6')))))

q4codes <-c('1','2','3','4','5','6')
q4level <- c('Less than 1 year','1-3 years','4-6 years','7-9 years','Above 10 years','Cant remember')
final_survey_data$Q4_recode <- factor(final_survey_data$Q4_recode,
                                            levels = q4codes,
                                            labels = q4level) 

# know your HIV status additional tables



# Recoding for number of children in a household

final_survey_data$Q7_recode <- ifelse(final_survey_data$secA_q7 == 0, '1',
                                      ifelse(final_survey_data$secA_q7 >= 1 & final_survey_data$secA_q7 <= 3,'2',
                                             ifelse(final_survey_data$secA_q7 >= 4 & final_survey_data$secA_q7 <= 6,'3',
                                                    ifelse(final_survey_data$secA_q7 >= 7 & final_survey_data$secA_q7 <= 9,'4','5'))))

q7codes <-c('1','2','3','4','5')
q7level <- c('None','1-3 children','4-6 children','7-9 children','More than 10 children')
final_survey_data$Q7_recode <- factor(final_survey_data$Q7_recode,
                                      levels = q7codes,
                                      labels = q7level) 


