###########################################################################################
#                              Date: <03/18/2020> Version: <1.0>                          #
###########################################################################################
@NextGen_demo 
Feature: NG001_NextGen_test_feature 

Scenario: Demo the Succeessful Login to Software Analyzer Nextgen 
	
	Given all configured endpoints for WEB are connected successfully
	
	# Pre-condition
	
	Given the nextgen app is loaded successfully 
	
	# Test-Steps
	
	When I open the Login page 
	
	Then I validate Software Analyser text to be present on page 
	
	When I input sashankkor1 on Username textbox 
	
	And I input admin on Password textbox 
	
	Then I click on the element Login button
	
	And I open the Dashboard page
	
	When I click on the element Logout link
	
	Then I terminate the web driver 
	