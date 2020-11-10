###########################################################################################
#                              Date: <05/11/2020> Version: <4.0.1>                          #
#                              Author name: Abdul Khadeer                                 #
###########################################################################################
@RefApp-Player_R5
@RefApp-Player_R5_0
@RefApp-PBR
Feature: RF001_WmcRefApp_PBR_LIVE_SkipFwBlkChk

	Scenario: Run the refapp player to verify that Skip forward is blocked for PBR LIVE media
	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	And I use the message-id PBR_LIVE_SkipFwBlk
    
		# Call common step
		Given I run the feature RefApp-Player-Common-Steps1

    # Verify the start Playback of Skip forward blocked LIVE media
	When I play the media for 15 seconds
	And I validate that the media is in playing state
	
	# verify the Restart of Skip forward blocked LIVE media
	# Since it's a Live channel, Skip forward can not be verified unless seeked back from Live. That's why restarting playback to create some buffer
	    Then I restart the media
	And I validate media has been played for 15 seconds
		And I wait for 15 seconds
	And I validate that the media is in playing state
	
	#Verify the Seek Skip Forward is blocked for LIVE media

	Given I expect that the next step will fail
	When I fast-forward the media for 1 time
	
	# Clicking on the Stop button to stop the playback
	Then I stop the media
		
	# Terminate the web driver

	
	
