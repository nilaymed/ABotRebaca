###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################

@Regression-LIVE
@Sanity-LIVE
@Basic-LIVE
@Player_TSE_MDRM_LIVE

Feature: RF005_WmcRefApp_Player_TSE_MDRM_LIVE_SkipFw

Scenario: Run the refapp player to verify the Skip Forward(15s) Playback of LIVE media.

	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	
	And I use the message-id TSE_MDRM_LIVE
    
    # Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Common-Steps
	
	# Verify the Skip Forward(15s) Playback of LIVE media.
	When I play the media for 30 seconds
	Then I validate that the media is in playing state
	
	# Verify the Restart playback of LIVE media.
	Then I restart the media
	And I wait for 30 seconds
	Then I validate that the media is in playing state
	
	# Verify the Skip Forward(15s) playback of LIVE media.
	Then I fast-forward the media for 1 time
    And I wait for 30 seconds
	Then I validate that the media is in playing state
	
	# The playback Stop of LIVE media.
	And I stop the media
	
	# Terminate the web driver

