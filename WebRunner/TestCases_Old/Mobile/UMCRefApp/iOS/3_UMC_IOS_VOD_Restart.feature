###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################
@UMC_IOS_VOD_Restart
@Demo_R5

Feature: D2_UMC_Player_TSE_MDRM_VOD_Restart

Scenario: Run the refapp player to verify the Restart Playback of VOD media.

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    #Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle_pprod.xml
    
    # Pre-condition
    #And I use the message-id RFVD003
    And I use the message-id RFVD002	
    #And I use the message-id RF_VOD

		# Start-up Test by calling the common steps
		Given I run the feature UMC_IOS_VOD_Common_Steps

	# Verify that the media is in playing state after (N) seconds played
	When I play the media for 30 seconds
	Then I validate that the media is in playing state

	# Verify the Restart playback of VOD media.
	When I restart the media
	And I wait for 10 seconds
	Then I validate that the media is in playing state

	# The media playback is stopped.
	Given I stop the media
	Then I validate that the media is in done state




