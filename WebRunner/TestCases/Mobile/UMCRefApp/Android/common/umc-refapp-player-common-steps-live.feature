@OTT-Common-RefApp-Step @WEB_LIBRARY
Feature: UMCRefApp-Player-Common-Steps_LIVE

  Scenario: Create global system configuration for UMC LIVE
	
Given I initialize the mobile-device Device1 and launch the application

And I input https://ottapp-appgw-amp-a.cip.mr.tv3cloud.com in Server textbox

And I input 2b791c224ef7e989dd70a0ec18fa301b in User textbox

And I input azuki in Owner textbox

And I input LIVE$2100010921 in Media textbox

And I input jinadatta@outlook.com in Primary textbox

And I input {abotprop.REFAPP.OAUTH.TOKEN} in STS tokens textbox

And I input 4781 in App Token textbox

And I input default in Tenant ID textbox