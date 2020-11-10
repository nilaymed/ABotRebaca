###########################################################################################
#                              Date: <04/10/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_LIVE_tuning
Feature: RefApp Player LIVE Tuning Validation
 
  Scenario: Run the LIVE channel and validate LIVE tuning support
  
    Given all configured endpoints for WEB are connected successfully
     
    Given the steps below will be executed at the end
    When I terminate the driver
    Then the ending steps are complete
        
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml

    And I use the message-id RFLV005
    
    # Call common step
	Given I run the feature RefApp_Player_LIVE_Common_Steps
    
         
    When I play the media for 30 seconds
    Then I validate the media resumed from LIVE state
    
    Then I save current playing time
    
    Then I play-pause the media
    
    And I wait for 120 seconds
    
    Then I play-pause the media
    
    And I wait for 10 seconds
    
    And I validate that the media is in playing state
    
    Then I save current playing time
    
    And I click on the element LIVE button
    
    And I wait for 10 seconds
    
    Then I validate the media resumed from LIVE state
 
    Then I stop the media
    