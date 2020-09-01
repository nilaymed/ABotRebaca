###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile_IMC
@UMC_RefApp_Sanity


Feature: RefApp_Player_VoD
Scenario: Run the UMCRefApp player to verify the Skip Forward/Reverse(30s) Playback of VOD media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I run the feature UMCRefApp-Player-Common-Steps_VOD

# Verify the Start Playback of VOD media

Given I run the feature FWD_BLK_PLAY


When I stop the media

Then I validate that the media is in done state








