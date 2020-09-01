###########################################################################################
#                              Date: <03/11/2020> Version: <1.0>                          #
###########################################################################################
@NextGen_test 
Feature: NG000_NextGen_test_feature 

Scenario: Demo the Software Analyzer Nextgen 
	Given all configured endpoints for WEB are connected successfully 
	
	# Pre-condition
	
	Given the nextgen app is loaded successfully 
	
	# Login Steps
	
	When I open the Login page 
	Then I validate Software Analyser text to be present on page 
	When I input sashankkor1 on Username textbox 
	And I input admin on Password textbox 
	And I click on the element Login button 
	
	Then I open the Dashboard page 
	Then I validate Software Analyser text to be present on page 
	And I validate My Reports table to be present on page 
	And I validate All Reports table to be present on page 
	And I validate the following rows from the My Reports table for the coloumns Component,Tool,Created Date/Time are present on page 
		| parameter 		|
		| No records found 	|
	And I click on the element Component View button 
	And I click on the element User View button 
	And I click on the element Reports link 
	
	Then I open the Reports page 
	And I click on the element Compare with another Baseline button 
	And I click on the element PVER-I/Ser button 
	And I click on the element Tool1 button 
	And I click on the element Tool2 button 
	And I click on the element Tool3 button 
	And I click on the element Warnings/Errors button 
	And I click on the element HIS Metrics button 
	And I click on the element System Logs button 
	And I click on the element Logout link 
	
	And I terminate the web driver 
    