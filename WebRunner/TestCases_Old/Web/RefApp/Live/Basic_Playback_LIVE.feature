###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_LIVE_Media_Playback
@RefApp_Player_LIVE_Sanity
@Sanity_Integration
Feature: Playback of LIVE media

  Scenario: Run the refapp player to verify the Start Playback of LIVE media
    
    Given all configured endpoints for WEB are connected successfully
    
    
    Given the steps below will be executed at the end
    When I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	
    
    And I use the message-id RFVD_LV_001 
    
	# Call common step
	Given I run the feature RefApp_Player_LIVE_Common_Steps
	
	# Verify the Start Playback of LIVE media
	When I play the media for 30 seconds
	Then I validate that the media is in playing state
    
	# The playback Stop of LIVE media.
	Given I stop the media
	Then I validate that the media is in done state
