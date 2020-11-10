###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile_Popup
@UMC_RefApp_Sanity

Feature: RefApp_Player_VoD_Popup
Scenario: Run the UMCRefApp player to validate error message from message box


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I initialize the mobile-device Device1 and launch the application

#And I input https://ottapp-appgw-amp-a.cip.mr.tv3cloud.com in Server textbox

And I input 2b791c224ef7e989dd70a0ec18fa301b in User textbox

And I input azuki in Owner textbox

And I input Default1_9333_Jitp_Reach_HD in Media textbox

And I input jinadatta@outlook.com in Primary textbox

And I input {abotprop.REFAPP.OAUTH.TOKEN} in STS tokens textbox

And I input default in Tenant ID textbox

When I click on the element START button
Then I validate Please enter a valid Server Url, Media ID and User! text to be present on pop-up alert
And I wait for 5 seconds
Then I accept the pop-up alert
Then I input https://ottapp-appgw-amp-a.cip.mr.tv3cloud.com in Server textbox


Given I play the media for 10 seconds

Then I validate that the media is in playing state

When I stop the media

Then I validate that the media is in done state
