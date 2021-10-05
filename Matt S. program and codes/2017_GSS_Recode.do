version 15
clear matrix
clear all
capture log close
set more off, permanently

************************************************************************
************************************************************************
* AUTHOR: Matthew Stackhouse
* DATE STARTED: September 20th, 2021
* FUNCTION: Age of Parental Bereavement & Self-reported Mental Health Recode
* INPUT DATA: GSS - 2016 DATA
* OUTPUT DATA: 
************************************************************************
************************************************************************

use "/Users/mattstackhouse/Desktop/PhD/CAnD3/RRWM Project/DTA files/2017_GSS_Data.dta"

***RECODING***
*recoding paternal bereavement
tab afdiedc, m
recode afdiedc (0/17=1)(18/34=2)(35/54=3)(55/70=4)(96=.d)(else=.), gen(pat_death)
la var pat_death "Respondent's Age of Paternal Bereavement"
la def pat_death1 1 "0 - 17" 2 "18 - 34" 3 "35 - 54" 4 "55 and older" 
la val pat_death pat_death1
tab pat_death, m
drop if pat_death ==.
drop if pat_death ==.d


*recoding maternal bereavement
tab amdiedc, m
recode amdiedc (0/17=1)(18/34=2)(35/54=3)(55/70=4)(96=.d)(else=.), gen(mat_death)
la var mat_death "Respondent's Age of Maternal Bereavement"
la def mat_death1 1 "0 - 17" 2 "18 - 34" 3 "35 - 54" 4 "55 and older" 
la val mat_death mat_death1
tab mat_death, m
drop if mat_death ==.
drop if mat_death == .d

*recoding Self-rated Mental Health
tab srh_115, m 
recode srh_115 (1/3=1)(4/5=0)(else=.), gen (SRMH)
la var SRMH "Self-reported mental health"
la def SRMH1 1 "Excellent/Very good/Good" 0 "Fair/Poor"
la val SRMH SRMH1
tab SRMH
drop if SRMH==.

**recoding select covariates
*respondents sex
tab sex, m
la def sex1 1 "male" 2 "female"
la val sex sex1

*respondents age group
tab agegr10, m
la def agegr101 1 "15 - 24" 2 "25 - 34" 3 "35 - 44" 4 "45 - 54" 5 "55 - 64" 6 "65 - 74" 7 "75 years and over"
la val agegr10 agegr101

*respondents marital status
tab marstat, m
recode marstat (1/2=1)(3/5=2)(6=3)(else=.), gen(marital)
la var marital "Marital status of respondent"
la def marital1 1 "Married/Common-law" 2 "Previously Married" 3 "Single/Never Married"
la val marital marital1
drop if marital==.

*respondents highest level of education
tab ehg3_01b, m
la def ehg3_01b1 1 "Less than HS" 2 "Has HS or equivalent" 3 "Trade certificate" 4 "College or non-uni certificate" 5 "University cert or diploma below bachelors" 6 "Bachelor's degree" 7 "University certificate, diploma or degree above bachelors"
la val ehg3_01b ehg3_01b1
drop if ehg3_01b == 97
drop if ehg3_01b == 98
drop if ehg3_01b == 99

*respondent income (before tax)
tab ttlincg2
la def ttlincg21 1 "Less than $25,000" 2 "$25,000 to $49,999" 3 "$50,000 to $74,999" 4 "$75,000 to $99,999" 5 "$100,000 to $124,999" 6 "$125,000 or more"
la val ttlincg2 ttlincg21


keep pat_death mat_death SRMH sex agegr10 marital ehg3_01b ttlincg2 wght_per


save "/Users/mattstackhouse/Desktop/PhD/CAnD3/RRWM Project/DTA files/2017_GSS_Recode.dta", replace
