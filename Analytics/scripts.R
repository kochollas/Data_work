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


z <- generate_dummy_tabs(var1)

write.table(z, "myDF3.csv", sep = ",", col.names = !file.exists("myDF3.csv"), append = T)
