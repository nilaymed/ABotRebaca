###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-LiveCheck
@SanityCheck

Feature: RF013_UmcRefApp_Player_TSE_MDRM_LIVE_LiveButton

Scenario: Run the refapp player to verify LIVE button in Timeshift mode

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

	Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
	And I use the message-id TSE_MDRM_LIVE

	# Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Mobile-Steps 
	
	# Verify the Start Playback of LIVE media
	Given I run the feature RefApp-Player-Start-Steps
	
	# Verify the Restart playback of LIVE media
	Given I run the feature RefApp-Player-Restart-Steps
    
	# Verify the player catchup the LIVE position when click the LIVE button
	When I run the feature RefApp-Player-LiveButton-Steps
	
	# The playback Stop of LIVE media
	Given I run the feature RefApp-Player-Stop-Steps
	
	# Terminate the web driver

