###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_Play_Time_LIVE
@UMC_RefApp_Sanity

Feature: UMC_Play_Time_LIVE

Scenario: Verify media playback time validation LIVE

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	# Start-up Test by calling the common steps
	Given I run the feature UMCRefApp-Player-Common-Steps_LIVE
	
	Given I play the media for 15 seconds
	Then I validate that the media is in playing state
	Then I validate media has been played for 10 seconds
	
	And I wait for 5 seconds
    Then I click on the element Stop button
    And I validate that the media is in done state




