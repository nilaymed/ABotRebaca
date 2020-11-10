###########################################################################################
#                        Date: <06/18/2020> Version: <4.3.0>                              #
#                               Author name: Puspendu                                     #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF005_WmcRefApp_IMCErrorCodes_LIVE_PauseResumeBlocked

    Scenario: Run the Refapp player to Check the Paused Block IMC error in LIVE content
        Given all configured endpoints for WEB are connected successfully

        Given the steps below will be executed at the end
        When I terminate the driver
        Then the ending steps are complete

        Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml

        And I use the message-id PBR_LIVE_PauseResumeBlk

        # Call common step
        Given I run the feature RefApp-Player-Common-Steps

        # Verifying the playback
        When I run the feature RefApp-Player-Start-Steps

        # PBR validation - Verifying that Restart is blocked
        When I run the feature RefApp-PBR-PauseResumeBlocked-Steps

        # Verifying Pause Resume block from console logs
        When I run the feature RefApp-IMC-PauseResumeBlocked-Steps

        # Clicking on the Stop button to stop the playback
        When I run the feature RefApp-Player-Stop-Steps

# Terminate the web driver

