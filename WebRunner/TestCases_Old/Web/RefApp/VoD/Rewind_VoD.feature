###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Rewind_tag
@RefApp_Player_VOD_Sanity
@Sanity_Integration
Feature: RefApp Player VOD Media Rewind

  Scenario: Run the refapp player to verify the Rewind Playback of VOD media.
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    When I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD002
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
	
	When I play the media
	And I wait for 30 seconds
	Then I validate that the media is in playing state
	
	Given I expect that the next step will fail
	When I 1x-rewind the media for 10 seconds
    
    And I wait for 5 seconds
	
	Then I validate that the media is in playing state
	
	When I stop the media
    Then I validate that the media is in done state
	
