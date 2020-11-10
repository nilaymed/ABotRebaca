###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-LiveCheck
@SanityCheck
@Test_Chk

Feature: RF006_UmcRefApp_Player_Live_SkipFw

Scenario: Run the UMC refapp player to verify the Skip Forward Playback of Live media

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
	
	# Verifying Restart to have some buffer for Skip forward
	Given I run the feature RefApp-Player-Restart-Steps
	
	# Verifying Skip forward(15 sec)
	Given I run the feature RefApp-Player-SkipFw-Steps

	# Verifying stop playback
	Given I run the feature RefApp-Player-Stop-Steps

	# Terminate the web driver



