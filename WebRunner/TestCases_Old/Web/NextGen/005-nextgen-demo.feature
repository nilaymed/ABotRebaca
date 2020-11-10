###########################################################################################
#                              Date: <03/18/2020> Version: <1.0>                          #
###########################################################################################
@NextGen_demo
Feature: NG005_NextGen_test_feature 

Scenario: Demo the failed table-row data validation to Software Analyzer Nextgen 
	
	Given all configured endpoints for WEB are connected successfully 
	
	# Pre-condition
	
	Given the nextgen app is loaded successfully 
	
	# Test-Steps
	
	When I open the Login page
	 
	Then I validate Software Analyser text to be present on page 
	
	When I input sashankkor1 on Username textbox 
	
	And I input admin on Password textbox 
	
	And I click on the element Login button 
	
	Then I open the Dashboard page 
	
	And I validate Software Analyser text to be present on page
	
	When I validate All Reports table to be present on page
	
	Then I validate the following rows from the All Reports table for the coloumns Component,Stage,Baseline version,Created By,Created Date/Time are present on page
		| parameter																  |
		| PVERName5,	Central Assessment,		USERNAME,	27-02-2020 / 06:45:26 |
		| PVERName2,	Manual Assessment,		USERNAMEX,	25-02-2020 / 09:49:48 |
		| PVERName3,	Import Assessment,		USERNAME,	13-02-2020 / 10:27:49 |
		
	And I terminate the web driver