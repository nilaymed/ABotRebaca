###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_LIVE_Media_Skip_Forward_Resume
@RefApp_Player_LIVE_Sanity


Feature: Skip Forward 15s Playback of LIVE Media

  Scenario: Run the refapp player to verify the Skip Forward(15s) Playback of LIVE media.
   
   Given all configured endpoints for WEB are connected successfully
    
   Given the steps below will be executed at the end
   Then I terminate the driver
   Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD_LV_001 
    
	# Call common step
	Given I run the feature RefApp_Player_LIVE_Common_Steps
	
	When I play the media for 15 seconds
	Then I validate that the media is in playing state
	
	# Verify the Skip Forward(15s) Playback of LIVE media.
	When I skip-forward the media for 1 time
	Then I validate that the media is in playing state
	
    When I stop the media
    Then I validate that the media is in done state
    