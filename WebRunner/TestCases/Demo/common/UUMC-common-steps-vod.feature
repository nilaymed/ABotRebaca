@UMC_VOD_Common_Steps @WEB_LIBRARY
Feature: UMC_VOD_Common_Steps_Demo

  Scenario: Create global system configuration for UMC VOD
	
Given I initialize the mobile-device Device1 and launch the application

#Then I validate UmcRefApp text to be present on window

# Start-up VOD
Given I select VoDLIVE option from IMC cast mode dropdown

And I input OTTAppRequestURL in Server textbox

And I input Token in User textbox

And I input OwnerName in Owner textbox

And I input MediaIndentifier in Media textbox

And I input UserEmail in Primary textbox

And I input STSTokenValue in STS tokens textbox

And I input TenantIdentifier in Tenant ID textbox