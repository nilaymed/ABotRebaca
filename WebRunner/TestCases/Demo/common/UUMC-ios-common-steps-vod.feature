@UMC_IOS_VOD_Common_Steps @WEB_LIBRARY
Feature: UMC_IOS_VOD_Common_Steps_Demo

  Scenario: Create global system configuration for UMC VOD
	
Given I initialize the mobile-device Device2 and launch the application

#Then I validate UmcRefApp text to be present on window

# Start-up VOD

And I input OTTAppRequestURL in Server textbox

And I input MediaIndentifier in Media textbox

And I input OwnerName in Owner textbox

And I input Token in User textbox

And I input UserEmail in Primary textbox

And I input STSTokenValue in STS tokens textbox

And I input TenantIdentifier in Tenant ID textbox