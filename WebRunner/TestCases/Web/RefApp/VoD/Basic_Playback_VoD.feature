###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Basic_Playback
@RefApp_Player_VOD_Sanity
@ADO_Test
@mytag_PB
@Sanity_Integration
@ADO_Test

Feature: RefApp Player VOD Media Basic Playback

  Scenario: Run the refapp player to verify the Start Playback of VOD media
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    When I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    #And I use the message-id RFVD002
    And I use the message-id RFVD014
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
	
	# Verify that the media is in playing state after (N) seconds played
	When I play the media for 60 seconds
	Then I validate that the media is in playing state
  
    
 	 When I stop the media
   Then I validate that the media is in done state
  
