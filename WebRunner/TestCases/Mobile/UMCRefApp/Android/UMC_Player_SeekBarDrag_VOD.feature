###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_Player_Seek_Bar_Drag
@UMC_RefApp_Sanity

Feature: UMC_Player_Seek_Bar_Drag

Scenario: Verify sliding bar drag

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	# Start-up Test by calling the common steps
	Given I run the feature UMCRefApp-Player-Common-Steps_VOD
	
	Given I play the media for 15 seconds

	Then I validate that the media is in playing state
	
	Given I drag the Video-Seek-bar towards right by 50%
	
	And I wait for 10 seconds

	Then I validate that the media is in playing state
	
	Given I click the Video-Seek-bar towards right by 50%
	
	And I wait for 10 seconds

	Then I validate that the media is in playing state

	Given I drag the Video-Seek-bar towards left by 60%
	
	And I wait for 7 seconds

	Then I validate that the media is in playing state
	
	Given I click the Video-Seek-bar towards left by 40%
	
	And I wait for 7 seconds

	Then I validate that the media is in playing state
	
	When I stop the media

	Then I validate that the media is in done state
