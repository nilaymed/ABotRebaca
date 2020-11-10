###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-LiveCheck
@SanityCheck


Feature: RF005_UmcRefApp_Player_Live_Restart

Scenario: Verify media playback restart for Live

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
	Then I terminate the driver
	Then the ending steps are complete

	Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
	And I use the message-id TSE_MDRM_LIVE
    
	# Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Mobile-Steps 
	
	# Verify the Start Playback of LIVE media
	Given I run the feature RefApp-Player-Start-Steps
	
	# Verifying the restart
	Given I run the feature RefApp-Player-Restart-Steps
	
	# Verifying stop playback
	Given I run the feature RefApp-Player-Stop-Steps

	# Terminate the web driver



