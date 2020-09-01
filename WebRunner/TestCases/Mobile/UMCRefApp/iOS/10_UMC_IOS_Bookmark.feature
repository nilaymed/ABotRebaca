###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@IOS_BookmarkUMC1 @IOS_BookmarkUMC
@IOS_Bookmark_Sanity

Feature: Enable-Disable Bookmark

  Scenario: Run the refapp player to verify bookmark reset feature.
    Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
  		Then I terminate the driver
	Then the ending steps are complete

	Given I run the feature UMC_IOS_RefApp-Player-Common-Steps_VOD
    
    #Enable Bookmark
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
    And I wait for 2 seconds
    Then I click on the element Stop button
    And I validate that the media is in done state
    
    #Disable Bookmark
    Then I click on the element Bookmark checkbox
    
    #Validate Initial
	When I play the media
    Then I validate the media resumed from initial state
    And I wait for 2 seconds
    Then I stop the media
	
	