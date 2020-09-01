###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_LIVE_Media_Configure_Attribute
@RefApp_Player_LIVE_Sanity

Feature:RefApp Player LIVE Media Configure Attribute

  Scenario: Run the refapp player for LIVE playback mode
  
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    Then I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	
	And I use the message-id RFVD_LV_001 
	
	# Call common step
	Given I run the feature RefApp_Player_LIVE_Common_Steps
	