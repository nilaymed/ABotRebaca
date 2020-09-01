###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@Bookmark5 
@Bookmark_Sanity
@Bookmark_wmc
Feature: Advanced Bookmark Verify bookmark feature for 2 media

  Scenario: Run the refapp player to verify bookmark feature for 2 media.
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
  	When I terminate the driver
	Then the ending steps are complete
	
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
	
    # Pre-condition
    Given the refapp app is loaded successfully
    And I use the message-id RFVD002
    
    # Start-up VOD for Media1
    When I open the Home page
    When I run the feature RefApp-Common-Step-bookmark-validation
    
    #Enable Bookmark
    #When I click on the element AMC Additional Parameters link
    Then I click on the element Bookmark checkbox
	
	When I play the media for 20 seconds
	Then I validate that the media is in playing state
    Then I save current playing time
    
    Given I stop the media
	Then I validate that the media is in done state
	
	Then I wait for 5 seconds
	
	#Validate Bookmark
	When I play the media
	Then I validate the player resumed from bookmark state
    
    Given I stop the media
	Then I validate that the media is in done state
	
	Then I wait for 5 seconds
	
    And I use the message-id RFVD005
    
    # Start-up VOD for Media2
    And I input MediaIndentifier on Media UID textbox
    
    
    When I play the media for 15 seconds
	Then I validate that the media is in playing state
	
    And I drag the Video-Seek-bar towards right by 50%
    
    And I wait for 10 seconds
    
    Then I save current playing time
    
    Given I stop the media
	Then I validate that the media is in done state
	
	Then I wait for 5 seconds
	
	#Validate Bookmark
	When I play the media
	Then I validate the player resumed from bookmark state
	