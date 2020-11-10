###########################################################################################
#                              Date: <26/06/2020> Version: <4.3.0>                        #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF004_WmcRefApp_Player_TSD_MDRM_LIVE_SkipFwDisabled

Scenario: Run the refapp player to verify the SKIP_FWD during the playback of LIVE timeshift disabled media

	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
	And I use the message-id TSD_MDRM_LIVE
    
    # Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Common-Steps
	
	# Verify the Playback of LIVE Timeshift disabled media
	Given I run the feature RefApp-Player-Start-Steps
	
	# Verify the Skip Forward(15s) of LIVE Timeshift disabled media
	Given I expect that the next step will fail
	Given I run the feature RefApp-Player-SkipFw-Steps
    
	# The playback Stop of LIVE media
	Given I run the feature RefApp-Player-Stop-Steps
	
	# Terminate the web driver

