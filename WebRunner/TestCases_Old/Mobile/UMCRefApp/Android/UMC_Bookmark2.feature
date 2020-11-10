###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@BookmarkUMC2 @BookmarkUMC
@Bookmark_Sanity

Feature: Check Bookmark for 2 different media

  Scenario: Run the refapp player to verify bookmark feature for different media.
    Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
  		Then I terminate the driver
	Then the ending steps are complete

	Given I run the feature UMCRefApp-Player-Common-Steps_VOD
    
    #Enable Bookmark
    Then I click on the element Bookmark checkbox
	
	When I play the media for 20 seconds
	Then I validate that the media is in playing state
	
    Then I save current playing time
    
    Given I stop the media
	Then I validate that the media is in done state
	
	Then I wait for 5 seconds
	
	#Validate Bookmark For Media1
	When I play the media
	Then I validate the media resumed from bookmark state
    And I wait for 2 seconds
    Then I click on the element Stop button
    And I validate that the media is in done state
    
    #Enter Media2 details
    And I input Default1_9333_Jitp_Reach_HD in Media textbox
    
    When I play the media for 25 seconds
	Then I validate that the media is in playing state
		
	Then I save current playing time
	
	Given I stop the media
	Then I validate that the media is in done state
	
	Then I wait for 5 seconds
	
	#Validate Bookmark For Media2
	When I play the media
	Then I validate the media resumed from bookmark state
    And I wait for 2 seconds
    Then I click on the element Stop button
    And I validate that the media is in done state
	
	