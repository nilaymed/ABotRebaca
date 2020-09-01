###########################################################################################
#                              Date: <06/11/2020> Version: <1.0>                          #
###########################################################################################
@subtitle_load-1
@mytag_subtitle
@Sanity_Integration
Feature: RefApp Player Subtitle validation from messagebundle

  Scenario: Run the refapp player for Subtitle load
    Given all configured endpoints for WEB are connected successfully
    
	Given the steps below will be executed at the end
  	And I terminate the driver
	Then the ending steps are complete
		
	Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
        
    And I use the message-id RFVD013
    
    # Call common step
	Given I run the feature RefApp_Player_VOD_Common_Steps
    
    When I play the media for 60 seconds
	Then I validate that the media is in playing state
	
	Then I click on the element Subtitle State checkbox
	
	Then I select Track1 option from Subtitle dropdown
	Then I validate subtitle Track1 is loaded successfully
	
	Then I select Track2 option from Subtitle dropdown
	Then I validate subtitle Track2 is loaded successfully
	
	And I wait for 5 seconds
	
	Then I stop the media
	
	
	