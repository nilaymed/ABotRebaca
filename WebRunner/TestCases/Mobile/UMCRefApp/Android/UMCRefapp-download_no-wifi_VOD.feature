###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile_Download2
@UMC_RefApp_Sanity

Feature: RefApp_Player_VoD_No-Wifi_Download
Scenario: Run the UMCRefApp player to verify the Skip Forward/Reverse(30s) Playback of VOD media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
Then I turn on the wifi
  Then I terminate the driver
Then the ending steps are complete

Given I run the feature UMCRefApp-Player-Common-Steps_VOD10

Then I download the media

Then I validate the media is downloaded successfully

Then I select Offline option from IMC Mode dropdown

Then I turn off the wifi

When I play the media

Then I validate that the media is in offline playing state








