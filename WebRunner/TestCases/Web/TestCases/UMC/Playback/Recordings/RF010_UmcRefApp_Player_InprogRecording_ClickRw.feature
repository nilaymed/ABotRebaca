###########################################################################################
#                              Date: <07/03/2020> Version: <5.0.0>                        #
#								  Author Name: NIKHIL SHET                                #
###########################################################################################
@Sanity-RecordingsCheck
@SanityCheck

Feature: RF010_UmcRefApp_Player_InprogRecording_ClickRw

	Scenario: Run the Refapp player to Verify the progress bar Click Rewind functionality of InprogRecording media.
		Given all configured endpoints for MOBILEDEVICE are connected successfully

		Given the steps below will be executed at the end
		And I terminate the driver
		Then the ending steps are complete

		Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml
		And I use the message-id RF_DVR_INPRROGRESS

		# Call common step
		Given I run the feature RefApp-Player-Mobile-Steps


		# Verifying playback start for InprogRecording media
		Given I run the feature RefApp-Player-Start-Steps

		# Verifying the Click Rewind functionality of InprogRecording media
		Given I run the feature RefApp-Player-ClickRw-Steps

		# Clicking on the Stop button to stop the playback
		Given I run the feature RefApp-Player-Stop-Steps


