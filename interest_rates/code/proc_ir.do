*************
* Clean up a Dataset  
*************

clear all
set more off

* Install the filelist module
/// ssc install filelist

* Set working directory
global dirin = "./data/raw"
global dirout = "./data"

* Automate Fixes
insheet using "$dirin/ir2000.csv", comma clear

foreach var of varlist * {
  rename `var' `=`var'[1]'
}
drop in 1 
destring, replace 


* Remove all rows with header values
drop if Month == "Month"

* Check all prime rates for errors at once
destring Prime_Rate, replace
replace Prime_Rate = Prime_Rate * 10 if (Prime_Rate < 1)

* Replace NDs with NAs
replace Treasury_Rate_3_Month = "" if (Treasury_Rate_3_Month == "ND")

* gen Year = regexs(0) if(regexm(Month, "^[0-9][0-9][0-9][0-9]"))
* replace Month = regexs(0) if(regexm(Month, "-[0-9][0-9]$"))
* replace Month = subinstr(Month,"-", "", .)
* order Year, before(Month)

* Save results
* save "$dirout/ir2000_new.dta"
export delimited "$dirout/ir2000_new.csv"
