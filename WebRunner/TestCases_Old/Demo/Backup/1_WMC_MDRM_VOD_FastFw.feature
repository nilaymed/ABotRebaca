###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################
@WMC_MDRM_VOD_FastFw_Demo
@WMC_VOD_Sanity
@OTT_Demo_Feature
@LIVE_LOGIN
Feature: WmcRefApp_Player_TSE_MDRM_VOD_SkipFw

Scenario: Run the refapp player to verify the Skip Forward Playback of VOD media.

	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml

	And I use the message-id RFVD002

	# Start-up Test by calling the common steps
	Given I run the feature WMC_VOD_Common_Steps_No_App_Token

	# Verify that the media is in playing state after (N) seconds played
	When I play the media for 30 seconds
	Then I validate that the media is in playing state

	# Verify the Restart playback of VOD media.
	When I restart the media
	And I wait for 10 seconds
	Then I validate that the media is in playing state

	# Verify the Skip Forward event for playback of VOD media.
	When I 2x-fast-forward the media for 5 seconds
	Then I validate that the media is in playing state
	
	And I wait for 1 seconds
	
	When I 1x-fast-forward the media for 10 seconds
	Then I validate that the media is in playing state
	
	# The playback Stop of VOD media.
	Given I play-pause the media
	Then I validate that the media is in paused state




