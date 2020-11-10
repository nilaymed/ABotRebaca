###########################################################################################
#                              Date: <06/04/2020> Version: <4.3>                          #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF007_WmcRefApp_IMCErrorCodes_LIVE_RestartBlocked

  Scenario: Run the refapp player for PBR validation with RestartNow Blocked media.
    Given all configured endpoints for WEB are connected successfully

    Given the steps below will be executed at the end
    And I terminate the driver
    Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml

    And I use the message-id PBR_LIVE_RSNowBlocked

    # Call common step
    Given I run the feature RefApp-Player-Common-Steps

    # Verifying the playback
    When I run the feature RefApp-Player-Start-Steps

    # PBR validation with RestartNow
    When I run the feature RefApp-PBR-RestartNowBlocked-Steps

    # Verifying Restart block from console logs
    When I run the feature RefApp-IMC-RestartBlocked-Steps

    # Clicking on the Stop button to stop the playback
    When I run the feature RefApp-Player-Stop-Steps
    
    # Terminate the web driver


