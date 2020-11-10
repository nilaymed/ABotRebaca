###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Restart_Playback
@Demo_R5
@Demo_R53

Feature: D5_WMC_Player_TSE_MDRM_VOD_Restart

  Scenario: Run the refapp player to verify the Restart Playback of VOD media
    Given all configured endpoints for WEB are connected successfully

    Given the steps below will be executed at the end
    	Then I terminate the driver
		Then the ending steps are complete
	    
    Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    
    # Pre-condition
    Given the refapp app is loaded successfully
    And I use the message-id RFVD002
    
	  # Start-up Test by calling the common steps
		Given I run the feature WMC_VOD_Common_Steps_No_App_Token
		
		# Verify that the media is in playing state after (N) seconds played
		When I play the media for 30 seconds
		Then I validate that the media is in playing state
		
		# Verify the Restart Playback of VOD media
		When I restart the media
	  And I wait for 10 seconds
	  Then I validate that the media is in playing state
	  
	  # The media playback is stopped.  
	  When I stop the media
	  Then I validate that the media is in done state