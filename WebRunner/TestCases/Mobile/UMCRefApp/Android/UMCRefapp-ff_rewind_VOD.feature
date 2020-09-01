###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile2
@UMC_RefApp_Sanity

Feature: RefApp_Player_VoD
Scenario: Run the UMCRefApp player to verify the fast-forward and rewind Playback of VOD media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I run the feature UMCRefApp-Player-Common-Steps_VOD

# Verify the Start Playback of VOD media

Given I play the media for 10 seconds

Then I validate that the media is in playing state

When I 1x-fast-forward the media for 10 seconds
Then I play-pause the media
And I wait for 5 seconds
Then I validate that the media is in playing state

When I 1x-rewind the media for 5 seconds
Then I play-pause the media
And I wait for 5 seconds
Then I validate that the media is in playing state

When I stop the media

Then I validate that the media is in done state








