###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@Bookmark2 
@Bookmark_Sanity
@Bookmark_wmc
Feature: Enable-Disable Bookmark

  Scenario: Run the refapp player to verify bookmark reset feature.
  
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
  	And I terminate the driver
	Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	
    # Pre-condition
    Given the refapp app is loaded successfully
    And I use the message-id RFVD002

    # Start-up VOD
    When I open the Home page
    When I run the feature RefApp-Common-Step-bookmark-validation
    
    #Enable Bookmark
    #When I click on the element AMC Additional Parameters link
    Then I click on the element Bookmark checkbox
	
	When I play the media for 15 seconds
	Then I validate that the media is in playing state
	
    Then I save current playing time
    
    Given I stop the media
	Then I validate that the media is in done state
	
	Then I wait for 5 seconds
	
	#Validate Bookmark
	When I play the media
	Then I validate the media resumed from bookmark state
    
    And I click on the element Stop button
    And I validate that the media is in done state
    
    #Disable Bookmark
    Then I click on the element Bookmark checkbox
    
    #Validate Initial
	When I play the media
    Then I validate the media resumed from initial state
	
	