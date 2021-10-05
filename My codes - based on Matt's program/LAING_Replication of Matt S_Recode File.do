CanD3 RRWM Activity - Attempt to replicate Matthew Stackhouse's results

Allison Laing
Sept 28, 2021
RECODE FILE 


**** create trimmed dataset
// import GSS Family 2017.csv

keep afdiedc amdiedc srh_115 marstat sex agegr10 ehg3_01b ttlincg2 


** PROGRAM: Recode do-file

// 1.	Clean predictor and outcome variables ++++++++++++++++++++++++++++++++++

** Predictor variables:

* I. Recode from continuous into categorical variable (4 categories)

* //Recode respondent's age of paternal bereavement (afdiedc) //

//???????????????????????????????????????????????????????????????????????????????
// PROBLEM: NO AGES / CATEGORY CUT-POINTS PROVIDED 
//???????????????????????????????????????????????????????????????????????????????

generate afdiedcat = .
replace afdiedcat = 1 if afdiedc<=18
replace afdiedcat = 2 if afdiedc>=19 & afdiedc<=29
replace afdiedcat = 3 if afdiedc>=30 & afdiedc<=49
replace afdiedcat = 4 if afdiedc>=50 & afdiedc<=70

label variable afdiedcat "Age of paternal bereavement"
label define afdiedcat_label 1 "Childhood 0-18" 2 "Young adult 19-29" 3 "Adulthood 30-49" 4 "Older adult ≥50"
label values afdiedcat afdiedcat_label

tab afdiedcat

* //Recode maternal bereavement (amdiedc) //

generate amdiedcat = .
replace amdiedcat = 1 if amdiedc<=18
replace amdiedcat = 2 if amdiedc>=19 & amdiedc<=29
replace amdiedcat = 3 if amdiedc>=30 & amdiedc<=49
replace amdiedcat = 4 if amdiedc>=50 & amdiedc<=70

label variable amdiedcat "Age of maternal bereavement"
label define amdiedcat_label 1 "Childhood 0-18" 2 "Young adult 19-29" 3 "Adulthood 30-49" 4 "Older adult ≥50"
label values amdiedcat amdiedcat_label

tab amdiedcat


* Omit those who have not experience parental bereavement.
// NOTE: 96 = Valid skip 

drop if afdiedcat == 96
drop if amdiedcat == 96

* II.	Drop all other missingness from both predictor variables (97 & 98 for each variable).
//NOTE: Dk and Ref 

drop if afdiedcat == 97
drop if afdiedcat == 98

drop if amdiedcat == 97
drop if amdiedcat == 98

tab afdiedcat
tab amdiedcat


** Outcome variable

* III.	Recode outcome variable self-rated mental health (srh_115) into a dummy variable called `SRMH' – the worst outcome should be the reference category.

//???????????????????????????????????????????????????????????????????????????????
// PROBLEM: 5 ORDINAL CATEGORIES - ASSUME HE WANTS A BINARY OF GOOD HEALTH VS BAD HEALTH = "WORST OUTCOME" would be FAIR AND POOR 
//???????????????????????????????????????????????????????????????????????????????
// so i created a binary of 0= fair or poor MH, 1= good, very good or excellent 

***** Nope!! This didn't work 
*generate srmh = 0
*replace srmh =1 if srh_115<=3 // 1=excellent, 2=v.good, 3=good

* This worked!!:

generate srmh = .
replace srmh = 0 if srh_115>=4 & srh_115<=5 
replace srmh = 1 if srh_115>=1 & srh_115<=3 

* IV.	Drop missing respondents from SRMH measure.
// DK=7, REF=8, NOT STATED=9
 
drop if srh_115 == 7
drop if srh_115 == 8
drop if srh_115 == 9

// Label variable and values //

label variable srmh "Self-Rated Mental Health"
label define srmh_label 0 "Poor or fair" 1 "Good, very good, or excellent"
label values srmh srmh_label
tab srmh

 
// 2.	Clean covariates +++++++++++++++++++++++++++++++++++++++++++++++++++++++

* I.	Recode marital status `marstat' into 1 "Married/Common-law" 2 "Previously married" and 3 "Single/Never Married" 


generate marstatcat = .
replace marstatcat = 1 if marstat<=2  // married and common law
replace marstatcat = 2 if marstat>=3 & amdiedc<=5 // widowed, separated, divorced
replace marstatcat = 3 if marstat==6 // single / never married 

* II.	Drop missingness from marital status 

drop if marstat == 96
drop if marstat == 97
drop if marstat == 98
drop if marstat == 99

tab marstatcat

// Label variable and values // marstat 

label variable marstatcat "Marital Status"
label define marstatcat_label 1 "Married/Common-law" 2 "Previously married" 3 "Single/Never Married"
label values marstatcat marstatcat_label
tab marstatcat


* III.	Add value labels to chosen covariates: respondents sex (sex), age (agegr10), highest level of education (ehg3_01b), and total income before tax (ttlincg2)

//sex//

label variable sex "Respondent's sex"
label define sex_label 1 "Male" 2 "Female" 
label values sex sex_label
tab sex

//agegr10//

label variable agegr10 "Age"
label define agegr10_label 1 "15 to 24" 2 "25 to 34" 3 "35 to 44" 4 "45 to 54" 5 "55 to 64" 6 "65 to 74" 7 "75 and over"
label values agegr10 agegr10_label
tab agegr10

//education// ehg3_01b

label variable ehg3_01b "Highest level of education"
label define ehg3_01b_label 1 "Less than Highschool" 2 "Highschool dipoma" 3 "Trade certificate" 4 "College certificate" 5 "University diploma below Bachelor" 6 "University Bachelor Degree" 7 "University diploma above Bachelor" 
label values ehg3_01b ehg3_01b_label
tab ehg3_01b

//income// ttlincg2

label variable ttlincg2 "Respondent's total income before tax"
label define ttlincg2_label 1 "Less than $25,000" 2 "$25,000 to $49,999" 3 "$50,000 to $74,999" 4 "$75,000 to $99,999" 5 "$100,000 to $124,999" 6 "$125,000 and more"
label values ttlincg2 ttlincg2_label
tab ttlincg2


*IV.	Drop missingness from education (ehg3_01b)

drop if ehg3_01b == 97
drop if ehg3_01b == 98
drop if ehg3_01b == 99

tab ehg3_01b










