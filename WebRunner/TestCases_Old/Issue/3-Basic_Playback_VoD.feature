###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@IssueNull
@IssueX
Feature: RefApp_Player_VOD_Media_Basic_Playback

  Scenario: Run the refapp player to verify the Start Playback of VOD media
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    # Pre-condition
    Given the refapp app is loaded successfully
    And I use the message-id RFVD002
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
	
	# Verify that the media is in playing state after (N) seconds played
	When I play the media for 60 seconds
	Then I validate that the media is in playing state
    
	# The playback Stop of VoD media.
	Given I stop the media
	Then I validate that the media is in done state
	