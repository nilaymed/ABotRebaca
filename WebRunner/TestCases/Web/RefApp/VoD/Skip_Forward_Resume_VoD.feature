###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Skip_Forward_Resume_tag
@RefApp_Player_VOD_Sanity
@mytag_skipForward
Feature: RefApp Player VOD Media Skip Forward Resume

  Scenario: Run the refapp player to verify the Skip Forward(15s) Playback of VOD media
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    Then I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD002
    
    # Call common step
    Given I run the feature RefApp_Player_VOD_Common_Steps

	
	When I play the media for 30 seconds
	Then I validate that the media is in playing state
	
	# Verify the Skip Forward(15s) Playback of VOD media.
	When I skip-forward the media for 1 time
	
	And I wait for 5 seconds
	
	Then I validate that the media is in playing state
	
	When I skip-forward the media for 3 time
	
	And I wait for 5 seconds
	
	Then I validate that the media is in playing state
	
    When I stop the media
    Then I validate that the media is in done state
    