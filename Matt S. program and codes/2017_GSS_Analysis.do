version 15
clear matrix
clear all
capture log close
set more off, permanently

************************************************************************
************************************************************************
* AUTHOR: Matthew Stackhouse
* DATE STARTED: September 20th, 2021
* FUNCTION: Age of Parental Bereavement & Self-reported Mental Health Analysis
* INPUT DATA: GSS - 2016 DATA
* OUTPUT DATA: Summary tables and regressions
************************************************************************
************************************************************************

use "/Users/mattstackhouse/Desktop/PhD/CAnD3/RRWM Project/DTA files/2017_GSS_Recode.dta"

***Data Weights***
svyset [pw=wght_per]


***Summary Statistics - Table 1
svy: proportion pat_death mat_death SRMH sex agegr10 marital ehg3_01b ttlincg2

***Bivariate Table
svy: logistic SRMH i.pat_death
eststo m1
svy: logistic SRMH i.mat_death
eststo m2

*Generate Table*
esttab m1 m2, eform b(a2) not label nonumber wide modelwidth(12 12) varwidth(15) ///
title("Table 2") mtitle("Model 1" "Model 2")

***Multivariate Table
svy: logistic SRMH i.pat_death i.sex i.agegr10 i.marital i.ehg3_01b i.ttlincg2
eststo m1
svy: logistic SRMH i.mat_death i.sex i.agegr10 i.marital i.ehg3_01b i.ttlincg2
eststo m2

*Generate Table*
esttab m1 m2, eform b(a2) not label nonumber wide modelwidth(12 12) varwidth(15) ///
title("Table 2") mtitle("Model 1" "Model 2")


save "/Users/mattstackhouse/Desktop/PhD/CAnD3/RRWM Project/DTA files/2017_GSS_Analysis.dta", replace
