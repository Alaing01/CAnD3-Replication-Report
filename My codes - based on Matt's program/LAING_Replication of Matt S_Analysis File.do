CanD3 RRWM Activity - Attempt to replicate Matthew Stackhouse's results

Allison Laing
Sept 28, 2021
ANALYSIS FILE 

** PROGRAM: Generate Analysis Do-file

** Run RECODE DO-FILE (Steps 1 to 3 in PROGRAM)


// 4.	Generate analysis do-file +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	// I.	Upload recode data "2017_GSS_recode"
        ** OR... Run RECODE DO-FILE (Steps 1 to 3 in PROGRAM)
		
	// II.	Apply survey weights for all analyses at the start of code or at the end of each analysis line.
	//      fuck, i don't know how to do this... Loop back to figure this out if you have time.


// 5.	Create a weighted summary table with all variables (t) – Table 1 ++++++++++++++++++++++++++++++++++++++++++++++++++++
	//      **** Create summary table w all variables (not weighted, for now)

	// I.	Generate a list of summary statistics for pat_death, mat_death, SRMH, sex, agegr10, marital, ehg3_01b, and ttlincg2 


proportion afdiedcat amdiedcat srmh sex agegr10 marstatcat ehg3_01b ttlincg2, percent cformat(%9.2f) 

*** couple of issues: names are all fucky (should I rename variables?), and no instruction re table parameters - I assumed percentages, 2 decimal places for SE and 95% CI

rename afdiedcat Age_Paternal_Death
rename amdiedcat Age_Maternal_Death
rename srmh Mental_Health
rename sex Sex
rename agegr10 Age
rename marstatcat Marital_Status
rename ehg3_01b Education
rename ttlincg2 Total_Income

proportion Age_Paternal_Death Age_Maternal_Death Mental_Health Sex Age Marital_Status Education Total_Income, percent cformat(%9.2f) 


// 6.	Create logistic regression: bivariate and multivariate (t) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	// I.	Separately regress self-rated mental health on respondents age of paternal and maternal bereavement
	// how to break out age categories ??? ugh 

logistic Mental_Health Age_Paternal_Death 
logistic Mental_Health Age_Maternal_Death 



	// II.	Now conduct a multivariate logistic regression using all recoded/relabelled covariates
******************
	// problem: did not specify that he wanted TWO regressions: one for pat death and one for mat death 
	// and that he wanted nested modelss, i.e. bivariate regression as Model 1, add all covariates Model 2 
	
logistic Mental_Health Age_Paternal_Death
eststo model1
logistic Mental_Health Age_Paternal_Death Sex Age Marital_Status Education Total_Income
eststo model2

esttab, r2 ar2 se scalar (rmse) ///
title("Table 2a. Effect of Paternal Bereavement in Childhood on Self-rated Mental Health") mtitle("Model 1" "Model 2")

logistic Mental_Health Age_Maternal_Death
eststo model3
logistic Mental_Health Age_Maternal_Death Sex Age Marital_Status Education Total_Income
eststo model4

esttab, r2 ar2 se scalar (rmse) ///
title("Table 2b. Effect of Maternal Bereavement in Childhood on Self-rated Mental Health") mtitle("Model 3" "Model 4")
	
	
	//with the i. (ack! this won't work with how I coded vars...)
logistic Mental_Health i.Age_Paternal_Death
eststo model1
logistic Mental_Health i.Age_Paternal_Death i.Sex i.Age i.Marital_Status i.Education i.Total_Income
eststo model2

esttab, r2 ar2 se scalar (rmse) ///
title("Table 2a. Effect of Paternal Bereavement in Childhood on Self-rated Mental Health") mtitle("Model 1" "Model 2")

logistic Mental_Health i.Age_Maternal_Death
eststo model3
logistic Mental_Health i.Age_Maternal_Death i.Sex i.Age i.Marital_Status i.Education i.Total_Income
eststo model4

esttab, r2 ar2 se scalar (rmse) ///
title("Table 2b. Effect of Maternal Bereavement in Childhood on Self-rated Mental Health") mtitle("Model 3" "Model 4")







// III.	Save recode file as "2017_GSS_Analysis.dta"

