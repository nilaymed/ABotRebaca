###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@BookmarkUMC5 @BookmarkUMC
@Bookmark_Sanity

Feature: Verify playback with only Session_Shift enabled

  Scenario: Run the refapp player to verify playback with only Session_Shift enabled.
    Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
  		Then I terminate the driver
	Then the ending steps are complete

	Given I run the feature UMCRefApp-Player-Common-Steps_VOD
    
    #Enable Session_Shift
    Then I click on the element Session Shift checkbox
	
	When I play the media for 15 seconds
	Then I validate that the media is in playing state
	
    Then I save current playing time
    
    Given I stop the media
	Then I validate that the media is in done state
	
	#Disable Session_Shift
    Then I click on the element Session Shift checkbox
	
	#Validate Playback Initial
	When I play the media
	Then I validate the media resumed from initial state
    And I wait for 5 seconds
    Then I click on the element Stop button
    And I validate that the media is in done state
	
	