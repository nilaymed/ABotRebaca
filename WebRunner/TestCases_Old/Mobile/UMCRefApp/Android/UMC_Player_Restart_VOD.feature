###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_Player_Restart_VOD
@UMC_RefApp_Sanity

Feature: UMC_Player_Restart_VOD

Scenario: Verify media playback restart for VOD

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	# Start-up Test by calling the common steps
	Given I run the feature UMCRefApp-Player-Common-Steps_VOD
	
	Given I play the media for 20 seconds

	Then I validate that the media is in playing state
	
	Then I restart the media
	
	Then I validate the player resumed from initial state
	
	And I wait for 5 seconds
    Then I click on the element Stop button
    And I validate that the media is in done state





