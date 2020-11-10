###########################################################################################
#                        Date: <06/18/2020> Version: <4.3.0>                              #
#                               Author name: Puspendu                                     #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF003_WmcRefApp_IMCErrorCodes_LIVE_SkipRwBlocked

	Scenario: Run the Refapp player to Check the Skip backward Block IMC error code in LIVE content
		Given all configured endpoints for WEB are connected successfully

		Given the steps below will be executed at the end
		When I terminate the driver
		Then the ending steps are complete

		Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml

		And I use the message-id PBR_LIVE_SkipRwBlk

		# Call common step
		Given I run the feature RefApp-Player-Common-Steps

		# Verifying the playback
		When I run the feature RefApp-Player-Start-Steps

		# PBR validation - Verifying Skip rewind
		When I run the feature RefApp-PBR-SkipRwBlocked-Steps

		# Verifying Skip Rewind block from console logs
		When I run the feature RefApp-IMC-SkipRwBlocked-Steps

		# Clicking on the Stop button to stop the playback
		When I run the feature RefApp-Player-Stop-Steps

# Terminate the web driver

