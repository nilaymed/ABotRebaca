###########################################################################################
#                              Date: <03/18/2020> Version: <1.0>                          #
###########################################################################################
@NextGen_demo 
Feature: NG003_NextGen_test_feature 

Scenario: Demo the Dashboard navigation to Software Analyzer Nextgen 
	
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
	
	When I validate My Reports table to be present on page  
	
	Then I validate the following rows from the My Reports table for the coloumns Component,Tool,Created Date/Time are present on page 
		| parameter 		|
		| No records found 	|
	
	Then I input xyz.report in My Reports search textbox
	
	And I click on the element button_1(My Reports) button
	
	And I click on the element button_2(My Reports) button
	
	When I validate All Reports table to be present on page
	
	Then I validate the following rows from the All Reports table for the coloumns Component,Stage,Baseline version,Created By,Created Date/Time are present on page 
		| parameter																  |
		| PVERName1,	Central Assessment,		USERNAME,	27-02-2020 / 06:45:26 |
		| PVERName2,	Manual Assessment,		USERNAME2,	25-02-2020 / 09:49:48 |
		| PVERName3,	Import Assessment,		USERNAME,	13-02-2020 / 10:27:49 |
	
	And I input PVERName4 in All Reports search textbox
	
	And I click on the element button_1(All Reports) button
	
	And I click on the element Component View button 
	
	And I click on the element User View button
	
	Then I click on the element Logout link
	
	And I terminate the web driver
	
	
	