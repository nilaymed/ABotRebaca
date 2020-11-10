###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-VoDCheck
@SanityCheck

Feature: RF006_UmcRefApp_Player_Vod_SkipFw

	Scenario: Verify the skip forward operation for VOD playback

		Given all configured endpoints for MOBILEDEVICE are connected successfully

		Given the steps below will be executed at the end
		And I terminate the driver
		Then the ending steps are complete

		Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml

		And I use the message-id RF_VOD

		# Start-up Test by calling the common steps
		Given I run the feature RefApp-Player-Mobile-Steps

		#Start VOD Playback
		Given I run the feature RefApp-Player-Start-Steps

		# Verify the Skip Forward operation on VOD Playback
		Given I run the feature RefApp-Player-SkipFw-Steps

		# Clicking on the Stop button to stop the playback
		Given I run the feature RefApp-Player-Stop-Steps



