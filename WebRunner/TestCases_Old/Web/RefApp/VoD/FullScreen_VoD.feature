###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_FullScreen
@RefApp_Player_VOD_Sanity
Feature: RefApp Player VOD Media Full Screen

  Scenario: Run the refapp player to verify the Full Screen Mode of VOD media
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    When I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD002
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
	
	# Verify that the media is in playing state after (N) seconds played
	When I play the media for 60 seconds
	Then I validate that the media is in playing state
  
  Then I validate the playback is in FullScreen mode
  #Then I validate media has been played for 60 seconds
    
 	 When I stop the media
   Then I validate that the media is in done state
  