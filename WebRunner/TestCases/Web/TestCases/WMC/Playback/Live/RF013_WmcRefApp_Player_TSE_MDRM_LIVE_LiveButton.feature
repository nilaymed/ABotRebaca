###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

@RF013_WmcRefApp_Player_TSE_MDRM_LIVE_LiveButton

Feature: RF013_WmcRefApp_Player_TSE_MDRM_LIVE_LiveButton

Scenario: Run the refapp player to verify LIVE button in Timeshift mode

	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
	
	And I use the message-id TSE_MDRM_LIVE
   
    # Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Common-Steps
	
	# Verify the LIVE button in Timeshifted channel
	Given I run the feature RefApp-Player-Start-Steps
	
	# Verify the Restart playback of LIVE media
	Given I run the feature RefApp-Player-Restart-Steps
    
	# Verify the player catchup the LIVE position when click the LIVE button
	When I run the feature RefApp-Player-LiveButton-Steps
	
	# The playback Stop of LIVE media
	Given I run the feature RefApp-Player-Stop-Steps
	
	# Terminate the web driver

