###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@OTTWMC

Feature: RefApp_Player_VoD

Scenario: Run the WMCRefApp player to verify the Skip Forward/Reverse(30s) Playback of VOD media

Given all configured endpoints for WEB are connected successfully

Given the steps below will be executed at the end
    Then I terminate the driver
Then the ending steps are complete

Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	
And I use the message-id RFVD002

# Call common step
Given I run the feature OTT-Common-RefApp-Step

# Verify the Skip Forward(30s) Playback of VOD media.

When I play the media for 30 seconds

Then I validate that the media is in playing state

When I fast-forward the media for 1 time

And the execution is paused for 5 seconds

Then I validate that the media is in playing state

When I rewind the media for 1 time

And the execution is paused for 5 seconds

Then I validate that the media is in playing state

When I stop the media

Then I validate that the media is in done state


