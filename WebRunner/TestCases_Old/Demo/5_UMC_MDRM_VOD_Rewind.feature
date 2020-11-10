###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMC_IOS_MDRM_Rewind
@Demo_R5

Feature: D3_UMC_IOS_MDRM_RefApp_Player_VoD
Scenario: Run the UMCRefApp player to verify the fast-forward and rewind Playback of VOD media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

# Load the message bundle
Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml

# Pre-condition
And I use the message-id RFVD003	

Given I run the feature UMC_IOS_VOD_Common_Steps_Demo

# Verify the Start Playback of VOD media

Given I play the media for 20 seconds

Then I validate that the media is in playing state

When I 1x-rewind the media for 5 seconds
Then I play-pause the media
And I wait for 5 seconds
Then I validate that the media is in playing state

When I stop the media

Then I validate that the media is in done state








