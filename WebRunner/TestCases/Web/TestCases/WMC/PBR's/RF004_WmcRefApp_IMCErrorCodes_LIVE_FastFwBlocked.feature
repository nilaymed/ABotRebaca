###########################################################################################
#                        Date: <06/18/2020> Version: <4.3.0>                              #
#                               Author name: Puspendu                                     #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF004_WmcRefApp_IMCErrorCodes_LIVE_FastFwBlocked

  Scenario: Run the Refapp player to Check the Fast Forward Block IMC error code in LIVE content
    Given all configured endpoints for WEB are connected successfully

    Given the steps below will be executed at the end
    When I terminate the driver
    Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml

    And I use the message-id PBR_LIVE_FastFwBlk

    # Call common step
    Given I run the feature RefApp-Player-Common-Steps

    # Verifying the playback
    When I run the feature RefApp-Player-Start-Steps
	
	#Verifying the restart 
	When I run the feature RefApp-Player-Restart-Steps

    # PBR validation with FastFwBlocked_Blocked media
    When I run the feature WmcRefApp-PBR-FastFwBlocked-Steps

    # Verifying Fast Forward block from console logs
    #When I run the feature RefApp-IMC-FastFwBlocked-Steps

    # Clicking on the Stop button to stop the playback
    When I run the feature RefApp-Player-Stop-Steps

# Terminate the web driver

