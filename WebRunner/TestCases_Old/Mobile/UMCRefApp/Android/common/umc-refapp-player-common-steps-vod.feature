@OTT-Common-RefApp-Step @WEB_LIBRARY
Feature: UMCRefApp-Player-Common-Steps_VOD

  Scenario: Create global system configuration for UMC VOD
	
Given I initialize the mobile-device Device1 and launch the application

#Then I validate UmcRefApp text to be present on window

# Start-up VOD
#Given I select VOD option from IMC cast mode dropdown
Then I select Download option from IMC Mode dropdown
And I input https://ottapp-appgw-amp-a.cip.mr.tv3cloud.com in Server textbox

And I input 2b791c224ef7e989dd70a0ec18fa301b in User textbox

And I input azuki in Owner textbox

#And I input Default1_dh32957_Jitp_Reach_HD in Media textbox
And I input Default1_416_Jitp_Reach_HD in Media textbox
#And I input Default1_55555_Jitp_Reach_HD in Media textbox
#And I input Default1_9333_Jitp_Reach_HD in Media textbox
#And I input Default1_420_Jitp_Reach_HD in Media textbox


And I input jinadatta@outlook.com in Primary textbox

And I input {abotprop.REFAPP.OAUTH.TOKEN} in STS tokens textbox

And I input default in Tenant ID textbox