###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-LiveCheck
@SanityCheck

Feature: RF004_UmcRefApp_Player_TSE_MDRM_LIVE_PauseResume

Scenario: Run the refapp player to verify the Pause and Resume playback of LIVE media

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
	Then I terminate the driver
	Then the ending steps are complete

	Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
	And I use the message-id TSE_MDRM_LIVE
    
	# Verify the Start Playback of LIVE media
	Given I run the feature RefApp-Player-Mobile-Steps 
	
	# Verify the Pause and Resume playback of LIVE media
	Given I run the feature RefApp-Player-Start-Steps
    
	# Verify the playback pause of LIVE media
	Given I run the feature RefApp-Player-PauseResume-Steps
		
	# The playback Stop of LIVE media
	Given I run the feature RefApp-Player-Stop-Steps
	
	# Terminate the web driver
