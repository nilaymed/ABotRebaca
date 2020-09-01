###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Stop_Playback
@RefApp_Player_VOD_Sanity
@mytag_stop

Feature: RefApp Player VOD Media Stop Playback

  Scenario: Run the refapp player to verify the Stop Playback of VOD media.
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    When I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD002
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
	
	# Verify the Stop Playback of VOD media.
	When I play the media for 30 seconds
	Then I validate that the media is in playing state
	
	Then I click the Video-Seek-bar towards right by 98%
	Then I wait till the media ends
	
	Then I save current playing time
	Then I validate that the media is in done state
	
	
    When I stop the media
    Then I validate that the media is in done state
    