###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################
@SanityCheck
@WMC_SanityCheck
@dhkilo


Feature: RF004_WmcRefApp_Player_TSE_MDRM_LIVE_Restart

Scenario: Run the refapp player to verify the Restart Playback of LIVE media

	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
	
	And I use the message-id TSE_MDRM_LIVE
    
    # Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Common-Steps
	
	# Verifying the playback
	Given I run the feature RefApp-Player-Start-Steps
	
	# Verifying the restart
	Given I run the feature RefApp-Player-Restart-Steps
	
	# Verifying stop playback
	Given I run the feature RefApp-Player-Stop-Steps
	
	# Terminate the web driver

