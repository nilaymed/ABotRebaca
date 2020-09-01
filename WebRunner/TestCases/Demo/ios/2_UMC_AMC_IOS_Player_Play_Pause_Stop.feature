###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_AMC_IOS_Player_Play_Pause_Stop
@UMC_AMC_IOS_Sanity


Feature: I1_UMC_Player_Play_Pause_Stop_VOD

Scenario: Verify media playback and stop

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete
	
    Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    
    # Pre-condition
    #And I use the message-id RFVD003
    And I use the message-id RFVD002	

		# Start-up Test by calling the common steps
		Given I run the feature UMC_IOS_VOD_Common_Steps_Demo
		
		# Verify the Pause and Resume playback of VOD media.
		When I play the media for 15 seconds
		Then I validate that the media is in playing state
		
		When I play-pause the media
		Then I validate that the media is in paused state
	
		When I play-pause the media
		Then I validate that the media is in playing state
	
		When I stop the media
		Then I validate that the media is in done state