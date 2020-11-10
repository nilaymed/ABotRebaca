###########################################################################################
#                              Date: <03/18/2020> Version: <1.0>                          #
###########################################################################################
@NextGen_demo
Feature: NG006_NextGen_test_feature

Scenario: Demo the Logger dropdown validation to Software Analyzer Nextgen 
	
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
	
	And I select Error option from Logger dropdown
	
	And I wait for 2 seconds
	
	And I validate Error Percentage text to be present on page
	
	And I wait for 2 seconds
	
	Then I click on the element Logout link 
	
	And I terminate the web driver