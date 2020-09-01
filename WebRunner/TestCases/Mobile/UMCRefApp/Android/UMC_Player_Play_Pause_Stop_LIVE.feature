###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_Player_Play_Pause_Stop_Live
@UMC_RefApp_Sanity

Feature: UMC_Player_Play_Pause_Stop_LIVE_Tuning

Scenario: Verify media playback and stop

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	# Start-up Test by calling the common steps
	Given I run the feature UMCRefApp-Player-Common-Steps_LIVE
	
	Given I play the media for 15 seconds

	Then I validate that the media is in playing state
	
	Then I validate the media resumed from LIVE state
	
	Given I play-pause the media

	Then I validate that the media is in paused state
	
	And I wait for 10 seconds

	Given I play-pause the media
	
	And I wait for 5 seconds
	
	Then I click on the element LIVE button

	Then I validate the media resumed from LIVE state

	When I stop the media

	Then I validate that the media is in done state