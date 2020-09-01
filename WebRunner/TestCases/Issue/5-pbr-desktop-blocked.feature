###########################################################################################
#                              Date: <06/04/2020> Version: <1.0>                          #
###########################################################################################
@IssueNull
Feature: PBR06_RefApp_Player_Desktop_Blocked

  Scenario: Run the refapp player for PBR validation with Desktop blocked media
    Given all configured endpoints for WEB are connected successfully
    
		Given the steps below will be executed at the end
  		And I terminate the driver
		Then the ending steps are complete
		
		Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    # Pre-condition
    
    Given the refapp app is loaded successfully
    And I use the message-id RFVD110
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
    
    # PBR validation with Desktop blocked media
    Given I expect that the next step will fail
    When I play the media for 60 seconds
	
	Then I validate the following from console logs
	| Parameter    		| Value |
    | IMC.ErrorCode	    | 221 |
     