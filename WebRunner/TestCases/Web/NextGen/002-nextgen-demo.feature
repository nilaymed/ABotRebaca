###########################################################################################
#                              Date: <03/18/2020> Version: <1.0>                          #
###########################################################################################
@NextGen_demo
Feature: NG002_NextGen_test_feature 

Scenario: Demo the Unsucceessful Login to Software Analyzer Nextgen 
	
	Given all configured endpoints for WEB are connected successfully
	
	# Pre-condition
	
	Given the nextgen app is loaded successfully 
	
	# Test-Steps
	
	When I open the Login page 
	
	Then I validate Software Analyser text to be present on page 
	
	When I input sashankkor786 on Username textbox 
	
	And I input admin420 on Password textbox 
	
	And I click on the element Login button
	
	Then I validate Sorry! username or password error text to be present on page
	
	And I terminate the web driver