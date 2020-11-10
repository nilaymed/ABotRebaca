###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile5
@UMC_RefApp_Sanity

Feature: RefApp_Player_VoD
Scenario: Run the UMCRefApp player to set home status


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I run the feature UMCRefApp-Player-Common-Steps_VOD

# Verify the Start Playback of VOD media

Given I play the media for 10 seconds

Then I validate that the media is in playing state

Then I select out home option from Home Status dropdown

Then I select in home option from Home Status dropdown

Then I select unknown option from Home Status dropdown










