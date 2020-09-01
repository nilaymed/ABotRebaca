###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@WMC_VOD_Media_Basic_Puase_Resume
@Demo_R53
@Demo6

Feature: D4_WMC_Player_Play_Pause_Stop_VOD

  Scenario: Run the refapp player to verify the Pause and Resume playback of VOD media.
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    	Then I terminate the driver
		Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    
    # Pre-condition
    And I use the message-id RFVD004
    
	  ## Start-up Test by calling the common steps
		Given I run the feature WMC_VOD_Common_Steps_No_App_Token
		
		# Verify the Pause and Resume playback of VOD media.
		When I play the media for 15 seconds
		Then I validate that the media is in playing state
		When I stop the media
		Then I validate that the media is in done state
		When I play the media for 15 seconds
		Then I validate that the media is in playing state
		When I play-pause the media
		Then I validate that the media is in paused state
		
		When I play-pause the media
	  Then I validate that the media is in resumed state
	    
	  When I stop the media
	  Then I validate that the media is in done state
