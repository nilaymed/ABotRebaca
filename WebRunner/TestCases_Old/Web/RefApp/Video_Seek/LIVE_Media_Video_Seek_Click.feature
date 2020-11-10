###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_LIVE_Media_Video_Seek_Click 
@RefApp_Player_LIVE_Sanity
@RefApp_Player_Video_Seek_Sanity
@Sanity_Integration
Feature: Click on Video Seek bar of LIVE Media

  Scenario: Run the refapp player to verify the click action on Video-Seek-bar of LIVE media.
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    When I terminate the driver
    Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD_LV_001
    
    # Call common step
	Given I run the feature RefApp_Player_LIVE_Common_Steps
	
    When I play the media for 15 seconds
    Then I validate that the media is in playing state
    
    
    # Verify the click on Video-Seek-bar of LIVE media
    Given I expect that the next step will fail
    Then I click the Video-Seek-bar towards right by 70%
    
    And I wait for 5 seconds
    
    Given I expect that the next step will fail
    Then I click the Video-Seek-bar towards left by 10%
    
    And I wait for 5 seconds
    
    When I stop the media
    Then I validate that the media is in done state
