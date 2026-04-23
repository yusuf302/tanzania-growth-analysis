*******************************************************
* Project: Government Spending and Growth (Tanzania)
* Author: Yusuf A. Jongo
* Description: Replication file - OLS analysis
* Date: 2026
*******************************************************

clear all
set more off

* Set working directory (CHANGE THIS PATH)
cd "C:\Users\yjong\OneDrive\Documents\YAJ'S\proposal\TZ growth analysis"

* Create log file
log using "log/analysis.log", replace

*******************************************************
* Install required packages (only run once)
*******************************************************
cap which outreg2
if _rc ssc install outreg2

cap which estout
if _rc ssc install estout

*******************************************************
* Import Data
*******************************************************

import excel "C:\Users\yjong\OneDrive\Documents\YAJ'S\proposal\gdp_inf_and_gexp_tz", firstrow clear

* Inspect data
describe
summarize

*******************************************************
* Clean variable names
*******************************************************

rename GDP gdp
rename Gexp gexp
rename Inf inf
rename year year

* Check again
summarize

*******************************************************
* Data cleaning
*******************************************************

* Sort data
sort year

* Check missing values
misstable summarize

* Drop missing (if any)
drop if missing(gdp, gexp, inf)

* Set time series structure
tsset year

*******************************************************
* Descriptive statistics
*******************************************************

summarize gdp gexp inf

* Correlation matrix
pwcorr gdp gexp inf, sig

*******************************************************
* Graphs
*******************************************************

tsline gdp, title("GDP Growth (Tanzania)")
tsline gexp, title("Government Expenditure (% GDP)")
tsline inf, title("Inflation Rate (%)")

tsline gdp gexp inf, ///
legend(label(1 "GDP Growth") ///
       label(2 "Gov Expenditure") ///
       label(3 "Inflation")) ///
title("Macroeconomic Trends in Tanzania")

graph export "output/trends.png", replace

*******************************************************
* Baseline OLS
*******************************************************
reg gdp gexp inf
eststo model1

*******************************************************
* Heteroskedasticity test
*******************************************************

estat hettest

*******************************************************
* Autocorrelation
*******************************************************

estat bgodfrey

* Durbin-Watson
estat dwatson

*******************************************************
* Robust Model
*******************************************************
reg gdp gexp inf, robust
eststo model2

*******************************************************
* Lag Model
*******************************************************
tsset year

reg gdp L.gexp L.inf, robust
eststo model3

*******************************************************
* Export comparison
*******************************************************
cap mkdir "output"

esttab model1 model2 model3 ///
using "final_results.txt", replace ///
se star(* 0.10 ** 0.05 *** 0.01) ///
mtitles("OLS" "Robust" "Lag") ///
title("Impact of Government Spending on GDP Growth")

*******************************************************
* Multicollinearity
*******************************************************

vif

*******************************************************
* Normality test
*******************************************************

predict resid, residuals

sktest resid

*******************************************************
* closing log file
*******************************************************

log close