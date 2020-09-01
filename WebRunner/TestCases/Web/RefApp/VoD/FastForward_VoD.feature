###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Fast_Forward_Resume_tag
@RefApp_Player_VOD_Sanity
@mytag_FF
Feature: RefApp Player VOD Media Fast Forward Resume

  Scenario: Run the refapp player to verify the Fast-Forward Playback of VOD media
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    Then I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD002
    
    # Call common step
	
	Given I run the feature RefApp_Player_VOD_Common_Steps

	# Verify the Skip Forward(15s) Playback of VOD media.
	When I play the media for 60 seconds
	Then I validate that the media is in playing state
	
	When I 2x-fast-forward the media for 5 time
	And I wait for 5 seconds
	Then I validate that the media is in playing state
	
	Then I click on the element FastForward - x 1 button
	
	When I 2x-fast-forward the media for 10 secs
	And I wait for 10 seconds
	Then I validate that the media is in playing state
	
    When I stop the media
    Then I validate that the media is in done state
    