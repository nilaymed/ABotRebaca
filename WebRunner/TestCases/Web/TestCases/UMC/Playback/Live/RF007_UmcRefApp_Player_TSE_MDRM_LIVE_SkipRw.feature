###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-LiveCheck
@SanityCheck

Feature: RF007_UmcRefApp_Player_Live_SkipRw

Scenario: Run the UMC refapp player to verify the Skip Rewind Playback of Live media

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
	Then I terminate the driver
	Then the ending steps are complete
	
	Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
	And I use the message-id TSE_MDRM_LIVE
    
	# Start-up Test by calling the common steps
	Given I run the feature RefApp-Player-Mobile-Steps 

	# Verifying playback of Live media
	Given I run the feature RefApp-Player-Start-Steps 
	
	# Verifying Skip Rewind(30 sec)
	Given I run the feature RefApp-Player-SkipRw-Steps

	# Verifying stop playback
	Given I run the feature RefApp-Player-Stop-Steps

	# Terminate the web driver



