###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Basic_Pause_Resume
@RefApp_Player_VOD_Sanity
@Sanity_Integration
Feature: RefApp Player VOD Media Basic Pause Resume

  Scenario: Run the refapp player to verify the Pause and Resume playback of VOD media.
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    Then I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD002
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
	
	When I play the media for 15 seconds
	Then I validate that the media is in playing state
	
	
	When I play-pause the media
	Then I validate that the media is in paused state
	
	When I play-pause the media
    Then I validate that the media is in resumed state
  
    When I stop the media
	Then I validate that the media is in done state
