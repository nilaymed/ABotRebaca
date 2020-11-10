@RefApp-Player-MobileTSB-Steps @WEB_LIBRARY
Feature: RefApp-Player-MobileTSB-Steps

  Scenario: Create global system configuration for UMC Cases
	
 # Pre-condition
  Given I initialize the mobile-device Device1 and launch the application

# Start Up 
And I input OTTAppRequestURL in Server textbox

And I input Token in User textbox

And I input OwnerName in Owner textbox

And I input MediaIndentifier in Media textbox

And I input UserEmail in Primary textbox

And I input {abotprop.REFAPP.OAUTH.TOKEN} in STS tokens textbox

And I input AppTokenValue on App Token textbox

And I input TenantIdentifier in Tenant ID textbox

And I input CatchUpStartTime in Catchup StartTime textbox
