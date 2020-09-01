###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################
@Player_LIVE_SkipFwRw1
@OTT
Feature: RF005_WmcRefApp_Player_TSE_MDRM_LIVE_SkipFw

Scenario: Run the refapp player to verify the Skip Forward Playback of LIVE media.

	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml

	And I use the message-id RFVDLV002

	# Start-up Test by calling the common steps
	Given I run the feature OTT-Common-RefApp-Step

	# Verify that the media is in playing state after (N) seconds played
	When I play the media for 10 seconds
	Then I validate that the media is in playing state

	# Verify the Restart playback of LIVE media.
	When I restart the media
	And I wait for 10 seconds
	Then I validate that the media is in playing state

	# Verify the Skip Forward event for playback of LIVE media.
	When I fast-forward the media for 1 time
	And I wait for 10 seconds
	Then I validate that the media is in playing state

	# The playback Stop of LIVE media.
	Given I stop the media
	Then I validate that the media is in done state




