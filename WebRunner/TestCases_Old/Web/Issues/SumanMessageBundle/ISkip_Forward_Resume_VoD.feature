###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Skip_Forward_Resume
@RefApp_Player_VOD_Sanity
@MBX
Feature: RefApp_Player_VOD_Media_Skip_Forward_Resume

  Scenario: Run the refapp player to verify the Skip Forward(15s) Playback of VOD media
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    # Pre-condition
    And I use the message-id RFVD002
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
	
	# Verify the Skip Forward(15s) Playback of VOD media.
	When I play the media for 15 seconds
	Then I validate that the media is in playing state
	
	When I 2x-fast-forward the media for 1 time
	And I wait for 5 seconds
	Then I validate that the media is in playing state
	
		When I 2x-fast-forward the media for 2 time
	And I wait for 10 seconds
	When I 2x-fast-forward the media for 6 time
	And I wait for 10 seconds
	
	When I 2x-fast-forward the media for 1 time
	And I wait for 10 seconds
	
	When I 2x-fast-forward the media for 8 time
	And I wait for 10 seconds
    When I stop the media
    Then I validate that the media is in done state