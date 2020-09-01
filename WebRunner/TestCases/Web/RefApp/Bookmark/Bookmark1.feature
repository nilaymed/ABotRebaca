###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@Bookmark1 
@Bookmark_Sanity
@Bookmark_wmc
Feature: Basic Bookmark

  Scenario: Run the refapp player to verify bookmark feature.
  
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    Then I terminate the driver
	Then the ending steps are complete
	
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	
    # Pre-condition
    Given the refapp app is loaded successfully
		
		#When I login to the app-environment Environment1 as User2
		
    # Start-up VOD
    When I open the Home page
    
    And I use the message-id RFVD002
    When I run the feature RefApp-Common-Step-bookmark-validation
    
    #Enable Bookmark
    #When I click on the element AMC Additional Parameters link
    Then I click on the element Bookmark checkbox
	
	When I play the media for 20 seconds
	Then I validate that the media is in playing state
	
	Then I validate media has been played for 10 seconds
	
    Then I save current playing time
    
    Given I stop the media
	Then I validate that the media is in done state
	
	And I wait for 5 seconds
	
	#Validate Bookmark
	When I play the media
	Then I validate the player resumed from bookmark state
