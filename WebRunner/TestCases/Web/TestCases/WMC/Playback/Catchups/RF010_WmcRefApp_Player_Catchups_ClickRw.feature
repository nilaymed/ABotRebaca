###########################################################################################
#                              Date: <07/01/2020> Version: <5.0.0>                        #
#								 Author Name: NIKHIL SHET                                 #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF010_WmcRefApp_Player_Catchups_ClickRw

	Scenario: Run the Refapp player to Verify the progress bar Click Rewind functionality of Catchup media.
		Given all configured endpoints for WEB are connected successfully

		Given the steps below will be executed at the end
		And I terminate the driver
		Then the ending steps are complete

		Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml

		And I use the message-id RF_TSB_CATCHUP

		# Call common step
		Given I run the feature RefApp-Player-WebTSB-Steps

		# Verifying playback start for Catchup media
		Given I run the feature RefApp-Player-Start-Steps

		# Verifying the Click Rewind functionality of Catchup media
		Given I run the feature RefApp-Player-ClickRw-Steps

		# Clicking on the Stop button to stop the playback
		Given I run the feature RefApp-Player-Stop-Steps


