###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-LiveCheck_MOBILE_DEVICE
@Sanity-LiveCheck
@SanityCheck

Feature: RF003_UmcRefApp_Player_TSD_MDRM_LIVE_RestartDisabled

Scenario: Run the refapp player to verify the Restart during the playback of LIVE disabled  media

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
	And I use the message-id TSD_MDRM_LIVE
    
	# Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Mobile-Steps
	
	# Verify the Playback of LIVE Timeshift disabled media
	Given I run the feature RefApp-Player-Start-Steps
	
	# Verify the Restart Playback is not happening for LIVE Timeshift disabled media
	Given I expect that the next step will fail
	Given I run the feature RefApp-Player-Restart-Steps
    
	# The playback Stop of LIVE media
	Given I run the feature RefApp-Player-Stop-Steps
	
	# Terminate the web driver

