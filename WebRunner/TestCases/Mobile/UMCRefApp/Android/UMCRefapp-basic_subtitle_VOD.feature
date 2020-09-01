###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile_Subtitle
@UMC_RefApp_Sanity

Feature: RefApp_Player_VoD
Scenario: Run the UMCRefApp player to verify the Skip Forward/Reverse(30s) Playback of VOD media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    
# Pre-condition
And I use the message-id RFVD010

Given I run the feature UMCRefApp-Player-Common-Steps_VOD

# Verify the Start Playback of VOD media

Given I play the media for 10 seconds

Then I validate that the media is in playing state

Then I select eng option from Subtitles dropdown

Then I validate subtitle eng is loaded successfully

Then I select ara option from Subtitles dropdown

Then I validate subtitle ara is loaded successfully

When I stop the media

Then I validate that the media is in done state








