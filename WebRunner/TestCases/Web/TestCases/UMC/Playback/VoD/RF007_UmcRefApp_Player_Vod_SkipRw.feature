###########################################################################################
#                            Date: <06/12/2020> Version: <4.3.0>                          #
#							        Author Name: Suman Saw                                #
###########################################################################################
@Sanity-VoDCheck
@SanityCheck

Feature: RF007_UmcRefApp_Player_Vod_SkipRw

	Scenario: Verify the skip rewind operation for VOD playback

		Given all configured endpoints for MOBILEDEVICE are connected successfully

		Given the steps below will be executed at the end
		And I terminate the driver
		Then the ending steps are complete

		Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml

		And I use the message-id RF_VOD

		# Start-up Test by calling the common steps
		Given I run the feature RefApp-Player-Mobile-Steps

		#Start playback
		Given I run the feature RefApp-Player-Start-Steps

		# Verify the Skip Rewind Playback of VOD media
		Given I run the feature RefApp-Player-SkipRw-Steps

		# Clicking on the Stop button to stop the playback
		Given I run the feature RefApp-Player-Stop-Steps

