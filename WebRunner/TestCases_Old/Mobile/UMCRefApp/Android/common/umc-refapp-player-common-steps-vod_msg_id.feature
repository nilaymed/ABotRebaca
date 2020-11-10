@OTT-Common-RefApp-Step @WEB_LIBRARY
Feature: UMCRefApp-Player-Common-Steps_VOD_msg_id

  Scenario: Create global system configuration for UMC VOD
	
Given I initialize the mobile-device Device1 and launch the application

And I input OTTAppRequestURL in Server textbox

And I input Token in User textbox

And I input OwnerName in Owner textbox

And I input MediaIndentifier in Media textbox

And I input UserEmail in Primary textbox

And I input {abotprop.REFAPP.OAUTH.TOKEN} in STS tokens textbox

And I input TenantIdentifier in Tenant ID textbox