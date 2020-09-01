###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Basic_Rewind_tag
@Demo_R511
Feature: D9_WMC_VOD_Media_Basic_Rewind

  Scenario: Run the refapp player to verify that Rewind of Playback is not permitted for VOD media.
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    	Then I terminate the driver
	  Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    # Pre-condition
    Given the refapp app is loaded successfully
    And I use the message-id RF_VOD
    
    # Call common step
    
		Given I run the feature RefApp_Player_VOD_Common_Steps
		When I play the media for 10 seconds
		
		Then I validate that the media is in playing state
		And I wait for 30 seconds
		Then I validate that the media is in playing state
		# Verify the Skip Rewind(7s) Playback of VOD media
		Given I expect that the next step will fail
		When I 1x-rewind the media for 10 seconds
    And I wait for 10 seconds
		Then I validate that the media is in playing state
	
		When I stop the media
  	Then I validate that the media is in done state
	
