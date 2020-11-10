###########################################################################################
#                              Date: <04/10/2020> Version: <1.0>                          #
###########################################################################################
@Program_Boundary
Feature: Program Boundary Validation

  Scenario: Run the live channel and validate program switch
  
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    When I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml

    And I use the message-id RFLV002
    
    # Call common step
	Given I run the feature RefApp_Player_LIVE_Common_Steps
    
    
    When I play the media for 30 seconds
	Then I validate that the media is in playing state
    
     
    Then I play live channel LIVE$13574 and wait for program switching of 1 times
    
    Then I click on the element Stop button
